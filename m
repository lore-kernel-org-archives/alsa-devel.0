From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002240]: no microphone capture from
	motherboard onboard sound using intel8x0 driver
Date: Thu, 29 Jun 2006 19:18:32 +0200
Message-ID: <5e86e241e23ff1171fa3ef26c4ce8a98@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 271A929D
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 19:18:33 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Last Modified:              06-29-2006 19:18 CEST
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

----------------------------------------------------------------------
 Alexis_Cousein - 06-29-06 19:01 
----------------------------------------------------------------------
Incidentally, googling reveals I'm not the only one having seen this
problem - unfortunately the other user "resolved" the issue by giving up
and buying another sound card:

http://debianforum.de/forum/viewtopic.php?p=376068&sid=76136ce09f80ddd7772a307dccda623b

Here's the actl -f ... store output:

state.ICH5 {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Playback Switch'
                value true
        }
        control.2 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Master Playback Volume'
                value.0 23
                value.1 23
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Center Playback Switch'
                value false
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Center Playback Volume'
                value 31
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'LFE Playback Switch'
                value false
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'LFE Playback Volume'
                value 31
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Surround Playback Switch'
                value.0 false
                value.1 false
        }
        control.8 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PC Speaker Playback Switch'
                value false
        }
        control.9 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'PC Speaker Playback Volume'
                value 15
        }
        control.10 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Playback Switch'
                value true
        }
        control.11 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value.0 31
                value.1 31
        }
        control.12 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Boost (+20dB) Switch'
                value true
        }
        control.13 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Line Playback Switch'
                value false
        }
        control.14 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 0
                value.1 0
        }
        control.15 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'CD Playback Switch'
                value false
        }
        control.16 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'CD Playback Volume'
                value.0 0
                value.1 0
        }
        control.17 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Video Playback Switch'
                value false
        }
        control.18 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Video Playback Volume'
                value.0 31
                value.1 31
        }
        control.19 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Aux Playback Switch'
                value false
        }
        control.20 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 31
                value.1 31
        }
        control.21 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PCM Playback Switch'
                value true
        }
        control.22 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 2
                comment.item.0 Mic
                comment.item.1 CD
                comment.item.2 Video
                comment.item.3 Aux
                comment.item.4 Line
                comment.item.5 Mix
                comment.item.6 'Mix Mono'
                comment.item.7 Phone
                iface MIXER
                name 'Capture Source'
                value.0 Mic
                value.1 Mic
        }
        control.23 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Capture Switch'
                value true
        }
        control.24 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 15
                value.1 15
        }
        control.25 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mix
                comment.item.1 Mic
                iface MIXER
                name 'Mono Output Select'
                value Mix
        }
        control.26 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic1
                comment.item.1 Mic2
                iface MIXER
                name 'Mic Select Capture Switch'
                value Mic1
        }
        control.27 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.28 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
cf000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
        }
        control.29 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Default'
                value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.30 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Switch'
                value false
        }
        control.31 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 3'
                iface MIXER
                name 'IEC958 Playback AC97-SPSA'
                value 3
        }
        control.32 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 AC-Link
                comment.item.1 ADC
                comment.item.2 SPDIF-In
                iface MIXER
                name 'IEC958 Playback Source'
                value SPDIF-In
        }
        control.33 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Capture Valid Switch'
                value false
        }
        control.34 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Capture Monitor'
                value false
        }
        control.35 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Capture Switch'
                value false
        }
        control.36 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 AC-Link
                comment.item.1 SPDIF-In
                comment.item.2 Both
                iface MIXER
                name 'DAC Clock Source'
                value Both
        }
        control.37 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Side Playback Switch'
                value.0 true
                value.1 true
        }
        control.38 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Side Playback Volume'
                value.0 4
                value.1 1
        }
        control.39 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Front
                comment.item.1 Side
                comment.item.2 Center/LFE
                comment.item.3 Rear
                iface MIXER
                name 'Side Playback Route'
                value Front
        }
        control.40 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'External Amplifier'
                value false
        }
        control.41 {
                comment.access 'read write user'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 255'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 230
                value.1 230
        }
}

Mhhh - setting "Mix" as the capture source in alsamixer gives me a 9dB
(i.e. much louder) constant white noise to record, regardless of what is
played.

Bizarre thing, though, that alsamixer "Mix" capture source - "Mix" can't
be selected in alsamixergui as a capture source, and is totally absent
from kmix.

----------------------------------------------------------------------
 tiwai - 06-29-06 19:18 
----------------------------------------------------------------------
Also, attach the whole content of
/proc/asound/card0/codec97#0/ac97#0-0+regs file without trimming.

alsamixergui is an obsoleted app, and kmix is known to buggy for many
devices.
Use alsamixer on terminal to be sure.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-28-06 18:21 Alexis_Cousein New Issue                                    
06-28-06 18:21 Alexis_Cousein Distribution              => SuSE 10.1       
06-28-06 18:21 Alexis_Cousein Kernel Version            => 2.6.16.13-4-smp 
06-29-06 17:36 tiwai          Note Added: 0010670                          
06-29-06 18:36 Alexis_Cousein Note Added: 0010688                          
06-29-06 18:44 tiwai          Note Added: 0010690                          
06-29-06 19:01 Alexis_Cousein Note Added: 0010693                          
06-29-06 19:18 tiwai          Note Added: 0010697                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
