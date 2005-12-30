From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000333]: no stereo sound (nforce2)
Date: Fri, 30 Dec 2005 04:47:32 +0100
Message-ID: <740bdfff352a9072289cbc6094dbedc9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 164B11A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:47:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=333> 
======================================================================
Reported By:                elkner
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   333
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.4.23, 2.6.6
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             06-12-2004 23:10 CEST
Last Modified:              12-30-2005 04:47 CET
======================================================================
Summary:                    no stereo sound (nforce2)
Description: 
I have a Gigabyte GA-7N400 PRO2 motherboard, which has an
Nforce2 chipset. So I trie to use 'snd-card-0 snd-intel8x0'.
The problem is - it seems to not support stereo (only the right speaker
sends out sound). So when one mutes the right
speaker/channel there is a big silence :(

I tried this with the 2.4.23 as well with the 2.6.6 kernel
both with alsa-* 0.9.1 and 1.0.4rc2 (which comes with the 2.6 kernel). 
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 15:49 
----------------------------------------------------------------------
Any improvement in later ALSA releases?

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:47 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-04 23:10 elkner         New Issue                                    
06-12-04 23:10 elkner         Distribution              => Slackware       
06-12-04 23:10 elkner         Kernel Version            => 2.4.23, 2.6.6   
03-23-05 15:49 jdthood        Note Added: 0004167                          
12-30-05 04:47 rlrevell       Status                   new => closed       
12-30-05 04:47 rlrevell       Note Added: 0007223                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
