From: noreply@alsa-project.org
Subject: [ALSA - driver 0000228]: unrecognized opl3sa2 isapnp id
Date: Fri, 16 Jul 2004 13:02:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110249.A3DBB26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D9528255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:02:49 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000228
======================================================================
Reported By:                nickysn
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     228
Category:                   ISA - opl3sa2
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-21-2004 02:15 CEST
Last Modified:              07-16-2004 13:02 CEST
======================================================================
Summary:                    unrecognized opl3sa2 isapnp id
Description: 
snd-opl3sa2 doesn't recognize my OPL3-SA2 isapnp card. (it's a standard
YMF711)
if I enter the ports, dmas and irq manually it works fine.
looking at the source of the module I found that it recognizes the YMH0800
pnp id, but my card has YMH0801.

cat /proc/isapnp
Card 1 'YMH0801:OPL3-SA2 Sound Board' PnP version 1.0
  Logical device 0 'YMH0021:Unknown'
    Device is active
    Active port 0x240,0xe80,0x388,0x300,0x100
    Active IRQ 5 [0x2]
    Active DMA 1,3
    Resources 0
      Priority preferred
      Port 0x220-0x220, align 0xf, size 0x10, 16-bit address decoding
      Port 0x530-0x530, align 0x7, size 0x8, 16-bit address decoding
      Port 0x388-0x388, align 0x7, size 0x8, 16-bit address decoding
      Port 0x330-0x330, align 0x1, size 0x2, 16-bit address decoding
      Port 0x370-0x370, align 0x1, size 0x2, 16-bit address decoding
      IRQ 5 High-Edge
      DMA 0 8-bit byte-count type-A
      DMA 1 8-bit byte-count type-A
      Alternate resources 0:1
        Priority acceptable
        Port 0x240-0x240, align 0xf, size 0x10, 16-bit address decoding
        Port 0xe80-0xe80, align 0x7, size 0x8, 16-bit address decoding
        Port 0x388-0x388, align 0x7, size 0x8, 16-bit address decoding
        Port 0x300-0x300, align 0x1, size 0x2, 16-bit address decoding
        Port 0x100-0xffe, align 0x1, size 0x2, 16-bit address decoding
        IRQ 5,7,2/9,10,11 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA 0,1,3 8-bit byte-count type-A
      Alternate resources 0:2
        Priority functional
        Port 0x220-0x280, align 0xf, size 0x10, 16-bit address decoding
        Port 0x530-0xf48, align 0x7, size 0x8, 16-bit address decoding
        Port 0x388-0x3f8, align 0x7, size 0x8, 16-bit address decoding
        Port 0x300-0x334, align 0x1, size 0x2, 16-bit address decoding
        Port 0x100-0xffe, align 0x1, size 0x2, 16-bit address decoding
        IRQ 3,5,7,2/9,10,11 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA 0,1,3 8-bit byte-count type-A
  Logical device 1 'YMH0022:Unknown'
    Compatible device PNPb02f
    Device is not active
    Active DMA 0,0
    Resources 0
      Priority preferred
      Port 0x201-0x201, align 0x0, size 0x1, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x202-0x202, align 0x0, size 0x1, 16-bit address decoding
      Alternate resources 0:2
        Priority acceptable
        Port 0x203-0x203, align 0x0, size 0x1, 16-bit address decoding
      Alternate resources 0:3
        Priority acceptable
        Port 0x204-0x20f, align 0x0, size 0x1, 16-bit address decoding

======================================================================

----------------------------------------------------------------------
 tiwai - 04-23-2004 17:33 CEST 
----------------------------------------------------------------------
does adding YMH0801 to snd_opl3sa2_pnpids fix your problem?

if yes, i'll change it on CVS, too.

----------------------------------------------------------------------
 nickysn - 04-23-2004 23:55 CEST 
----------------------------------------------------------------------
Yes, that should fix it, although what I actually tried was changing the
YMH0800 id to YMH0801 in the _binary_ module, because I'm using a binary
.rpm and I was too lazy to recompile from source :P

----------------------------------------------------------------------
 perex - 04-24-2004 14:08 CEST 
----------------------------------------------------------------------
Added new PnP ID to CVS. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-21-04 02:15 nickysn        New Bug                                      
04-23-04 17:33 tiwai          Bugnote Added: 0000908                       
04-23-04 23:55 nickysn        Bugnote Added: 0000920                       
04-24-04 14:08 perex          Bugnote Added: 0000923                       
04-24-04 14:08 perex          Assigned To               => perex           
04-24-04 14:08 perex          Resolution               open => fixed       
04-24-04 14:08 perex          Status                   new => resolved     
07-16-04 13:02 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
