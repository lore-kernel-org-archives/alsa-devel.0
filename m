From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: HG vs GIT
Date: Fri, 08 Feb 2008 00:06:33 +1100
Message-ID: <47AB0259.6060604@superbug.co.uk>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id B8379103833
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 14:05:56 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
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

Jaroslav Kysela wrote:
> Hi,
>
> 	it seems that GIT matured somewhat. git-push has been implemneted. 
> It was main reason to not use GIT when we made decision between HG and 
> GIT.
> 	As we could have potential problems with branches in HG 
> repository, I would like to consider a switch to GIT althought it means 
> some changes in my scripts on ALSA server and my ksync tool.
> 	I just successfully tried (a bit modified hg-to-git.py script) and 
> it seems to be working properly.
> 	Any objections?
>
> 						Jaroslav
>   
I have no problem with moving to git.
Just so long as we can still create alsa-driver packages from it.
Will the git tree just be alsa-kernel, or will it be the entire linux 
kernel with the latest alsa additions?

James
