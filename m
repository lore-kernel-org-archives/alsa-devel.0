From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000440]: Gateway Solo 250 nma2 - no soundcard detected
Date: Tue, 30 Aug 2005 12:18:30 +0200
Message-ID: <a8bd8fc7d0465a0cacc7ba86e8f79f04@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 21F171C7
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 12:18:30 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=440> 
======================================================================
Reported By:                thelight
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   440
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.6-1.435.2.3
======================================================================
Date Submitted:             08-14-2004 19:38 CEST
Last Modified:              08-30-2005 12:18 CEST
======================================================================
Summary:                    Gateway Solo 250 nma2 - no soundcard detected
Description: 
The laptops specs say it has a 'neomagic nma 2' sound card onboard. From
what I can tell this is some sort of NeoMagic nm256 equivalent.

My main problem is that I simply get no sound. The fedora core 2 program
system-config-soundcard doesnt actually detect a soundcard at all. Im
using the 1.0.3 rpms of alsa which came with fedora. 
======================================================================

----------------------------------------------------------------------
 tiwai - 08-20-04 15:09 
----------------------------------------------------------------------
Then try alsaconf and probe legacy cards.
It may detect and set up your device.

----------------------------------------------------------------------
 jdthood - 08-30-05 12:18 
----------------------------------------------------------------------
Hi.  What's the status of this bug.  Any improvement in later ALSA
releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-04 19:38 thelight       New Issue                                    
08-14-04 19:38 thelight       Distribution              => Fedora Core 2   
08-14-04 19:38 thelight       Kernel Version            => 2.6.6-1.435.2.3 
08-18-04 11:59 tiwai          Note Added: 0001577                          
08-18-04 15:37 thelight       Note Added: 0001582                          
08-18-04 15:45 tiwai          Note Added: 0001584                          
08-20-04 15:03 thelight       Note Added: 0001599                          
08-20-04 15:09 tiwai          Note Added: 0001600                          
08-30-05 12:18 jdthood        Note Added: 0005969                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
