From: Travis Place <wishie@wishie.net>
Subject: Re: alsa-info.sh debugging script
Date: Tue, 5 Feb 2008 00:23:19 +1000
Message-ID: <200802050023.19822.wishie@wishie.net>
References: <200802022334.42705.wishie@wishie.net>
	<Pine.LNX.4.61.0802041257040.8166@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B69D24433
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 15:26:00 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id 8F04C2E2F9
	for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2008 14:47:57 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0802041257040.8166@tm8103.perex-int.cz>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 4 Feb 2008 10:01:04 pm Jaroslav Kysela wrote:
> On Sat, 2 Feb 2008, Travis Place wrote:
> > Hi everyone,
> >
> > I am new to this list, so be nice please :P
> >
> > I am the author of the alsa-info.sh debugging script, and heard you may
> > want to use it within ALSA.. I have been speaking to Tobin, and he
> > mentioned that a few things may need to be added (like alsactl output).
> >
> > I just want to get some ideas of things i can add, and if they should be
> > included automatically, or require a --with-alsactl (for example).
> >
> > I have added the alsactl output to the script now, its included by
> > default.. Any other ideas/changes that need to be made ?
>
> Hi,
>
> 	First, thank you for your contribution. I just played with script
> and added alsactl functionality, too. (Sorry for duplicate work.) Also, I
> made few other changes to show --help, --about, --update without
> /tmp/alsa-info.txt file processing.
> 	The alsa-info.sh is hosted in HG repository now available at:
>
> http://hg.alsa-project.org/alsa/raw-file/tip/alsa-info.sh
> http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh
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

Also note, the --update code is fairly flawed, and prone to errors, but it was 
ok, since i was manually controlling the version numbers, and knew what to 
avoid.. basically, if the version number on the server is different at all 
(higher OR lower) it will download the copy from the server.. perhaps someone 
can help implement a better mechanism..

To be honest, this script was my first real bash script.. I was (and still am) 
a bash newbie, so to speak.

Travis Place

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
