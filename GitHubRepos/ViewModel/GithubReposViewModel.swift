//
//  GithubReposViewModel.swift
//  GitHubRepos
//
//  Created by João Tribuzy on 28/08/20.
//  Copyright © 2020 João Tribuzy. All rights reserved.
//

import Foundation

class GitHubReposViewModel {
     
    static var shared: GitHubReposViewModel = {
        return GitHubReposViewModel()
    }()
    
    public private(set) var githubAPIResult: GithubResult? = nil {
        didSet {
            allRepos = githubAPIResult?.items.sorted { $0.name < $1.name }
        }
    }
    
    public private(set) var allRepos: [Repository]? = nil {
        didSet{
            if allRepos != nil {
                reposCount = allRepos?.count
                NotificationCenter.default.post(name: .reloadAllReposCollectionView, object: nil)
            }
        }
    }
    
    public private(set) var reposCount: Int? = nil
    
    init() {
        fetchAllRepos()
    }
}

extension GitHubReposViewModel {
    func fetchAllRepos() {
        GithubResultAPI().fetch { [weak self] result in
            self?.githubAPIResult = result
        }
    }
}
