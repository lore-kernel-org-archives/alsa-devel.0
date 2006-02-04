From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001812]: Apps that uses alsa-1.0.11rc3 crashes with my asound.conf
Date: Sat, 4 Feb 2006 10:10:37 +0100
Message-ID: <b23b4f03ff55455749ee67ca337f5087@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B6EA177
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2006 10:10:37 +0100 (MET)
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
Last Modified:              02-04-2006 10:10 CET
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

----------------------------------------------------------------------
 theli - 02-04-06 10:10 
----------------------------------------------------------------------
not using dmix in asound.conf "fixes" this ... but that way i don't have
soft mixing :(

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 15:19 AnarSoul       New Issue                                    
02-03-06 15:19 AnarSoul       File Added: asound.conf                      
02-04-06 10:05 theli          Issue Monitored: theli                       
02-04-06 10:10 theli          Note Added: 0007914                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
