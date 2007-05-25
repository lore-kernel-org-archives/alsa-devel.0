From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Suggestion for getting alsa to use Conexant
Date: Fri, 25 May 2007 09:37:44 -0700
Message-ID: <1180111064.9034.42.camel@razman.gruemaster.com>
References: <000301c78d28$9d7a3a70$bbe664d0@PC120716747189>
	<1180060375.9034.18.camel@razman.gruemaster.com>
	<s5hwsyxnrap.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1u/M+aQ3AQKgrPV2PaGb"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 18E60244AF
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2007 18:37:46 +0200 (CEST)
In-Reply-To: <s5hwsyxnrap.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Victor Schneider <vtailor@copper.net>
List-Id: alsa-devel@alsa-project.org


--=-1u/M+aQ3AQKgrPV2PaGb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Just out of curiosity, has anyone with these codecs tried the linuxant
software?  I looked at it briefly, and they are modifying my
patch_conexant.c driver.  Some of the changes I may include in the main
alsa driver (hey, I wrote the bulk, so why not), some of it would never
pass kernel coding style.

I am kind of peeved that they don't bother to communicate with the alsa
team, instead they take all of the hda code and hack it up, adding their
copyright info to the code header (see header patch attached).  Takashi,
what's your take on this?

Tobin

On Fri, 2007-05-25 at 12:14 +0200, Takashi Iwai wrote:

> At Thu, 24 May 2007 19:32:55 -0700,
> Tobin Davis wrote:
> > 
> > I don't think this is limited to the Conexant CX20549 (5045) or the
> > CX20551 (5047).  I have a laptop with a Conexant vendor ID of 2bfa.  The
> > hda-intel driver picks it up, but uses the hda-generic configuration.
> > 
> > On the CX20549 & CX20551, I think I need to toggle a bit to enable the
> > MFG portion.  I have a test board here, but the drivers are not
> > detecting it, even without my patch_conexant code.  I'll look at the
> > intel-80xm module, but it is written for the AC'97 bus specification,
> > which is very different from the HDA bus specification.
> 
> The bus design isn't a so big issue, but the problem would be rather
> the difference of the codec/controller communication.  For example,
> smartlink modem codecs (si3054) and compatibles are already supported
> in patch_si3054.c.  As you can see, the code is really small.
> 
> AFAIK, the conexant modem codec requires extra communication, a kind
> of ACK, and thus incompatible with smartlink codecs.  Similarly, the
> intel8x0m driver also doesn't support conexant chips because the
> conexant codecs need different controls.
> 
> Ideally, the whole encoding stuff should go to the user-space like
> slmodemd.  I once tried to convince Conexant guys to do that, but they
> disagreed because of lack of man power.  To me, it's hard to imagine
> because keeping the kernel driver needs more effort...
> 
> 
> Takashi
> 
> > 
> > Tobin
> > 
> > On Wed, 2007-05-02 at 21:13 -0500, Victor Schneider wrote:
> > 
> > > How about being able to parameterize Alsa modules so that the intel 80xm 
> > > module finds any hda modem that also acts as an Intel hda chip? I am 
> > > referring to the Conexant combination modem and hda chip that gets 
> > > identified as "Conexant Waikiki" by alsamixer, but that 80xm can't find as a 
> > > modem. Giving the 80xm module the device:identifier value to override its 
> > > detection of the Intel version of the Conexant hda modem might let slmodemd 
> > > work.
> > > 
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> > -- 
> > Tobin Davis <tdavis@dsl-only.net>
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-1u/M+aQ3AQKgrPV2PaGb
Content-Disposition: attachment; filename=cxtheader.patch
Content-Type: text/x-patch; name=cxtheader.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- ../../../../../../../alsa/alsa-project/alsa-driver/alsa-kernel/pci/hda/patch_conexant.c	2007-05-23 09:54:08.000000000 -0700
+++ patch_conexant.c	2007-05-25 09:16:39.000000000 -0700
@@ -1,10 +1,12 @@
 /*
- * HD audio interface patch for Conexant HDA audio codec
+ * HD audio interface patch for Conexant HDA audio/modem codec
  *
  * Copyright (c) 2006 Pototskiy Akex <alex.pototskiy@gmail.com>
  * 		      Takashi Iwai <tiwai@suse.de>
  * 		      Tobin Davis  <tdavis@dsl-only.net>
  *
+ * Copyright (c) 2005-2006 Linuxant inc.
+ *
  *  This driver is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or

--=-1u/M+aQ3AQKgrPV2PaGb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-1u/M+aQ3AQKgrPV2PaGb--
