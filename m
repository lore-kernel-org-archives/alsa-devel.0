From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000411]: IEC958 status non-audio (and others) bits are not updated on iec958 stream
Date: Thu, 19 Aug 2004 19:01:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040819170110.09D751102E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6CCE2214
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2004 19:01:10 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000411
======================================================================
Reported By:                domi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     411
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-28-2004 21:04 CEST
Last Modified:              08-19-2004 19:01 CEST
======================================================================
Summary:                    IEC958 status non-audio (and others) bits are not updated on iec958 stream
Description: 
To investigate a problem where AC3 is not working
with my Yamaha amplifer and my Asus a7n8x deluxe board,
I've set up a loopback between the rear spdif output (RCA)
and the on-board spdif input.

Reading the 'SPDIF In Status' status line in  the card0/codec97#0/ac97#0-0
file, I've noticed that the status, non-audio or any other information
sent through the spdif stream are not sent on the wire.

This behavior would explain the problems found in bug 00369 (SPDIF always
on) and 00214 (AC3 not working)

Note that the 'SPDIF Control' line and ac97#0-0+regs file are updated
correctly, only the information sent on the
stream are lost.
======================================================================

----------------------------------------------------------------------
 domi - 08-05-2004 20:18 CEST 
----------------------------------------------------------------------
I've also tried alsa-driver 1.0.6rc1 with kernel 2.6.7 to no avail.

The same tests produce the same results. It looks like the SPIF control
informations is lost between the driver and the ALC650F registers.
According to the status bit found on the captured SPDIF stream, it looks
like the ALC650 register MX3A is left to its default value (0x2000).

So I guess the ALC register values are cached in the driver. Is there a
way to disable the cache (if any) to actually check the ALC650 registers ?

----------------------------------------------------------------------
 domi - 08-07-2004 18:09 CEST 
----------------------------------------------------------------------
I've hacked snd_intel8x0_codec_write and snd_intel8x0_codec_read in
intel8x0.c to verify what's written in register 0x3a.

I've found nothing suspicious, the register 0x3a is indeed written to:

  Aug  7 17:43:01 localhost kernel: snd_intel8x0_codec_write:Writing 3a
reg with 2a26
  [snip]
  Aug  7 17:43:18 localhost kernel: snd_intel8x0_codec_read:Read 3a reg
with 2a26

So at this point, I believe that either my H/W is faulty (very subtle
corruption of the SPDIF output controller), or there is a bug in the
ALC650 (rev F) chip.
Since other people are reporting that AC3 is not working with high end
amplifier, I cannot dismiss the possibility of a bug in the ALC650F chip.

There's nothing more I can do on this topic. I need other people with the
same Hardware (Asus A7N8X deluxe with ALC650F) to loop back the spdif out
to an spdif input and to read the SDPIF control bits on input SPDIF
stream.

Thanks

----------------------------------------------------------------------
 tiwai - 08-19-2004 19:01 CEST 
----------------------------------------------------------------------
I guess the spdif output isn't connected from AC97 but driven
directly from the nvidia chip.  If so, there should be a register
to set up the SPDIF out status in Nvidia chip itself.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-28-04 21:04 domi           New Bug                                      
07-28-04 21:04 domi           Distribution              => Debian unstable 
07-28-04 21:04 domi           Kernel Version            => 2.6.7           
08-05-04 20:18 domi           Bugnote Added: 0001535                       
08-07-04 18:09 domi           Bugnote Added: 0001544                       
08-19-04 19:01 tiwai          Bugnote Added: 0001590                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
