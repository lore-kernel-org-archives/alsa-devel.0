From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: git down?
Date: Wed, 4 Jun 2008 16:59:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806041659200.1798@tm8103-a.perex-int.cz>
References: <58658.220.233.78.168.1212589386.squirrel@webmail.exetel.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 049FC2441D
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 16:59:45 +0200 (CEST)
In-Reply-To: <58658.220.233.78.168.1212589386.squirrel@webmail.exetel.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ben.stanley@exemail.com.au
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 5 Jun 2008 ben.stanley@exemail.com.au wrote:

> I'm having trouble with git:
> 
> ben@mythtv:~/alsa-git$ git clone
> git://git.alsa-project.org/alsa-driver.git alsa-driver
> Initialized empty Git repository in /home/ben/alsa-git/alsa-driver/.git/
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'git://git.alsa-project.org/alsa-driver.git' failed.
> ben@mythtv:~/alsa-git$
> 
> Anyone else seeing this?

Sorry, git-daemon-export-ok files were missing in repos on server. It's 
fixed now. Thanks for notice.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
