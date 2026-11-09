Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204E606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=aOXjCW4O;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJ1wGKph
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADF95601EE;
	Mon,  9 Nov 2026 14:16:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADF95601EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794230190;
	bh=moLQb0mHQMaRcxE4D4EJtb5cXH+6oaxJha+qERe+nMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aOXjCW4OmtB9SLefCxCnwX8PMd7iZF13ShfEFV3eEUsuUacUZT10tXjTbY9j7ZhO8
	 44riuAcljhgE/CaT1f3JA0sopktKWKPAimgV8qZRO6VNfqrdsTT4t+kh77kXtUT7mJ
	 j6VmDyYCIOY5u21SwFb3t/Xg9IA7xie0GqVadjEM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 414FEF80602; Mon,  9 Nov 2026 14:15:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65F5EF80600;
	Mon,  9 Nov 2026 14:15:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 599F3F805C7; Mon,  9 Nov 2026 14:15:48 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794230147;
	b=dHntga0IYBjHtjHNy+MZZr05bA9DYnvrGwcZIYN5F/J0wqSS6iSj5z5RqgrDLAszyNdA
	 oVeGULCWCtyVTrps1r7vWFBcLZp5x0L5ILTkNJKXHjqvLHmN/cIr14pVYQKTWc2AOLRe7
	 i42XLP67OisG12RJBzAcrNyASBRG5LpAUofrynL7emmjgqka/WmtP+nDcBewz3tRmPKwF
	 AYVfhggxpDJSKftWC8uTJaKS4qkmjkY4LCWOt0iaOCumDsizEFMTORsJTbYFInsfbF2Wv
	 +OJ286Zcr6jm17Zg8D17cY75ThTxJMC3Pk4rigi52W2a5cWEccnYqgVWtgzBf/LdA0g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794230147;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=moLQb0mHQMaRcxE4D4EJtb5cXH+6oaxJha+qERe+nMw=;
	b=KpZNH6+TAGWlK/yBDVtKi3GKEKvVtnPiGE0vZPvuwf3DANzumy42oslgcYFpdqU3nIW5
	 dKLwoBQFKA3oFIPjYG+O8j7bHqQWOGEOT1qJGAMESmNJS2wUR0zcbS8Rhj1tMudo6845p
	 S5Ckw6JBZ5CHmXHzU5Lf1fsbt52MG6P6E/FTcMP5HQ2pv0I+txTB3dylS+JBefM2807Dt
	 hyvvPSWFHeJAGP/YJiV7H8R/sqlIPewhvDgndrfB7kFXdr1gxDfGISfAoMYnIOWEOlktr
	 p6YG0oPVho+TxeKJsHLrCCGhLN2dDkYoWOm46eBkngyyxnJeYpYCr4toRcssSQLiBBg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jJ1wGKph;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B0F41F80124
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 14:15:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0F41F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jJ1wGKph
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DD3B405BB;
	Mon,  9 Nov 2026 13:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01571F008A1;
	Mon,  9 Nov 2026 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230142;
	bh=qWYxEANPerw9+vwjfiGLR3BT2n5+ClkG5uu0vCxSqc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jJ1wGKphnG5o4B0V+76FtBaRwxwqHU/kdK+Xvn7MrRu3kfzPNlXEuyeEZEQcmRNy8
	 nMsY2nzNS3OqnnRaxm7NVD+L9BezdNrsaEzazA13AC/ZG56c8oLgRgy2DTuIfQkuLJ
	 h1Ueh9s4ei3oN7Mz8AbrN+OF+9urPjn4ATIszvVHBsF7K9PeocYWvX+C6VUV6TbWPy
	 ZDWSAlBqD2LdyX5zDijaYamFQU19wd86LN0wm9uSgbPLr9UUNi0BcetcnS/OpIz1LY
	 Q6SB72kvmr8eFkOu3GR5Qg+Df7ahzO0ohC5z9BqvjaEQmuMw2R98yH2i1g9Kll3k+H
	 xTD5AWEG6snKw==
Date: Mon, 9 Nov 2026 14:15:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com, lkp@intel.com
Subject: Re: [PATCH v2 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
Message-ID: <20261109-myna-of-noble-downpour-e09d3e@quoll>
References: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
 <20261109051251.471879-3-YLCHANG2@nuvoton.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109051251.471879-3-YLCHANG2@nuvoton.com>
Message-ID-Hash: Q7SY2YWPPOASY7QSVBQNEGXHLUCDXEI3
X-Message-ID-Hash: Q7SY2YWPPOASY7QSVBQNEGXHLUCDXEI3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q7SY2YWPPOASY7QSVBQNEGXHLUCDXEI3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Mon, Nov 09, 2026 at 01:12:51PM +0800, Neo Chang wrote:
> +static void nau8310_init_regs(struct nau8310 *nau8310)
> +{
> +	struct regmap *regmap = nau8310->regmap;
> +	unsigned int clk_det = 0, ana_ctrl = 0;
> +
> +	/* Latch IIC LSB value */
> +	regmap_write(regmap, NAU8310_R02_I2C_ADDR, 0x0001);
> +	/* Block MCLK */
> +	regmap_update_bits(regmap, NAU8310_R04_ENA_CTRL,
> +		NAU8310_MCLK_SEL_MASK, 0x7 << NAU8310_MCLK_SEL_SFT);
> +	/* stall DSP */
> +	regmap_update_bits(regmap, NAU8310_R1A_DSP_CORE_CTRL2,
> +		NAU8310_DSP_RUNSTALL, NAU8310_DSP_RUNSTALL);
> +	/* Default ADCI from slot1, ADCV from slot 0. */
> +	regmap_update_bits(regmap, NAU8310_R0C_TDM_CTRL,
> +		NAU8310_ADC_I_SEL_MASK | NAU8310_ADC_V_SEL_MASK,
> +		(0x4 << NAU8310_ADC_I_SEL_SFT) | 0x4);
> +	/* Set I-sense digital gain to +10.25dB */
> +	regmap_update_bits(regmap, NAU8310_R14_ADC_VOL_CTRL,
> +		NAU8310_ADC_GAIN_L_MASK | NAU8310_ADC_GAIN_R_MASK,
> +		(0x1 << NAU8310_ADC_GAIN_L_SFT) | 0x62);
> +	/* PGA in Class A Mode */
> +	regmap_update_bits(regmap, NAU8310_R76_BOOST,
> +		NAU8310_STG2_SEL_CLASSA, NAU8310_STG2_SEL_CLASSA);
> +	/* Set I-sense PGA Bias Current to minimum,
> +	 * Disable PGA Common Mode Lock.
> +	 */

Even netdev does not use that format of comments anymore. And this is
not netdev in the first place.

...

> +	nau8310 = devm_kzalloc(dev, sizeof(*nau8310), GFP_KERNEL);
> +	if (!nau8310)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(i2c, nau8310);
> +	mutex_init(&nau8310->lock);
> +	INIT_WORK(&nau8310->load_fw_work, nau8310_load_fw_work);
> +
> +	nau8310->regmap = devm_regmap_init(dev, NULL, i2c, &nau8310_regmap_config);
> +	if (IS_ERR(nau8310->regmap))
> +		return PTR_ERR(nau8310->regmap);
> +
> +	nau8310->dev = dev;
> +
> +	nau8310_reset_chip(nau8310->regmap);
> +	ret = regmap_read(nau8310->regmap, NAU8310_R46_I2C_DEVICE_ID, &value);
> +	if (ret) {
> +		dev_err(dev, "Failed to read NAU8310/20 device id: %d", ret);
> +		return ret;
> +	}
> +
> +	nau8310->silicon_id = value & NAU8310_REG_SI_REV_MASK;
> +	ret = nau8310_read_device_properties(nau8310);
> +	if (ret)
> +		return ret;
> +
> +	nau8310_print_device_properties(nau8310);
> +	nau8310_init_regs(nau8310);
> +
> +	return devm_snd_soc_register_component(dev, &soc_comp_dev_nau8310,
> +		&nau8310_dai, 1);
> +}
> +
> +static void nau8310_i2c_remove(struct i2c_client *client)
> +{
> +	struct nau8310 *nau8310 = i2c_get_clientdata(client);
> +
> +	cancel_work_sync(&nau8310->load_fw_work);

This looks safe, but still error-prone and discouraged. Use same order
of cleanup as order of init/allocation in probe.

See also include/linux/devm-helpers.h

> +}
> +
> +static const struct i2c_device_id nau8310_i2c_ids[] = {
> +	{ .name = "nau8310" },
> +	{ .name = "nau8320" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, nau8310_i2c_ids);
> +
> +static const struct of_device_id nau8310_of_ids[] = {
> +	{ .compatible = "nuvoton,nau8310" },
> +	{ .compatible = "nuvoton,nau8320" },

This suggests devices are compatible, but was not expressed in the
binding (and then second entry is redundant).

Best regards,
Krzysztof

