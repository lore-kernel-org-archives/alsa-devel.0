Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270ABC43334
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 12:12:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DCB6173E;
	Tue, 14 Jun 2022 14:12:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DCB6173E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655208772;
	bh=qGiAmGGeB4z4KjBXDxeBanIVqp6bFNnoVA0Q7TRvMMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LKx+X+GDErUulvfGykuAbjvjYe4+yv+tk62NFzgTwzgnIJp9uum6fxKD4uWiFcQGo
	 QpeFcL7sgy/HdaMFChrIk1djXLDYMjhhOWlok5bzYOH/ZDygV8mUQc/dzOpe0xMWHE
	 W+7iOnVFxpH6bnolKkc3t8Wqwo7mIeNvvShLVROk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FE88F80137;
	Tue, 14 Jun 2022 14:12:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98117F80139; Tue, 14 Jun 2022 14:12:00 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19A3CF800E1
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 14:11:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19A3CF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="MqvzK0QN"
Received: by mail-lf1-x135.google.com with SMTP id i29so13601502lfp.3
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u9EmHLrRjxHFBdlsSBFyEwaq+4MBfbXyYr9YLTakrQE=;
 b=MqvzK0QN0NO1GNmlZ4NR+mxM9Wbc87csEVFEfJPdQO68UW4pFezTnoaBUYLPdcgv8X
 /PT7p4DC3+iv5cdw/B5sC+6c6XPet516xDUhECZ3hLLpHie39KIJ7gItYMs39tKkofx5
 E0AHxK18blE1FqG7ABRlLDjtlpe79/S8oWwHKVpo3mq55xJb8lLTNjQEihiBmvfbcVIk
 GVGqfJWheyzVEYCTIuIial7P6Zy5R/gs6GMWSZDSVJc0B7XujPpT6yt0nE1lWXvlh3d8
 Bsrkg3eglslmDSSuHay6+byX6aUC/HQWbOR3FrlbkY6fMrpgDfiYw3qH/+n78Bz/ktlW
 jxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u9EmHLrRjxHFBdlsSBFyEwaq+4MBfbXyYr9YLTakrQE=;
 b=YAi7G8p4KqFQH5LIr2zDW5ids6TViGcA11rmPzVFWqwbDrG0eyOUon6hxo9WfbRtO8
 nHl0b85XS65GVC+asEgkd0JoLtCIVeBbpYlWxdYUVt+nL0tAKlzpdqo2Qx2GuGiU1eK3
 2LfhBZG/buNdhzEUbC+/TFlvS1M7GDiK58VQ26Z5jkplQU/2py3M3YtoyCr+tsUGxS2f
 O0hC5SE8kgQTO2bEuNgrcTkh9rJj5rJRrICZMdObOxed3IvjjO3GGMKP+9krjZNcGHw8
 iwa/bFpqMAUXjLFw10k80kQwQTn7Zuwvh2H6ftlkzE9xhxMB2X7jFZAd5xj1yGYFScDG
 PaGA==
X-Gm-Message-State: AJIora9CVJAxJRrOD0DcmH9T/j5e+bUEI/cU12CLeSZCgMR5ZXEWecmf
 NzxBVasSq3F2RyNNbKcSeF//Ocn2uLcm8K2Ecx8=
X-Google-Smtp-Source: AGRyM1vIssMSYG2ICObVKMEhJb+aZP/jcZkwISyaVWHRHEBOnY907vwKa7NfnLmsyuGgUX6PafLlRRTeRakpEwot1fw=
X-Received: by 2002:ac2:5c48:0:b0:478:fad6:a8b1 with SMTP id
 s8-20020ac25c48000000b00478fad6a8b1mr2827545lfp.273.1655208711378; Tue, 14
 Jun 2022 05:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220614101546.1559434-1-s.hauer@pengutronix.de>
In-Reply-To: <20220614101546.1559434-1-s.hauer@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 14 Jun 2022 20:11:39 +0800
Message-ID: <CAA+D8APsh36+d5NtwKczVJnBZdtcD_04eqg-1fLxQezNCK=qQw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: fully initialize structs
To: Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <kernel@pengutronix.de>, Xiubo Li <Xiubo.Lee@gmail.com>
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

On Tue, Jun 14, 2022 at 6:15 PM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The driver uses two statically ininitialized struct dma_slave_config,
> but only one of them is initialized to zero. Initialize config_be to
> zero as well to make sure that no fields are filled with random values.
> Let the compiler do this instead of explicitly calling memset() which
> makes it easier to read.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Wang Shengjiu

> ---
>  sound/soc/fsl/fsl_asrc_dma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index 5038faf035cba..fec56dbb64e60 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -138,7 +138,7 @@ static int fsl_asrc_dma_hw_params(struct
> snd_soc_component *component,
>         struct dma_chan *tmp_chan = NULL, *be_chan = NULL;
>         struct snd_soc_component *component_be = NULL;
>         struct fsl_asrc *asrc = pair->asrc;
> -       struct dma_slave_config config_fe, config_be;
> +       struct dma_slave_config config_fe = {}, config_be = {};
>         enum asrc_pair_index index = pair->index;
>         struct device *dev = component->dev;
>         struct device_node *of_dma_node;
> @@ -181,7 +181,6 @@ static int fsl_asrc_dma_hw_params(struct
> snd_soc_component *component,
>                 return -EINVAL;
>         }
>
> -       memset(&config_fe, 0, sizeof(config_fe));
>         ret = snd_dmaengine_pcm_prepare_slave_config(substream, params,
> &config_fe);
>         if (ret) {
>                 dev_err(dev, "failed to prepare DMA config for
> Front-End\n");
> --
> 2.30.2
>
>
