From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001486]: headphone control disappeared
Date: Thu, 20 Oct 2005 14:51:55 +0200
Message-ID: <922ec4571ae476b2bce4361274b7c2b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33493174
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2005 14:51:56 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1486> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1486
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-20-2005 11:07 CEST
Last Modified:              10-20-2005 14:51 CEST
======================================================================
Summary:                    headphone control disappeared
Description: 
The submitter of Ubuntu bug report 18024 reports that the "Headphone"
control disappeared when he upgraded from linux-image-2.6.10-5-386
(2.6.10-34.7, from
hoary) to linux-image-2.6.12-9-386 (2.6.12-9.23, breezy).

$cat /proc/asound/cards
0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 with STAC9750,51 at 0xfaeff800,
irq 7

See

    http://bugzilla.ubuntu.com/show_bug.cgi?id=18024

for additional info.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-20-05 14:51 
----------------------------------------------------------------------
Too old kernel to debug.  The bug regarding STAC9751 should have been
already fixed in the recent version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-20-05 11:07 jdthood        New Issue                                    
10-20-05 12:58 apeeters       Issue Monitored: apeeters                    
10-20-05 14:51 tiwai          Note Added: 0006503                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
