Return-Path: <SRS0=21/e=FE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9021C63777
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 21:58:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873E22085B
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Nov 2020 21:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sVKw7P4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873E22085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70E1F172F;
	Mon, 30 Nov 2020 22:57:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70E1F172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606773502;
	bh=s1+gRngT2Qnhudj2pwKnK2vU96kTX5EFFAzdQBKob+w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVKw7P4ZwaI4D9pNbwLwsxeQNT0ZEFo/3jsuPEXPGBSndfYWUVF5xO2NBFyz1Xmip
	 tvOqnPmcV5ntlnoS6oTfgdUQ1w4XPjntCXV/lmEDU4NiqdS0bXqk6JxKaynE3mqMu4
	 cisVM9dC4+zTKzd8ZAJ+yoNYoCcDZF+v15sNOhgk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FE22F804A9;
	Mon, 30 Nov 2020 22:57:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A28FF804AA; Mon, 30 Nov 2020 22:57:18 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4084CF8049C
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2020 22:57:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4084CF8049C
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr
 [86.194.74.19]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B5ACD40002;
 Mon, 30 Nov 2020 21:57:10 +0000 (UTC)
Date: Mon, 30 Nov 2020 22:57:10 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau1372: add missing dependencies
Message-ID: <20201130215710.GV1296649@piout.net>
References: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
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

On 30/11/2020 22:56:26+0100, Alexandre Belloni wrote:
> SND_SOC_ADAU1372_I2C and SND_SOC_ADAU1372_SPI prpoerly select the REGMAP
> config they need but forget to depend on the underlying bus.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I forgot:

Reported-by: kernel test robot <lkp@intel.com>

> ---
>  sound/soc/codecs/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index a457300f95da..625f762903ea 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -371,11 +371,13 @@ config SND_SOC_ADAU1372
>  
>  config SND_SOC_ADAU1372_I2C
>  	tristate "Analog Devices ADAU1372 CODEC (I2C)"
> +	depends on I2C
>  	select SND_SOC_ADAU1372
>  	select REGMAP_I2C
>  
>  config SND_SOC_ADAU1372_SPI
>  	tristate "Analog Devices ADAU1372 CODEC (SPI)"
> +	depends on SPI
>  	select SND_SOC_ADAU1372
>  	select REGMAP_SPI
>  
> -- 
> 2.28.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
