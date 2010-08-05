From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
 variable SSI FIFO depth
Date: Fri, 6 Aug 2010 00:22:26 +0100
Message-ID: <20100805232225.GA18627@opensource.wolfsonmicro.com>
References: <20100805145430.GB26801@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
	<20100805160310.GA17454@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914F@az33exm25.fsl.freescale.net>
	<20100805181832.GA32359@rakim.wolfsonmicro.main>
	<AANLkTi=oYiW5_6mEwjgzwJxUHJV5fG3pwKntkTr0Cn3m@mail.gmail.com>
	<AANLkTinBK79FTsJCkL5aAJmN1fRoN327WOHY4cUKwPU-@mail.gmail.com>
	<AANLkTim3Tbyajxxc3c-aeso0x=UjimLDdrL33vX=TBak@mail.gmail.com>
	<14BB2727-715C-4AF7-9750-75F011BE71FD@opensource.wolfsonmicro.com>
	<AANLkTinia_D1XeWwZ-m+ayQv3JHaH3h9GVpZULU7r9U7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4EE4A103927
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 01:22:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinia_D1XeWwZ-m+ayQv3JHaH3h9GVpZULU7r9U7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2010 at 04:04:06PM -0600, Grant Likely wrote:
> On Thu, Aug 5, 2010 at 3:42 PM, Mark Brown

> > i think all the issues from the recent discussion about bootloaders
> > also make it strongly desirable to get the soc generic stuff out of
> > the dts that's shipped separately to the kernel...

> The board specific data has the same issues as the soc specific data
> in this regard, so I don't think it helps much to split it up at the
> .dtb level.  However....

Oh, this is purely on the basis that the error count is related to the
amount of data.  The board specific stuff does at least have more chance
someone actually looked at it on this particular board too.

> Absolutely correct.  All of this discussion and lessons learned has
> distilled the fact the .dtb file must not be linked into the boot
> firmware.  Any design that requires a boot firmware upgrade to
> update/replace the .dtb is broken.  There will still be broken cases,
> but fortunately for the broken cases the .dtb can always be linked
> into the kernel image.  So, for "good" firmware, the .dtb use case
> works really well.  In the "broken" firmware case, the .dtb(s) can be
> linked into the wrapper image and the correct one can be chosen based
> on machine-id or some other discernible board data.  I'm being very
> careful to make sure that using a .dtb doesn't paint anybody into a
> corner.

On the other hand if you end up having to replace the device tree with
one in the wrapper then you've got an issue with any per-system data
like MAC addresses that someone put in the device tree unless you can do
some sort of overlay/fixup thing.

> > Remember rmk's constant complaint about bootloaders on ARM - these
> > are programs that need to get two registers right on kernel start
> > and don't reliably do so.

> Understood.  It is my priority to complete a full-featured sample
> implementation so I can prove that it is actually a useful solution.
> I'm going to start with U-Boot and make sure upstream u-boot always
> passes the correct thing for passing a .dtb

u-boot will probably be fine anyway, it's more the less widely used ones
that people cook up which are a concern here.
