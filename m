From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000430]: the argument parsing for -D is broken (fix included)
Date: Fri, 24 Sep 2004 13:40:08 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924114008.0DA10101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 55278288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:40:08 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000430
======================================================================
Reported By:                muth
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Bug ID:                     430
Category:                   amixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             08-08-2004 04:28 CEST
Last Modified:              09-24-2004 13:40 CEST
======================================================================
Summary:                    the argument parsing for -D is broken (fix included)
Description: 
Form amixer.c

case 'D':
	case HELPID_DEVICE:
		strncpy(card, optarg, sizeof(card-1));
			card[sizeof(card)-1] = '\0';
			break;

the first sizeof should be like the second sizeof.
Right now it will be identical to sizeof(int) or four.


======================================================================

----------------------------------------------------------------------
 perex - 08-10-2004 11:46 CEST 
----------------------------------------------------------------------
Fixed in CVS. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-08-04 04:28 muth           New Bug                                      
08-10-04 11:46 perex          Bugnote Added: 0001547                       
08-10-04 11:46 perex          Assigned To               => perex           
08-10-04 11:46 perex          Resolution               open => fixed       
08-10-04 11:46 perex          Status                   new => resolved     
09-24-04 13:40 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
