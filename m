Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C22C4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:41:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AE320825
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UlXQsscy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AE320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 277BA950;
	Thu, 29 Oct 2020 17:40:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 277BA950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603989681;
	bh=CVfsd9lqKCXm9WRwl3QdSN2zIPKKpCvAwoPptXIL2gE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UlXQsscykWBnUXkgwkD/H+w5roE59Qhjke4iwgoi05shgOZU6LlRw84JHiYQucjpD
	 a+JyYZmhz5RZrVaqFUIQGV8POSKNLBYNZaEWTSz00rRAuLI1QnmjyOWixOE9Q53O3A
	 U80DvUs0/KrsS5KeMqjuZzJgccaaH4ZgZYt3eObg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 716CAF80217;
	Thu, 29 Oct 2020 17:40:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B853AF800FF; Thu, 29 Oct 2020 17:40:28 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EC5FF800FF
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 17:40:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EC5FF800FF
IronPort-SDR: YWD7PBTORkwWNP8yGIodUrq/+DTE4ZCk21nNiwglEdOlwXaVGDPZ4F6/1FapXvLEchnaCnBAei
 O+qRuHBEUjrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="168563734"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; d="scan'208";a="168563734"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 09:40:16 -0700
IronPort-SDR: ff0QrJ4MtgF2phCB4taCFLTeIZk/DLnPIIRD+XCN5+M+BdmRYYp21ogVdAablqM+r9XWgHBWjK
 XjCTnwzzWYSQ==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; d="scan'208";a="323762885"
Received: from mghaffa-mobl1.amr.corp.intel.com (HELO [10.212.235.9])
 ([10.212.235.9])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 09:40:15 -0700
Subject: Re: [PATCH v2 3/6] ASoC: codecs: lpass-wsa-macro: add dapm widgets
 and route
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-4-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3300f31e-28d1-becf-41e7-814b38082dcb@linux.intel.com>
Date: Thu, 29 Oct 2020 10:52:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029110829.16425-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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


> +static int wsa_macro_enable_mix_path(struct snd_soc_dapm_widget *w,
> +				     struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> +	u16 gain_reg;
> +	int offset_val = 0;
> +	int val = 0;
> +
> +	switch (w->reg) {
> +	case CDC_WSA_RX0_RX_PATH_MIX_CTL:
> +		gain_reg = CDC_WSA_RX0_RX_VOL_MIX_CTL;
> +		break;
> +	case CDC_WSA_RX1_RX_PATH_MIX_CTL:
> +		gain_reg = CDC_WSA_RX1_RX_VOL_MIX_CTL;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		val = snd_soc_component_read(component, gain_reg);
> +		val += offset_val;
> +		snd_soc_component_write(component, gain_reg, val);

missed from v1: offset_val is zero so the sequence is reading and 
writing the same thing. Is this intentional or useful?

> +		break;
> +	case SND_SOC_DAPM_POST_PMD:
> +		snd_soc_component_update_bits(component, w->reg,
> +					      CDC_WSA_RX_PATH_MIX_CLK_EN_MASK,
> +					      CDC_WSA_RX_PATH_MIX_CLK_DISABLE);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +

[...]

> +static bool wsa_macro_adie_lb(struct snd_soc_component *component,
> +			      int interp_idx)
> +{
> +	u16 int_mux_cfg0 = 0, int_mux_cfg1 = 0;

these inits are ignored

> +	u8 int_mux_cfg0_val = 0, int_mux_cfg1_val = 0;

these as well

> +	u8 int_n_inp0 = 0, int_n_inp1 = 0, int_n_inp2 = 0;

and these are also ignored.

> +	int_mux_cfg0 = CDC_WSA_RX_INP_MUX_RX_INT0_CFG0 + interp_idx * 8;
> +	int_mux_cfg1 = int_mux_cfg0 + 4;
> +	int_mux_cfg0_val = snd_soc_component_read(component, int_mux_cfg0);
> +	int_mux_cfg1_val = snd_soc_component_read(component, int_mux_cfg1);
> +
> +	int_n_inp0 = int_mux_cfg0_val & 0x0F;
> +	if (int_n_inp0 == INTn_1_INP_SEL_DEC0 ||
> +		int_n_inp0 == INTn_1_INP_SEL_DEC1)
> +		return true;
> +
> +	int_n_inp1 = int_mux_cfg0_val >> 4;
> +	if (int_n_inp1 == INTn_1_INP_SEL_DEC0 ||
> +		int_n_inp1 == INTn_1_INP_SEL_DEC1)
> +		return true;
> +
> +	int_n_inp2 = int_mux_cfg1_val >> 4;
> +	if (int_n_inp2 == INTn_1_INP_SEL_DEC0 ||
> +		int_n_inp2 == INTn_1_INP_SEL_DEC1)
> +		return true;
> +
> +	return false;
> +}

