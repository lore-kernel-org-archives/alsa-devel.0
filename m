From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001875]: null device gererates much more frames than physical hw would
Date: Fri, 24 Feb 2006 22:51:26 +0100
Message-ID: <f241d8fbc25eedea8cc2ac4068adf6a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 866E11C8
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2006 22:51:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1875> 
======================================================================
Reported By:                gjasny
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1875
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-24-2006 22:51 CET
Last Modified:              02-24-2006 22:51 CET
======================================================================
Summary:                    null device gererates much more frames than physical
hw would
Description: 
Hi,

for some reason, my application supports capturing from the null device.
In contrast to real devices, the null device supplies sound data as fast
as possible.
I would expect that I get about channel*bits*rate/8 bytes per second.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-24-06 22:51 gjasny         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
