From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: More CS4630, secondary CODEC output.
Date: Fri, 02 Aug 2002 07:51:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4A1DDF.2090404@cucumelo.org>
References: <3D41D4DC.60004@cucumelo.org>	<s5h1y9ic3xs.wl@alsa2.suse.de>	<3D4901D9.7040409@cucumelo.org>	<s5hwuraalt8.wl@alsa2.suse.de> <s5hptx2agxp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA01127
	for <alsa-devel@alsa-project.org>; Fri, 2 Aug 2002 08:41:45 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>
>
>about the secondary codec on terratec xfire: it's still not detected.
>could you test the latest cvs driver?  i'm afraid that i did something
>wrong in merging...
>

I've done a quick test with the CVS code now, and it seems to work just 
fine, i just got some newbie
questions,  how do activate CONFIG_SND_CS46XX without modifying the 
Makefile?, how do
I activate the snd_printd ? , (without modifying config.h)

About the secondary codec on the terratex xfire card, can we try to 
trace exactly where it failed
to detect it, I would like to know.

On the "Turtle Beach Santa Cruz" now i know that GPIO7/GPIO8 on sec. 
codec controls back speakers, that's not done yet,
But I would like to know if current code at least detects the secondary 
CODEC successfully. In theory it should.

I would like to build a list with card and of DSP and codec (only cs46xx 
cards), please helpme to complete this list.

Hercules Game Theater XP
dsp: cs4630
primary codec: cs4294
secondary codec: cs4294
EPGIO2 controls ext. amplifier

Turtle Beach Santa Cruz
dsp: cs4630
primary codec: cs4294
secondary codec: cs4297A
GPIO7/GPIO8 on secondary codec controls back speakers support

Terratec XFIRE:
dsp: cs4630
primary codec:  ????
secondary codec:  ????
????

....


A small fix to cs46xx_lib.c, it does not make any sense calling 
playback_transfer before the PCMreader is linked or Playback controll 
register set to 0. && I would like to update the TODO text to something 
else.

--- ../../cvs_ref/alsa-kernel/pci/cs46xx/cs46xx_lib.c    Thu Aug  1 
14:30:52 2002
+++ alsa-kernel/pci/cs46xx/cs46xx_lib.c    Fri Aug  2 07:22:34 2002
@@ -8,11 +8,11 @@
  *    --
  *
  *  TODO:
- *    We need a DSP code to support multichannel outputs and S/PDIF.
- *    Unfortunately, it seems that Cirrus Logic, Inc. is not willing
- *    to provide us sufficient information about the DSP processor,
- *    so we can't update the driver.
+ *    SPDIF input.
+ *    Secondary CODEC on some soundcards
  *
+ *  NOTE: with CONFIG_SND_CS46XX_NEW_DSP unset uses old DSP image 
(which is default
+ *   configuration), no SPDIF, no secondary codec, no multi channel 
PCM. But known to work.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -334,7 +334,6 @@
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 
-// #include "imgs/cwcemb80.h"
 #include "imgs/cwc4630.h"
 #include "imgs/cwcasync.h"
 #include "imgs/cwcsnoop.h"
@@ -880,8 +879,6 @@
     switch (cmd) {
     case SNDRV_PCM_TRIGGER_START:
     case SNDRV_PCM_TRIGGER_RESUME:
-        if (substream->runtime->periods != CS46XX_FRAGS)
-            snd_cs46xx_playback_transfer(substream, 0);
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
         if (cpcm->pcm_channel->unlinked)
             cs46xx_dsp_pcm_link(chip,cpcm->pcm_channel);
@@ -892,6 +889,8 @@
         snd_cs46xx_poke(chip, BA1_PCTL, chip->play_ctl | tmp);
         }
 #endif
+        if (substream->runtime->periods != CS46XX_FRAGS)
+           snd_cs46xx_playback_transfer(substream, 0);
         break;
     case SNDRV_PCM_TRIGGER_STOP:
     case SNDRV_PCM_TRIGGER_SUSPEND:





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
