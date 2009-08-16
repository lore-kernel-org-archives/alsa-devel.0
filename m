From: ruchi sirauthiya <ruchisirauthiya@gmail.com>
Subject: Error enabling dmix with ALSA
Date: Sun, 16 Aug 2009 15:49:11 +0530
Message-ID: <3a2444df0908160319q790d7460l171fa52be7c29aca@mail.gmail.com>
References: <3a2444df0908150606p7a1cb237qad6d31dedae3ec4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C6C824353
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Aug 2009 12:19:32 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so937834anc.2
	for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2009 03:19:31 -0700 (PDT)
In-Reply-To: <3a2444df0908150606p7a1cb237qad6d31dedae3ec4a@mail.gmail.com>
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

Hi,

I am trying to enable a software mixer (using ALSA and dmix) on an OMAP3
based embedded target board using the twl4030 codec.

When I try to play audio using the command,

# aplay -D playback rec.wav

I am getting the following error:

ALSA lib pcm_direct.c:1098:(snd_pcm_direct_initialize_poll_fd) unable to
open timer 'hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0'
ALSA lib pcm_dmix.c:943:(snd_pcm_dmix_open) unable to initialize poll_fd
aplay: main:546: audio open error: No such file or directory

The contents of my /etc/asound.conf is given below.

pcm.playback {
   type dmix
   ipc_key 2048
   ipc_key_add_uid true
   ipc_gid 1
   slave {
      rate 44100
      pcm hw:0
   }
}

I have tested it on two kernel versions, 2.6.22 and 2.6.29, but it fails on
both.
Playback and recording works fine if -D option is not provided.

I also tried configuring ALSA (dmix) with a different configuration file
which is given in the following link:
http://amarok.kde.org/wiki/Setting_up_Dmix_for_ALSA

# aplay -D plug:ossmix /mnt/Audio1_1.wav
ALSA lib pcm_direct.c:1098:(snd_pcm_direct_initialize_poll_fd) unable to
open timer 'hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0'
ALSA lib pcm_dmix.c:943:(snd_pcm_dmix_open) unable to initialize poll_fd
aplay: main:546: audio open error: No such file or directory

But as you can see the same error turns up again.

The topic discussed in the following link (a similar issue) suggests that it
is unable to open a second timer.
http://osdir.com/ml/linux.distributions.crux.general/2005-11/msg00134.html

What could be the cause of this error?

Is the above error related to my ALSA configuration (for dmix) or is it
related to the sound hardware (or driver)?
Do I need to patch the kernel or ALSA for using dmix?

Please help me resolve this issue. Let me know if any more setup info is
required.

Thanks and Regards,

Ruchi Sirauthiya.



Some information I obtained from the proc filesystem is given below for your
reference.

-----------------------
For Linux kernel 2.6.29
-----------------------

[root@OMAP3 tests]# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.19


[root@OMAP3 tests]# cat /proc/asound/cards
 0 [omap3evm       ]: twl4030 - omap3evm
                      omap3evm (twl4030)

[root@OMAP3 tests]# omap-dss: Could not find exact pixel clock. Requested
25188 kHz, got 25187 kHz

[root@OMAP3 tests]# cat /proc/asound/devices
  2:        : timer
  3: [ 0- 0]: digital audio playback
  4: [ 0- 0]: digital audio capture
  5: [ 0]   : control

[root@OMAP3 tests]# cat /proc/asound/timers
G0: system timer : 7812.500us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE

[root@OMAP3 tests]# cat /proc/asound/pcm
00-00: TWL4030 twl4030-0 :  : playback 1 : capture 1

[root@OMAP3 tests]# cat /proc/asound/devices
  2:        : timer
   3: [ 0- 0]: digital audio playback
  4: [ 0- 0]: digital audio capture
  5: [ 0]   : control

[root@OMAP3 tests]# cat /proc/asound/pcm
00-00: TWL4030 twl4030-0 :  : playback 1 : capture 1

[root@OMAP3 tests]# cat /proc/asound/oss/devices
  3: [0- 0]: digital audio
  4: [0- 0]: digital audio

[root@OMAP3 tests]# cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA v1.0.19 emulation code)
Kernel: Linux OMAP3 2.6.29-rc3-omap1 #1 Fri Jul 24 14:45:37 IST 2009 armv7l
Config options: 0
Installed drivers:
Type 10: ALSA emulation

Card config:
omap3evm (twl4030)

Audio devices:
0:  (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices: NOT ENABLED IN CONFIG

Timers:
31: system timer

Mixers: NOT ENABLED IN CONFIG

[root@OMAP3 tests]# aplay -D playback /mnt/Audio1_1.wav
ALSA lib pcm_direct.c:1098:(snd_pcm_direct_initialize_poll_fd) unable to
open timer 'hw:CLASS=3,SCLASS=0,CARD=0,DEV=0,SUBDEV=0'
ALSA lib pcm_dmix.c:943:(snd_pcm_dmix_open) unable to initialize poll_fd
aplay: main:546: audio open error: No such file or directory


-----------------------
For Linux kernel 2.6.22
-----------------------

[root@OMAP3 tests]# cat /proc/asound/devices
  2:        : timer
  3: [ 0- 0]: digital audio playback
  4: [ 0- 0]: digital audio capture
  5: [ 0]   : control

[root@OMAP3 tests]# cat /proc/asound/pcm
00-00: OMAP PCM : omap alsa pcm : playback 1 : capture 1

[root@OMAP3 tests]# cat /proc/asound/timers
G0: system timer : 7812.500us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE

[root@OMAP3 tests]# cat /proc/asound/
/proc/asound/TWL4030/  /proc/asound/devices   /proc/asound/timers
/proc/asound/card0/    /proc/asound/hwdep     /proc/asound/version
/proc/asound/cards     /proc/asound/pcm

[root@OMAP3 tests]# cat /proc/asound/cards
 0 [TWL4030        ]: OMAP_ALSA - TWL4030
                      TWL4030

/proc/asound/oss was not found in the proc file system when booted with
kernel 2.6.22.
