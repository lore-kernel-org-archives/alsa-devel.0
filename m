From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001486]: headphone control disappeared
Date: Wed, 9 Nov 2005 13:44:34 +0100
Message-ID: <2587a84c8352354610ae383e3658aab7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DFCD21A8
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2005 13:44:34 +0100 (MET)
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
Last Modified:              11-09-2005 13:44 CET
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
 tiwai - 11-08-05 18:34 
----------------------------------------------------------------------
Does the attached patch fix the problem?  Preferably try together with ALSA
1.0.10rc3.

----------------------------------------------------------------------
 apeeters - 11-09-05 13:44 
----------------------------------------------------------------------
No, unfortunately it does not fix the problem. I used 1.0.10rc3 with your
patch. 
The data of amixer etc (as in alsa_headphone for the pristine 2.6.14) is
identical.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-20-05 11:07 jdthood        New Issue                                    
10-20-05 12:58 apeeters       Issue Monitored: apeeters                    
10-20-05 14:51 tiwai          Note Added: 0006503                          
11-06-05 16:58 apeeters       Note Added: 0006607                          
11-06-05 16:58 apeeters       File Added: alsa_headphone                    
11-08-05 18:34 tiwai          Note Added: 0006633                          
11-08-05 18:34 tiwai          File Added: ac97-check-fix.diff                   

11-09-05 13:44 apeeters       Note Added: 0006650                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
