From: noreply@alsa-project.org
Subject: [ALSA - driver 0000187]: 82C928 chip wrong interrupt and dma configuration
Date: Fri, 16 Jul 2004 12:46:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104621.83D8626009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C55A5255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:46:21 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000187
======================================================================
Reported By:                krak3n
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     187
Category:                   ISA - opti9xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               debian
Kernel Version:             2.6.4
======================================================================
Date Submitted:             04-05-2004 10:03 CEST
Last Modified:              07-16-2004 12:46 CEST
======================================================================
Summary:                    82C928 chip wrong interrupt and dma configuration
Description: 
Last week I tested a new kernel 2.6.4 (alsa 1.0.2) with ISA sound card
(OPTI 82C928 chipset) but driver was wrong. Test with kernel 2.4.25 and
alsa driver 1.0.3 - wrong .. Latest working version of alsa driver was
0.9.0rc2. (witch 2.4.18 kernel). I was not able compile 0.9.0rc3 with
2.4.18 kernel. Next 0.9.0rc4 compiled with 2.4.18 kernel run with the same
bug like alsa 1.0.2.

I found problem with interrupt on this card, no one interrupt was received
from AD1848. If I use OSS driver (MAD16) this driver set up this card
correctly and next use of alsa (0.9.0 .. 1.0.3) work correctly too. Diff
between working 0.9.0rc2 and broken 0.9.0rc4 show a different setup of
interrupts bit in function snd_opti9xx_configure from file
alsa-driver-0.9.0rc3/alsa-kernel/isa/opti9xx/opti92x-ad1848.c (only
relevant part of diff):

static int __init snd_opti9xx_configure(opti9xx_t *chip)

@@ -600,7 +604,7 @@
 #endif /* CS4231 || OPTi93X */

        spin_lock_irqsave(&chip->lock, flags);
-       outb(irq_bits << 3 | dma_bits, chip->wss_base);
+       snd_opti9xx_write(chip, OPTi9XX_MC_REG(3), (irq_bits << 3 |
dma_bits));
        spin_unlock_irqrestore(&chip->lock, flags);

 __skip_resources:

In CVS log from revision 1.15 of file
alsa-driver-0.9.0rc3/alsa-kernel/isa/opti9xx/opti92x-ad1848.c
I found this:

> Revision: 1.15, Mon Jul 22 10:31:45 2002 UTC (20 months, 2 weeks ago) by
 tiwai
> Changes since 1.14: +30 -21 lines
> .
> .
> 7) In snd_opti9xx_configure, I believe the port
> used to set the pcm irq on the card was wrong
> for the 931.
> .
> .

I show what configuration is used in oss driver (mad16) and I found for
all cards (92X 93x) the same config port:
int config_port = hw_config->io_base + 0
I don't known why 931 chip need to be setup differ from 928, but current
setup is not working with 82C928 (maybe others 92X).


======================================================================

----------------------------------------------------------------------
 perex - 04-19-2004 21:17 CEST 
----------------------------------------------------------------------
The proposed patch was applied to CVS. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-05-04 10:03 krak3n         New Bug                                      
04-05-04 10:03 krak3n         Distribution              => debian          
04-05-04 10:03 krak3n         Kernel Version            => 2.6.4           
04-05-04 10:10 krak3n         Bug Monitored: krak3n                        
04-05-04 15:04 krak3n         Bug End Monitor: krak3n                      
04-19-04 21:17 perex          Bugnote Added: 0000863                       
04-19-04 21:17 perex          Assigned To               => perex           
04-19-04 21:17 perex          Resolution               open => fixed       
04-19-04 21:17 perex          Status                   new => resolved     
07-16-04 12:46 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
