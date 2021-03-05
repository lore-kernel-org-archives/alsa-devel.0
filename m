Return-Path: <SRS0=qX2V=ID=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AEAC433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 09:20:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E5764F70
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 09:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E5764F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D2251772;
	Fri,  5 Mar 2021 10:19:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D2251772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614935999;
	bh=zIt3Qywc1Vqmgi76kaCMhv+RkmVe+Kjafcwcc9UMFFg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RGk/cz/sb3ISHrGBoMB0UJphHBu3gT9acB9c+SayPx8m36dkjmEj6uKi0tPtOqv5B
	 W/b3FISLvBJgckWVlRm06XFYRGrEH3P7/UE14M7X+jjtvAO2ndzOGJi2SW8wsUVmlU
	 HYmvB87wgVt1B5qfbeqosXX5G6DmRiipjhZt/Fn4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEA05F80257;
	Fri,  5 Mar 2021 10:19:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40626F8025E; Fri,  5 Mar 2021 10:19:07 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DAAAF80121
 for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2021 10:18:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DAAAF80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Hke56nsG"
Received: by mail-wm1-x332.google.com with SMTP id
 w203-20020a1c49d40000b029010c706d0642so5688536wma.0
 for <alsa-devel@alsa-project.org>; Fri, 05 Mar 2021 01:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9NaXk4dB/rdZ6Q95jjM7mfrL2gEwIE0c0/Z44hytAfo=;
 b=Hke56nsGOFEllx5nEFlQ7K+8nJcZqv81lMbYYK+j9c6hfvFkV0FjZaCRpSVajwmF+R
 GZI+CjXTUC11H+imXOfNZqJatZHa91SDJqqugfmJxerX+JAeHe+eouMn7LVUzLloMZCy
 Y4IstHkPHM+rYlCNbPNB0sj7vjLnL4KEYrJVSLVisFxOSi6R726B8fXb5oXCXB9I9bq2
 2+Oq6rlaGwmdFyXaKFVHQ/pn5gsCxAGrhZbZJdG/H4IV5ZAGFXeZyCIhfEqItEsMnpZK
 hTfK/LsgFCRdEU5+il/a9i52RVry3xDajxqkQz/+XlgzeizorZEGs8mJE2dA/DXJtX90
 beeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9NaXk4dB/rdZ6Q95jjM7mfrL2gEwIE0c0/Z44hytAfo=;
 b=CjHenqIg00yHjxJ9xh1mnpFjsakBC85WCVgcweg+yneTSGng9FcS1mNNrvasowfflK
 I055+ji3F2OHLiRKImppeEiZvAvZOKR79WoL9lH6o/DTeokDe70IB9ytYbnb9JN1r2RO
 O8MAfIZnSrqgzrfS6nlrR2Dv+soKWxxfOyM83R5aPLIKKeZm4FRQkhEVHctJDFp08ptg
 tQJF2ZOntKmuCJInYNnurqy41vKPB8kGGDxNflEi+msdhcmFf/IuYnL9xJBxrioNteyc
 U1uUuWxJpfnUN45Z2Tnw2V8OItvUQ0TFLg42zj3FgCxOO6gg6RosFCz5MvjSkA0KQmsZ
 gVIQ==
X-Gm-Message-State: AOAM532s6gCc+qKRHyU+EZhvcQ3mn6vk+2mxL9svMuSom5ydBwLfxc3E
 OBBBbKjqWtbYRQFmCBjZrx4iMQ==
X-Google-Smtp-Source: ABdhPJw6DQo57kVctbf9LdrGa50qhXc9YYge5k8O1RQjCtdYNLIQRZq/GIm4f3DRItMYIea2ZkfHSQ==
X-Received: by 2002:a1c:c244:: with SMTP id s65mr7629124wmf.2.1614935938869;
 Fri, 05 Mar 2021 01:18:58 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id f7sm3478937wre.78.2021.03.05.01.18.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Mar 2021 01:18:58 -0800 (PST)
Subject: Re: [PATCH] ASoC: codecs: lpass-wsa-macro: fix RX MIX input controls
To: Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
References: <20210305005049.24726-1-jonathan@marek.ca>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <901874d6-9b1f-714b-31bf-0e1e61956890@linaro.org>
Date: Fri, 5 Mar 2021 09:18:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210305005049.24726-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "moderated list:QCOM AUDIO \(ASoC\) DRIVERS" <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
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

Thanks Jonathan for testing the Mix path!

On 05/03/2021 00:50, Jonathan Marek wrote:
> Attempting to use the RX MIX path at 48kHz plays at 96kHz, because these
> controls are incorrectly toggling the first bit of the register, which
> is part of the FS_RATE field.
> 
Yes bit 0 is part of PCM RATE!

> Fix the problem by using the same method used by the "WSA RX_MIX EC0_MUX"
> control, which is to use SND_SOC_NOPM as the register and use an enum in
> the shift field instead.
> 
> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

This looks good to me.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   sound/soc/codecs/lpass-wsa-macro.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index f399f4dff5511..bd2561f9fb9fa 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -1211,14 +1211,16 @@ static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
>   				     struct snd_kcontrol *kcontrol, int event)
>   {
>   	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> -	u16 gain_reg;
> +	u16 path_reg, gain_reg;
>   	int val;
>   
> -	switch (w->reg) {
> -	case CDC_WSA_RX0_RX_PATH_MIX_CTL:
> +	switch (w->shift) {
> +	case WSA_MACRO_RX_MIX0:
> +		path_reg = CDC_WSA_RX0_RX_PATH_MIX_CTL;
>   		gain_reg = CDC_WSA_RX0_RX_VOL_MIX_CTL;
>   		break;
> -	case CDC_WSA_RX1_RX_PATH_MIX_CTL:
> +	case WSA_MACRO_RX_MIX1:
> +		path_reg = CDC_WSA_RX1_RX_PATH_MIX_CTL;
>   		gain_reg = CDC_WSA_RX1_RX_VOL_MIX_CTL;
>   		break;
>   	default:
> @@ -1231,7 +1233,7 @@ static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
>   		snd_soc_component_write(component, gain_reg, val);
>   		break;
>   	case SND_SOC_DAPM_POST_PMD:
> -		snd_soc_component_update_bits(component, w->reg,
> +		snd_soc_component_update_bits(component, path_reg,
>   					      CDC_WSA_RX_PATH_MIX_CLK_EN_MASK,
>   					      CDC_WSA_RX_PATH_MIX_CLK_DISABLE);
>   		break;
> @@ -2068,14 +2070,14 @@ static const struct snd_soc_dapm_widget wsa_macro_dapm_widgets[] = {
>   	SND_SOC_DAPM_MUX("WSA_RX0 INP0", SND_SOC_NOPM, 0, 0, &rx0_prim_inp0_mux),
>   	SND_SOC_DAPM_MUX("WSA_RX0 INP1", SND_SOC_NOPM, 0, 0, &rx0_prim_inp1_mux),
>   	SND_SOC_DAPM_MUX("WSA_RX0 INP2", SND_SOC_NOPM, 0, 0, &rx0_prim_inp2_mux),
> -	SND_SOC_DAPM_MUX_E("WSA_RX0 MIX INP", CDC_WSA_RX0_RX_PATH_MIX_CTL,
> -			   0, 0, &rx0_mix_mux, wsa_macro_enable_mix_path,
> +	SND_SOC_DAPM_MUX_E("WSA_RX0 MIX INP", SND_SOC_NOPM, WSA_MACRO_RX_MIX0,
> +			   0, &rx0_mix_mux, wsa_macro_enable_mix_path,
>   			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>   	SND_SOC_DAPM_MUX("WSA_RX1 INP0", SND_SOC_NOPM, 0, 0, &rx1_prim_inp0_mux),
>   	SND_SOC_DAPM_MUX("WSA_RX1 INP1", SND_SOC_NOPM, 0, 0, &rx1_prim_inp1_mux),
>   	SND_SOC_DAPM_MUX("WSA_RX1 INP2", SND_SOC_NOPM, 0, 0, &rx1_prim_inp2_mux),
> -	SND_SOC_DAPM_MUX_E("WSA_RX1 MIX INP", CDC_WSA_RX1_RX_PATH_MIX_CTL,
> -			   0, 0, &rx1_mix_mux, wsa_macro_enable_mix_path,
> +	SND_SOC_DAPM_MUX_E("WSA_RX1 MIX INP", SND_SOC_NOPM, WSA_MACRO_RX_MIX1,
> +			   0, &rx1_mix_mux, wsa_macro_enable_mix_path,
>   			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
>   
>   	SND_SOC_DAPM_MIXER_E("WSA_RX INT0 MIX", SND_SOC_NOPM, 0, 0, NULL, 0,
> 
