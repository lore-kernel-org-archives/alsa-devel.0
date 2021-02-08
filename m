Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BFEC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 12:25:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C24964E4F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 12:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C24964E4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7299B852;
	Mon,  8 Feb 2021 13:24:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7299B852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612787130;
	bh=YILaTyqcfZnBpQee7oi6GxoJMbmfuyKRaf/Nf9DZ3lU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FnHZb41VPmo+QrQoWX0IPhoL1N8EAfG4WnHv40x3VqE3rXErWnXEjVDdktn/G/YEB
	 3bbrCTToMSfYbl8TNWmFbrHcNQo5z/fCg1Bt3dmAazHS3k8y1n/BDwttEKcjVhBa8p
	 9o2By3yeHnLb4lP6x1G0+G42/4ZFNAKqXSuuAN5Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBD17F80169;
	Mon,  8 Feb 2021 13:24:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A2FCF8022B; Mon,  8 Feb 2021 13:24:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FEFDF80165
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 13:24:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FEFDF80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cqqUraYo"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64FAF64DD1;
 Mon,  8 Feb 2021 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612787069;
 bh=YILaTyqcfZnBpQee7oi6GxoJMbmfuyKRaf/Nf9DZ3lU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cqqUraYoHUKQd86Yp7vpXj0WmPLKvoBn630iKO9q0MXRMPsHAvNgPrU0gBREcXVyS
 Hkm5o1uHVYPLydeLGWPGz2cnsUYWWQs4dJjPc9draNxL/O/O3nYjYJ9ycEZRbwYaQJ
 o6ABKq3R3B8WhBUD/LGuCwJxYp1kmjYpFg2geSI1yzLCDJAWR3xv9qd0wKoOPGdFaL
 65Gbe3iFufp623zDFA//PejbyyGnkcI7ylDD+4edAmbMsYK6L9MOKSBta5Sbs4RDgH
 BV+m+KjWF1rE4gf3YztaOlP4ttQ0SF6veMEdhNYTsl2jIRC6Izj17S7jfQ22sxhwxl
 l0+Rgr6ck9uow==
Date: Mon, 8 Feb 2021 12:23:37 +0000
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com
Subject: Re: [PATCH] ASoC: rt1316: Add RT1316 SDCA vendor-specific driver
Message-ID: <20210208122337.GE8645@sirena.org.uk>
References: <20210208090432.1078-1-shumingf@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <20210208090432.1078-1-shumingf@realtek.com>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, derek.fang@realtek.com,
 bard.liao@intel.com, flove@realtek.com, pierre-louis.bossart@intel.com
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


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2021 at 05:04:32PM +0800, shumingf@realtek.com wrote:

> +	/* initial settings - blind write */
> +	regmap_write(rt1316->regmap, 0xc710, 0x17);
> +	regmap_write(rt1316->regmap, 0xc711, 0x80);
> +	regmap_write(rt1316->regmap, 0xc712, 0x26);
> +	regmap_write(rt1316->regmap, 0xc713, 0x06);
> +	regmap_write(rt1316->regmap, 0xc714, 0x80);

These look like a regmap patch?

> +static const char * const rt1316_xu24_bypass_ctl[] = {
> +	"Not Bypass",
> +	"Bypass",
> +};

Why is this an enum and not a standard switch?

> +static const char * const rt1316_lr_iv_sel[] = {
> +	"0",
> +	"1",
> +	"2",
> +	"3",
> +	"4",
> +	"5",
> +	"6",
> +	"7",
> +};

This looks like it could just be a regular control and not an enum -
this is just a normal sequence of numbers that could be mapped directlym
onto a normal control.

> +static int rt1316_sdw_set_tdm_slot(struct snd_soc_dai *dai,
> +				   unsigned int tx_mask,
> +				   unsigned int rx_mask,
> +				   int slots, int slot_width)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct rt1316_sdw_priv *rt1316 =
> +		snd_soc_component_get_drvdata(component);
> +
> +	if (tx_mask)
> +		return -EINVAL;
> +
> +	if (slots > 2)
> +		return -EINVAL;
> +
> +	rt1316->rx_mask = rx_mask;
> +	rt1316->slots = slots;
> +	/* slot_width is not used since it's irrelevant for SoundWire */

I wouldn't expect to see any TDM stuff at all for SoundWire?  I do see
some crept through though :/

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhLUgACgkQJNaLcl1U
h9Acxgf/W4o2qwoPsFXmakmTnBOoV829oT9jPNiE/H4JTYV9+yayxMDQ5lwTQ0NA
S77RwY6u86rfrsxpRT00NBDtDbu5zA0JAZG5ueDxZD/9ka7An+VFo/GMZ1qD1E6j
TbshTtjQz2V6llr81AywXN87GQhWIGALogeZOAomCeFrNCmjGQy6LV9+184qjYGH
SOFl8m50UyJ/14TQHQxqaNBbOrNvM843ArLSX1ajvPWAMnX3go2ppuD87VUmGW0u
pImoN24bda/jlMm8Zn3oIPm5UkSv+zZPrW8HAvSkZFPjBrsEK/FgpTKZhR/7MNgZ
Aek9Fi4qXIy75JNFLMq2QLqc1QGnyA==
=Aw7t
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
