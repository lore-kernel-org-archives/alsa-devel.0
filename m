From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000708]: Fix CVS envy24control crash on midi 00 control
Date: Fri, 30 Dec 2005 04:28:51 +0100
Message-ID: <993326a4bdc5906520aff0e9784ec2f3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9620F1A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:28:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=708> 
======================================================================
Reported By:                shadow
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   708
Category:                   envy24control
Reproducibility:            sometimes
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-05-2004 12:36 CET
Last Modified:              12-30-2005 04:28 CET
======================================================================
Summary:                    Fix CVS envy24control crash on midi 00 control
Description: 
envy24control adds midi support, but if it receives data from a controller
with ID '0' it will crash.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 03:58 
----------------------------------------------------------------------
Is this still broken?

----------------------------------------------------------------------
 shadow - 12-30-05 04:28 
----------------------------------------------------------------------
I havent used midi function of envy24control in many months. I cannot say
if this issue exists or has been resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 12:36 shadow         New Issue                                    
12-05-04 12:36 shadow         File Added:
cvs_alsa_20041205-envy24control.midi00crash.patch                    
12-05-04 13:58 shadow         Note Added: 0002721                          
12-05-04 15:02 shadow         Note Added: 0002722                          
12-05-04 15:02 shadow         File Added:
cvs_alsa_20041205-envy24control.midi00crash.patch                    
12-30-05 03:58 rlrevell       Note Added: 0007194                          
12-30-05 04:28 shadow         Note Added: 0007209                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
