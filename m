From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001968]: ews88mt does not work with the terratec mic8/2 module
Date: Sun, 9 Apr 2006 19:29:17 +0200
Message-ID: <7f79a423ceee56251cfd752a78592287@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 51A43156
	for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2006 19:29:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1968> 
======================================================================
Reported By:                jewi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1968
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               debian unstable
Kernel Version:             2.6.15
======================================================================
Date Submitted:             03-27-2006 11:42 CEST
Last Modified:              04-09-2006 19:29 CEST
======================================================================
Summary:                    ews88mt does not work with the terratec mic8/2
module
Description: 
Is it possible to get the ews88mt pci card working with the mic8/2 module
(http://audioen.terratec.net/modules.php?op=modload&name=News&file=article&sid=2)?

When I load the ice1712 driver I get the following error message:
AK4524 chip select failed, check cable to the front module.

I have this setup at home and hope I can post all the required
information.
Thanks for help.
======================================================================

----------------------------------------------------------------------
 jewi - 04-09-06 19:29 
----------------------------------------------------------------------
I have some additional information that might be helpful:

The mic8 module is shipped together with the ews88mt pci card. I found an
old win98 hd and check that my setup works with Win. So there is no
problem with not connected cables or broken hardware.

The kernel messages are a bit more comprehensive than mentioned above.
When I load the snd-ice1712 module I get the following:

kernel: ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKD] -> GSI 11
(level, ow) -> IRQ 11
kernel: AK4524 chip select failed, check cable to the front module
kernel: ACPI: PCI interrupt for device 0000:00:09.0 disabled
kernel: ICE1712: probe of 0000:00:09.0 failed with error -5

The module is loaded but there is no soundcard in /proc/asound/cards

I found out that forcing the module to take a ews88d card I can see a
soundcard in /proc/asound/cards and the 3.5mm jack works on the ews88mt
works. But I don't get usefull input from the 8 analog inputs.

Is there anyone who has an idea what I can do to get things working?

Thanks for help

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-27-06 11:42 jewi           New Issue                                    
03-27-06 11:42 jewi           Distribution              => debian unstable 
03-27-06 11:42 jewi           Kernel Version            => 2.6.15          
04-09-06 19:29 jewi           Note Added: 0009183                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
