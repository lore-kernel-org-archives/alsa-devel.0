Return-Path: <SRS0=1MT+=LV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BE4C49EAB
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Jun 2021 22:30:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE639619B6
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Jun 2021 22:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE639619B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65640167D;
	Mon, 28 Jun 2021 00:30:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65640167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624833051;
	bh=1KP6kNEmRr4H9Htj4DexcZjDFgcy1qXBPrSzmV05bzM=;
	h=Subject:References:To:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ec9kCkum8xWcxS03g2ZK3Bqk3Yae7xgqmasizdQrgICyd2xKCzF/055JBB9ZwSFWu
	 EAA1TE/L9Ipfc5Id1JSfAdxt0G39DJnZKJWfQ1+2by43Y4jJ4YTCupvgDxvNE/JlJk
	 nt7e1Rfo5r1sbZuqfCJgnO8ZQsgoWlanCSvfGK3s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABF64F80240;
	Mon, 28 Jun 2021 00:30:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A3CAF80259; Mon, 28 Jun 2021 00:29:27 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DB56F80117
 for <alsa-devel@alsa-project.org>; Mon, 28 Jun 2021 00:29:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DB56F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="USQpt8Br"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:To:References:Cc:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=d8svfUq3qYcrgyvvdRpE5dqBzOTIVqAR61eh/boxRkE=; b=USQpt8BrA9sN3c9kafC46ma2Fn
 BQdLtJSd4ZpOAeVBnjuNqL0Gp7drL8prMsaQ+ambM/+o1K5FApfPTBRdbno6bagj4BjP/8qDWR62O
 4oWyXWBuO6ey3K5IZN37yc7xnKrc466mFIyfcWp9kSMdqz+elf709NgQTwOZ/X1DZyC6tnAh0qpNX
 upZ80vWeQ9Sg01o7mnjcOCVCUDR2TcwDz+qv9M3KrB1GipRznx3ySDu85oyP8okxOMXrEzDjv4Bmj
 zBj3J47VDcv8WddrB9MAp5sGwQ5EQ+FJATdIRkupAeja9hW4cjSGOwXmTCMmZpKFU6dRtM39MgsLK
 zzx6mnVQ==;
Received: from [2601:1c0:6280:3f0::aefb]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxdGu-006Efa-Fb; Sun, 27 Jun 2021 22:29:00 +0000
Subject: Re: [PATCH] ASoC: atmel: ATMEL drivers depend on HAS_DMA
References: <20210530204851.3372-1-rdunlap@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9ba0da3b-dbdb-c91d-2def-f3dcd30cbde3@infradead.org>
Date: Sun, 27 Jun 2021 15:28:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210530204851.3372-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Bo Shen <voice.shen@atmel.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

[adding LKML]

ping?

thanks.

On 5/30/21 1:48 PM, Randy Dunlap wrote:
> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> is not set, several ATMEL ASoC drivers select symbols that cause
> kconfig warnings. There is one "depends on HAS_DMA" here but several
> more are needed to prevent kconfig warnings since 'select' does not
> recognize any dependencies.
> 
> Fix the following kconfig warnings:
> 
> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_PDC
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
>   Selected by [m]:
>   - SND_ATMEL_SOC_SSC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m]
>   - SND_ATMEL_SOC_SSC_PDC [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> 
> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_PDC
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
>   Selected by [m]:
>   - SND_AT91_SOC_SAM9G20_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> 
> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && HAS_DMA [=n]
>   Selected by [m]:
>   - SND_ATMEL_SOC_SSC_DMA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m]
> 
> WARNING: unmet direct dependencies detected for SND_ATMEL_SOC_SSC_DMA
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && ATMEL_SSC [=m] && HAS_DMA [=n]
>   Selected by [m]:
>   - SND_ATMEL_SOC_WM8904 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && I2C [=m]
>   - SND_AT91_SOC_SAM9X5_WM8731 [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_ATMEL_SOC [=m] && (ARCH_AT91 || COMPILE_TEST [=y]) && ATMEL_SSC [=m] && SND_SOC_I2C_AND_SPI [=m]
> 
> Fixes: 3951e4aae2ce ("ASoC: atmel-pcm: dma support based on pcm dmaengine")
> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> Fixes: 061981ff8cc8 ("ASoC: atmel: properly select dma driver state")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Cc: alsa-devel@alsa-project.org
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Bo Shen <voice.shen@atmel.com>
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  sound/soc/atmel/Kconfig |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-next-20210528.orig/sound/soc/atmel/Kconfig
> +++ linux-next-20210528/sound/soc/atmel/Kconfig
> @@ -19,12 +19,14 @@ config SND_ATMEL_SOC_DMA
>  
>  config SND_ATMEL_SOC_SSC
>  	tristate
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_DMA
>  	select SND_ATMEL_SOC_PDC
>  
>  config SND_ATMEL_SOC_SSC_PDC
>  	tristate "SoC PCM DAI support for AT91 SSC controller using PDC"
>  	depends on ATMEL_SSC
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_PDC
>  	select SND_ATMEL_SOC_SSC
>  	help
> @@ -34,6 +36,7 @@ config SND_ATMEL_SOC_SSC_PDC
>  config SND_ATMEL_SOC_SSC_DMA
>  	tristate "SoC PCM DAI support for AT91 SSC controller using DMA"
>  	depends on ATMEL_SSC
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_DMA
>  	select SND_ATMEL_SOC_SSC
>  	help
> @@ -44,6 +47,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
>  	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_SSC_PDC
>  	select SND_SOC_WM8731
>  	help
> @@ -54,6 +58,7 @@ config SND_ATMEL_SOC_WM8904
>  	tristate "Atmel ASoC driver for boards using WM8904 codec"
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on ATMEL_SSC && I2C
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_SSC_DMA
>  	select SND_SOC_WM8904
>  	help
> @@ -64,6 +69,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
>  	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	depends on ATMEL_SSC && SND_SOC_I2C_AND_SPI
> +	depends on HAS_DMA
>  	select SND_ATMEL_SOC_SSC_DMA
>  	select SND_SOC_WM8731
>  	help
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
https://people.kernel.org/tglx/notes-about-netiquette
