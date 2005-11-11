From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001545]: Flash player hangs in Firefox when using aoss
Date: Fri, 11 Nov 2005 21:30:17 +0100
Message-ID: <8e7604093ce6ee4c90d8ab598e2e5c33@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6FC281BD
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2005 21:30:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1545> 
======================================================================
Reported By:                smagoun
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1545
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-11-2005 21:30 CET
Last Modified:              11-11-2005 21:30 CET
======================================================================
Summary:                    Flash player hangs in Firefox when using aoss
Description: 
I'm trying to get aoss to work with Firefox 1.5b2 and the Flash 7 plugin on
an XScale (PXA 270) running Linux 2.6.13.4. Problem is, the browser hangs
when navigating off a page that has Flash w/ sounds. The problem only
happens when using aoss. GDB reports that the browser's hung up in
snd_pcm_wait_nocheck, called from snd_pcm_dmix_drain.

This sounds a bit like
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1306, which was
reportedly fixed in ALSA
1.0.9a. I'm using the 1.0.9b drivers from 2.6.13.4 (plus patches for the
AC97 that were subsequently rolled into 2.6.14). Upgrading alsa-oss and
alsa-libs to 1.0.10rc3 didn't fix the problem.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-11-05 21:30 smagoun        New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
