From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002017]: Identify ALC880 chip on Epox EP-5LDA+ GLi motherboard
Date: Wed, 12 Apr 2006 20:16:34 +0200
Message-ID: <5d0523d1838327277cd27536ce473420@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D09114F
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 20:16:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2017> 
======================================================================
Reported By:                timo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2017
Category:                   PCI - hda-intel
Reproducibility:            have not tried
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Kubuntu - Dapper Flight 4
Kernel Version:             2.6.15
======================================================================
Date Submitted:             04-12-2006 20:16 CEST
Last Modified:              04-12-2006 20:16 CEST
======================================================================
Summary:                    Identify ALC880 chip on Epox EP-5LDA+ GLi
motherboard
Description: 
This motherboard has the Realtek ALC880 chip, but it was not recognized. No
sound at all. I tried most of the index, position_fix and model
possibilities, no help. Also alsa from cvs. I used instructions from this
forum to generate an addition to the patch_realtek.c with the 1.0.11rc5:
{ .pci_subvendor = 0x1695, .pci_subdevice = 0x4012, .config =
ALC880_6ST_DIG },
compiled and bingo.

I'm not sure if this is the only way to go, but it did the trick for me.
Now I have sound.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-06 20:16 timo           New Issue                                    
04-12-06 20:16 timo           Distribution              => Kubuntu - Dapper
Flight 4
04-12-06 20:16 timo           Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
