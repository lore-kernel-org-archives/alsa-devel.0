From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 22:42:07 +0100
Message-ID: <14BB2727-715C-4AF7-9750-75F011BE71FD@opensource.wolfsonmicro.com>
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
	(sfid-20100805_221936_651051_0BC48DA7)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F123B10390E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 23:42:12 +0200 (CEST)
In-Reply-To: <AANLkTim3Tbyajxxc3c-aeso0x=UjimLDdrL33vX=TBak@mail.gmail.com>
	(sfid-20100805_221936_651051_0BC48DA7)
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

On 5 Aug 2010, at 22:19, Grant Likely wrote:

> You are; but the lack of dts factorization must be solved first before
> looking at whether or not .dtb overlays make sense.  Otherwise we
> don't have a source for the factorized data.  I personally don't think
> .dtb overlays are needed, but I'm not closed to the idea either.

I think all the issues from the recent discussion about bootloaders also make it strongly desirable to get the SoC generic stuff out of the DTS that's shipped separately to the kernel. You've got issues on reference boards where the SoC vendor may have shipped a low quality device tree in flash and users are scared to try to reflash the board due to a lack of recovery facilities (so the less we rely on being able to update data flashed into the device the better) and you've got issues on end user projects with large, potentially distributed, teams where coordinating updates between everyone can be tricky especially if those updates need to be done in lockstep (so the less data is shipped outside the kernel the better).

Remember rmk's constant complaint about bootloaders on ARM - these are programs that need to get two registers right on kernel start and don't reliably do so. 
