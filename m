Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA29CCD193
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Oct 2025 11:59:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D93E60255;
	Sat, 18 Oct 2025 13:59:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D93E60255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1760788770;
	bh=cOe3G0BH5671j/qS/sTJORyXf/hboUMejotYwCwAQTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p2iF96X4VH4ef/ph8CeJY2Myz6EgvMN2t6M2u/FWMYbtNZGsdaMKd9RkEzrCQ9Snx
	 fVC+fFSf15cvifyeiqBHqaQpkWxoHuFx0x8ydeuA9fcmDUAKEVKq/flL2r0xpRB8z6
	 yB4Kqx25YKLaAIxMXMTO1qMQoVMMionuhlAOSWaI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43007F806C3; Sat, 18 Oct 2025 13:57:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E394F806C1;
	Sat, 18 Oct 2025 13:57:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D151AF805EF; Mon, 13 Oct 2025 13:32:17 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB567F80236
	for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2025 13:32:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB567F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZK3ngD7Y
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 726D44058F;
	Mon, 13 Oct 2025 11:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57FAC4CEE7;
	Mon, 13 Oct 2025 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760355132;
	bh=m96PGABlYdaOepyswTgRBnP+TrYhgaE0uamm4TF3lqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZK3ngD7YgoydXPNquZipau9n/XLQUAAybdAZm4SdvmE5Tu4JxTlC77qLF74oC8XTq
	 5Y8N7QmHz9GEuUT0o+M1mJf+r7Al8okw/bkJQqP6XA6lMS32G+jYE2VcjiPcLkyN1n
	 UP9I2cZMgXkm5HrzJnzztGaSxjlCEhY1ax8vzAinbKKtuuCLKNqC6q53SERbdAPWg+
	 X0tEOEyvm+JA8htxKrhYDBxxfJ+hgUgJUgBHEy7Ha3Q/sYwfzQYfyIKFrlswCE+DXj
	 8L/G58RdD0F8Plk8I9U2QUS56aQhDbLwv2yX9ml0CBfrXsuJghhk/chq2Zv6X26o2O
	 fIpC93j4xYzNw==
Date: Mon, 13 Oct 2025 12:32:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, flove@realtek.com,
	shumingf@realtek.com, jack.yu@realtek.com, derek.fang@realtek.com
Subject: Re: [PATCH v4 1/2] ASoC: rt5575: Add the codec driver for the ALC5575
Message-ID: <ff70ca0c-a413-4bcc-8ded-f2d73ccf506a@sirena.org.uk>
References: <20251013090805.2678409-1-oder_chiou@realtek.com>
MIME-Version: 1.0
In-Reply-To: <20251013090805.2678409-1-oder_chiou@realtek.com>
X-Cookie: Ahead warp factor one, Mr. Sulu.
Message-ID-Hash: YCNKQH6KDRBLTE5PYPUHDKB3N4CHDLL4
X-Message-ID-Hash: YCNKQH6KDRBLTE5PYPUHDKB3N4CHDLL4
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
Content-Type: multipart/mixed; boundary="===============5108999916654866175=="


--===============5108999916654866175==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="il+/hSusFMA4pljx"
Content-Disposition: inline


--il+/hSusFMA4pljx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 13, 2025 at 05:08:04PM +0800, Oder Chiou wrote:

> This codec driver is for the ALC5575 that has a built-in audio DSP. The
> firmware can be loaded by the SPI from the SOC or the external flash.

> +	regmap_update_bits(rt5575->regmap, RT5575_SW_INT, 1, 1);

> +	ret = 1;
> +	for (i = 0; i < 100 && ret; i++) {
> +		regmap_read(rt5575->regmap, RT5575_SW_INT, &ret);
> +		msleep(100);
> +	}
> +
> +	return 0;

Shouldn't there be an error reported if we get to the end of our 100
loops and ret is still set?

> +static int rt5575_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}

Just delete this if it's empty.

> +static int rt5575_set_bias_level(struct snd_soc_component *component,
> +			enum snd_soc_bias_level level)
> +{
> +	switch (level) {

This also does nothing and could be removed.

> +static irqreturn_t rt5575_irq(int irq, void *data)
> +{
> +	return IRQ_HANDLED;
> +}

This seems strange?  Why even register an interrupt handler if we're
just going to ignore it?

--il+/hSusFMA4pljx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjs4zcACgkQJNaLcl1U
h9A5XQf/dob1cVHl8XTpv+8MZSMNg2cb9Z5olL8Z38rg6j0sqW3FaPwgMWL4mYOz
a3RSjUaRcuoVG3qd4mWbkO83ysx/mjqYoCdLNJVS4M5xqHw3cCvltTb4cHda7Hg0
U21hPf9ZrkoYULf/f24bRzSJFU8zIikHtqKt5EjdkbFlAd3asXqQZpc25DIfIz1h
XupUPCH4jN2atpkW8kouJPZDeoCoMOu7tuBVXB2VxfkbMzPK/ixzuuuO17wvhLhA
FCBG0t1Hpm3B6SH927Xy8zGR2GbBUQOFsFHa/luWtM6CEH3v+3fVpwLZr4OA3Muc
nL1O84HDeb0Pem7ts52DryufYKQDYg==
=raqK
-----END PGP SIGNATURE-----

--il+/hSusFMA4pljx--

--===============5108999916654866175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list -- alsa-devel@alsa-project.org
To unsubscribe send an email to alsa-devel-leave@alsa-project.org

--===============5108999916654866175==--
