From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001688]: midi doesn't work with two ice1712 (M-Audio Delta 1010) Cards
Date: Wed, 28 Dec 2005 21:09:28 +0100
Message-ID: <a6599a9b9ab3a7f4fbaa279581efeec0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9B4AA12B
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 21:09:28 +0100 (MET)
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
Last Modified:              12-28-2005 21:09 CET
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
 Schafwoller - 12-28-05 21:05 
----------------------------------------------------------------------
In qjackctl there are no midi-devices visible!

----------------------------------------------------------------------
 rlrevell - 12-28-05 21:09 
----------------------------------------------------------------------
Is snd-seq-midi loaded?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-05 20:59 Schafwoller    New Issue                                    
12-28-05 20:59 Schafwoller    Kernel Version            => 2.6.13          
12-28-05 21:02 Schafwoller    Issue Monitored: Schafwoller                    
12-28-05 21:05 Schafwoller    Note Added: 0007178                          
12-28-05 21:09 rlrevell       Note Added: 0007179                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
