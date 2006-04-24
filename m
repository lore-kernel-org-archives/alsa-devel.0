From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002055]: Sis 7012 - Only get Sound with headPhone on my laptop
Date: Mon, 24 Apr 2006 22:08:16 +0200
Message-ID: <81c19e5d4adbdd078a35bf164dad3dfd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2743174
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 22:08:16 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2055> 
======================================================================
Reported By:                cYrAX
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2055
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.15
======================================================================
Date Submitted:             04-21-2006 20:11 CEST
Last Modified:              04-24-2006 22:08 CEST
======================================================================
Summary:                    Sis 7012 - Only get Sound with headPhone on my
laptop
Description: 
Hi,

I've got a sound card with SiS 7012 Chipset on my laptop (Medion Sim
2000)

I've (a low) sound when i use a HeadPhone but if i disconnect HeadPhone, i
don't have any sound.

I try a lot of combinaisons of mixer with alsamixer/amixer but any
combinaisons works.


Here is my sound configuration : ( i use 1.0.11 Alsa Driver)

lspci | grep audio
~~~~~~~~~~~~~~~~~~

Multimedia audio controller: Silicon Integrated Systems [SiS] Sound
Controller (rev a0)

lshw -C sound
~~~~~~~~~~~~~

  *-multimedia
       description: Multimedia audio controller
       product: Sound Controller
       vendor: Silicon Integrated Systems [SiS]
       physical id: 2.7
       bus info: pci@00:02.7
       version: a0
       width: 32 bits
       clock: 33MHz
       capabilities: bus_master cap_list
       configuration: driver=Intel ICH
       resources: ioport:e800-e8ff ioport:ec00-ec7f irq:10


lsmod | grep snd

snd_pcm_oss            34080  0
snd_mixer_oss          14336  1 snd_pcm_oss
snd_seq_dummy           2820  0
snd_seq_oss            27776  0
snd_seq_midi_event      5504  1 snd_seq_oss
snd_seq                40912  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device          6668  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_intel8x0           26012  2
snd_ac97_codec         80032  1 snd_intel8x0
snd_ac97_bus            1920  1 snd_ac97_codec
snd_pcm                66696  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              17796  2 snd_seq,snd_pcm
snd                    42688  14
snd_pcm_oss,snd_mixer_oss,snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc          7688  2 snd_intel8x0,snd_pcm


amixer
~~~~~~

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 2 [6%] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Surround Jack Mode',0
  Capabilities:
  Mono:
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [off]
  Front Right: Playback 31 [100%] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic Select',0
  Capabilities:
  Mono:
Simple mixer control 'Video',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [on]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%]
Simple mixer control 'IEC958 Playback Source',0
  Capabilities:
  Mono:
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [on]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [on]
  Front Right: Playback 31 [100%] [on] Capture [on]
Simple mixer control 'Mono Output Select',0
  Capabilities:
  Mono:
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [on]
  Front Right: Capture 0 [0%] [on]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Channel Mode',0
  Capabilities:
  Mono:
Simple mixer control 'Duplicate Front',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]




Anyone have a solution?
Is it a Bug?
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-24-06 21:51 
----------------------------------------------------------------------
Sounds like a bug, I'm not sure there's anything you can do but wait for a
fix.  It's only been 3 days since you submitted the report and 2 of those
were weekend days.

Try toggling "External Amplifier"

----------------------------------------------------------------------
 cYrAX - 04-24-06 22:08 
----------------------------------------------------------------------
Ok sorry to be impatient.
I have already mute/unmute all possible channels with alsamixer.
It seems to be a bug.
But this problem is not really a new bug.
I hope alsa developpers fix it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-06 20:11 cYrAX          New Issue                                    
04-21-06 20:11 cYrAX          Distribution              => Gentoo          
04-21-06 20:11 cYrAX          Kernel Version            => 2.6.15          
04-24-06 21:35 cYrAX          Note Added: 0009479                          
04-24-06 21:51 rlrevell       Note Added: 0009480                          
04-24-06 22:08 cYrAX          Note Added: 0009481                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
