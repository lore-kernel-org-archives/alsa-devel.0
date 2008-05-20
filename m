From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HG -> GIT migration
Date: Tue, 20 May 2008 16:24:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805201620240.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>
	<1211292748.3811.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id F255924819
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 16:24:26 +0200 (CEST)
In-Reply-To: <1211292748.3811.7.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Stanley <Ben.Stanley@exemail.com.au>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 May 2008, Ben Stanley wrote:

> Jaraslay,
> 
> I tried tonight to run
> 
> git clone git@git.alsa-project.org:alsa-driver.git alsa-driver

Use anonymous access, please, as described on wiki:

 git clone git://git.alsa-project.org/alsa-driver.git alsa-driver

> I'd like to upload some changes later, do I need an account or something
> to do that? Or just submit to ML? My changes *will* need review before
> commit.

Yes, use ML to post your patches (you may use handy git-format-patch and 
git-send-email). One of developers with write access will push your 
changes to GIT tree after review.

				Thanks,	
					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
