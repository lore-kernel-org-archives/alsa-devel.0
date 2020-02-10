Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A8CC352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:15:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6752080C
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kMcna4Yl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LApxvCvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6752080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14AEB1676;
	Mon, 10 Feb 2020 18:14:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14AEB1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581354924;
	bh=pNYfNTXVe9UbOwfIbAEIvoz9ft2F5DLIHpP10QXMKCU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kMcna4YlnzI4m9ziQyuykTfKL7Jk+PzovDSEiB+c26q7al8cMkyAmn/PhZuUw069Q
	 1gj2chu9k1W2B8fk6u8rbHWiyHtP3pAmOz2XqSzUfGZMeYU5qWs/wOsRI6slV07weO
	 RfK8NE8tcO+uLmegXcXIWDxTag45/qNTyVpE0alg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB480F8019B;
	Mon, 10 Feb 2020 18:13:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF199F80228; Mon, 10 Feb 2020 18:13:42 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC6DAF80157
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 18:13:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC6DAF80157
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="LApxvCvQ"
Received: by mail-wr1-x442.google.com with SMTP id w15so8763129wru.4
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 09:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dT6SGlIAayRtxR7LTqZPmk0Gfcmis2qaH+GTfxwu2fw=;
 b=LApxvCvQZSOS8im3yL3XTp3sia6J46w3IYYvV71fXEnLvHAOrAN1whLz/i/42Dov04
 JGkUaMrQrz1JINwmFOqiDDGtJD/NFaUCOs1pZ9Wo03nfmMxCsx+BnTe15r4sig6p7I48
 KHNehvY4fwWNlrIGMZsQMuBnw0DyEae5fgTRP+F/R/3Hl2ZgIgr0q4EOzQ3BjwnpFrYH
 Jc5j4pioKx8ZMHeZ/S7AEg8RyCbIB/GDa8QEg8b/1xqTpzi42oqmI8Rj1DF5kGQH0paw
 MyCUak2nt328yKNe+mNvtVbv7+I55GDbHz6ZsValEHju/AGpImAtW1fKveV/02Fm7Nkd
 q83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dT6SGlIAayRtxR7LTqZPmk0Gfcmis2qaH+GTfxwu2fw=;
 b=B8IYtLkZYVZQQiTxdexu/E+8qt2hZNSKpu5V+KB14pxF4GOPqEU0kA+u0v/zGWWBnV
 b2Njh24Dm6SBiClm8ktT0nLwoTD0RyBekz7NoSBR2fnjBWpR+EQ/52FmSJgBQuXRhbYk
 lYThtGoCj/Y2YKzMqKfVdBNJfesMNO7MHXwEmFZgDm7VRzPxrgXh7ipO1Jw3MqerbPVI
 qxGfzMpUbgQCkKNagldExN4A+M9h/qmILY/eNB4mdDlKLwcW1SEjCnBOEz0DgUvix8W0
 P8Tr6hSmko84/QM2Tgx7PZFSc4kUR/iOfJXesu2F62cD5fU+XBG7ySECFAaJNz2y1RNI
 2uPw==
X-Gm-Message-State: APjAAAUD4t6C8KGt2lPw1DRH9Hlkka+k2zZrvAAJUoIagsgSab3r31n9
 SriOy+xAi7w8pldeA2+UPYTv/A==
X-Google-Smtp-Source: APXvYqxfaFB4k+8T3DjlAtB0Qivp+v/Gykui7kso1O0BFmhrp7NMhTTjvpaXWgd34aR5HYxvIFv11A==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr3193454wrw.347.1581354818558; 
 Mon, 10 Feb 2020 09:13:38 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id a5sm1169894wmb.37.2020.02.10.09.13.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Feb 2020 09:13:37 -0800 (PST)
To: Adam Serbinski <adam@serbinski.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-3-adam@serbinski.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4f0c3528-c7cd-37a9-7ca0-e30eb8e6d103@linaro.org>
Date: Mon, 10 Feb 2020 17:13:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200209154748.3015-3-adam@serbinski.com>
Content-Language: en-US
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 2/8] ASoC: qdsp6: q6afe: add support to
	pcm ports
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



On 09/02/2020 15:47, Adam Serbinski wrote:
> This patch adds support to pcm ports in AFE.
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
>   sound/soc/qcom/qdsp6/q6afe.c | 246 +++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.h |   9 +-
>   2 files changed, 254 insertions(+), 1 deletion(-)
> 

Few general comments.

1>documentation to  "struct afe_param_id_pcm_cfg "
Either we follow kerneldoc style or not add this as we did with other 
similar afe port config structures.
Am okay either way!

2> some of the defines in this patch has no reals users, so we better 
remove all the unused constants.





> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index e0945f7a58c8..b53ad14a78fd 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -40,6 +40,7 @@
>   
...

> +/**
> + * q6afe_pcm_port_prepare() - Prepare pcm afe port.
> + *
> + * @port: Instance of afe port
> + * @cfg: PCM configuration for the afe port
> + *
> + */
> +int q6afe_pcm_port_prepare(struct q6afe_port *port, struct q6afe_pcm_cfg *cfg)
> +{
> +	union afe_port_config *pcfg = &port->port_cfg;
> +
> +	pcfg->pcm_cfg.pcm_cfg_minor_version = AFE_API_VERSION_PCM_CONFIG;
> +	pcfg->pcm_cfg.aux_mode = AFE_PORT_PCM_AUX_MODE_PCM;
> +
> +	switch (cfg->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		pcfg->pcm_cfg.sync_src = AFE_PORT_PCM_SYNC_SRC_INTERNAL;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		/* CPU is slave */
> +		pcfg->pcm_cfg.sync_src = AFE_PORT_PCM_SYNC_SRC_EXTERNAL;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	switch (cfg->sample_rate) {
> +	case 8000:
> +		pcfg->pcm_cfg.frame_setting = AFE_PORT_PCM_BITS_PER_FRAME_128;
> +		break;
> +	case 16000:
> +		pcfg->pcm_cfg.frame_setting = AFE_PORT_PCM_BITS_PER_FRAME_64;
> +		break;
> +	}
> +	pcfg->pcm_cfg.quantype = AFE_PORT_PCM_LINEAR_NOPADDING;
> +	pcfg->pcm_cfg.ctrl_data_out_enable = AFE_PORT_PCM_CTRL_DATA_OE_DISABLE;
> +	pcfg->pcm_cfg.reserved = 0;
> +	pcfg->pcm_cfg.sample_rate = cfg->sample_rate;
> +
> +	/* 16 bit mono */
> +	pcfg->pcm_cfg.bit_width = 16;
> +	pcfg->pcm_cfg.num_channels = 1;
> +	pcfg->pcm_cfg.slot_number_mapping[0] = 1;

PCM quantization type and Slot Mapping should come from device tree.



> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(q6afe_pcm_port_prepare);
> +
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
