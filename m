From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000835]: Possible race condition leading to crash in gnome-volume-control
Date: Fri, 30 Dec 2005 23:02:10 +0100
Message-ID: <ad8ccca8b4675f5a13fdea281260b2a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7203718F
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:02:11 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=835> 
======================================================================
Reported By:                jcspray
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   835
Category:                   PCI - emu10k1
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu
Kernel Version:             2.6.8
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             01-18-2005 22:49 CET
Last Modified:              12-30-2005 23:02 CET
======================================================================
Summary:                    Possible race condition leading to crash in
gnome-volume-control
Description: 
The maintainer of the gstreamer-based gnome-volume-control utility believes
that a crash may be the result of a race condition in ALSA driver.

Please see http://bugzilla.gnome.org/show_bug.cgi?id=156921#c9
======================================================================

----------------------------------------------------------------------
 jdthood - 09-15-05 15:05 
----------------------------------------------------------------------
A small (better) testcase is needed for debugging.

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:02 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-18-05 22:49 jcspray        New Issue                                    
01-18-05 22:49 jcspray        Distribution              => Ubuntu          
01-18-05 22:49 jcspray        Kernel Version            => 2.6.8           
01-19-05 14:28 tiwai          Note Added: 0003267                          
09-15-05 15:05 jdthood        Note Added: 0006199                          
09-15-05 15:05 jdthood        Status                   new => feedback     
12-30-05 23:02 rlrevell       Status                   feedback => closed  
12-30-05 23:02 rlrevell       Note Added: 0007273                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
