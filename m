From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001682]: Errors during install
Date: Wed, 28 Dec 2005 14:01:23 +0100
Message-ID: <4b0794e0f43aaad135a4bd6aa650e0bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D0478185
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2005 14:01:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1682> 
======================================================================
Reported By:                theskuj
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1682
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-26-2005 20:16 CET
Last Modified:              12-28-2005 14:01 CET
======================================================================
Summary:                    Errors during install
Description: 
Errors during 

'./configure --with-cards=indigo --with-sequencer=yes;make;make install'

Not sure what to do... linux newbie...
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-26-05 21:57 
----------------------------------------------------------------------
It sounds like you don't have the kernel sources that match your running
kernel installed.

----------------------------------------------------------------------
 pochini - 12-28-05 14:01 
----------------------------------------------------------------------
You must be root, otherwise you can't install anything in /lib/modules .

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-05 20:16 theskuj        New Issue                                    
12-26-05 20:31 rlrevell       Note Added: 0007161                          
12-26-05 21:20 theskuj        Note Added: 0007162                          
12-26-05 21:57 rlrevell       Note Added: 0007164                          
12-28-05 14:01 pochini        Note Added: 0007175                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
