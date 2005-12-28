From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001688]: midi doesn't work with two ice1712 (M-Audio Delta 1010) Cards
Date: Wed, 28 Dec 2005 21:36:14 +0100
Message-ID: <208c3d1c86c1ec4e0f8e12f3105d05dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51BC0181
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 21:36:15 +0100 (MET)
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
Last Modified:              12-28-2005 21:36 CET
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
 rlrevell - 12-28-05 21:09 
----------------------------------------------------------------------
Is snd-seq-midi loaded?

----------------------------------------------------------------------
 Schafwoller - 12-28-05 21:36 
----------------------------------------------------------------------
With one delta1010 midi and MUSE worked!

Following modules are loaded now regarding midi:
snd_seq_device (used by snd_rawmidi)
snd_rawmidi (used by snd_mpu401_uart)
snd_mpu401_uart (finally used by snd_ice1712)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 20:59 Schafwoller    New Issue                                    
12-28-05 20:59 Schafwoller    Kernel Version            => 2.6.13          
12-28-05 21:02 Schafwoller    Issue Monitored: Schafwoller                    
12-28-05 21:05 Schafwoller    Note Added: 0007178                          
12-28-05 21:09 rlrevell       Note Added: 0007179                          
12-28-05 21:36 Schafwoller    Note Added: 0007180                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
