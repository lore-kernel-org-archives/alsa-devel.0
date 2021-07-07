Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA0C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 22:00:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B31BE61CB9
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 22:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31BE61CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA8B582C;
	Wed,  7 Jul 2021 23:59:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA8B582C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625695219;
	bh=BxJtDts8qr4LZXJrib2Y7ToA1oz9Ty0xHmqs1zSqNOM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FPLZmcqzQtxoMRCkUI1hQtFPScYiq/SV0tNeuCEIsa/l3eMUgTdGd67zURXo00yK2
	 P2rZpxDxVB1xkUwvRtGYH1wFloe7udD0nBgAc54yMcTWFJtBc4p2MecivSB4RSxpb4
	 wyM7CzW6pLgkA9f8idwrAmNjqa2i3FfaqbjouBvI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B28BF8016C;
	Wed,  7 Jul 2021 23:59:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9C0EF80224; Wed,  7 Jul 2021 23:59:27 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D612F8014E
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 23:59:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D612F8014E
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BA1CFFF809;
 Wed,  7 Jul 2021 21:59:16 +0000 (UTC)
Date: Wed, 7 Jul 2021 23:59:16 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] ASoC: atmel: ATMEL drivers don't need HAS_DMA
Message-ID: <YOYjtE5R2ApV4N9F@piout.net>
References: <20210707214752.3831-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210707214752.3831-1-rdunlap@infradead.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 Mark Brown <broonie@kernel.org>,
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

On 07/07/2021 14:47:52-0700, Randy Dunlap wrote:
> On a config (such as arch/sh/) which does not set HAS_DMA when MMU
> is not set, several ATMEL ASoC drivers select symbols that cause
> kconfig warnings. There is one "depends on HAS_DMA" which is no longer
> needed. Dropping it eliminates the kconfig warnings and still builds
> with no problems reported.
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
> Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: rebase & resend;
>     drop Cc: to Bo Shen <voice.shen@atmel.com> # bounced
> v3: drop "depends on HAS_DMA" (as suggested by Codrin; Thanks)
> 
> ---
>  sound/soc/atmel/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- linux-next-20210707.orig/sound/soc/atmel/Kconfig
> +++ linux-next-20210707/sound/soc/atmel/Kconfig
> @@ -11,7 +11,6 @@ if SND_ATMEL_SOC
>  
>  config SND_ATMEL_SOC_PDC
>  	bool
> -	depends on HAS_DMA
>  
>  config SND_ATMEL_SOC_DMA
>  	bool

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
