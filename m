From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001424]: crash on snd-powermac initilize
Date: Wed, 1 Mar 2006 07:20:20 +0100
Message-ID: <7d08d917454c993bb9bb3e449ce7c542@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 71C0D1CA
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 07:20:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1424> 
======================================================================
Reported By:                amir
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1424
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               GeeXboX
Kernel Version:             2.6.13.1
======================================================================
Date Submitted:             09-15-2005 20:38 CEST
Last Modified:              03-01-2006 07:20 CET
======================================================================
Summary:                    crash on snd-powermac initilize
Description: 
I have users reporting a reproducable, on init, crash of our powerpc
distro,
but this happens to only some of the ppc users.

the distro is geexbox, www.geexbox.org

this crash happens also when snd-powermac is compiled as module,
and crashes when module is loaded.

I can't reproduce the bug myself, but I have users who do the tests,
and those users report that debian and ubuntu works great for them.

this bug also happened with linux 2.6.12
======================================================================

----------------------------------------------------------------------
 netstar - 03-01-06 07:20 
----------------------------------------------------------------------
I can also confirm this behaviour.  Using 2.6.15 kernel and any
distribution.  I think it's an issue with older iMacs.  My model is:

processor       : 0
cpu             : PPC970FX, altivec supported
clock           : 1800.000000MHz
revision        : 3.0 (pvr 003c 0300)

timebase        : 33333333
machine         : PowerMac8,1
motherboard     : PowerMac8,1 MacRISC4 Power Macintosh
detected as     : 338 (iMac G5)
pmac flags      : 00000000
L2 cache        : 512K unified
pmac-generation : NewWorld

This crashing is definitely not distribution specific, but rather model
specific.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 20:38 amir           New Issue                                    
09-15-05 20:38 amir           File Added: .config                          
09-15-05 20:38 amir           Distribution              => GeeXboX         
09-15-05 20:38 amir           Kernel Version            => 2.6.13.1        
03-01-06 07:20 netstar        Note Added: 0008272                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
