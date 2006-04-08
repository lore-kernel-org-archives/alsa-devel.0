From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001787]: Terratec Aureon Universe - No sound on first startup, sound after reboot
Date: Sat, 8 Apr 2006 16:58:06 +0200
Message-ID: <aa6fe8df60582bbfbb50003f6e36f531@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E182F144
	for <alsa-devel@alsa-project.org>; Sat,  8 Apr 2006 16:58:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1787> 
======================================================================
Reported By:                paskharen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1787
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Ubuntu
Kernel Version:             2.6.12
======================================================================
Date Submitted:             01-27-2006 19:58 CET
Last Modified:              04-08-2006 16:58 CEST
======================================================================
Summary:                    Terratec Aureon Universe - No sound on first
startup, sound after reboot
Description: 
When I first start the computer, you can hear no sound. If I turn all
volume to max and press my ear against the speaker I can hear the correct
sounds/music very faintly. After a reboot sound is fine.
======================================================================

----------------------------------------------------------------------
 ungod - 04-03-06 15:47 
----------------------------------------------------------------------
Have you tried with the aureon-mutex2.diff patch from BUG 1797?

----------------------------------------------------------------------
 paskharen - 04-08-06 16:58 
----------------------------------------------------------------------
I have now, it doesn't help. I tried with alsa 1.0.11-rc4 and not cvs but I
didn't think that would matter.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-06 19:58 paskharen      New Issue                                    
01-27-06 19:58 paskharen      Distribution              => Ubuntu          
01-27-06 19:58 paskharen      Kernel Version            => 2.6.12          
01-28-06 18:02 ungod          Note Added: 0007829                          
01-30-06 19:38 paskharen      Note Added: 0007841                          
02-08-06 23:48 paskharen      Note Added: 0007968                          
04-03-06 15:47 ungod          Note Added: 0009099                          
04-08-06 16:58 paskharen      Note Added: 0009172                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
