Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A00C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:14:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7226320828
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZVpJ6tQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7226320828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D62A16ED;
	Tue, 10 Dec 2019 16:13:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D62A16ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575990867;
	bh=hGkkIhokgAOrI5s5UrZSrQ7CKv7EciZwwT6A2pSxDEw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZVpJ6tQWhPcTcCvUaOOdEMLQ2KPuOHEdHFKmFXrWnhdUZURYSRy70bSm9uiNzP5Sy
	 KMa8QXaEZbiBebfsRdMmF58XwBir7qQpcferFKljORsjwrhq0/HnfRpUX6eTQDhx/E
	 0ZKWsfUfEbiHefIwNtvTH9gsgHtpjWtLQ6QnCi6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3F96F8011E;
	Tue, 10 Dec 2019 16:13:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CA1BF8020C; Tue, 10 Dec 2019 16:13:35 +0100 (CET)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A66DF800F3
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 16:13:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A66DF800F3
X-Originating-IP: 90.182.112.136
Received: from localhost (136.112.broadband15.iol.cz [90.182.112.136])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E678840011;
 Tue, 10 Dec 2019 15:13:30 +0000 (UTC)
Date: Tue, 10 Dec 2019 16:13:27 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191210151327.GO1463890@piout.net>
References: <20191210145406.21419-1-tiwai@suse.de>
 <20191210145406.21419-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191210145406.21419-3-tiwai@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [alsa-devel] [PATCH for-5.6 02/23] ASoC: atmel: Drop
	superfluous ioctl PCM ops
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 10/12/2019 15:53:45+0100, Takashi Iwai wrote:
> ASoC PCM core deals the empty ioctl field now as default.
> Let's kill the redundant lines.
> 
> Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/atmel/atmel-pcm-pdc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
> index 18a2fd02fffe..59c1331a6984 100644
> --- a/sound/soc/atmel/atmel-pcm-pdc.c
> +++ b/sound/soc/atmel/atmel-pcm-pdc.c
> @@ -379,7 +379,6 @@ static int atmel_pcm_close(struct snd_soc_component *component,
>  static const struct snd_soc_component_driver atmel_soc_platform = {
>  	.open		= atmel_pcm_open,
>  	.close		= atmel_pcm_close,
> -	.ioctl		= snd_soc_pcm_lib_ioctl,
>  	.hw_params	= atmel_pcm_hw_params,
>  	.hw_free	= atmel_pcm_hw_free,
>  	.prepare	= atmel_pcm_prepare,
> -- 
> 2.16.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
