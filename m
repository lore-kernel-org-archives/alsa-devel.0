From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000965]: No Sound from Right Surround Speaker
Date: Sun, 6 Mar 2005 13:27:18 +0100
Message-ID: <7a97b08726667198b5886968ebe54f0c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 318E5188
	for <alsa-devel@alsa-project.org>; Sun,  6 Mar 2005 13:27:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=965> 
======================================================================
Reported By:                imac
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   965
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sid
Kernel Version:             2.6.11-rc4 (And many many kernels earlier)
======================================================================
Date Submitted:             03-06-2005 01:23 CET
Last Modified:              03-06-2005 13:27 CET
======================================================================
Summary:                    No Sound from Right Surround Speaker
Description: 
This bug has been around since 0000043 (Original ALSA Bugtrack #)
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=43
Lots of details there, but a bad bug description.  Here's my current
details
BTW, the profile pulldown in the bug form was empty :)

Let me know how I can help debug this further, if there is no trivial
fix.

****LSPCI:
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: ABIT Computer Corp.: Unknown device 1401
        Flags: medium devsel, IRQ 22
        I/O ports at cc00 [size=256]
        Capabilities: [c0] Power Management version 2

****AMIXER:
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 21 [68%] [on]
  Front Right: Playback 21 [68%] [on]
Simple mixer control 'Master Mono',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 19 [61%] [on]
Simple mixer control '3D Control - Center',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 15
  Mono: 0 [0%]
Simple mixer control '3D Control - Switch',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 16 [52%] [on]
  Front Right: Playback 16 [52%] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 28 [90%] [on]
  Front Right: Playback 31 [100%] [on]
Simple mixer control 'Surround Down Mix',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 24 [77%] [on]
Simple mixer control 'Center/LFE Down Mix',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 22 [71%] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 20 [65%] [on] Capture [off]
  Front Right: Playback 20 [65%] [on] Capture [off]
Simple mixer control 'Line-In As Surround',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [off] Capture [off]
  Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [on]
  Front Right: Capture [on]
Simple mixer control 'Mic As Center/LFE',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Mic Select',0
  Capabilities:
  Mono:
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [off] Capture [off]
  Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Phone',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 2 [67%]
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 0 [0%] [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 25 [81%] [on] Capture [off]
  Front Right: Playback 25 [81%] [on] Capture [off]
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
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Analog to IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Duplicate Front',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Exchange Center/LFE',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Input Source Select',0
  Capabilities:
  Mono:
Simple mixer control 'Input Source Select',1
  Capabilities:
  Mono:
Simple mixer control 'Swap Surround Slot',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'VIA DXS',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%]
  Front Right: Playback 31 [100%]
Simple mixer control 'VIA DXS',1
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%]
  Front Right: Playback 31 [100%]
Simple mixer control 'VIA DXS',2
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%]
  Front Right: Playback 31 [100%]
Simple mixer control 'VIA DXS',3
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%]
  Front Right: Playback 31 [100%]

****PROC/CODEC97
0-0/0: Realtek ALC650D

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
Extended ID      : codec=0 rev=1 AMAP LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=6/9 SPDIF VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=44.1kHz


0:00 = 5980
0:02 = 0a0a
0:04 = 0000
0:06 = 000c
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 0b0b
0:12 = 9f1f
0:14 = 9f1f
0:16 = 0606
0:18 = 0f0f
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 07c7
0:2a = 05e5
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = 0000
0:36 = 0907
0:38 = 0380
0:3a = 0824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 4001
0:6c = 0000
0:6e = 0003
0:70 = 0211
0:72 = 6aa9
0:74 = 0063
0:76 = 0001
0:78 = 8102
0:7a = 57c0
0:7c = 414c
0:7e = 4720


======================================================================

----------------------------------------------------------------------
 slammer - 03-06-05 13:27 
----------------------------------------------------------------------
This looks identically like the issue for intel8x0 driver that I reported
at https://bugtrack.alsa-project.org/alsa-bug/view.php?id=902
Maybe it is related somehow, however this appeared in the versions around
1.08 and it's rc. There was no such problem i.e. in 1.07 so i suggest
checking if it's the case with your card.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-06-05 01:23 imac           New Issue                                    
03-06-05 01:23 imac           Distribution              => Debian Sid      
03-06-05 01:23 imac           Kernel Version            => 2.6.11-rc4 (And many
many kernels earlier)
03-06-05 13:21 slammer        Issue Monitored: slammer                     
03-06-05 13:27 slammer        Note Added: 0003805                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
