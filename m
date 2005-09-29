From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000057]: Kernel device in bad state after suspend/resume
Date: Thu, 29 Sep 2005 20:55:37 +0200
Message-ID: <f1420efcac7633abfff51940e1b5ece4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8501191
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 20:55:37 +0200 (MEST)
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


The issue 0001442 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=57> 
======================================================================
Reported By:                daenzer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   57
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-13-2004 01:55 CET
Last Modified:              05-14-2004 15:12 CEST
======================================================================
Summary:                    Kernel device in bad state after suspend/resume
Description: 
If a process has the kernel device open during a suspend/resume cycle,
playing sound fails afterwards with

pcm_write:1084: write error: File descriptor in bad state

until the process dies, then it works again.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001442 snapper: no sound after resume
======================================================================

----------------------------------------------------------------------
 daenzer - 02-26-04 19:30 
----------------------------------------------------------------------
Any feedback on this? I'll gladly try to track it down myself given some
pointers how to go about it.

----------------------------------------------------------------------
 tiwai - 02-26-04 19:39 
----------------------------------------------------------------------
which chip model?  check /proc/asound/cards.

----------------------------------------------------------------------
 daenzer - 02-26-04 22:47 
----------------------------------------------------------------------
0 [Snapper        ]: PMac Snapper - PowerMac Snapper
                     PowerMac Snapper (Dev 26) Sub-frame 0

----------------------------------------------------------------------
 tiwai - 05-14-04 15:12 
----------------------------------------------------------------------
does it happen with an OSS app or an ALSA app?

do you see any kernel messages after resume?
(e.g. tumbler_init_client error or so)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 01:55 daenzer        New Issue                                    
02-26-04 19:30 daenzer        Note Added: 0000363                          
02-26-04 19:39 tiwai          Note Added: 0000364                          
02-26-04 22:47 daenzer        Note Added: 0000374                          
05-14-04 15:12 tiwai          Note Added: 0001111                          
09-29-05 20:55 jdthood        Relationship added       has duplicate 0001442
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
