From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002020]: Rear output should be useable as normal output (not just sourround)
Date: Fri, 14 Apr 2006 16:34:15 +0200
Message-ID: <5faec0114c59dccbab9a74c69963acec@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7463194
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 16:34:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2020> 
======================================================================
Reported By:                shina
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2020
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             
======================================================================
Date Submitted:             04-14-2006 16:34 CEST
Last Modified:              04-14-2006 16:34 CEST
======================================================================
Summary:                    Rear output should be useable as normal output (not
just sourround)
Description: 
The one thing that keeps me from using ALSA's snd-emu10k1 instead OSS's
emu10k1 is that I cannot really use the rear output.
Yes, there is a mixer control named "Wave Sourround", but it outputs only
PCM (not Line/Wavetable/..). Also I have to change Wave Sourround and PCM
Volume seperately. The way it works with the OSS driver is more logical.
I tried to figure out how to make things work with ld10k1, but I really
don't understand this program. emu-dspmgr is "easier" to understand.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-14-06 16:34 shina          New Issue                                    
04-14-06 16:34 shina          Distribution              => Gentoo Linux    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
