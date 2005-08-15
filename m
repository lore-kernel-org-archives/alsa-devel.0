From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001336]: When a 64bit program has opened a dmix device first, 32bit programs cannot play through it
Date: Mon, 15 Aug 2005 19:44:46 +0200
Message-ID: <8a6fc3b0ff98fd31479d268c7e1aa5f3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0DC671BB
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 19:44:46 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1336> 
======================================================================
Reported By:                ikonst
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1336
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-14-2005 22:28 CEST
Last Modified:              08-15-2005 19:44 CEST
======================================================================
Summary:                    When a 64bit program has opened a dmix device first,
32bit programs cannot play through it
Description: 
When a 64bit has opened a dmix device first and holds it, a 32bit program
cannot play through it, instead giving the error:

set_params:910: Unable to install hw params:

I suspect the problem is due to misunderstandments in the dmix protocol,
e.g. using long instead of int.
======================================================================

----------------------------------------------------------------------
 tiwai - 08-15-05 19:44 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-05 22:28 ikonst         New Issue                                    
08-15-05 19:44 tiwai          Status                   new => resolved     
08-15-05 19:44 tiwai          Resolution               open => fixed       
08-15-05 19:44 tiwai          Assigned To               => tiwai           
08-15-05 19:44 tiwai          Note Added: 0005819                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
