From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001658]: Capture happens only on one channel
Date: Fri, 13 Jan 2006 14:29:37 +0100
Message-ID: <a2e04a288a7bc5123fddbd6d9baf2d1d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9FA84121
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 14:29:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1658> 
======================================================================
Reported By:                phil_troin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1658
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.14-gentoo-r2
======================================================================
Date Submitted:             12-18-2005 08:40 CET
Last Modified:              01-13-2006 14:29 CET
======================================================================
Summary:                    Capture happens only on one channel
Description: 
When I am playing a CD, if I capture the sound output via the capture
channel OR the CD channel (amixer output attached), the captured sound is
only one one channel (the right one) and is very distorted.
The audio plays normally in stereo on the speakers.
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-13-06 02:17 
----------------------------------------------------------------------
That's bizarre, the only difference is:

--- /home/rlrevell/Desktop/alsa.conf.ubuntu     2006-01-12
20:15:41.000000000 -0500
+++ /home/rlrevell/Desktop/alsa.conf.record1channel     2006-01-12
20:16:28.000000000 -0500
@@ -251,6 +251,7 @@
 pcm.iec958 cards.pcm.iec958
 pcm.spdif cards.pcm.iec958
 pcm.modem cards.pcm.modem
+pcm.phoneline cards.pcm.phoneline
 
 pcm.default cards.pcm.default
 pcm.dmix cards.pcm.dmix

----------------------------------------------------------------------
 Matthias Koenig - 01-13-06 14:29 
----------------------------------------------------------------------
I have the same symptoms on my system:
Capturing Line, works only on channel 1, channel 2 is silent,
although with some noise. 
I figured out that switching the Mic Boost on changes (boosts) 
the noisefloor of the silent channel 2.
Some tests with a Microphone confirmed that channel 2 records always
the Mic input, independently of any capture source settings in mixer.
Switching Capture off in mixer does work (silence on both channels
without noise). However, switching capture source is only effective 
on channel 1. Channel 2 keeps listening to Mic input.

ALSA Versions tried:
1.0.10rc3
1.0.11rc2

Kernel: Vanilla 2.6.15 on Debian/testing

card 0: nForce2 [NVidia nForce2], device 0: Intel ICH [NVidia nForce2]

0000:00:05.0 Multimedia audio controller: nVidia Corporation nForce Audio
Processing Unit (rev a2)
        Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 5
        Memory at ef000000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [44] Power Management version 2

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97
Audio Controler (MCP) (rev a1)
        Subsystem: EPoX Computer Co., Ltd.: Unknown device 1000
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 193
        I/O ports at d400 [size=256]
        I/O ports at d800 [size=128]
        Memory at ef081000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-18-05 08:40 phil_troin     New Issue                                    
12-18-05 08:40 phil_troin     File Added: amixout                          
12-18-05 08:40 phil_troin     Distribution              => Gentoo          
12-18-05 08:40 phil_troin     Kernel Version            => 2.6.14-gentoo-r2
12-18-05 12:00 linuxbear      Note Added: 0007071                          
12-18-05 12:02 linuxbear      Note Edited: 0007071                         
12-27-05 10:34 linuxbear      Issue Monitored: linuxbear                    
01-07-06 06:24 tgutwin        Note Added: 0007508                          
01-07-06 06:25 tgutwin        Issue Monitored: tgutwin                     
01-09-06 01:34 legluondunet   Note Added: 0007529                          
01-09-06 01:35 legluondunet   File Added: alsa.conf.record1channel              
     
01-09-06 01:37 legluondunet   File Added: alsa.conf.ubuntu                    
01-09-06 01:43 legluondunet   Note Added: 0007530                          
01-13-06 02:17 rlrevell       Note Added: 0007615                          
01-13-06 14:29 Matthias KoenigNote Added: 0007640                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
