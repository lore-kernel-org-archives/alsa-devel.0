Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D93C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:14:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C9820715
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mj0Mms9i";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJ2x+0R0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C9820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E99415F2;
	Mon, 10 Feb 2020 18:13:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E99415F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581354870;
	bh=25MJcPkkUwnNe0mDDpXbbF6auMjATOGbsr+6nWqVg4Q=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mj0Mms9i7IwZulRr74hCgN1lIoLdbpOR1PKMPiEcduCWGQEL6n4Zm7EZmGa7k0PqD
	 AEdNT0SQVYTpfs6w3tQPxRwspLwEWtR+WrBoTRtEu8uCurkfPl044j36lZTRHMQ/6V
	 Mjw+EiZF6o/i77LSziaDzooHMQjrv9+Y5JBH7Ukk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2234F8014F;
	Mon, 10 Feb 2020 18:13:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E64F9F80157; Mon, 10 Feb 2020 18:13:37 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FA33F800E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 18:13:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FA33F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="mJ2x+0R0"
Received: by mail-wr1-x441.google.com with SMTP id z7so8694486wrl.13
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 09:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DSU+tE7/gI2emqC2rIzadepHX0f2kKadx71NAW+DB9c=;
 b=mJ2x+0R0KG/zW9mIk2M541OD92fCUzci3ZA329+8cFqWKkKoiYinhkyd1Jrxr6rS6o
 XzAdYkfUKOg8fLKFIuQLVAtDlVky8uxBVPPeEZVK1N4BX2ybShGvTRvZtumVm6OHfrIq
 XOyc0/kGBjxkdPEt41xI+CVY3WQM0UQtYwmrQNC4kp/zAVMslhWKnjTJJnInArcQwtls
 fY1X5FX7K14iEp44Q/RVA8efFh5NjzSaBfQwNJHRMeMzB57wlDqxplKrCv/I8BdpZTyG
 XZlOO4zgEJC4kThvpMC/eudPXsSHKe0GwibyEQECmv0IJxekTVidJ9XRo8VGQxZmcClm
 /FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DSU+tE7/gI2emqC2rIzadepHX0f2kKadx71NAW+DB9c=;
 b=q4gZuOuOKoogvuCF6cVluWr4lkCKkqdIcArzvN7jEnzFe+d6y3WOixFwo8rKQToIr9
 /Eo3Fkii6XLVjS//n4qHNt+xgdRZC8DJhu2V6AUybQe1swZjnXfMJWeahsr0Pn1F4ai0
 aQSu11pUL6NfnN6pnmzqVcqfCoYVCGPxr4V12Iitu/GeNNmYZM9bFIbTbWlK3MH8osek
 ulOsl8ZOHimJeRidE1oprdii70RDjpdhuw3sj9Uw98JjAjVAxHyxQGjSUya97upwnj84
 7FjL0q3Oy8e34Go7MgVABoj2FKYxVG/tWeMVn+Mh5qC9LyokbRxe6AnI/5Id0PfDzzH5
 umvQ==
X-Gm-Message-State: APjAAAUmvCyn+FkkvZuW71IXWVBhxuNLn1yfnaNQIeitsUEQcNZ8tNyI
 +EOXiaT/m6qu4dZKZMgl6ExSEw==
X-Google-Smtp-Source: APXvYqygfM/XPvD44FZpBV06QPyRiPM1bpOlyzUpNUVyAgaDXnrZJoL6ryy34a3DovTGrMav5A6R7w==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr3005070wrn.135.1581354814017; 
 Mon, 10 Feb 2020 09:13:34 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id d22sm1344739wmd.39.2020.02.10.09.13.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Feb 2020 09:13:33 -0800 (PST)
To: Adam Serbinski <adam@serbinski.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-4-adam@serbinski.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d0437f6d-84c8-e1cd-b6f5-c1009e00245d@linaro.org>
Date: Mon, 10 Feb 2020 17:13:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200209154748.3015-4-adam@serbinski.com>
Content-Language: en-US
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 3/8] ASoC: qdsp6: q6afe-dai: add support
 to pcm port dais
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Few minor comments

On 09/02/2020 15:47, Adam Serbinski wrote:
> This patch adds support of AFE DAI for PCM port.
> 
> Signed-off-by: Adam Serbinski <adam@serbinski.com>
> CC: Andy Gross <agross@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Liam Girdwood <lgirdwood@gmail.com>
> CC: Patrick Lai <plai@codeaurora.org>
> CC: Banajit Goswami <bgoswami@codeaurora.org>
> CC: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.com>
> CC: alsa-devel@alsa-project.org
> CC: linux-arm-msm@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>   sound/soc/qcom/qdsp6/q6afe-dai.c | 198 ++++++++++++++++++++++++++++++-
>   1 file changed, 197 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> index c1a7624eaf17..23b29591ef47 100644
> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c

...

> +static int q6afe_tdm_set_sysclk(struct snd_soc_dai *dai,
> +		int clk_id, unsigned int freq, int dir)
> +{

Why are we adding exactly duplicate function of q6afe_mi2s_set_sysclk here?

> +	struct q6afe_dai_data *dai_data = dev_get_drvdata(dai->dev);
> +	struct q6afe_port *port = dai_data->port[dai->id];
> +
> +	switch (clk_id) {
> +	case LPAIF_DIG_CLK:
> +		return q6afe_port_set_sysclk(port, clk_id, 0, 5, freq, dir);
> +	case LPAIF_BIT_CLK:
> +	case LPAIF_OSR_CLK:
> +		return q6afe_port_set_sysclk(port, clk_id,
> +					     Q6AFE_LPASS_CLK_SRC_INTERNAL,
> +					     Q6AFE_LPASS_CLK_ROOT_DEFAULT,
> +					     freq, dir);
>   	case Q6AFE_LPASS_CLK_ID_PRI_TDM_IBIT ... Q6AFE_LPASS_CLK_ID_QUIN_TDM_EBIT:
>   		return q6afe_port_set_sysclk(port, clk_id,
>   					     Q6AFE_LPASS_CLK_ATTRIBUTE_INVERT_COUPLE_NO,
> @@ -468,6 +520,11 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>   	{"Tertiary MI2S Playback", NULL, "TERT_MI2S_RX"},
>   	{"Quaternary MI2S Playback", NULL, "QUAT_MI2S_RX"},
>   
> +	{"Primary PCM Playback", NULL, "PRI_PCM_RX"},
> +	{"Secondary PCM Playback", NULL, "SEC_PCM_RX"},
> +	{"Tertiary PCM Playback", NULL, "TERT_PCM_RX"},
> +	{"Quaternary PCM Playback", NULL, "QUAT_PCM_RX"},
> +
>   	{"Primary TDM0 Playback", NULL, "PRIMARY_TDM_RX_0"},
>   	{"Primary TDM1 Playback", NULL, "PRIMARY_TDM_RX_1"},
>   	{"Primary TDM2 Playback", NULL, "PRIMARY_TDM_RX_2"},
> @@ -562,6 +619,11 @@ static const struct snd_soc_dapm_route q6afe_dapm_routes[] = {
>   	{"PRI_MI2S_TX", NULL, "Primary MI2S Capture"},
>   	{"SEC_MI2S_TX", NULL, "Secondary MI2S Capture"},
>   	{"QUAT_MI2S_TX", NULL, "Quaternary MI2S Capture"},
> +
> +	{"PRI_PCM_TX", NULL, "Primary PCM Capture"},
> +	{"SEC_PCM_TX", NULL, "Secondary PCM Capture"},
> +	{"TERT_PCM_TX", NULL, "Tertiary PCM Capture"},
> +	{"QUAT_PCM_TX", NULL, "Quaternary PCM Capture"},
>   };
>   

...

>   
> +	SND_SOC_DAPM_AIF_IN("QUAT_PCM_RX", NULL,
> +			    0, 0, 0, 0),

This can be in single line, same for below


> +	SND_SOC_DAPM_AIF_OUT("QUAT_PCM_TX", NULL,
> +			     0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("TERT_PCM_RX", NULL,
> +			    0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("TERT_PCM_TX", NULL,
> +			     0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("SEC_PCM_RX", NULL,
> +			    0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("SEC_PCM_TX", NULL,
> +			     0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_IN("PRI_PCM_RX", NULL,
> +			    0, 0, 0, 0),
> +	SND_SOC_DAPM_AIF_OUT("PRI_PCM_TX", NULL,
> +			     0, 0, 0, 0),
> +
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
