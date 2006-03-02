From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001857]: regression in snd-cs4281 in recent 2.6.16-rcX kernels
Date: Thu, 2 Mar 2006 16:05:04 +0100
Message-ID: <7e8291218a16f20c789eb6beefe62711@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8CB06191
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 16:05:04 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1857> 
======================================================================
Reported By:                hoffmajs
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1857
Category:                   PCI - cs4281
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu (Dapper)
Kernel Version:             2.6.16-rc4
======================================================================
Date Submitted:             02-19-2006 06:11 CET
Last Modified:              03-02-2006 16:05 CET
======================================================================
Summary:                    regression in snd-cs4281 in recent 2.6.16-rcX
kernels
Description: 
In the recent 2.6.16-rc kernels snd-cs4281 broke for me.
(I think since 2.6.16-rc2, but Im not sure atm. In 2.6.15 the card works
fine.)

# > modprobe snd-cs4281
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKC] -> GSI 5 (level, low)
-> IRQ 5
never read ISV3 and ISV4 from AC'97
ACPI: PCI interrupt for device 0000:00:08.0 disabled
CS4281: probe of 0000:00:08.0 failed with error -5

and no soundcard is found.

If you need more info or want me to test something, please say so.


kind regards,
Jens

======================================================================

----------------------------------------------------------------------
 tiwai - 03-02-06 16:05 
----------------------------------------------------------------------
Since there is no change in cs4281 driver for long time, it's likely an
ACPI breakage.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-06 06:11 hoffmajs       New Issue                                    
02-19-06 06:11 hoffmajs       Distribution              => Ubuntu (Dapper) 
02-19-06 06:11 hoffmajs       Kernel Version            => 2.6.16-rc4      
03-02-06 16:05 tiwai          Note Added: 0008319                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
