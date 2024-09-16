Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29832C3ABB2
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2024 10:00:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31F34E0D;
	Mon, 16 Sep 2024 12:00:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31F34E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726480848;
	bh=UkkJhVmPZRFzZAuAcyiy2i8RwGIpDoJ5oqfQ2KdcAd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pHpJLL3fmfN88wf0d53VuhFuX1nYjeexEcIc9og7Ud+AsXvBzMOSDZjP1N8WLN5x7
	 OCbq87SNOg4AqSbqM3TrDJsoS4H3LI6D2ocdjQYDYvk/q7z/QoXb6auRS67IS6voCc
	 6Fc7eUmVoDPXoW9gPjLFkVd7ehYN2HZhUNJLcOww=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9D5AF805C8; Mon, 16 Sep 2024 12:00:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 35993F805DA;
	Mon, 16 Sep 2024 12:00:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9DE99F80236; Mon, 16 Sep 2024 12:00:12 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 515FBF801C0
	for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2024 12:00:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 515FBF801C0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=O4ETYETg
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF3B51BF208;
	Mon, 16 Sep 2024 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726480809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVcKgmtsHiY6zmy9L9WXJLjM0R6FE0qNoX99Did6GQM=;
	b=O4ETYETgxUUfpMvCpGK0TLhjTTodnCl3fjQh1P7pEW+3zQqfh8d6XdMLf9WLIoOYAS68RE
	vMc2GkAH78QTrgbizmeJyIw0nRLXkrhK2MMgfndA4tVpHq0lp4HEBiI4A/0JNbCknYfZDv
	2+9y994TBls8TJDXetU4jwuToRmSGKJ2rtMTnOd5sTvjDt93KM/JGppcR48QPpoGOGAsE7
	1dz3eHHhjdMhjGGQr+jYjzrQ6PqnzODM6CrU1LDkQcPRdGii1SzENOFIm5VY0hjAiKP11m
	CysVURAD7KhecdypD9YKtsvljbA33yR++yVQ4Gz/VEpKefuePHWjQoA6bWkMiA==
Date: Mon, 16 Sep 2024 12:00:06 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH 1/2] ASoC: atmel: atmel_ssc_dai: Add stream names
Message-ID: <20240916100006f2db7b06@mail.local>
References: <20240916085214.11083-1-andrei.simion@microchip.com>
 <20240916085214.11083-2-andrei.simion@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916085214.11083-2-andrei.simion@microchip.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
Message-ID-Hash: UEE2XJM7RVANKTL2XQUL4ITU4ZNN4YEJ
X-Message-ID-Hash: UEE2XJM7RVANKTL2XQUL4ITU4ZNN4YEJ
X-MailFrom: alexandre.belloni@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UEE2XJM7RVANKTL2XQUL4ITU4ZNN4YEJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 16/09/2024 11:52:14+0300, Andrei Simion wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> Add required stream names for DPCM and future use-cases.
> 
> [andrei.simion@microchip.com: Adjust commit title. Reword commit message.]
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 3763454436c1..7047f17fe7a8 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -836,6 +836,7 @@ static const struct snd_soc_dai_ops atmel_ssc_dai_ops = {
>  
>  static struct snd_soc_dai_driver atmel_ssc_dai = {
>  		.playback = {
> +			.stream_name = "Playback",
>  			.channels_min = 1,
>  			.channels_max = 2,
>  			.rates = SNDRV_PCM_RATE_CONTINUOUS,
> @@ -843,6 +844,7 @@ static struct snd_soc_dai_driver atmel_ssc_dai = {
>  			.rate_max = 384000,
>  			.formats = ATMEL_SSC_FORMATS,},
>  		.capture = {
> +			.stream_name = "Capture",
>  			.channels_min = 1,
>  			.channels_max = 2,
>  			.rates = SNDRV_PCM_RATE_CONTINUOUS,
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
