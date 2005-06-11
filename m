From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000915]: When compiled with SND_HWDEP enabled, the intel8x0 driver is no longer able to share an IRQ with other devices
Date: Sat, 11 Jun 2005 15:49:41 +0200
Message-ID: <0a40d1c685c5c602d9b85ba8b24c97be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CD8AE1D2
	for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2005 15:49:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=915> 
======================================================================
Reported By:                Jochen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   915
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10-gentoo-r7
======================================================================
Date Submitted:             02-17-2005 10:17 CET
Last Modified:              06-11-2005 15:49 CEST
======================================================================
Summary:                    When compiled with SND_HWDEP enabled, the intel8x0
driver is no longer able to share an IRQ with other devices
Description: 
On my System an intel8x0 card and a Intel PRO Wireless 2200BG card share
irq5 which works perfectly with SND_HWDEP.

I recently enabled SND_HWDEP for another audio driver. since then all
commands the ipw2200 driver issues to the wlan card time out, the audio
driver however is still working.

Since I didn't change the ipw2200 driver but only an alsa related option,
I guess it's an alsa bug
======================================================================

----------------------------------------------------------------------
 tiwai - 02-17-05 18:39 
----------------------------------------------------------------------
Then correct your driver's Kconfig file to select SND_HWDEP.

Anyway, this sounds like a false positive.
hwdep module can't influence on intel8x0 or any other drivers.  It's a
core module and have no h/w access by itself.
Check whether any other drivers are loaded casually and conflict.

----------------------------------------------------------------------
 Jochen - 06-11-05 15:49 
----------------------------------------------------------------------
yes, true. this was a false positive. could somebody please close the bug?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-17-05 10:17 Jochen         New Issue                                    
02-17-05 10:17 Jochen         Distribution              => Gentoo          
02-17-05 10:17 Jochen         Kernel Version            => 2.6.10-gentoo-r7
02-17-05 10:56 Jochen         Note Added: 0003627                          
02-17-05 18:18 tiwai          Note Added: 0003629                          
02-17-05 18:33 Jochen         Note Added: 0003633                          
02-17-05 18:39 tiwai          Note Added: 0003634                          
06-11-05 15:49 Jochen         Note Added: 0004993                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
