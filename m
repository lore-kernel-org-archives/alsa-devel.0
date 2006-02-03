From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001812]: Apps that uses alsa-1.0.11rc3 crashes with my asound.conf
Date: Fri, 3 Feb 2006 15:19:53 +0100
Message-ID: <ee5a9f2ec82dd0d6b2c3ac8f308e1196@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7A1801A3
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2006 15:19:53 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1812> 
======================================================================
Reported By:                AnarSoul
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1812
Category:                   0_general
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-03-2006 15:19 CET
Last Modified:              02-03-2006 15:19 CET
======================================================================
Summary:                    Apps that uses alsa-1.0.11rc3 crashes with my
asound.conf
Description: 
All apps that uses alsa-1.0.11rc3 crashed with my asound.conf with
message:

 conf.c:3144: snd_config_iterator_first: Assertion `node->type ==
SND_CONFIG_TYPE_COMPOUND' failed.

With alsa-1.0.10 everything is OK :)
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 15:19 AnarSoul       New Issue                                    
02-03-06 15:19 AnarSoul       File Added: asound.conf                      
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
