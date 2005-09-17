From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001430]: powermac sound does't work on the latest iBooks
Date: Sat, 17 Sep 2005 02:21:59 +0200
Message-ID: <544545f60452750cd7373caf3af48533@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33B31117
	for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2005 02:22:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1430> 
======================================================================
Reported By:                thouters
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1430
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13.1
======================================================================
Date Submitted:             09-17-2005 02:21 CEST
Last Modified:              09-17-2005 02:21 CEST
======================================================================
Summary:                    powermac sound does't work on the latest iBooks
Description: 
On the latest Apple iBooks, snapper chips get detected as
awacs, aparently this is because of some sort of chip id
(I am not a programmer, not even familar in this matter - though I was
able to make a fix)

Note that this is to linux kernel 2.6.13.1. 
Also note that somebody else has submitted another patch that looks
very similar to this one, though it is NOT the same.
(the 1.42ghz iBooks need 0x5C, the 1.33ghz iBooks 0x50)

I hope this information is useful enough to get into alsa-cvs,
thank you and have a nice day.

*** sound/ppc/pmac.c.orig       2005-09-17 02:07:49.000000000 +0200
--- sound/ppc/pmac.c    2005-09-14 19:18:12.000000000 +0200
***************
*** 988,993 ****
--- 988,994 ----
                case 0x33:
                case 0x29:
                case 0x24:
+               case 0x50:
                        chip->num_freqs = ARRAY_SIZE(tumbler_freqs);
                        chip->model = PMAC_SNAPPER;
                        chip->can_byte_swap = 0; /* FIXME: check this */

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-17-05 02:21 thouters       New Issue                                    
09-17-05 02:21 thouters       Kernel Version            => 2.6.13.1        
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
