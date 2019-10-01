Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A49C352AA
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:57:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD9420842
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iPK5peg5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="JsQ1F1kX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD9420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26A241668;
	Tue,  1 Oct 2019 16:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26A241668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569941876;
	bh=+ohpBSax/H/hlDLnCY1qvb4eizk49Hp1CTxRidZNKxg=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iPK5peg554hyAeMJT3ZSx5Hk6vcapBe+6UmnhsQETBDjmGyi2oV1j0SJNja4NIgZP
	 VxDQL02khOLPO7NZzlLBQXC3m7YpqpJta/Vnwp6UlMcqptEiFaA4PhjFvDNgOotvRW
	 MBbgYIUr295bFTrgO6fx2MPnseTgPgcmVyrdv6S4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC2CCF804FF;
	Tue,  1 Oct 2019 16:57:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DFF61F80506; Tue,  1 Oct 2019 16:57:03 +0200 (CEST)
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 439A5F800DE
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 16:57:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 439A5F800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl
 header.b="JsQ1F1kX"
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 46jMkZ2SSrz4G;
 Tue,  1 Oct 2019 16:55:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1569941704; bh=/oFjgNLU/ZvSelC6tLjw91cHQa877YduGYa+snzVYRU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JsQ1F1kX3wGRrlY1a9hWTLA2LaalbBEahiTlqlZOGsDZXb+SyXUwzKD4rbke0EmXG
 x7N82fQJUZm074OdjoaLeJbSdMG/B3bF3Y+uWGhTlrenGAtWt3MMrBkxoPn3XT0f1v
 ZYxlbloRZzLwqC97uSfDNoEDk0Yhu006mYNLkwnJtid/YXtL8s7NeBwDWKf2yIH9tk
 brd/t5cuqt8mnC01f850RppQzimpW7PEbWF1Z5ZrE8uY+2lVF17M9PdYc7BIglHjxm
 ZiM2Lzi3u2RaucgE3dU7OMpp60GXXQsanht7Z/0Ho1o/zDnV8d5fPbjPMTazBU7wW0
 JuWnKzqAZOu9g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date: Tue, 1 Oct 2019 16:56:56 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191001145656.GB6905@qmqm.qmqm.pl>
References: <20191001142116.1172290-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191001142116.1172290-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Takashi Iwai <tiwai@suse.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Mark Brown <broonie@kernel.org>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel: fix atmel_ssc_set_audio link
	failure
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Oct 01, 2019 at 04:20:55PM +0200, Arnd Bergmann wrote:
> The ssc audio driver can call into both pdc and dma backends.  With the
> latest rework, the logic to do this in a safe way avoiding link errors
> was removed, bringing back link errors that were fixed long ago in commit
> 061981ff8cc8 ("ASoC: atmel: properly select dma driver state") such as
> =

> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> atmel_ssc_dai.c:(.text+0xac): undefined reference to `atmel_pcm_pdc_platf=
orm_register'
> =

> Fix it this time using Makefile hacks and a comment to prevent this
> from accidentally getting removed again rather than Kconfig hacks.
> =

> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in =
Kconfig")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/atmel/Kconfig  |  4 ++--
>  sound/soc/atmel/Makefile | 10 ++++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> =

> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index f118c229ed82..25c31bf64936 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -10,11 +10,11 @@ config SND_ATMEL_SOC
>  if SND_ATMEL_SOC
>  =

>  config SND_ATMEL_SOC_PDC
> -	tristate
> +	bool
>  	depends on HAS_DMA
>  =

>  config SND_ATMEL_SOC_DMA
> -	tristate
> +	bool
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  =

>  config SND_ATMEL_SOC_SSC
> diff --git a/sound/soc/atmel/Makefile b/sound/soc/atmel/Makefile
> index 1f6890ed3738..c7d2989791be 100644
> --- a/sound/soc/atmel/Makefile
> +++ b/sound/soc/atmel/Makefile
> @@ -6,8 +6,14 @@ snd-soc-atmel_ssc_dai-objs :=3D atmel_ssc_dai.o
>  snd-soc-atmel-i2s-objs :=3D atmel-i2s.o
>  snd-soc-mchp-i2s-mcc-objs :=3D mchp-i2s-mcc.o
>  =

> -obj-$(CONFIG_SND_ATMEL_SOC_PDC) +=3D snd-soc-atmel-pcm-pdc.o
> -obj-$(CONFIG_SND_ATMEL_SOC_DMA) +=3D snd-soc-atmel-pcm-dma.o
> +# pdc and dma need to both be built-in if any user of
> +# ssc is built-in.
> +ifdef CONFIG_SND_ATMEL_SOC_PDC
> +obj-$(CONFIG_SND_ATMEL_SOC_SSC) +=3D snd-soc-atmel-pcm-pdc.o
> +endif
> +ifdef CONFIG_SND_ATMEL_SOC_DMA
> +obj-$(CONFIG_SND_ATMEL_SOC_SSC) +=3D snd-soc-atmel-pcm-dma.o
> +endif
>  obj-$(CONFIG_SND_ATMEL_SOC_SSC) +=3D snd-soc-atmel_ssc_dai.o
>  obj-$(CONFIG_SND_ATMEL_SOC_I2S) +=3D snd-soc-atmel-i2s.o
>  obj-$(CONFIG_SND_MCHP_SOC_I2S_MCC) +=3D snd-soc-mchp-i2s-mcc.o

I was just exploring similar solution, using $(if X,Y) instead, but your
fix will work just as well.

Reviewed-by: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>

Best Regards,
Micha=B3=A0Miros=B3aw
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
