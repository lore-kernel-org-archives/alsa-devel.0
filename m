From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001316]: can't run mixer to adjusting volumes / no sound
Date: Sat, 6 Aug 2005 11:11:38 +0200
Message-ID: <46d8bdc6c9afa4bfb5dbb7d436b61314@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AAC531D2
	for <alsa-devel@alsa-project.org>; Sat,  6 Aug 2005 11:11:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1316> 
======================================================================
Reported By:                boris
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1316
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian stable
Kernel Version:             2.6.13-rc5-git3
======================================================================
Date Submitted:             08-06-2005 11:11 CEST
Last Modified:              08-06-2005 11:11 CEST
======================================================================
Summary:                    can't run mixer to adjusting volumes / no sound
Description: 
When I try to run alsamixer it fails with:
alsamixer: function snd_mixer_load failed: Invalid argument

running ogg123 seems to work ...

running aumix over oss-emu only shows a view controls 
which have no effect -> no sound

This happened with 2.6.13-rc[3,5]-git?.
2.6.12-rc5-git8 (for example) works. 

HW: Aopen 915gmm-hfs.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-06-05 11:11 boris          New Issue                                    
08-06-05 11:11 boris          Distribution              => Debian stable   
08-06-05 11:11 boris          Kernel Version            => 2.6.13-rc5-git3 
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
