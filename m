From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000592]: Need addition to the INSTALL file please
Date: Tue, 9 Nov 2004 19:40:03 +0100
Message-ID: <979199b9964c61e2d7e2dab1851aee61@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 193DF2B4
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 19:40:03 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=592> 
======================================================================
Reported By:                JColeman
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   592
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-21-2004 11:16 CEST
Last Modified:              11-09-2004 19:40 CET
======================================================================
Summary:                    Need addition to the INSTALL file please
Description: 
bash-2.05b# alsaconf
/usr/sbin/alsaconf: line 33: [: too many arguments
/usr/sbin/alsaconf: line 35: [: too many arguments
modinfo: could not find module snd
modinfo: could not find module snd
modinfo: could not find module snd
which: no dialog in
(/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin)
which: no whiptail in
(/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin)
Error, dialog or whiptail not found.
bash-2.05b#

======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 19:40 
----------------------------------------------------------------------
I added the requirements section in INSTALL.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-04 11:16 JColeman       New Issue                                    
10-21-04 11:17 JColeman       Issue Monitored: JColeman                    
11-09-04 19:40 tiwai          Status                   new => resolved     
11-09-04 19:40 tiwai          Resolution               open => fixed       
11-09-04 19:40 tiwai          Assigned To               => tiwai           
11-09-04 19:40 tiwai          Note Added: 0002348                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
