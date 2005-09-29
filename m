From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000726]: headphone output on the docking station (Dell Lattitude D400) does not work
Date: Thu, 29 Sep 2005 13:47:01 +0200
Message-ID: <36b9cbc4474f0d5e3bd94ba69aff791d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6FC47155
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 13:47:01 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=726> 
======================================================================
Reported By:                vassili
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   726
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     acknowledged
Distribution:               debian
Kernel Version:             2.6.8, custom build
======================================================================
Date Submitted:             12-15-2004 17:26 CET
Last Modified:              09-29-2005 13:47 CEST
======================================================================
Summary:                    headphone output on the docking station (Dell
Lattitude D400) does not work
Description: 
Support of a headphone jack on the docking station is missing.

Hardware: Dell Latitude D400 with docking station, 
Intel 82810DB AC97 Audio
======================================================================

----------------------------------------------------------------------
 tiwai - 01-07-05 19:56 
----------------------------------------------------------------------
Which codec?  Attach the contents of /proc/asound/card0/codec97#0/* files
(and /etc/asound.state).

----------------------------------------------------------------------
 vassili - 01-11-05 13:11 
----------------------------------------------------------------------
Kernel upgraded to 2.6.10, using ALSA driver from that kernel.

If "IEC958 Playback AC97-SPSA" is muted, there is strongly distorted 
signal on the headphone jack of the docking station.
Otherwise, there is not output at all.

Master (internal speaker of the laptop) - working OK
Headphone on the laptop - working OK
digital out on the docking station - untested

----------------------------------------------------------------------
 vassili - 01-11-05 13:15 
----------------------------------------------------------------------
registers and asound.state are in the attached file codecs
$ cat  /proc/asound/card0/codec97#0/ac97#0-0

0-0/0: SigmaTel STAC9750/51

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 20-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP DSA=0 SPDIF VRA
Extended status  : SPCV SPDIF=10/11 SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz

----------------------------------------------------------------------
 tiwai - 01-11-05 15:04 
----------------------------------------------------------------------
How about /etc/asound.state?  Please upload it instead of pasting.

----------------------------------------------------------------------
 vassili - 01-11-05 15:52 
----------------------------------------------------------------------
all output is inside the uploaded file "codecs"
including /etc/asound.state /proc/asound/card0/codec97#0/ac97#0-0+regs
and /proc/asound/card0/codec97#0/ac97#0-0

----------------------------------------------------------------------
 jdthood - 09-29-05 12:12 
----------------------------------------------------------------------
vassili: Any improvement in the latest ALSA release?

----------------------------------------------------------------------
 vassili - 09-29-05 13:30 
----------------------------------------------------------------------
No changes with the version 1.0.9b (kernel 2.6.12.2)

I have not noticed any changes when I installed 1.0.10rc1 today.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-15-04 17:26 vassili        New Issue                                    
12-15-04 17:26 vassili        Distribution              => debian          
12-15-04 17:26 vassili        Kernel Version            => 2.6.8, custom build
01-07-05 19:56 tiwai          Note Added: 0003120                          
01-11-05 13:02 vassili        File Added: codecs                           
01-11-05 13:11 vassili        Note Added: 0003144                          
01-11-05 13:15 vassili        Note Added: 0003145                          
01-11-05 15:04 tiwai          Note Added: 0003147                          
01-11-05 15:52 vassili        Note Added: 0003150                          
09-29-05 12:12 jdthood        Note Added: 0006417                          
09-29-05 13:30 vassili        Note Added: 0006422                          
09-29-05 13:47 jdthood        Status                   new => acknowledged 
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
