Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF5606A336
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=nMF5Z7oP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fR1wh0z6
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F07D601EB;
	Mon,  9 Nov 2026 20:49:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F07D601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794253759;
	bh=uz0EEhKFqb2Rh6VAYejYUKzktncm0H9HpNXhrqxvcSA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nMF5Z7oPcL8YJbT3df1AR3JVU0XYEi8WZ92fPYQ8ZuWHMltuWGaDOma+UGznnK4UF
	 RSdcuLY7ft/GOCBc15/UZ4ZtVI9Jhe8PBsDCy6GdM9zJCNyX/tlbcWi1zBLPCgWeuc
	 ThSSJN5pfYNipKdpaawtRnPTsF2F4bTajvJOpGHY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0217F805F0; Mon,  9 Nov 2026 20:48:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73ED7F80600;
	Mon,  9 Nov 2026 20:48:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15980F805C7; Mon,  9 Nov 2026 20:48:39 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794253718;
	b=goqjVtIAHLaLva38lRhHAXDLeVEZhFxzyYZjWVE+Ii0krzpZ3AI/la2YSux9iC0Wv8LD
	 VgaghV8Ooip++mN3kRZqz96FJK4RhITm3J+dZ2HRVoULU+qdCP10BsCUVxHOiCAsXtVrn
	 gD0aF2pU9tPwDOSF0DckypvODeiNtSl2WYK2+lTEvGncHnYvf0se6ZIJSSgsD+O1LfQdd
	 kZn7M8iDa6+Mc10pLAo/EuADH/1tQZY7HMxUrRPLkROb/opLbymL0ODigEotWKZJaLZwh
	 SFSAdT/EJbB5/VY0RrwoRXJ2uxt+CD/NhBY/GfV7mzJc/h1bZVBnIQHbSL0gHzSpznw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794253718;
	h=DKIM-Signature:MIME-Version:Subject:From:To:Date:Message-Id;
	bh=uz0EEhKFqb2Rh6VAYejYUKzktncm0H9HpNXhrqxvcSA=;
	b=KYeMacDCoHjghamP4H9HFJ6TOsXnDREfs4bpsaeIFzV+b/dtliGepvc74RuaSasbEvKx
	 1MvfwVQR3WK/ekJ6U9L6sdGZrTWIm+PhNg9hLQsrksVU1BaRPnL3MZII/cN3kKiTvH9Us
	 XIsysDhqcIpo7nCcMuv3ScHwgg0qAi4MsR50+gb0Es5GFkMCpNk34vcXF58Mkbsurum7w
	 /zhhk/PU4CDNGAQcf8+UIjsHnBaWvqthc/4KMXKpHU2X+an8DVe0esfw2tdgOYAL4OSp/
	 x7enb/iTddgvEDuH2lg+Si6fgVHhOesG1kBwHOJVRnJKdbFkVX9RvGXwO8iNpuH4Ceg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fR1wh0z6;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C2A28F805B0
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 20:48:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2A28F805B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fR1wh0z6
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BEB1B45B6F;
	Mon,  9 Nov 2026 19:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D91B1F008A1;
	Mon,  9 Nov 2026 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253713;
	bh=A8LWwHch8iz5/b23akV80ol5/MMcIgwIVUMrnGv0GxY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=fR1wh0z6oiy/Ntnm9M7hG50ecB143XgeGf/Na/f8N0PyYpFB0al9UwvfSezSP2TEk
	 KPE9fmMvumfvBTdjDsAkLpH6EbYJXFDg8pcbBNEPyITno6RN2YRLxgSu74ZqZpw+7u
	 GNRooOuWuZggkLDubkwXOldRt4kWJrxD4aDhMCYwDkzZkzNrPRLqKIeKe/G6k+ygnG
	 DqMs5DkJQ13wnqLPhOCmk/mRxSkIwQxH/priITQRL1dSAvZXz9GHe23bAyh5gf5Eun
	 yvhe81A4XQjbYismOTwKaR38kiiZAUi1KiknkdTrrChDwRfG7aqs4hWM+udD5A0CCz
	 5gcbjoxKXIhsA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 626432FC6C89;
	Mon, 09 Nov 2026 19:48:20 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com,
 lkp@intel.com
In-Reply-To: <20261109051251.471879-3-YLCHANG2@nuvoton.com>
References: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
 <20261109051251.471879-3-YLCHANG2@nuvoton.com>
Date: Mon, 09 Nov 2026 19:48:19 +0000
Message-Id: <179425369963.3711751.8538085283431158098.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uz0EEhKFqb2Rh6VAYejYUKzktncm0H9HpNXhrqxvcSA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+Kbfs7VjTVXgy6tOdgrJNTtdrphdO8NIPnn60+PH8X
 4auij+sO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRVZ8Y/kfEO3N4Oz5pX2yt
 EHrXcsH7V0HSxSq3Jmyf//pZdywH50mGf0aPBX93brz0f66CW9whhtPGfzg2L/JZsupI0PYVtQ8
 SyvgA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: V4IKQHEEICAXTKGCAEIVLDTIEUYBKQ5U
X-Message-ID-Hash: V4IKQHEEICAXTKGCAEIVLDTIEUYBKQ5U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V4IKQHEEICAXTKGCAEIVLDTIEUYBKQ5U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

> Add support for the Nuvoton NAU83G10 audio amplifier.
> The NAU83G10 is a mono boost Class-D audio amplifier with
> integrated DSP and I/V-sense support.

> +config SND_SOC_NAU8310
> +	tristate "Nuvoton Technology Corporation NAU83G10 Mono Boosted Amplifier"

This handles NAU83G20 as well.

> +static int nau8310_dsp_idle(struct snd_soc_component *cp)
> +{
> +	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
> +	struct regmap *regmap = nau8310->regmap;
> +	unsigned int idle_pattern, timeout = NAU8310_DSP_IDLE_RETRY * USEC_PER_MSEC;
> +	int ret = 0;
> +
> +	ret = regmap_read_poll_timeout(regmap,
> +		NAU8310_RF000_DSP_COMM, idle_pattern,
> +		idle_pattern == NAU8310_DSP_COMM_IDLE_WORD, USEC_PER_MSEC, timeout);
> +	if (ret) {
> +		dev_err(nau8310->dev, "Timeout waiting for DSP idle state: %d", ret);
> +		nau8310_sw_reset_chip(regmap);

If you need to reset the chip you should probably also resync the cache,
and there's some redundancy here with nau8310_software_reset().

> +int nau8310_dsp_init(struct snd_soc_component *cp)
> +{
> +	struct regmap *regmap = cp->regmap;
> +
> +	nau8310_sw_reset_chip(regmap);
> +
> +	/* wait for the power ready */
> +	msleep(120);
> +
> +	regmap_update_bits(regmap, NAU8310_R1A_DSP_CORE_CTRL2,
> +		NAU8310_DSP_RUNSTALL | NAU8310_DAC_SEL_DSP_OUT, NAU8310_DAC_SEL_DSP_OUT);

NAU8310_DAC_SEL_DSP_OUT is used by DAPM, you might want to solve this
the way nau8360 does.

> +static int nau8310_biq_coeff_put(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
> +	struct snd_soc_component *cp = snd_soc_dapm_to_component(dapm);

This is the same issue as was fixed in nau8310_clkdet_put() in this
version.

> +	/* Boost Control Target Value Limit. 0.16 V per step. */
> +	SOC_SINGLE("Boost Target Limit", NAU8310_R17_BOOST_CTRL1,
> +		NAU8310_BSTLIMIT_SFT, NAU8310_BSTLIMIT_MAX, 0),

The binding describes nuvoton,boost-target-limit/-margin as having
0.19V steps - either that or the comment here is wrong.

> +	ret = nau8310_clock_config(nau8310, fs, nau8310->mclk);
> +	if (ret)
> +		return -EINVAL;

Just return ret in case it's more descriptive.

> +static struct i2c_driver nau8310_i2c_driver = {
> +	.driver = {
> +		.name = "nau8310",
> +		.of_match_table = of_match_ptr(nau8310_of_ids),
> +		.acpi_match_table = ACPI_PTR(nau8310_acpi_match),

We don't need the wrappers for these pointers these days.

-- 
Mark Brown <broonie@kernel.org>
