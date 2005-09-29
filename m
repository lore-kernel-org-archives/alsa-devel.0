From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001442]: snapper: no sound after resume
Date: Thu, 29 Sep 2005 20:55:36 +0200
Message-ID: <0e93720ef35766ed710cdcaab195508e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7CF2F188
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 20:55:36 +0200 (MEST)
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


The following issue has been set as DUPLICATE OF issue 0000057.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1442> 
======================================================================
Reported By:                Johannes Berg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1442
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-22-2005 17:32 CEST
Last Modified:              09-29-2005 20:55 CEST
======================================================================
Summary:                    snapper: no sound after resume
Description: 
After resuming from suspend to disk there's no sound with a snapper chip on
a post-february 2005 powerbook.

alsactl restore doesn't help, the only way I have managed to work around
this is to reload the module
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000057 Kernel device in bad state after suspen...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-22-05 17:32 Johannes Berg  New Issue                                    
09-22-05 17:32 Johannes Berg  Distribution              => debian          
09-22-05 17:32 Johannes Berg  Kernel Version            => 2.6.13          
09-22-05 17:32 Johannes Berg  Issue Monitored: Johannes Berg                    
09-29-05 20:55 jdthood        Relationship added       duplicate of 0000057
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
