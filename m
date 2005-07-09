From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001247]: amixer beeps on errors in arguments
Date: Sat, 9 Jul 2005 21:39:17 +0200
Message-ID: <5c6c0418a6244e1781329721b22882a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 613DC11E
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 21:39:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1247> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1247
Category:                   amixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-09-2005 21:39 CEST
Last Modified:              07-09-2005 21:39 CEST
======================================================================
Summary:                    amixer beeps on errors in arguments
Description: 
Please remove the bell characters from the error messages.

jdthood@turmeric:/usr/src/alsa/alsa/alsa-utils/amixer$ grep nvali *
amixer.c:                                       fprintf(stderr,
"\07Invalid card number.\n");
amixer.c:                       fprintf(stderr, "\07Invalid switch or
option needs an argument.\n");

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-05 21:39 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
