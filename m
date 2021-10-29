Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E510C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 19:11:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE85611F0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 19:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CE85611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC66D1706;
	Fri, 29 Oct 2021 21:10:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC66D1706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635534662;
	bh=EJ+j+hXVfMnyeQBEG9aGlqjPJxhddldm2FSoPvy6b2A=;
	h=In-Reply-To:References:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HIhDZvnydVwN0+1JaPqDkKsU8Rum/8vR9qPQ3hZe/ZszsO4G2Rx+W6VEUl+b0bHDI
	 Vlg2kFa8jB3li1Dcb2F+5/8kqZQNoTYqKogSHVNwJjKsl/hqmLwe7bzLc2flJUxWW7
	 E4Xtw7azK1wVRKibQFjMhSVGF0IipUieYz5YzrGk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75E02F801EC;
	Fri, 29 Oct 2021 21:10:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF631F8025A; Fri, 29 Oct 2021 21:10:07 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C545F800F4
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 21:10:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C545F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="UFJEf++O"
Received: by mail-ot1-x336.google.com with SMTP id
 x27-20020a9d459b000000b0055303520cc4so14887861ote.13
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:user-agent:date:message-id
 :subject:to; bh=Kz/yTkFuE3j75lMFedbJ8K12mUe3O4G4qhqkBQktKHc=;
 b=UFJEf++Ob04pUNadKX3RxaS932qSamdLIXwAuxhbNpn3BB2KnBBLjpwjcNL0qImZbh
 DAa0IZiW6HAXTdHmNEnbdeXroN1d1n8Uv5T4cwKaUy5ICGxhrwETNK4uA72csTFinpF6
 vU4rQBEv9WpybF3axkmMVjFp87kM1PxrAR7WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from
 :user-agent:date:message-id:subject:to;
 bh=Kz/yTkFuE3j75lMFedbJ8K12mUe3O4G4qhqkBQktKHc=;
 b=Ja5wLWgY+XjQwZFdw60Ff7+ngFZsaMzSz1gUQ4eCwrd39W3jYerrRQyWb2147D/+Jc
 eQZ9iSkmQ5Gn7zmvOSNZ9IXpy2QLK8+8KFKpmeMPRxyl1eV4/u47u6wz94BxJ/MnUzay
 lsXRjYHOhJtE8O3OzwWW0NkTUgsPcYH7LMZXA+FyTGlWwwU74E1MtTrC2sPM9+upDUZe
 mhM22GPF1a6nUHigPPeaFeeAVXyifuOXBuu4xn8LYsA744IBJhJSPd09FoFLlFXdtNBH
 IeD3Wrx2mIP5m3DgjkFByx1EJHQY0y/FFPUnvAiPlKZ+dpadZzAoK/6K1s+AsOACQT7c
 EKbA==
X-Gm-Message-State: AOAM533Bb+lpbldSFRSQNyBSz2G/sUevZQm6hGCEOutr+uK4ckQb1keL
 38KhPOsbkvGlEt3s1/OpXgZSPC8ENrG3UgSJPl4b+Q==
X-Google-Smtp-Source: ABdhPJwYWvHGaVfjF0bPaSopI+BHlYZPo+Y+4QZQuyIdj56QD9257KA3KDSh1QGEn0MlGq/ly7Nl6RbgJNxSlMAS3Z4=
X-Received: by 2002:a9d:7655:: with SMTP id o21mr9926661otl.126.1635534600504; 
 Fri, 29 Oct 2021 12:10:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Oct 2021 14:10:00 -0500
MIME-Version: 1.0
In-Reply-To: <1635519876-7112-3-git-send-email-srivasam@codeaurora.org>
References: <1635519876-7112-1-git-send-email-srivasam@codeaurora.org>
 <1635519876-7112-3-git-send-email-srivasam@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date: Fri, 29 Oct 2021 14:10:00 -0500
Message-ID: <CAE-0n51zXLZiaB9aCdv=p_Wcxr5ZEdN-=b1hd5VATL6-CD0vRw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ASoC: qcom: SC7280: Add machine driver
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 alsa-devel@alsa-project.org, 
 bgoswami@codeaurora.org, bjorn.andersson@linaro.org, broonie@kernel.org, 
 devicetree@vger.kernel.org, judyhsiao@chromium.org, lgirdwood@gmail.com, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, perex@perex.cz, 
 plai@codeaurora.org, robh+dt@kernel.org, rohitkr@codeaurora.org, 
 srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
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

Quoting Srinivasa Rao Mandadapu (2021-10-29 08:04:36)
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index cc7c1de..d9ffcb7 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -152,4 +152,16 @@ config SND_SOC_SC7180
>           SC7180 SoC-based systems.
>           Say Y if you want to use audio device on this SoCs.
>
> +config SND_SOC_SC7280
> +       tristate "SoC Machine driver for SC7280 boards"
> +       depends on I2C && SOUNDWIRE

Add || COMPILE_TEST so we can compile test this driver?

> +       select SND_SOC_QCOM_COMMON
> +       select SND_SOC_MAX98357A
> +       select SND_SOC_LPASS_RX_MACRO
> +       select SND_SOC_LPASS_TX_MACRO
> +       help
> +         To add support for audio on Qualcomm Technologies Inc.

Drop "To"?

> +         SC7280 SoC-based systems.
> +         Say Y if you want to use audio device on this SoCs.
> +
>  endif #SND_SOC_QCOM
> diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
> new file mode 100644
> index 0000000..1d73b4f
> --- /dev/null
> +++ b/sound/soc/qcom/sc7280.c
> @@ -0,0 +1,343 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> +//
> +// sc7280.c -- ALSA SoC Machine driver for sc7280

Please remove filename from the comment as it's not useful and may
change.

> +
> +#include <linux/gpio.h>
[...]
> +
> +static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +
> +       switch (cpu_dai->id) {
> +       case LPASS_CDC_DMA_RX0:
> +       case LPASS_CDC_DMA_TX3:
> +       case LPASS_CDC_DMA_VA_TX0:
> +               break;
> +       case MI2S_SECONDARY:
> +               break;
> +       case LPASS_DP_RX:
> +               break;
> +       default:
> +               dev_err(rtd->dev, "%s: invalid dai id %d\n", __func__, cpu_dai->id);
> +               break;
> +       }

The function doesn't do anything though. Why do we care?

> +}
> +
> +static const struct snd_soc_ops sc7280_ops = {
> +       .startup = sc7280_snd_startup,
> +       .shutdown = sc7280_snd_shutdown,
> +       .hw_params = sc7280_snd_hw_params,
> +       .hw_free = sc7280_snd_hw_free,
> +       .prepare = sc7280_snd_prepare,
> +};
> +
> +static const struct snd_soc_dapm_widget sc7280_snd_widgets[] = {
> +       SND_SOC_DAPM_HP("Headphone Jack", NULL),
> +       SND_SOC_DAPM_MIC("Headset Mic", NULL),
> +};
> +
> +static int sc7280_snd_platform_probe(struct platform_device *pdev)
> +{
> +       struct snd_soc_card *card;
> +       struct sc7280_snd_data *data;
> +       struct device *dev = &pdev->dev;
> +       struct snd_soc_dai_link *link;
> +       int ret, i;
> +
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       card = &data->card;
> +       snd_soc_card_set_drvdata(card, data);
> +
> +       card->owner = THIS_MODULE;
> +       card->driver_name = "SC7280";
> +       card->dev = dev;
> +
> +       ret = qcom_snd_parse_of(card);
> +       if (ret)
> +               return ret;
> +
> +       for_each_card_prelinks(card, i, link) {
> +               link->init = sc7280_init;
> +               link->ops = &sc7280_ops;
> +       }
> +
> +       return devm_snd_soc_register_card(dev, card);
> +}
> +
> +static const struct of_device_id sc7280_snd_device_id[]  = {
> +       {.compatible = "google,sc7280-herobrine"},

Please add space after { and before }

> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sc7280_snd_device_id);
