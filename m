From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 23:34:15 +0100
Message-ID: <D99680EC-76E2-4D4D-AC7E-DFFFCBE4E666@opensource.wolfsonmicro.com>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
	<69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
	<20100805145430.GB26801@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
	<20100805160310.GA17454@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914F@az33exm25.fsl.freescale.net>
	<20100805181832.GA32359@rakim.wolfsonmicro.main>
	<AANLkTi=oYiW5_6mEwjgzwJxUHJV5fG3pwKntkTr0Cn3m@mail.gmail.com>
	<AANLkTinBK79FTsJCkL5aAJmN1fRoN327WOHY4cUKwPU-@mail.gmail.com>
	<AANLkTim3Tbyajxxc3c-aeso0x=UjimLDdrL33vX=TBak@mail.gmail.com>
	<14BB2727-715C-4AF7-9750-75F011BE71FD@opensource.wolfsonmicro.com>
	<AANLkTinia_D1XeWwZ-m+ayQv3JHaH3h9GVpZULU7r9U7@mail.gmail.com>
	(sfid-20100805_230432_950100_F99C4A39)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A91BD103918
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 00:34:21 +0200 (CEST)
In-Reply-To: <AANLkTinia_D1XeWwZ-m+ayQv3JHaH3h9GVpZULU7r9U7@mail.gmail.com>
	(sfid-20100805_230432_950100_F99C4A39)
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

On 5 Aug 2010, at 23:04, Grant Likely wrote:
> On Thu, Aug 5, 2010 at 3:42 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On 5 Aug 2010, at 22:19, Grant Likely wrote:
>> 
>>> You are; but the lack of dts factorization must be solved first before
>>> looking at whether or not .dtb overlays make sense.  Otherwise we
>>> don't have a source for the factorized data.  I personally don't think
>>> .dtb overlays are needed, but I'm not closed to the idea either.
>> 
>> I think all the issues from the recent discussion about bootloaders also make it strongly desirable to get the SoC generic stuff out of the DTS that's shipped separately to the kernel...
> 
> The board specific data has the same issues as the soc specific data
> in this regard, so I don't think it helps much to split it up at the
> .dtb level.  However....

This is purely on the basis that the error rate and the volume of data are correlated.

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

On the other hand if you do have to link the device tree into the wrapper image you run into fun and games with any per system data like MAC addresses which might be embedded in the device tree.

Also, it's not just good and bad firmware that's the issue - like I say, there are also coordination issues within large development teams to consider.
