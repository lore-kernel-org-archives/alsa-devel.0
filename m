From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Re: Anyone have Gadget Labs Wave/4? (patch)
Date: Thu, 22 Aug 2002 11:23:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020822162352.GA27580@mlug.missouri.edu>
References: <20020820175155.GA18510@mlug.missouri.edu> <s5hd6sbt4pm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlug.missouri.edu (root@mlug.missouri.edu [128.206.61.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA19922
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 18:23:56 +0200
Content-Disposition: inline
In-Reply-To: <s5hd6sbt4pm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 22, 2002 at 03:15:17PM +0200, Takashi Iwai wrote:
> Hi,
> 
> At Tue, 20 Aug 2002 12:51:55 -0500,
> Mark Rages wrote:
> > 
> > I would like someone with a Gadget Labs Wave/4 to try out my driver and
> > report any problems (and fixes!)
> 
> it's not any bug/working reports (sorry!), but i'd like to ask a bit.
> the code includes the firmware and declares that
> 
> **
> **                 GADGET LABS LLC PROPRIETARY INFORMATION
> **
> ** This software is supplied under the terms of a license agreement or
> ** nondisclosure agreement with Gadget Labs LLC and may not be copied or
> ** disclosed except in accordance with the terms of that agreement.
> **
> **         Copyright (C) 1997 Gadget Labs LLC.  All Rights Reserved.
> **
> 
> 
> i feel it's somehow odd to be included in the standard kernel.
> supplied under NDA..?

Well, Gadget Labs is out of business. I talked to one of the former owners
to get permission to redistribute. He told me "Gadget Labs is no more" and
basically no one would be enforcing copyright.  I'm no lawyer, but that
seems kinda murky, legally.  Would it be better to rip the firmware code
from the Windows driver binary (which I've already did to check I had the
right version)?  They released the Windows drivers into public domain when
the company dissolved.

> > MIDI is not supported... There's just a 16550 on the board. Has the code 
> > for this been written already?
> 
> there is a generic serial-u16550 driver.
> perhaps you can load the driver additionally (with proper
> parameters).  is it a pnp device?
> 

It's ISA-PNP. I already have the I/O location of the UART (It's used to 
program the firmware) and a place in the ISR that tells me the UART is 
interrupted. 

> 
> > In particular there are a couple things I've been trying to pin down:
> > 
> > 1 - The driver only works every second time it's loaded. Some bizarre 
> > alignment problem? A bug in isapnp code? I don't have the knowledge to say 
> > for sure.
>  
> do you mean, the driver is not loaded, or not work even though it's
> loaded?
> 

It works, but the interrupts come back slowly. The pointer isn't updated.  
No sound comes out. rmmod and insmod again and it works. It always works
on the first load from a clean boot.  I haven't worried about it much... I
was hoping someone else would have one of these and could help me
troubleshoot.

> 
> Takashi
> 

Thanks for your help.

Regards,
Mark


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
