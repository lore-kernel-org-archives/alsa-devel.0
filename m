From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001049]: No sound at all
Date: Fri, 15 Apr 2005 12:08:30 +0200
Message-ID: <cb856cf7cfa58cbea0a7ab901f1349a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 44E9725D
	for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2005 12:08:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1049> 
======================================================================
Reported By:                DF5JT
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1049
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.10-1.770_FC3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Feb 24 14:00:06 EST
2005 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             04-13-2005 11:25 CEST
Last Modified:              04-15-2005 12:08 CEST
======================================================================
Summary:                    No sound at all
Description: 
00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)
        Subsystem: Rioworks: Unknown device 203d
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at 80000000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)



======================================================================

----------------------------------------------------------------------
 tiwai - 04-13-05 17:19 
----------------------------------------------------------------------
First, remove non-standard definition in ~/.asoundrc until the culprit is
found.

The problem is likely the misconfiguration of assignment of pin nodes.
Try to pass module option "model=5stack" to snd-hda-intel.  And check
whether you get outputs from other jacks (surround and center/lfe).
Check even input jacks whether any sound comes out.

----------------------------------------------------------------------
 DF5JT - 04-15-05 12:08 
----------------------------------------------------------------------
I have no .asoundrc under ~/, so it is using the default configuration of
/etc/asound.state.

Indeed, there was some sound coming out of the "Front" jack, very softly
and rather distortedly when I use "model=5stack". The notebook has a
headphone jack plus "Front", "Surround" and Center as well as "Audio-In"
and an optical SPDIF-jack. I assume that would make "model=3stack-digout"
the correct module option.

What does this contents in /proc/asound/hda-intel_test/oss_mixer mean:

VOLUME "Front" 0
BASS "" 0
TREBLE "" 0
SYNTH "" 0
PCM "" 0
SPEAKER "PC Speaker" 0
LINE "Line" 0
MIC "Mic" 0
CD "CD" 0
IMIX "" 0
ALTPCM "Headphone" 0
RECLEV "" 0
IGAIN "Capture" 0
OGAIN "" 0
LINE1 "" 0
LINE2 "" 0
LINE3 "" 0
DIGITAL1 "IEC958" 0
DIGITAL2 "" 0
DIGITAL3 "" 0
PHONEIN "" 0
PHONEOUT "" 0
VIDEO "" 0
RADIO "" 0
MONITOR "" 0

The sound device *definitely* works perfect under Linux on this computer.
There is a program called "PowerCinema Linux" on one of the partitions and
it boots into a minimal linux, using the framebuffer device and it plays
all kinds of videos, DVDs and mp3s.

So somehow the "wiring" seems to be incorrect.

Arrgh.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-05 11:25 DF5JT          New Issue                                    
04-13-05 11:25 DF5JT          Distribution              => Fedora Core 3   
04-13-05 11:25 DF5JT          Kernel Version            => 2.6.10-1.770_FC3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Thu Feb 24 14:00:06 EST
2005 i686 i686 i386 GNU/Linux
04-13-05 11:25 DF5JT          Issue Monitored: DF5JT                       
04-13-05 16:34 tiwai          Note Added: 0004469                          
04-13-05 16:52 DF5JT          Note Added: 0004470                          
04-13-05 17:19 tiwai          Note Added: 0004473                          
04-15-05 12:08 DF5JT          Note Added: 0004497                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
