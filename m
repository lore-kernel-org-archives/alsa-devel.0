From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001334]: module fails to load because it can't register ac97 bus
Date: Sun, 14 Aug 2005 00:13:02 +0200
Message-ID: <a548cd93b65d4aec8e81a9c009bdea61@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2854D1D8
	for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2005 00:13:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1334> 
======================================================================
Reported By:                bdijkstra
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1334
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux
Kernel Version:             2.6.13-rc5-git3-3-default
======================================================================
Date Submitted:             08-14-2005 00:13 CEST
Last Modified:              08-14-2005 00:13 CEST
======================================================================
Summary:                    module fails to load because it can't register ac97
bus
Description: 
The Hercules GameTheater XP card has two codecs of the same type (CS4294).
The cs46xx driver tries to register these two codecs with the same name
with the ac97 bus which then fails.
I have attached the message log of a module load which shows the problem.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-05 00:13 bdijkstra      New Issue                                    
08-14-05 00:13 bdijkstra      File Added: cs46xx-error.log                    
08-14-05 00:13 bdijkstra      Distribution              => SuSE Linux      
08-14-05 00:13 bdijkstra      Kernel Version            =>
2.6.13-rc5-git3-3-default
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
