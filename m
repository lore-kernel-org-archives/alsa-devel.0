From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: HG -> GIT migration
Date: Wed, 21 May 2008 00:12:28 +1000
Message-ID: <1211292748.3811.7.camel@localhost>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id C73D12488F
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 16:12:33 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaraslay,

I tried tonight to run

git clone git@git.alsa-project.org:alsa-driver.git alsa-driver

I get the following output:
----------------------------------------------------------
ben@mythtv:~/ubuntu-kernel/alsa-git$ git clone
git@git.alsa-project.org:alsa-driver.git alsa-driver
Initialized empty Git repository
in /home/ben/ubuntu-kernel/alsa-git/alsa-driver/.git/
The authenticity of host 'git.alsa-project.org (212.20.107.51)' can't be
established.
RSA key fingerprint is da:f5:f8:5c:ed:a3:bc:78:a5:67:09:41:b6:a8:64:22.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'git.alsa-project.org,212.20.107.51' (RSA) to
the list of known hosts.
Password: 
Permissions on the password database may be too restrictive.
-----------------------------------------------------------
(I tried an empty password.)

So, can you please publish the RSA key fingerprint, and tell us how to
gain public read access?

I'd like to upload some changes later, do I need an account or something
to do that? Or just submit to ML? My changes *will* need review before
commit.

Thanks,
Ben Stanley.




On Tue, 2008-05-20 at 13:21 +0200, Jaroslav Kysela wrote:
> Hi all,
> 
> 	I finished migration from HG to GIT. All repositories are 
> converted and we have one "new" repository - alsa-kernel.git which is full 
> Linux 2.6 GIT tree. The old HG alsa-kernel repository was renamed to 
> alsa-kmirror - just to track our changes in continuous timeline for 
> releases and packaging. HG access to all repositories is closed now.
> 	More information can be obtained here:
> 
> http://www.alsa-project.org/main/index.php/GIT_Server
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
