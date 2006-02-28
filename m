From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001884]: alsaconf don't find Realtek ALC850 onboard soundchip on ASUS A8V Deluxe when Creative X-Fi XtremeMusic is pluged in
Date: Tue, 28 Feb 2006 15:52:49 +0100
Message-ID: <3617a1a0ca7daca119d45571807c02e6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D5DEE19C
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 15:52:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1884> 
======================================================================
Reported By:                bergwiesel
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1884
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian 4.0.2-5
Kernel Version:             2.6.12
======================================================================
Date Submitted:             02-28-2006 15:18 CET
Last Modified:              02-28-2006 15:52 CET
======================================================================
Summary:                    alsaconf don't find Realtek ALC850 onboard soundchip
on ASUS A8V Deluxe when Creative X-Fi XtremeMusic is pluged in
Description: 
Hi!

I have an Asus A8V Deluxe mainboard with its Realtek ALC850 soundchip,
which is fine for its own, but if I plug in my new Soundblaster X-Fi
alsaconf don't find a thing.

Do you need some more informations?
======================================================================

----------------------------------------------------------------------
 er-ku - 02-28-06 15:20 
----------------------------------------------------------------------
could it be conflicting IRQs?

----------------------------------------------------------------------
 vsu - 02-28-06 15:52 
----------------------------------------------------------------------
ASUS A8V BIOS has a "feature" which cannot be disabled: if a PCI sound card
is present, the onboard sound is disabled automatically.  I remember that
it is documented somewhere in the manual.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001066 describes the
same problem with the same motherboard.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-28-06 15:18 bergwiesel     New Issue                                    
02-28-06 15:18 bergwiesel     Distribution              => Debian 4.0.2-5  
02-28-06 15:18 bergwiesel     Kernel Version            => 2.6.12          
02-28-06 15:20 er-ku          Note Added: 0008243                          
02-28-06 15:52 vsu            Note Added: 0008244                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
