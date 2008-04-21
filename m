From: Andy Green <andy@warmcat.com>
Subject: Acer Aspire 8920g / snd-hda-intel / ALC889
Date: Mon, 21 Apr 2008 13:02:40 +0100
Message-ID: <480C8260.70501@warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.mog.warmcat.com (purr.warmcat.com [87.106.142.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 62CDC243DC
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 14:02:48 +0200 (CEST)
Received: from armbox7.home.warmcat.com
	(cpc1-nthc5-0-0-cust289.nrth.cable.ntl.com [82.29.29.34])
	by mailserver.mog.warmcat.com (Postfix) with ESMTP id 2F3081B409E
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 13:02:47 +0100 (BST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by armbox7.home.warmcat.com (Postfix) with ESMTP id D6605F3BD
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 12:05:23 +0000 (UTC)
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

Hi folks -

I have a new 8920g on Fedora development running 2.6.25 which has

$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.16rc2 (Thu Jan 31 
16:40:16 2008 UTC).

I get a decent looking set of alsa things in /proc/asound

$ cat /proc/asound/cards
  0 [Intel          ]: HDA-Intel - HDA Intel
                       HDA Intel at 0xfc300000 irq 22

and dmesg says that model=acer was selected reasonably enough.

I can play audio down the logical sound devices, including cat 
/dev/urandom > /dev/dsp and the interrupt count goes up in /proc/interrupts.

Alsamixer shows a bunch of things and I twiddled them all to no avail. 
There has never been even a click from the speakers or headphone jack on 
this machine.

At least three funnies on this machine:

1) It is confused if it has ALC889 or ALC883 in there

$ grep ALC /proc/asound/* -R
/proc/asound/card0/codec#0:Codec: Realtek ALC889    <==== 889
/proc/asound/card0/pcm2c/sub0/info:id: ALC883 Analog  <=== 883...
/proc/asound/card0/pcm2c/sub0/info:name: ALC883 Analog
/proc/asound/card0/pcm2c/info:id: ALC883 Analog
/proc/asound/card0/pcm2c/info:name: ALC883 Analog
/proc/asound/card0/pcm0c/sub0/info:id: ALC883 Analog
/proc/asound/card0/pcm0c/sub0/info:name: ALC883 Analog
/proc/asound/card0/pcm0c/info:id: ALC883 Analog
/proc/asound/card0/pcm0c/info:name: ALC883 Analog
/proc/asound/card0/pcm0p/sub0/info:id: ALC883 Analog
/proc/asound/card0/pcm0p/sub0/info:name: ALC883 Analog
/proc/asound/card0/pcm0p/info:id: ALC883 Analog
/proc/asound/card0/pcm0p/info:name: ALC883 Analog
/proc/asound/Intel/codec#0:Codec: Realtek ALC889    <=== 889
/proc/asound/Intel/pcm2c/sub0/info:id: ALC883 Analog
/proc/asound/Intel/pcm2c/sub0/info:name: ALC883 Analog
/proc/asound/Intel/pcm2c/info:id: ALC883 Analog
/proc/asound/Intel/pcm2c/info:name: ALC883 Analog
/proc/asound/Intel/pcm0c/sub0/info:id: ALC883 Analog
/proc/asound/Intel/pcm0c/sub0/info:name: ALC883 Analog
/proc/asound/Intel/pcm0c/info:id: ALC883 Analog
/proc/asound/Intel/pcm0c/info:name: ALC883 Analog
/proc/asound/Intel/pcm0p/sub0/info:id: ALC883 Analog
/proc/asound/Intel/pcm0p/sub0/info:name: ALC883 Analog
/proc/asound/Intel/pcm0p/info:id: ALC883 Analog
/proc/asound/Intel/pcm0p/info:name: ALC883 Analog
/proc/asound/oss/sndstat:0: ALC883 Analog (DUPLEX)
/proc/asound/oss/sndstat:0: Realtek ALC889
/proc/asound/pcm:00-02: ALC883 Analog : ALC883 Analog : capture 1
/proc/asound/pcm:00-00: ALC883 Analog : ALC883 Analog : playback 1 : 
capture 1

2) from dmesg

ALSA sound/pci/hda/hda_intel.c:1810: chipset global capabilities = 0x4401
ALSA sound/pci/hda/hda_intel.c:749: codec_mask = 0x3
ALSA sound/pci/hda/hda_codec.c:2211: hda_codec: model 'acer' is selected
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Headphone 
Playback Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback 
Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback 
Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Line-Out Playback 
Volume, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Speaker Playback 
Switch, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave Mono Playback 
Switch, skipped
ALSA sound/pci/hda/hda_codec.c:1073: Cannot find slave IEC958 Playback 
Switch, skipped

3) there is a funny embedded capacitive volume control thing on this 
device, whether it gates output by itself or is just a bunch of special 
keyboard keys, I dunno.

Any ideas, more information needed?

-Andy
