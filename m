From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000583]: xruns when playing audio or video files
Date: Wed, 14 Sep 2005 15:52:46 +0200
Message-ID: <86157b975c54843eef2ae5c9235a8b13@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 91CB6191
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 15:52:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=583> 
======================================================================
Reported By:                KAtiOS
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   583
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.9_rc4
======================================================================
Date Submitted:             10-15-2004 16:27 CEST
Last Modified:              09-14-2005 15:52 CEST
======================================================================
Summary:                    xruns when playing audio or video files
Description: 
I get xruns when playing files.
I tested with lots of 2.6 kernels, up to 2.6.9_rc4 with the same results.
It seems that mplayer with sdl output works fine, but xruns with alsa.
Using acpi=off or pci=noacpi helps in mplayer but not in vdr (with
softdevice plugin - using alsa).



======================================================================

----------------------------------------------------------------------
 KAtiOS - 10-16-04 11:39 
----------------------------------------------------------------------
Ok, tested with xine, it seems to be working, except with HDTV files but I
supposed it's normal given the load.
So, even if almost every alsa apps causes xruns on some hardware only, as
long as it's their use of alsa which is bad, that's not a problem.
How alsa can be so hard to implement correctly so that experienced
programmers can't make their software usable on every platform?

[Question : if I can test another sound card on the same computer, could I
conclude something with the result with mplayer/vdr-softdevice before
definitely closing this bug?]

----------------------------------------------------------------------
 jdthood - 09-14-05 15:52 
----------------------------------------------------------------------
Is there a consensus that this report can be closed,
because the problem is really in mplayer?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-15-04 16:27 KAtiOS         New Issue                                    
10-15-04 16:27 KAtiOS         Distribution              => Gentoo Linux    
10-15-04 16:27 KAtiOS         Kernel Version            => 2.6.9_rc4       
10-15-04 18:43 lee            Note Added: 0002168                          
10-15-04 18:51 KAtiOS         Note Added: 0002169                          
10-15-04 19:02 lee            Note Added: 0002170                          
10-15-04 19:12 KAtiOS         Note Added: 0002171                          
10-15-04 19:24 KAtiOS         Note Added: 0002172                          
10-15-04 19:29 lee            Note Added: 0002173                          
10-15-04 20:28 KAtiOS         Note Added: 0002174                          
10-15-04 22:17 lee            Note Added: 0002175                          
10-15-04 23:49 KAtiOS         Note Added: 0002176                          
10-16-04 01:11 lee            Note Added: 0002180                          
10-16-04 01:18 lee            Note Added: 0002181                          
10-16-04 06:05 lee            Note Added: 0002183                          
10-16-04 10:08 KAtiOS         Note Added: 0002185                          
10-16-04 11:39 KAtiOS         Note Added: 0002186                          
09-14-05 15:52 jdthood        Note Added: 0006161                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
