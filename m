From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001424]: crash on snd-powermac initilize
Date: Mon, 3 Apr 2006 10:56:34 +0200
Message-ID: <d5c96001e353f9eec48a865749a8efe1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ECEE118D
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 10:56:34 +0200 (MEST)
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
Last Modified:              04-03-2006 10:56 CEST
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
 bugmenot - 04-03-06 10:47 
----------------------------------------------------------------------
Why the dependence on i2c-powermac is not explicit?

$ modinfo /lib/modules/2.6.16-gentoo-r1/kernel/sound/ppc/snd-powermac.ko
filename:      
/lib/modules/2.6.16-gentoo-r1/kernel/sound/ppc/snd-powermac.ko
license:        GPL
description:    PowerMac
depends:        snd-pcm,snd
^^^^^^^

----------------------------------------------------------------------
 Johannes Berg - 04-03-06 10:56 
----------------------------------------------------------------------
Because it calls it implicitly via the i2c layer so the dependency cannot
be determined at link time.

The problem is just that snd-powermac detects a chip even if the i2c stuff
isn't there -- it shouldn't, it should do a proper i2c driver instead.

Note that there's some effort I am currently doing on writing a new sound
driver called snd-aoa (google) that does this correctly and will likely
deprecate snd-powermac in the future so I recommend not investing too much
time and brainpower into fixing it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 20:38 amir           New Issue                                    
09-15-05 20:38 amir           File Added: .config                          
09-15-05 20:38 amir           Distribution              => GeeXboX         
09-15-05 20:38 amir           Kernel Version            => 2.6.13.1        
03-01-06 07:20 netstar        Note Added: 0008272                          
04-03-06 01:31 bugmenot       Note Added: 0009075                          
04-03-06 01:32 bugmenot       File Added: linux-2.6.16-gentoo-r1.config         
          
04-03-06 08:54 Johannes Berg  Note Added: 0009089                          
04-03-06 10:47 bugmenot       Note Added: 0009092                          
04-03-06 10:56 Johannes Berg  Note Added: 0009093                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
