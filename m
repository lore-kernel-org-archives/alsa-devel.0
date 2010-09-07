From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 7 Sep 2010 16:42:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<alpine.LNX.2.00.1008231907170.10278@eeebox2.perex-int.cz>
	<1282640988.3053.43.camel@odin>
	<alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D87BC244A8
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 16:42:58 +0200 (CEST)
In-Reply-To: <1283864698.3048.26.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Sep 2010, Liam Girdwood wrote:

> Hi Jaroslav,
>
> Any update on this ? I have someone scheduled to write new use case
> files and someone else ready to add PA support.

Hi,

I'm working on this. Unfortunately, I have other things which interrupts 
this work. The actual code is at:

http://git.alsa-project.org/?p=alsa-lib.git;a=shortlog;h=ucm

During coding, it appears that even the handling of controls might be 
changed. Your code has everything build-in. I'm not sure why to restrict 
the card/verb/modifier/transition definitions only for the universal 
control API. I think that it might be more "easy to understand" and 
universal to define just sequence of commands like:

SectionDefaults [
         exec "amixer cset name='Master Playback Switch',index=2 1,1"
         exec "amixer cset name='Master Playback Volume',index=2 25,25"
         exec "amixer cset name='Master Mono Playback',index=1 0"
         exec "amixer cset name='Master Mono Playback Volume',index=1 0"
         msleep 50 # or: exec "usleep 50000"
         exec "amixer cset name='PCM Switch',index=2 1,1"
         ........
]

Because "amixer cset" command will be probably most used command, we can 
eventually move the amixer code to alsa-lib to not create so much 
processes and speed-up things.

It means that the ucm should not track card controls, but commands for 
transitions.

The only thing which might "broke" things is calling fork from a pthread:

http://unix.derkeiler.com/Newsgroups/comp.unix.programmer/2003-09/0672.html

But it seems that fork/immediate-exec is an acceptable way.

Comments?

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
