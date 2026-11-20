Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A23606A335
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=N6yP+XD9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VH+yKrnf
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4A0C601F3;
	Fri, 20 Nov 2026 16:52:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4A0C601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795189934;
	bh=KOu4dfAoXSFCnNhotrAGtOBjjTCy5ruXmmCqmsoVDyg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=N6yP+XD9PA8tsDHH1WitR1q9n3PCc0UXXnqX/QZ6bvuMCMwMgcLoFwmXKjVLZ2avR
	 rVqEmT8lSyRXRm5MdwbzOA4t3Ts8baw8I2Ode5mKZB2H3K4q1XRW9BO/IPXAHzd2zg
	 uIfa2/oXZH21ViFaG0UWc/m0iQTOR2Hvcf0YdwCY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D55B0F8061D; Fri, 20 Nov 2026 16:51:25 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 02C36F8061D;
	Fri, 20 Nov 2026 16:51:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4CBDAF8025F; Fri, 20 Nov 2026 16:51:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795189874;
	b=or6QaW7SBOybcpJpWSpYyLCl+6dpGiCeuzwR/66Y/YecjcuFtADFp/xQhS60kI0tMHEJ
	 j4tFt2bG2KS47Q+E9er7TE84c36NNBM2hr8eLAj+5fYaviGWLzIa7KesPpoGVvbkZoQcb
	 TJVD1EVABkV+BMBSWf+6hklM47TOxwy1913mwH4miqFAxJuDC1evJLbuLjnIFs6cnea5C
	 LK8pjUMedl2dA1/++dy1m7FGYYTytKyTQHaguopw1KoGi0KV+jToeylRytGEgR/P1EgFi
	 cmbNZktXxyJKdQIn9tH5kp1FDl/9Wgx0zSp14f0vnXqIu9BmeAA/AXdZukSsAXMxmpA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795189874;
	h=DKIM-Signature:MIME-Version:Subject:From:To:Date:Message-Id;
	bh=KOu4dfAoXSFCnNhotrAGtOBjjTCy5ruXmmCqmsoVDyg=;
	b=fe9GmdtGrqrr4GSpRSZbuWMfGoegCR2BekUC1YC1bKqfnbbMFe+gWLg6AfrhLHPpMuTQ
	 DC0DKsCcgP+FHgp+AnyxO0oD+mvm2HxHe1h+9KCSeoqf1TMXcdACspneLY52LaloREXy3
	 JF1FbQncWOezlW7D+bu30cMA1SeNM5OB2mP3DkrHMmEjOYyKcVBvVJbpKmHvFCmkehgwr
	 xlBxwKOOjJJwx1HzxHK15ceYk0cRHu2aAl32xIz1wBgDT2Qbcm/yFR88MMeQS3Dp1AdtQ
	 YyV1FfDeL0W6CtaTomVpZpT1efCbHSWUmOG4nBHWzc6NSrjrzs4zvQ8yeVO9qWk3Rkw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VH+yKrnf;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 19007F80152
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2026 16:51:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19007F80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VH+yKrnf
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0080A4560B;
	Fri, 20 Nov 2026 15:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5B91F000E0;
	Fri, 20 Nov 2026 15:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795189869;
	bh=IfG+lJs6Vtr2atuutvXLgr93FHZRLpK6+MO0TbfEonM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VH+yKrnfquyhi59IlWSrIOByImLfKFrap5H32pA3H6HQXQj4qh4Fn3ikP8DqIY1nW
	 0K104HIA9Ib8xIT9l4QmZFQrLN8lsqGdz77SazITb+Vo5LNdf3BFFjXrHuiPtjReab
	 fT3VAx51+YfzlU/bjoVyiVGZZ+Erwu1WFPCt28aSTQwifgn+Ie90TGIcQOFbNP9uqp
	 QOK2TlQQwu8r+SlPxDDMmv4AgpP4dHkp/MZ9yf2yHHTd4n8iYP8yARS28xXXTf4Sf1
	 UZYhy86zKLlXXv3DjgZDdV2N9N/SH+a9TgMo58ZeAykXB87fRHZToAkn0PoDi5mMe0
	 x9AgIba/btnKg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
In-Reply-To: <20261118084214.527804-3-YLCHANG2@nuvoton.com>
References: <20261118084214.527804-1-YLCHANG2@nuvoton.com>
 <20261118084214.527804-3-YLCHANG2@nuvoton.com>
Date: Fri, 20 Nov 2026 15:51:01 +0000
Message-Id: <179518986191.6016.16828944387493140658.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KOu4dfAoXSFCnNhotrAGtOBjjTCy5ruXmmCqmsoVDyg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIZctKWK1+wWRzfdURxwlvNa8ZNux55Lp7buOr6isVRh
 /t3t64t6yhlYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBE2noY/ml8/Vz/tOGY0aL6
 lt8MWwoNg5eJtmu1fFjClKt1IGv6q8WMDK8Y3Ka03bWdHmAq4S+j/2+td/Z82XNH7y53LrsfGbx
 rNj8A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: AIX45MXSIJGJRGKP6F2S22IWAGM3DNR2
X-Message-ID-Hash: AIX45MXSIJGJRGKP6F2S22IWAGM3DNR2
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AIX45MXSIJGJRGKP6F2S22IWAGM3DNR2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

> Add support for the Nuvoton NAU83G10/20 audio amplifier.
> The NAU83G10 is a mono boost Class-D audio amplifier with
> integrated DSP and I/V-sense support.

> +static int nau8310_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *cp = dai->component;
> +	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
> +	unsigned int val_len = 0;
> +	int fs, ret;
> +
> +	fs = params_rate(params);
> +	if (nau8310_dsp_active(cp) && fs != NAU8310_DEFAULT_FS) {
> +		dev_err(nau8310->dev,
> +			"For ROM Code revision 00, DSP only run at 48kHz.");
> +		return -EINVAL;
> +	}
> +	ret = nau8310_clock_config(nau8310, fs, nau8310->mclk);
> +	if (ret)
> +		return -EINVAL;

As previously noted this hosld return ret, not overwrite the value.

> +static int __maybe_unused nau8310_resume(struct snd_soc_component *cp)
> +{
> +	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
> +	struct regmap *regmap = nau8310->regmap;
> +	int ret = 0;
> +
> +	regcache_cache_only(regmap, false);
> +	ret = regcache_sync(regmap);
> +	if (ret)
> +		return ret;
> +
> +	ret = nau8310_dsp_fw_load(nau8310);

This will set the clock back to the internal clock and if we had an
active stream nothing restores it so the audio will be broken.

> +static const struct regmap_config nau8310_regmap_config = {
> +	.reg_bits = NAU8310_REG_ADDR_LEN,
> +	.val_bits = NAU8310_REG_DATA_LEN,
> +
> +	.max_register = NAU8310_REG_MAX,
> +	.readable_reg = nau8310_readable_reg,
> +	.writeable_reg = nau8310_writeable_reg,
> +	.volatile_reg = nau8310_volatile_reg,

Does NAU8310_RF000_DSP_COMM not need to be marked as previous?

-- 
Mark Brown <broonie@kernel.org>
