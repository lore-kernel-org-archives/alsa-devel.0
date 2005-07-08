From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000247]: An option cannot specify correctly.
Date: Fri, 8 Jul 2005 10:34:32 +0200
Message-ID: <6d8630c667c3cd9f7d1e4904524fc4a9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B3C07186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:32 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=247> 
======================================================================
Reported By:                sitamo
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   247
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-29-2004 18:14 CEST
Last Modified:              07-08-2005 10:34 CEST
======================================================================
Summary:                    An option cannot specify correctly.
Description: 
I think that it becomes the following codes.

--- alsamixer/alsamixer.c.org   2004-02-17 01:44:06.000000000 +0900
+++ alsamixer/alsamixer.c       2004-04-30 01:08:52.000000000 +0900
@@ -2002,8 +2002,8 @@
          }
          break;
        case 'D':
-         strncpy(card_id, optarg, sizeof(card_id));
-         card_id[sizeof(card_id)-1] = '\0';
+         strncpy(card_id, optarg, strlen(optarg));
+         card_id[strlen(optarg)] = '\0';
          break;
        case 'g':
          mixer_do_color = !mixer_do_color;

======================================================================

----------------------------------------------------------------------
 tiwai - 05-01-04 11:07 
----------------------------------------------------------------------
the current code is correct.

what error did you have exactly?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-29-04 18:14 sitamo         New Issue                                    
05-01-04 11:07 tiwai          Note Added: 0000999                          
03-22-05 09:47 jdthood        Status                   new => resolved     
03-22-05 09:47 jdthood        Resolution               open => not an issue
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
