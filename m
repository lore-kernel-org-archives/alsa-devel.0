From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001688]: midi doesn't work with two ice1712 (M-Audio Delta 1010) Cards
Date: Thu, 29 Dec 2005 11:39:20 +0100
Message-ID: <787b5f58072dedfdc28f468ca1c4894c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 107A4197
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2005 11:39:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1688> 
======================================================================
Reported By:                Schafwoller
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1688
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.13
======================================================================
Date Submitted:             12-28-2005 20:59 CET
Last Modified:              12-29-2005 11:39 CET
======================================================================
Summary:                    midi doesn't work with two ice1712 (M-Audio Delta
1010) Cards
Description: 
When running 2 M-Audio_delta-1010 Cards Midi don't seem to work.

Getting following error while starting muse:
ALSA lib seq_hw.c:455:(snd_seq_hw_open) open /dev/snd/seq failed: No such
file or directory.
======================================================================

----------------------------------------------------------------------
 Schafwoller - 12-28-05 21:36 
----------------------------------------------------------------------
With one delta1010 midi and MUSE worked!

Following modules are loaded now regarding midi:
snd_seq_device (used by snd_rawmidi)
snd_rawmidi (used by snd_mpu401_uart)
snd_mpu401_uart (finally used by snd_ice1712)

----------------------------------------------------------------------
 Schafwoller - 12-29-05 11:39 
----------------------------------------------------------------------
The problem is solved. First I tried the standard kernel and updated the
alsa-driver to 1.0.10 and I could't get midi working. Then I compiled the
kernel and the modules with no effect. Then I recompiled the kernel again
with "default" settings + the preemptible feature and now midi works.
Actually I don't know what the problem was but it is solved on this
machine. Now we can run the Cards in duplex-mode (synched via Word Clock
-> thanks to John Rigg and others for their big help!!!) using ardour. But
now the next problem occurs. The second soundcard does not synch correctly
to the first whereas the waveforms of the "wordclocked" card are "earlier"
and not (as i assumed before the tests) later.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 20:59 Schafwoller    New Issue                                    
12-28-05 20:59 Schafwoller    Kernel Version            => 2.6.13          
12-28-05 21:02 Schafwoller    Issue Monitored: Schafwoller                    
12-28-05 21:05 Schafwoller    Note Added: 0007178                          
12-28-05 21:09 rlrevell       Note Added: 0007179                          
12-28-05 21:36 Schafwoller    Note Added: 0007180                          
12-29-05 11:39 Schafwoller    Note Added: 0007188                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
