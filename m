From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001857]: regression in snd-cs4281 in recent 2.6.16-rcX kernels
Date: Mon, 10 Apr 2006 16:47:28 +0200
Message-ID: <62635d5f0026d2c19b45b7dc4da59286@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EE66A184
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 16:47:28 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1857> 
======================================================================
Reported By:                hoffmajs
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1857
Category:                   PCI - cs4281
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Ubuntu (Dapper)
Kernel Version:             2.6.16-rc4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-19-2006 06:11 CET
Last Modified:              04-10-2006 16:47 CEST
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
 Mo6eB - 04-09-06 12:29 
----------------------------------------------------------------------
2.6.17-rc1 fixed it for me.

----------------------------------------------------------------------
 tiwai - 04-10-06 16:47 
----------------------------------------------------------------------
OK then let's close.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-06 06:11 hoffmajs       New Issue                                    
02-19-06 06:11 hoffmajs       Distribution              => Ubuntu (Dapper) 
02-19-06 06:11 hoffmajs       Kernel Version            => 2.6.16-rc4      
03-02-06 16:05 tiwai          Note Added: 0008319                          
04-05-06 10:33 julienbras     Note Added: 0009119                          
04-07-06 13:11 Mo6eB          Note Added: 0009138                          
04-07-06 19:16 tiwai          Note Added: 0009142                          
04-09-06 12:29 Mo6eB          Note Added: 0009178                          
04-10-06 16:47 tiwai          Status                   new => resolved     
04-10-06 16:47 tiwai          Resolution               open => fixed       
04-10-06 16:47 tiwai          Assigned To               => tiwai           
04-10-06 16:47 tiwai          Note Added: 0009197                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
