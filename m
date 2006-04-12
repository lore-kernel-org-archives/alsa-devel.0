From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002016]: Choppy/skippy sound on onboard SiS SI7012-controller
Date: Wed, 12 Apr 2006 04:40:19 +0200
Message-ID: <d2272df09af45eb362d4f227f4dd0830@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 864DF137
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 04:40:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2016> 
======================================================================
Reported By:                Ensnared
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2016
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 "Breezy Badger"
Kernel Version:             2.6.x
======================================================================
Date Submitted:             04-12-2006 04:40 CEST
Last Modified:              04-12-2006 04:40 CEST
======================================================================
Summary:                    Choppy/skippy sound on onboard SiS SI7012-controller
Description: 
The sound on my specific sound controller is very bad. The times it even
plays, the quality is very choppy and it skips almost like a scratched CD,
which makes it pretty much unusable.

I suspect this might be specific for my model laptop as I'm having a hard
time finding anyone else with the same problem, but I've tried several
distros and kernel versions, and the card works in Windows.

The laptop is an Elite Group G732, which has a SiS mainboard chipset with
the SI7012 onboard controller (Realtek ALC202 chip).

I've tried messing with the buffer_size and period_size in asound.conf,
which seem to have some impact on the "pattern" of the chopping and
skipping, but there are no values that I've found that will get rid of
them entirely.

I'm assuming this is an incompatibility with the driver and this specific
hardware, but I could obviously be wrong.

I've tried using the version of ALSA in the 2.6.10, 2.6.12 and 2.6.16.2
kernels, as well as compiled the latest stable and developement releases
of ALSA myself. The result is the same for them all.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-06 04:40 Ensnared       New Issue                                    
04-12-06 04:40 Ensnared       Distribution              => Ubuntu 5.10 "Breezy
Badger"
04-12-06 04:40 Ensnared       Kernel Version            => 2.6.x           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
