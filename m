From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000057]: Kernel device in bad state after suspend/resume
Date: Wed, 12 Oct 2005 21:02:51 +0200
Message-ID: <90fe000f8d9ebe20ad92b66eed53d4e9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CD4B0169
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 21:02:51 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Last Modified:              10-12-2005 21:02 CEST
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
 tiwai - 10-05-05 18:40 
----------------------------------------------------------------------
Does touching mixer volumes change anything (instead of reloading)?

----------------------------------------------------------------------
 Johannes Berg - 10-12-05 21:02 
----------------------------------------------------------------------
tiwai, no it did not, all was silent. However, the code in 2.6.14 fixes the
problem entirely for me.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 01:55 daenzer        New Issue                                    
02-26-04 19:30 daenzer        Note Added: 0000363                          
02-26-04 19:39 tiwai          Note Added: 0000364                          
02-26-04 22:47 daenzer        Note Added: 0000374                          
05-14-04 15:12 tiwai          Note Added: 0001111                          
09-29-05 20:55 jdthood        Relationship added       has duplicate 0001442
09-29-05 23:52 Johannes Berg  Issue Monitored: Johannes Berg                    
09-29-05 23:59 Johannes Berg  Note Added: 0006427                          
10-05-05 18:40 tiwai          Note Added: 0006432                          
10-12-05 21:02 Johannes Berg  Note Added: 0006474                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
