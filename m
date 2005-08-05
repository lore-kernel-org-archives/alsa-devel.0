From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001313]: Using module snd_azx instead of snd_hda_intel
Date: Fri, 5 Aug 2005 13:58:43 +0200
Message-ID: <58636f45f811848f49b1f032cabeb14d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 760D2216
	for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2005 13:58:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1313> 
======================================================================
Reported By:                chris
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1313
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.12-gentoo-r4
======================================================================
Date Submitted:             08-05-2005 13:58 CEST
Last Modified:              08-05-2005 13:58 CEST
======================================================================
Summary:                    Using module snd_azx instead of snd_hda_intel
Description: 
When I start alsasound, it tries to use snd_azx instead of snd_hda_intel.
In /etc/modprobe.conf I find "alias snd-card0 snd-azx" and "alias
snd-slot0 snd-azx" instead of being "alias snd-card0 snd-hda-intel" and
"alias snd-slot0 snd-hda-intel"
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-05-05 13:58 chris          New Issue                                    
08-05-05 13:58 chris          Distribution              => Gentoo          
08-05-05 13:58 chris          Kernel Version            => 2.6.12-gentoo-r4
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
