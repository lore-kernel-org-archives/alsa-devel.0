From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000533]: Cannot restore from file it created
Date: Tue, 9 Nov 2004 16:37:55 +0100
Message-ID: <4d3d0ac5ad5bcb27e038c215eef957d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A9C512B1
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:37:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=533> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   533
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-24-2004 06:39 CEST
Last Modified:              11-09-2004 16:37 CET
======================================================================
Summary:                    Cannot restore from file it created
Description: 
Package: alsa-utils
Version: 1.0.3-1

fishbowl:~# alsactl store
fishbowl:~# alsactl restore
alsactl: set_control:966: Cannot write control '2:0:0:CD Playback
Switch:0' : Invalid argument

I got nothing more to add.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-27-04 09:56 
----------------------------------------------------------------------
OK, thanks.  Please close this report.

----------------------------------------------------------------------
 jdthood - 09-27-04 09:57 
----------------------------------------------------------------------
OK, thanks.  Please close this report.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 06:39 jdthood        New Issue                                    
09-24-04 12:06 tiwai          Note Added: 0001870                          
09-27-04 09:56 jdthood        Note Added: 0001934                          
09-27-04 09:57 jdthood        Note Added: 0001935                          
09-27-04 14:49 tiwai          Status                   new => resolved     
09-27-04 14:49 tiwai          Resolution               open => fixed       
09-27-04 14:49 tiwai          Assigned To               => tiwai           
11-09-04 16:37 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
