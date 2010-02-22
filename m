From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 2.6.31.x vs. rme vs. alsa 1.0.22?
Date: Mon, 22 Feb 2010 23:51:29 +0000
Message-ID: <1266882689.3704.178.camel@localhost.localdomain>
References: <1266371882.3361.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.stanford.edu (smtp5.Stanford.EDU [171.67.219.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E22E244B4
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 00:52:16 +0100 (CET)
In-Reply-To: <1266371882.3361.40.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Linux Audio Developers' Mailing List <linux-audio-dev@lists.linuxaudio.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-02-16 at 17:58 -0800, Fernando Lopez-Lezcano wrote:
> Hey, has anyone been seeing strange behavior from this combination?
> 
>   kernel 2.6.31.x rt20 + alsa 1.0.22 userland
>   RME card (pcmcia card + multiface)
> 
> hdspmixer is not doing the right thing (does not initialize the card in
> a way in which playback works), it does not see the hwdep interface (or
> something like that) and disables metering,

This is what hdspmixer prints when I attempt to run it:

----
$ hdspmixer

HDSPMixer 1.6 - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>
This program comes with ABSOLUTELY NO WARRANTY
HDSPMixer is free software, see the file COPYING for details

Looking for HDSP cards :
Card 0 : HDA Intel at 0xfe020000 irq 17
Card 1 : RME Hammerfall DSP + Multiface at 0xc0000000, irq 16
Multiface found !
1 Hammerfall DSP card found.
Initializing default presets
HwDep ioctl failed. Metering stopped
----

> alsamixer even segfaults
> when I reach the end of the controls listed. Plain weird. Smells like
> something changed deep in the kernel that makes alsa-lib very unhappy.
> Alsa-tools rebuilt from source does not make a difference. 
> 
> Weirdness goes away when I boot into 2.6.29.6 rt23...
> 
> Is there anything in alsa-* that depends on which _kernel_ is available
> at compile time?

I have been trying to see if I can figure _anything_ out of this...

A diff of 2.6.29 (last known working) against 2.6.31.12 reveals
something that might have an influence on the problem:

in snd_hdsp_create_hwdep there are two lines added:

+ hw->ops.open = snd_hdsp_hwdep_dummy_op;
  hw->ops.ioctl = snd_hdsp_hwdep_ioctl;
+ hw->ops.release = snd_hdsp_hwdep_dummy_op;

And snd_hdsp_hwdep_dummy_op just returns 0...

Other differences between the two files (not that many) seem irrelevant
to me. 

I imagine this is what is causing the difference in behavior (hwdep
fails). Any suggestions on what I could try to fix this?

Thanks for any help!

-- Fernando
