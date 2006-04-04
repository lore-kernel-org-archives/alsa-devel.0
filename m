From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002000]: Sound continually cuts in and out
Date: Tue, 4 Apr 2006 19:22:03 +0200
Message-ID: <e8fb0dea17b6351409c9f51d5de6fd8c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9EC8621C
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 19:22:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2000> 
======================================================================
Reported By:                spm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2000
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 Breezy
Kernel Version:             2.6.12-10-386
======================================================================
Date Submitted:             04-04-2006 19:22 CEST
Last Modified:              04-04-2006 19:22 CEST
======================================================================
Summary:                    Sound continually cuts in and out
Description: 
And it makes a pop sound when cutting out.

I thought it was an IRQ conflict, but it is not (I checked with "cat
/proc/interrupts".

This actually started to occur after plugging in a USB mouse. Mouse is no
longer in, but problem persists. I have redone "alsaconf" problem still
persists...pulling my hair out here...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-06 19:22 spm            New Issue                                    
04-04-06 19:22 spm            Distribution              => Ubuntu 5.10 Breezy
04-04-06 19:22 spm            Kernel Version            => 2.6.12-10-386   
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
