From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001424]: crash on snd-powermac initilize
Date: Thu, 15 Sep 2005 20:38:05 +0200
Message-ID: <ad7be7697ce3b3a30218951738500b15@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39286175
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 20:38:05 +0200 (MEST)
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
Last Modified:              09-15-2005 20:38 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 20:38 amir           New Issue                                    
09-15-05 20:38 amir           File Added: .config                          
09-15-05 20:38 amir           Distribution              => GeeXboX         
09-15-05 20:38 amir           Kernel Version            => 2.6.13.1        
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
