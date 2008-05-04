From: Bart de Boer <bart@mediawave.nl>
Subject: Spdif clock switching?
Date: Sun, 04 May 2008 12:19:10 +0200
Message-ID: <481D8D9E.8030905@mediawave.nl>
References: <4819E4FD.9030902@mediawave.nl>	<5bdc1c8b0805011046y6da8c71ew673e54d1c0dd9414@mail.gmail.com>	<481A6982.602@mediawave.nl>
	<481ADCDC.9050009@mediawave.nl>	<20080502150538.GF3811@sewage.raw-sewage.fake>	<481C3E92.9010305@mediawave.nl>
	<87abj74m3n.fsf@gandalf.hd.free.fr>	<481C5CAC.9020200@mediawave.nl>
	<878wyrs7j9.fsf@gandalf.hd.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr10.xs4all.nl (smtp-vbr10.xs4all.nl [194.109.24.30])
	by alsa0.perex.cz (Postfix) with ESMTP id AE0DB244B3
	for <alsa-devel@alsa-project.org>;
	Sun,  4 May 2008 12:19:02 +0200 (CEST)
In-Reply-To: <878wyrs7j9.fsf@gandalf.hd.free.fr>
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


Hi all,

I have some weird behavior with my Realtek ALC650F chip and it was 
suggested at Alsa-user (by Dominique Dumont) to post my case here. It 
may concern a bug in the via82xx driver. I've used the same subject at 
Alsa-user in case someone wants to check the discussion over there.

I'm trying to get all audio (44.1 kHz music and 48 kHz video) through my 
SPDIF link. I have succeeded at this. I am able to get bitperfect 44.1 
kHz digital audio with MythMusic and I'm able to get bitperfect 48 kHz 
digital audio with mplayer. However, after playing 48 kHz material the 
system doesn't switch back to 44.1 kHz mode! It seems to be stuck at 48 
kHz. The only way to trigger the system back into 44.1 kHz is to play 
some 44.1 kHz sample through the iec958 device (which will play the 44.1 
kHz sample too fast at 48 kHz). After this I'm able to get 44.1 kHz 
digital audio through the analog device again. :|


These are the settings I'm using:

alsamixer
=========
Unmute "IEC958"
Set "IEC958 Playback AC97-SPSA" to 0 (0%)


MythTV (General)
================
Audio output device: ALSA:default
SPDIF passthrough device: ALSA:iec958:{AES0 0x02}
[x] enable AC3 to SPDIF passthrough
[x] enable DTS to SPDIF passthrough


MythTV (Music)
==============
Audio output device: default


Ubuntu 8.04 - Sound Preferences
===============================
Everything set to: Intel ICH5 - IEC958


.asoundrc
=========
pcm.!default {
   type plug
   slave.pcm "analog-hw"
   # slave.pcm "digital-hw"
   # slave.pcm "dmix-digital"
}

ctl.!default {
   type hw
   card 0
}

pcm.analog {
   type plug
   slave.pcm "analog-hw"
}

ctl.analog {
   type hw
   card 0
}

pcm.analog-hw {
   type hw
   card 0
   ## The default value for device is 0, so no need to specify
   ##  - Uncomment one of the below or create a new "device N" line as 
appropriate
   ##    for your sound card or
   # device 1
   # device 4
}

ctl.analog-hw {
  type hw
  card 0
}

pcm.digital-hw {
   type hw
   card 0
   ## - Comment out "device 1" above and uncomment one of the below or 
create a
   ##   new "device N" line as appropriate for your sound card or
   # device 1
   # device 2
   device 4
}

ctl.digital-hw {
   type hw
   card 0
}

pcm.dmix-digital {
   type dmix
   ipc_key 1235
   slave {
      pcm "digital-hw"
      period_time 0
      period_size 1024
      buffer_size 4096
      rate 48000
   }
}

ctl.dmix-digital {
   type hw
   card 0
}


mplayer config
==============
monitoraspect=16:9
fs=yes
vo=xv
# ao=alsa
ao=alsa:device=iec958
# ao=alsa:device=hw=0.4
# ao=alsa:device=spdif
afm=hwac3


$ cat /proc/asound/card0/codec97#0/ac97#0-0
===========================================
0-0/0: Realtek ALC650F

PCI Subsys Vendor: 0x1509
PCI Subsys Device: 0x9202

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=3/4 SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 44100Hz
SPDIF Control    : Consumer PCM Copyright Category=0x2 Generation=1 
Rate=44.1kHz
SPDIF In Status  : Not Locked



I hope someone can shed some light. :)

Bart
