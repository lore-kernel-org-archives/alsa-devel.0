From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001873]: emu10k1 AC97 loopback on left channel only.
Date: Fri, 24 Feb 2006 00:28:56 +0100
Message-ID: <30359096403794b592ba2ebe99de9319@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E5B61C3
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2006 00:28:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1873> 
======================================================================
Reported By:                kenm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1873
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware current
Kernel Version:             2.6.15.3
======================================================================
Date Submitted:             02-24-2006 00:28 CET
Last Modified:              02-24-2006 00:28 CET
======================================================================
Summary:                    emu10k1 AC97 loopback on left channel only.
Description: 
Creative Labs CT4832 SBLive Value
With alsa-driver versions 1.0.9b and previously, it was possible to set
both "AC97" and "AC97 Capture" to full volume in alsamixer, to set up
digital loopback to monitor in real time the sound recorded through "line
in" via "line out".  With version 1.0.10, the monitored sound appears on
the left channel only.  The right channel is completely muted.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-24-06 00:28 kenm           New Issue                                    
02-24-06 00:28 kenm           Distribution              => Slackware current
02-24-06 00:28 kenm           Kernel Version            => 2.6.15.3        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
