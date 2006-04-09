From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001335]: No sound on first probe
Date: Sun, 9 Apr 2006 02:49:57 +0200
Message-ID: <8be5a0c9b62165b36c5449b24a047ebf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E381134
	for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2006 02:49:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1335> 
======================================================================
Reported By:                cpx
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1335
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0
Kernel Version:             2.6.13-rc6
======================================================================
Date Submitted:             08-14-2005 08:31 CEST
Last Modified:              04-09-2006 02:49 CEST
======================================================================
Summary:                    No sound on first probe
Description: 
The first probe of the snd-via82xx module results in no sound from the
speakers/headphone jack. Removing the module and reloading it fixes the
problem. Upon reloading (sometimes when removing) a small bit of feedback
is audible (i.e. suggesting the hardware's been "initialized").

The module seems to have to be removed for it to work though... just
rebooting and having it reload the module that way doesn't work.

After performing the above to make it work the system can then be warm
booted with the sound continuing to work until powering off.
======================================================================

----------------------------------------------------------------------
 cpx - 01-06-06 19:10 
----------------------------------------------------------------------
So... this is still happening with the latest kernel, only sometime around
2.6.14 the rmmod trick stop working. Now I have to boot to winders first
to get the hardware initialized.

----------------------------------------------------------------------
 cpx - 04-09-06 02:49 
----------------------------------------------------------------------
Still no luck with kernel 2.6.16... can someone help please? :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-05 08:31 cpx            New Issue                                    
08-14-05 08:31 cpx            Distribution              => Slackware 10.0  
08-14-05 08:31 cpx            Kernel Version            => 2.6.13-rc6      
01-06-06 19:10 cpx            Note Added: 0007493                          
01-10-06 20:10 mysticxhiro    Issue Monitored: mysticxhiro                    
04-09-06 02:49 cpx            Note Added: 0009176                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
