From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002002]: No SPDIF/OUT device on ICH2
Date: Fri, 7 Apr 2006 19:24:41 +0200
Message-ID: <c560049d8a9345ed212694dac21aa336@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D664015C
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 19:24:41 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2002> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2002
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Fedore Core 1
Kernel Version:             2.4.22-1.2199.nptl
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-05-2006 04:00 CEST
Last Modified:              04-07-2006 19:24 CEST
======================================================================
Summary:                    No SPDIF/OUT device on ICH2
Description: 
Do intel8x0 support SPDIF/OUT for ICH2 ?


00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio
(rev 12)
        Subsystem: Asustek Computer, Inc.: Unknown device 8072
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at a800 [size=256]
        I/O ports at a400 [size=64]


cat /proc/asound/pcm

01-01: Intel ICH - MIC ADC : Intel 82801BA-ICH2 - MIC ADC : capture 1
01-00: Intel ICH : Intel 82801BA-ICH2 : playback 1 : capture 1



cat /proc/asound/I82801BAICH2/codec97#0/ac97#0-0
0-0/0: Realtek ALC200,200P rev 0
 
PCI Subsys Vendor: 0x1043
PCI Subsys Device: 0x8072
 
Capabilities     : -headphone out-
DAC resolution   : 18-bit
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
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=7/8 VRA
PCM front DAC    : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz


amixer -c 1 controls

numid=32,iface=MIXER,name='IEC958 Playback Con Mask'
numid=33,iface=MIXER,name='IEC958 Playback Pro Mask'
numid=36,iface=MIXER,name='IEC958 Playback AC97-SPSA'
numid=34,iface=MIXER,name='IEC958 Playback Default'
numid=35,iface=MIXER,name='IEC958 Playback Switch'


======================================================================

----------------------------------------------------------------------
 tiwai - 04-07-06 19:24 
----------------------------------------------------------------------
There is no dedicated PCM for SPDIF on ICH2.
Set up 'IEC958 AC97-SPSA' to 0 and turn on 'IEC958 Playback Switch'.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-05-06 04:00 Raymond        New Issue                                    
04-05-06 04:00 Raymond        Distribution              => Fedore Core 1   
04-05-06 04:00 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
04-07-06 19:24 tiwai          Status                   new => resolved     
04-07-06 19:24 tiwai          Resolution               open => not an issue
04-07-06 19:24 tiwai          Assigned To               => tiwai           
04-07-06 19:24 tiwai          Note Added: 0009147                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
