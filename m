From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000504]: after the alsa modules are loaded, active speaker beginns to make noise
Date: Wed, 14 Sep 2005 16:21:18 +0200
Message-ID: <912eb7df959232ce47953a2b531af5f1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 029E7151
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:21:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=504> 
======================================================================
Reported By:                placew
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   504
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo.2004
Kernel Version:             2.6.7-gentoo-r6
======================================================================
Date Submitted:             09-16-2004 12:36 CEST
Last Modified:              09-14-2005 16:21 CEST
======================================================================
Summary:                    after the alsa modules are loaded, active speaker
beginns to make noise
Description: 
i've got my alsa modules compiled in a kernel, v.2.6.7-gentoo-r6. At boot,
once, there are the alsa modules loaded, active speaker starts hissing.
When mp3 (or other sound) is playing, the noise is getting low, almoust
unhearable. Active speaker stops hissing once the modules are unloaded
during the reboot.  My soundcard is ensoniq PCI128, using module ens1371.
Thanks for cooperation.
======================================================================

----------------------------------------------------------------------
 wvd - 01-12-05 21:48 
----------------------------------------------------------------------
Same here, modules compiled with a 2.6.10 GNU/Linux, exactly the same
behaviour as discribed by reporter 'placew'.
Using the same ensoniq 1371
Alsa version 1.05a
Hissing fades when screen activity (RIVA TNT2)
Muting ALL does not have any effect on the hissing.

----------------------------------------------------------------------
 jdthood - 09-14-05 16:21 
----------------------------------------------------------------------
Is the behavior improved in more recent ALSA versions?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-16-04 12:36 placew         New Issue                                    
09-16-04 12:36 placew         Distribution              => Gentoo.2004     
09-16-04 12:36 placew         Kernel Version            => 2.6.7-gentoo-r6 
09-17-04 10:42 placew         Issue Monitored: placew                      
09-17-04 10:42 placew         Issue End Monitor: placew                    
09-28-04 16:07 djtm           Note Added: 0001948                          
12-02-04 21:01 Sebastian      Issue Monitored: Sebastian                    
12-02-04 21:12 Sebastian      Note Added: 0002698                          
01-12-05 21:48 wvd            Note Added: 0003179                          
01-12-05 21:50 wvd            Issue Monitored: wvd                         
09-14-05 16:21 jdthood        Note Added: 0006182                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
