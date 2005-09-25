From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001458]: hda - High frequency noise in background and muting when changing volume
Date: Sun, 25 Sep 2005 16:07:53 +0200
Message-ID: <5fb051bd3a70a8355301793bcfb7e3d2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D97716F
	for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2005 16:07:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1458> 
======================================================================
Reported By:                andres
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1458
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               ubuntu breezy badger
Kernel Version:              2.6.12-9-386
======================================================================
Date Submitted:             09-25-2005 16:07 CEST
Last Modified:              09-25-2005 16:07 CEST
======================================================================
Summary:                    hda - High frequency noise in background and muting
when changing volume
Description: 
When i play sound i hear a high (constant) frequency beep additionally to
what i intend to play. I also tried to set position_fix=[0,1,2] and model,
but that didnt help (for both, related?, problems)
If i change volume via alsamixer no sound can be heard anymore till i
unload and load the snd_hda_intel module.

Thanks for helping

Andres

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 16:07 andres         New Issue                                    
09-25-05 16:07 andres         Distribution              => ubuntu breezy badger
09-25-05 16:07 andres         Kernel Version            =>  2.6.12-9-386   
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
