Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7107EC8732
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Sep 2023 14:31:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E89F9852;
	Thu,  7 Sep 2023 16:30:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E89F9852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694097093;
	bh=SpgVoXpZ8tTPJGkfU3ecVLROLILLP+Tw7lqoCXII6pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=N74IcHiJB/yERnu8oA5Q2ZTP7azt8mPF3adCuoomMvqEw3CZ/ItQS0JOPSSjA3ppH
	 qJMagM+w4EWZUUXksKqpUELhCzOysFjrzmt9pz7asQDCvsDyRQiobhYE8de0IgjRe+
	 79fb3IcJaIYAgUG8kev6w32o8NqRWTRzMj8DgykE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7689F8055A; Thu,  7 Sep 2023 16:30:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A641F800F5;
	Thu,  7 Sep 2023 16:30:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54701F80494; Thu,  7 Sep 2023 16:30:10 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 199E6F800AA
	for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2023 16:30:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 199E6F800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pzVfDghy
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 0011CCE1A05;
	Thu,  7 Sep 2023 14:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9DC3278F;
	Thu,  7 Sep 2023 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694096471;
	bh=SpgVoXpZ8tTPJGkfU3ecVLROLILLP+Tw7lqoCXII6pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzVfDghyPadfvHEaQazjewvNksmHCOeqpcQtRd8NfmTvtgJaEIil6dYLiDDwRBmt8
	 I4PAp7Qp9QVzzCF4dJZWLMReBnQbv4uLDnicicGHV1dVh2l7Z+y/L2Yun5UcE3XRqp
	 DnINdfmlALickPzVNDSarwzlwJdc0rh4WKt2cQIq64nPNYjKFe76qtZkUdIDQ6voBV
	 oC3MX+cdASaWGkV4h+fRDK9CQBJNeWWVFAWDtKHtGloudKltLKBOJKFINtc3mBFq+3
	 I/jIwllcIfRLPGanbBTts8/MLJVF4kIVzNiEpJNGosbNRZyAcWOI7GiY3qAySKst1O
	 VdkWDT8YlMXew==
Date: Thu, 7 Sep 2023 15:21:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc: a-krasser@ti.com, joerg@hifiberry.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Zhang Qilong <zhangqilong3@huawei.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: Adds support for TAS575x to the pcm512x driver
Message-ID: <a9c3d43a-af26-44a0-9352-4666107f9f56@sirena.org.uk>
References: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pHp2IBdZnGQB80wz"
Content-Disposition: inline
In-Reply-To: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
X-Cookie: In the next world, you're on your own.
Message-ID-Hash: AHURR2L4FQS6DZ3B7FAOJWLGMCGDER7T
X-Message-ID-Hash: AHURR2L4FQS6DZ3B7FAOJWLGMCGDER7T
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AHURR2L4FQS6DZ3B7FAOJWLGMCGDER7T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--pHp2IBdZnGQB80wz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2023 at 06:12:05PM +0200, Joerg Schambacher wrote:

> +		if (pcm512x->tas_device) {
> +			/* set necessary PLL coeffs for amp
> +			 * according to spec only 2x and 4x MCLKs
> +			 * possible
> +			 */
> +			ret = regmap_write(pcm512x->regmap,
> +					   PCM512x_PLL_COEFF_0, 0x01);
> +			if (mck_rate > 25000000UL)
> +				ret = regmap_write(pcm512x->regmap,
> +						   PCM512x_PLL_COEFF_1, 0x02);
> +			else
> +				ret = regmap_write(pcm512x->regmap,
> +						   PCM512x_PLL_COEFF_1, 0x04);

I would name this quirk something a bit more specific - it seems likely
that there might be future TASxxxx devices which need different quirks.
If it's a limited range of MCLK multipliers perhaps something about how
the PLL is limited, or just make the quirk data being to specify min/max
for the multiplier?

> +		if (!pcm512x->tas_device) {
> +			ret = regmap_update_bits(pcm512x->regmap,
> +						 PCM512x_PLL_EN, PCM512x_PLLE, 0);
> +		} else {
> +			/* leave PLL enabled for amp clocking */
> +			ret = regmap_write(pcm512x->regmap,
> +					   PCM512x_PLL_EN, 0x01);
> +			dev_dbg(component->dev, "Enabling PLL for TAS575x\n");
> +		}

This is probably a separate quirk?  I'm a bit concerned about what's
turning the PLL off here...

--pHp2IBdZnGQB80wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT53E8ACgkQJNaLcl1U
h9DIkAf8DvIkbJTLPPb9WOeICPPEg31V9fX1Gbjibv6WKE3XAX0kQvEVID4XikuC
DMutxl/up7Xepw12fXsRnM6ZM1x24dcJoZHfJTLruL48di2xmfOdPskk70WIpXL+
fF9+GzaQ/7pH0VLSOQ7SK/28BNU7lAhVBhqngemmMKLGf7HJpldwoFdaHs4PYOy+
adM6gpYlOJc4bxd0WJ5ua2KUEHWYhaz7T13GLlxchG7WR1UOjHA39uoL3K0NkRuX
unIygkvTh01GYmpEsW3FEfZiRvLhGlxkW15DbrkALX1Tty5Q1hs4eSsGkiwhzTBk
nR0dMZ1hISOepsmVPvS2cq8hnjHYKQ==
=N6pg
-----END PGP SIGNATURE-----

--pHp2IBdZnGQB80wz--
