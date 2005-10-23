From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001495]: nForce2 IEC958 output is working when IEC958 control is muted.
Date: Mon, 24 Oct 2005 00:16:50 +0200
Message-ID: <6ab3ea9c2ca22f7ea498d787d13ac56a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07C00157
	for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2005 00:16:51 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1495> 
======================================================================
Reported By:                damscot
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1495
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.12-gentoo-r1
======================================================================
Date Submitted:             10-24-2005 00:16 CEST
Last Modified:              10-24-2005 00:16 CEST
======================================================================
Summary:                    nForce2 IEC958 output is working when IEC958 control
is muted.
Description: 
Good evening,

I'am using my MSI MEGA 180 under linux.
I'am using ALSA 1.0.9 Embedded inside the Linux ALSA kernel system.

***************************
*** USEFULL INFORMATION ***
***************************

<< lspci
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device
7960
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 22
        I/O ports at d400 [size=256]
        I/O ports at d800 [size=128]
        Memory at e1087000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2


<< cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24
10:33:39 2005 UTC).

<< cat /proc/asound/cards
0 [nForce2        ]: NFORCE - NVidia nForce2
                     NVidia nForce2 with ALC650F at 0xe1087000, irq 22
1 [Modem          ]: ICH-MODEM - NVidia nForce2 Modem
                     NVidia nForce2 Modem at 0xe1080000, irq 22

<< cat /proc/asound/devices
 18: [0- 2]: digital audio playback
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  1:       : sequencer
 33:       : timer
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 32: [1- 0]: ctl

<< cat /proc/asound/pcm
00-00: Intel ICH : NVidia nForce2 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : NVidia nForce2 - MIC ADC : capture 1
00-02: Intel ICH - IEC958 : NVidia nForce2 - IEC958 : playback 1
01-00: Intel ICH - Modem : NVidia nForce2 Modem - Modem : playback 1 :
capture 1

<< cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Realtek ALC650F

Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Double rate slots: 10/11
Extended ID      : codec=0 rev=1 LDAC SDAC CDAC DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=10/11 VRA
PCM front DAC    : 44100Hz
PCM Surr DAC     : 44100Hz
PCM LFE DAC      : 44100Hz
PCM ADC          : 44100Hz
SPDIF Control    : Consumer PCM Copyright Category=0x2 Generation=1
Rate=48kHz
SPDIF In Status  : Not Locked

<< amixer | grep -A 5 IEC958
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [on] Capture [off]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Limits: 0 - 3
  Mono: 3 [100%]
Simple mixer control 'Analog to IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]

***************************

My SPDIF output is referenced as hw:0,2, the chipset is a nForce2 (then i
use the snd-intel8x0 driver), the AC97 device seems to be a Realtek
ALC650F.

while using a basic application to send samples to the spdif output ex:

<< aplay -f dat -c 2 -D hw:0,2 anybigfile.gz

I need to mute the IEC958 control in order to ear something from my
DTS/Digital decoder/amplifier.

It seems that the control function is inverted. The problem is that all
application, xmms (for each playing file), mplayer, xine try to unmute the
IEC958 control before starting to play. Then, I have to manually mute the
IEC958 control after lauching the media application to ear the sound.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-24-05 00:16 damscot        New Issue                                    
10-24-05 00:16 damscot        Distribution              => Gentoo          
10-24-05 00:16 damscot        Kernel Version            => 2.6.12-gentoo-r1
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
