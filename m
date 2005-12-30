From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000877]: balance problem with ALC880 (Intel HD Audio)
Date: Fri, 30 Dec 2005 23:21:04 +0100
Message-ID: <3d27e0959c96cd0217f06f4dafdeee26@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7290F148
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:21:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=877> 
======================================================================
Reported By:                alphacc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   877
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Scientific Linux 3.03 (close to Redhat ES 3)
Kernel Version:             2.4.21
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-02-2005 11:32 CET
Last Modified:              12-30-2005 23:21 CET
======================================================================
Summary:                    balance problem with ALC880 (Intel HD Audio)
Description: 
module : snd-azx

When I try to change the Front balance (left/right), the Front volume is
going up or down randomly.
Tested with xmms, alsamixer, gnome-alsamixer.

Is it a known problem with other platforms / modules ?

======================================================================

----------------------------------------------------------------------
 jdthood - 09-19-05 09:58 
----------------------------------------------------------------------
alphacc: Is there any improvement in later ALSA versions?

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:21 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-05 11:32 alphacc        New Issue                                    
02-02-05 11:32 alphacc        Distribution              => Scientific Linux 3.03
(close to Redhat ES 3)
02-02-05 11:32 alphacc        Kernel Version            => 2.4.21          
09-19-05 09:58 jdthood        Note Added: 0006278                          
12-30-05 23:21 rlrevell       Status                   new => closed       
12-30-05 23:21 rlrevell       Note Added: 0007284                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
