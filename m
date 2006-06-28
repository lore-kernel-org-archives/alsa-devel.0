From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002240]: no microphone capture from
	motherboard onboard sound using intel8x0 driver
Date: Wed, 28 Jun 2006 18:21:17 +0200
Message-ID: <be4cec372482474b65f2a742026151bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98D9327B
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 18:21:17 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2240> 
======================================================================
Reported By:                Alexis_Cousein
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2240
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE 10.1
Kernel Version:             2.6.16.13-4-smp
======================================================================
Date Submitted:             06-28-2006 18:21 CEST
Last Modified:              06-28-2006 18:21 CEST
======================================================================
Summary:                    no microphone capture from motherboard onboard sound
using intel8x0 driver
Description: 
I'm using Skype on (ugh!) Windows for the moment, and microphone is fully
functional. Plugged in the back of the PC (which should be Mic1); there's
a second Mic input at the front.

In SuSE 10.1, microphone doesn't work. krecord, arecord and Skype all
record silence (or a constant pitch signal at very high gains), even
though mixer settings appear correct.

Evidently, some parts of ALSA do think they're recording from the
microphone, because there is a 20dB boost to whatever constant pitch
thinggummie is recorded when toggling the Mic boost in the mixer.

Plugging Microphone in other port doesn't change anything; neither does
selecting Mic2 in the mixer panel.

lspci details:
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)

yggdrasil:/proc/asound/card0/codec97#0 # cat ac97#0-0
0-0/0: C-Media Electronics CMI9780

PCI Subsys Vendor: 0x1462
PCI Subsys Device: 0x0480

Revision         : 0x01
Compat. Class    : 0x04
Subsys. Vendor ID: 0x8086
Subsys. ID       : 0x1234

Capabilities     :
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 SPDIF DRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=10/11
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
yggdrasil:/proc/asound/card0/codec97#0 # cat ac97#0-0+regs
0:00 = 0000
0:02 = 0808
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 8000
0:0c = 0000
0:0e = 0040
0:10 = 9f1f
0:12 = 1f1f
0:14 = 8000
0:16 = 8000
0:18 = 0808
0:1a = 0000
0:1c = 0f0f
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0001
0:26 = 800f
0:28 = 0bc6
0:2a = 05f0
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 8080
0:38 = 8080
0:3a = 2824
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
0:5c = 0004
0:5e = 0000
0:60 = 0401
0:62 = 8086
0:64 = 1234
0:66 = 0000
0:68 = 0000
0:6a = 0000 

amixer output:

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 23 [74%] [on]
  Front Right: Playback 23 [74%] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 230 [90%] [on]
  Front Right: Playback 230 [90%] [on]
Simple mixer control 'Surround',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 31
  Mono: Playback 31 [100%] [off]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch enum
  Items: 'Front' 'Side' 'Center/LFE' 'Rear'
  Item0: 'Front'
  Item1: 'Front'
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [off] Capture [off]
  Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 0 [0%] [on] Capture [off]
  Front Right: Playback 0 [0%] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [on] Capture [on]
  Front Right: Playback 31 [100%] [on] Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic Select',0
  Capabilities: enum
  Items: 'Mic1' 'Mic2'
  Item0: 'Mic1'
Simple mixer control 'Video',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [off] Capture [off]
  Front Right: Playback 31 [100%] [off] Capture [off]
Simple mixer control 'Phone',0
  Capabilities: cswitch cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [off] Capture [off]
Simple mixer control 'IEC958 Capture Monitor',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Capture Valid',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%]
Simple mixer control 'IEC958 Playback Source',0
  Capabilities: enum
  Items: 'AC-Link' 'ADC' 'SPDIF-In'
  Item0: 'SPDIF-In'
Simple mixer control 'PC Speaker',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [off]
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 31 [100%] [off] Capture [off]
  Front Right: Playback 31 [100%] [off] Capture [off]
Simple mixer control 'Mono Output Select',0
  Capabilities: enum
  Items: 'Mix' 'Mic'
  Item0: 'Mix'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [on]
  Front Right: Capture 15 [100%] [on]
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
Simple mixer control 'DAC Clock Source',0
  Capabilities: enum
  Items: 'AC-Link' 'SPDIF-In' 'Both'
  Item0: 'Both'
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]









======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-28-06 18:21 Alexis_Cousein New Issue                                    
06-28-06 18:21 Alexis_Cousein Distribution              => SuSE 10.1       
06-28-06 18:21 Alexis_Cousein Kernel Version            => 2.6.16.13-4-smp 
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
