From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000606]: Sound loops around every 1/2 second or so,
Date: Tue, 9 Nov 2004 19:20:17 +0100
Message-ID: <9cb7687dcc3e75666531a95f75fd47b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C56492B6
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 19:20:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=606> 
======================================================================
Reported By:                deggy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   606
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Arch Linux
Kernel Version:             2.4.9
======================================================================
Date Submitted:             10-26-2004 18:38 CEST
Last Modified:              11-09-2004 19:20 CET
======================================================================
Summary:                    Sound loops around every 1/2 second or so,
Description: 
When I try to play a sound alsa loops the audio every 1/2 second or so.
Sounds a bit like a sampler looping the same 1/2 second again and again
and again.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 19:20 
----------------------------------------------------------------------
It's likely an interrupt routing problem.
This problem is often solved by turning off ACPI on the boot.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 18:38 deggy          New Issue                                    
10-26-04 18:38 deggy          Distribution              => Arch Linux      
10-26-04 18:38 deggy          Kernel Version            => 2.4.9           
10-27-04 00:08 chomwitt       Issue Monitored: chomwitt                    
11-09-04 19:20 tiwai          Note Added: 0002343                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
