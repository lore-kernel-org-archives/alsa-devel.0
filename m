From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001202]: No sound  through speakers, only headphones
Date: Wed, 22 Jun 2005 05:12:40 +0200
Message-ID: <1f74c62003141b6967ff2b754a920c01@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 827491FB
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 05:12:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1202> 
======================================================================
Reported By:                viroid
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1202
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 4
Kernel Version:             2.6.11-1.1369
======================================================================
Date Submitted:             06-18-2005 04:47 CEST
Last Modified:              06-22-2005 05:12 CEST
======================================================================
Summary:                    No sound  through speakers, only headphones
Description: 
I cannot get any audio output from the internal speakers on the laptop, I
did however hear output through headphones; I tried that after reading a
few issues on here.  I've muted headphones, phone, and line from the
alsamixer, I've only recently started using linux and I don't really know
what else to try. 
======================================================================

----------------------------------------------------------------------
 tiwai - 06-21-05 12:58 
----------------------------------------------------------------------
The hardware details?  Otherwise really hard to tell you anything.

Please attach /etc/asound.state, the contents of
/proc/asound/card0/codec97#0/* files, too.

----------------------------------------------------------------------
 viroid - 06-22-05 05:12 
----------------------------------------------------------------------
I've pasted the contents of the files you requested, if there's anything
else yo u need or anything that would be helpful just let me know.  Thanks
in advance for your assistance, I appreciate it!

...Chris


asound.state >>
state.I82801DBICH4 {
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
                value.0 31
                value.1 31
        }
        control.3 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Headphone Playback Switch'
                value false
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Headphone Playback Volume'
                value.0 30
                value.1 30
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Master Mono Playback Switch'
                value true
        }
        control.6 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Master Mono Playback Volume'
                value 31
        }
        control.7 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PC Speaker Playback Switch'
                value true
        }
        control.8 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name 'PC Speaker Playback Volume'
                value 15
        }
        control.9 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Phone Playback Switch'
                value false
        }
        control.10 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Phone Playback Volume'
                value 0
        }
        control.11 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Playback Switch'
                value false
        }
        control.12 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 31'
                iface MIXER
                name 'Mic Playback Volume'
                value 0
        }
        control.13 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Mic Boost (+20dB)'
                value false
        }
        control.14 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Line Playback Switch'
                value false
        }
        control.15 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Line Playback Volume'
                value.0 0
                value.1 0
        }
        control.16 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'CD Playback Switch'
                value true
        }
        control.17 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'CD Playback Volume'
                value.0 30
                value.1 30
        }
        control.18 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Video Playback Switch'
                value false
        }
        control.19 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Video Playback Volume'
                value.0 0
                value.1 0
        }
        control.20 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Aux Playback Switch'
                value false
        }
        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'Aux Playback Volume'
                value.0 0
                value.1 0
        }
        control.22 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'PCM Playback Switch'
                value true
        }
        control.23 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 31'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 30
                value.1 30
        }
        control.24 {
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
                value.0 Line
                value.1 Line
        }
        control.25 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Capture Switch'
                value false
        }
        control.26 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 0
                value.1 0
        }
        control.27 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 'pre 3D'
                comment.item.1 'post 3D'
                iface MIXER
                name 'PCM Out Path & Mute'
                value 'pre 3D'
        }
        control.28 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name '3D Control - Switch'
                value true
        }
        control.29 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mix
                comment.item.1 Mic
                iface MIXER
                name 'Mono Output Select'
                value Mix
        }
        control.30 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 Mic1
                comment.item.1 Mic2
                iface MIXER
                name 'Mic Select'
                value Mic1
        }
        control.31 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Center'
                value 15
        }
        control.32 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 15'
                iface MIXER
                name '3D Control - Depth'
                value 15
        }
        control.33 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Con Mask'
                value
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.34 {
                comment.access read
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Pro Mask'
                value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
        }
        control.35 {
                comment.access 'read write'
                comment.type IEC958
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Default'
                value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
        }
        control.36 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'IEC958 Playback Switch'
                value true
        }
        control.37 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 1
                comment.range '0 - 3'
                iface MIXER
                name 'IEC958 Playback AC97-SPSA'
                value 3
        }
        control.38 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'External Amplifier'
                value false
        }
}
state.Modem {
        control.1 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 1
                iface MIXER
                name 'Off-hook Switch'
                value false
        }
}


/proc/asound/card0/code9797#0/ac97#0-0 >>
0-0/0: SigmaTel STAC9750,51

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 20-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=10/11 SPDIF VRA
PCM front DAC    : 48000Hz
PCM ADC          : 8000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

((( I see that capabilities tag = headphones out? )))


/proc/asound/card0/codec97#0/ac97#0-0+regs >>
0:00 = 6a90
0:02 = 0000
0:04 = 8101
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 0101
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0101
0:1a = 0404
0:1c = 8000
0:1e = 0000
0:20 = 2000
0:22 = 000c
0:24 = 0000
0:26 = 800f
0:28 = 0605
0:2a = 0435
0:2c = bb80
0:2e = 0000
0:30 = 0000
0:32 = 1f40
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2824
0:3c = 0000
0:3e = 0100
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0003
0:4e = ffff
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
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0002
0:6e = 1000
0:70 = 0000
0:72 = 0000
0:74 = 8800
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 8384
0:7e = 7650

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-05 04:47 viroid         New Issue                                    
06-18-05 04:47 viroid         Distribution              => Fedora Core 4   
06-18-05 04:47 viroid         Kernel Version            => 2.6.11-1.1369   
06-21-05 12:58 tiwai          Note Added: 0005110                          
06-22-05 05:12 viroid         Note Added: 0005118                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
