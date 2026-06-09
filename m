Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF29CD8CAC
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:35:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC65A60176;
	Tue,  9 Jun 2026 09:34:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC65A60176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780990503;
	bh=ZmI9AW2O3V8qrVXiliMS9DUM/RILyY1t/K1HqWqUqAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nBfyACVAfPVyzoT0PGccSQhrv8Owop5DZPR7bJvqqwGdmPBZMBZxHYu4eYBMVrLFt
	 jRqMp6a8zdtdPxd7eba7PfKhlm7/9Lj/WGRsNoMn4djIaEO6wrQGf94rwW0vGiiKKt
	 xd2cbtOa77Du/zRXFm/euZdtTOkboBKDAAvGnhY0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E844F80587; Tue,  9 Jun 2026 09:34:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1DE48F805FA;
	Tue,  9 Jun 2026 09:34:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AE69DF80496; Tue,  9 Jun 2026 09:34:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780990465;
	b=D1hsYA3/3If9b/mNymtZr/Dt6ZDvITi6peyUz727vBo76GxDj1E79VDWHK6tgdrAPJnE
	 mAU9aFym0pdXrivYfJXa3sX0xZ5bTi3kARPXXEXwnvHQgDljyinkOGpMtt7IAIDazV9/v
	 i590eA3Kn4jx5XjBGPPur2rerSDe+AcWZBxN25pHnuWTFyqgPpWaGwsg3HbI59JLibD9z
	 IkOZZJRmRb2xe4ZrMUO10VH4c1dSYpMgQEI1bjdrrfnYdmgSpvxOWOfYj9uer3kB56t+Z
	 WuJWHzUf/eRO1rcttaj7KnYGYmvPU86AXm4GUpEwyvBfsEhagJHWIrw0XIwMV5I8Ddw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780990465;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=ZmI9AW2O3V8qrVXiliMS9DUM/RILyY1t/K1HqWqUqAI=;
	b=JQo4DVzSr5buwukUtQoUZGuX9jyxX0jecA177GR5HmZtKQpQOZMcnNV5Bs765P14d5Ay
	 b5c6uy1OBTs4z8h6TXOu+QBSjwBwER4/cRLhBDL8kR+UfblKea2GlXQawFnFalALlpojB
	 lTSXXy2E6Ei1TdnNL/CLIReWZFb8YsF9Wq7PtaQGw2mycSic5rSOL3llyEtDy1oM6LEKB
	 bEji/vicXgilxS6VXkyGDkuHzD8W55b4idLqwbieL1miTXgF0dixC9YrbN+UqxQQUdUQd
	 yUKGL07jkG87y/67oS4jT+AgdMxAdW9VC+9/IrDJHTSNV8n4hUH/Wpo3y/DJCCu1TtA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BD30PwzL;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1115F8003C
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 09:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1115F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BD30PwzL
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A6B7438A7;
	Tue,  9 Jun 2026 07:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F041F00893;
	Tue,  9 Jun 2026 07:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780990460;
	bh=GKMXiBpjL54krW7Ij3+vSOaYgR+z4B8wc3h+zOk8PiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BD30PwzLcfG31rqzM+qLb6RcLshde+UxruSa0nnzQTmVMjzqK496TP+MDgv2mc4oa
	 pmH4fqB8YojZATjJHasr7CycBq40b9xFwx4KQ3AfqDURUVY9O7VKjufaf389uwHIoc
	 FGEcHGo2IKeOBpL5/QNDh1t0Kwdlg7zsWh2udv9PQeeTYN/PnpDcnIUvWwNAcN8NWb
	 t4QXcew63MwP+wYiO5z98ZhWmZuBWFJkuf3EMZ0vNdJ6iZ7Ac4gcZ1HaXIHi1h7lvv
	 S/VHKWzY+YQiKSV1ynXV+WwEzUsnWfHl+Kf91a0p5JWAbuL1jEsQuIBKfWeyfiU1eh
	 Nl6Lap3wo5RCA==
Date: Tue, 9 Jun 2026 09:34:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
	devicetree@vger.kernel.org, tiwai@suse.com, robh@kernel.org,
 krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 2/7] ASoC: codecs: ES8389: Fix the issue about mclk_src
Message-ID: <20260609-visionary-truthful-viper-ceff75@quoll>
References: <20260609030623.17404-1-zhangyi@everest-semi.com>
 <20260609030623.17404-3-zhangyi@everest-semi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609030623.17404-3-zhangyi@everest-semi.com>
Message-ID-Hash: XWDDWTLY7BEEVLLJO7FMTL4WDKHTOSUF
X-Message-ID-Hash: XWDDWTLY7BEEVLLJO7FMTL4WDKHTOSUF
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XWDDWTLY7BEEVLLJO7FMTL4WDKHTOSUF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jun 09, 2026 at 11:06:18AM +0800, Zhang Yi wrote:
> Fix the issue with incorrect modifications to mclk_src

What issue? Your commit msgs are really poor - explain nothing. You just
duplicated subject... and anything can be a fix.

> 
> Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
> ---
>  sound/soc/codecs/es8389.c | 12 ++++--------
>  sound/soc/codecs/es8389.h |  5 ++---
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
> index 9c8164916..7a9d5d42a 100644
> --- a/sound/soc/codecs/es8389.c
> +++ b/sound/soc/codecs/es8389.c
> @@ -36,8 +36,8 @@ struct	es8389_private {
>  	unsigned int sysclk;
>  	int mastermode;
>  
> -	u8 mclk_src;
>  	u8 vddd;
> +	bool mclk_src;
>  	int version;
>  	enum snd_soc_bias_level bias_level;
>  };
> @@ -607,9 +607,9 @@ static int es8389_pcm_hw_params(struct snd_pcm_substream *substream,
>  	regmap_update_bits(es8389->regmap, ES8389_ADC_FORMAT_MUTE, ES8389_DATA_LEN_MASK, state);
>  	regmap_update_bits(es8389->regmap, ES8389_DAC_FORMAT_MUTE, ES8389_DATA_LEN_MASK, state);
>  
> -	if (es8389->mclk_src == ES8389_SCLK_PIN) {
> +	if (es8389->mclk_src) {
>  		regmap_update_bits(es8389->regmap, ES8389_MASTER_CLK,
> -					ES8389_MCLK_SOURCE, es8389->mclk_src);
> +					ES8389_MCLK_MASK, ES8389_MCLK_FROM_SCLK);
>  		es8389->sysclk = params_channels(params) * params_width(params) * params_rate(params);
>  	}
>  
> @@ -897,11 +897,7 @@ static int es8389_probe(struct snd_soc_component *component)
>  	int ret, i;
>  	struct es8389_private *es8389 = snd_soc_component_get_drvdata(component);
>  
> -	ret = device_property_read_u8(component->dev, "everest,mclk-src", &es8389->mclk_src);

Why are you changing implemented ABI?

Best regards,
Krzysztof

