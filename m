From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001426]: only mono sound available on via82xx
Date: Thu, 15 Sep 2005 22:47:24 +0200
Message-ID: <0ed2f2911bd69270ca87f21b9f25592f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 50EE8185
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 22:47:24 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1426> 
======================================================================
Reported By:                netset99
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1426
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               gentoo
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-15-2005 22:12 CEST
Last Modified:              09-15-2005 22:47 CEST
======================================================================
Summary:                    only mono sound available on via82xx
Description: 
Only get mono sound with alsa. This is shown by the fact that I cannot
change the master stereo volume e.g. in alsamixer, only mute or unmute
it.

Tried with kernels 2.6.12, 2.6.13, both compiled into the kernel or as
modules. Also happens with the drivers from the alsa homepage
(1.0.10_rc1). Tried live CD's from Gentoo (2.6.12 kernel) and from Knoppix
(2.6.11). dxs_support 1-5 and ac97_quirk parameters didn't solve the
problem. Neither did changing volume / muting and unmuting a combination
of controls in alsamixer.

However: A Ubuntu Live CD (Kernel 2.6.10) gives me normal stereo sound.
======================================================================

----------------------------------------------------------------------
 netset99 - 09-15-05 22:47 
----------------------------------------------------------------------
I just wanted to add that in fact I can hear sound and it is stereo, I just
cannot change the master stereo volume, just the PCM one.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 22:12 netset99       New Issue                                    
09-15-05 22:12 netset99       Distribution              => gentoo          
09-15-05 22:12 netset99       Kernel Version            => 2.6.13          
09-15-05 22:47 netset99       Note Added: 0006226                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
