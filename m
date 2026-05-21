Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE69CD5BCF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 08:22:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2C206021E;
	Mon, 25 May 2026 10:22:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2C206021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779697377;
	bh=oImRwjI+XSNpas5HABW8j0NwP849AjVk4QzoZ8axO3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D0NlBttkj1q42xPVbZXiHU26vldIBDYdlvd8kXxfnSiDrOukdCkzjGZTLylnjP1Z7
	 vsNM0HO0YWK9kuPzMpZGvqstABbl0dq3GgzGwPX5z3GAaPAIFDKPHjQ7LPHCGGudl8
	 TqxJALm6OHNdiSJ2253ONMnVvektpdCjQBL+OmmI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C3FAF805F7; Mon, 25 May 2026 10:22:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 61E54F805E9;
	Mon, 25 May 2026 10:22:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6342AF80557; Mon, 25 May 2026 10:22:13 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D94B7F8001F
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 10:22:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D94B7F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WgIOVQ24
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 35551600C3;
	Thu, 21 May 2026 15:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB1D1F000E9;
	Thu, 21 May 2026 15:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377743;
	bh=TQwSrXVYnpbCfJdtfPjLSghRrh3omoKn1DB2+rGBNjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WgIOVQ24fSOQxyG4iGiLd0T3oOMQsbj1BC/sFOR9UkwhioDe7MhOPISoGe7bQweJ1
	 E4IzCvBrBQmsxwuyT87jWxYliddNtjMx6Zi7iUgHkXoWXLwPRm2snsiTWNSvkM38Lf
	 FBxiOdrm2SVUxF2l2KsRygGAmu7mNxlgwV6N9rgnbLAbjiY749XK/HmuChFRFfEc/4
	 jJkvGrMQSD5HgBEcQUYrRwBamaJOSWdeGFM/u7LtU+ZSoRNi6VQIoEe1CwCFgkIESV
	 9FsHq3NjbHUiXO7DM5sTA3mKiBno3JbQeCMt8Ei03tGAkHinbeBqRmepmXaq5Uaqs0
	 ziTJdrplekOwg==
Date: Thu, 21 May 2026 16:35:39 +0100
From: Mark Brown <broonie@kernel.org>
To: YLCHANG2 <neo.chang70@gmail.com>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v2 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <934509a9-1347-4b02-a341-0db0d1db42e7@sirena.org.uk>
References: <20260518024704.118613-1-YLCHANG2@nuvoton.com>
 <20260518024704.118613-3-YLCHANG2@nuvoton.com>
 <ce8d5ba7-22aa-47ac-90ab-026ed1ee3928@sirena.org.uk>
 <ddacfe50-072d-66fd-c760-c898bdab52f4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UVs/AC80Z1SYC8M2"
Content-Disposition: inline
In-Reply-To: <ddacfe50-072d-66fd-c760-c898bdab52f4@gmail.com>
X-Cookie: No shirt, no shoes, no service.
Message-ID-Hash: 5RGX2QEGXIZCNABWCDAZYG3WG6ETHVXY
X-Message-ID-Hash: 5RGX2QEGXIZCNABWCDAZYG3WG6ETHVXY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5RGX2QEGXIZCNABWCDAZYG3WG6ETHVXY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--UVs/AC80Z1SYC8M2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 20, 2026 at 11:01:53AM +0800, YLCHANG2 wrote:
> On 5/18/26 19:35, Mark Brown wrote:

> > > +static bool nau8360_volatile_reg(struct device *dev, unsigned int reg)
> > > +{
> > > +	switch (reg) {
> > > +	case NAU8360_R00_SOFTWARE_RST ... NAU8360_R02_I2C_ADDR:
> > > +	case NAU8360_R06_INT_CLR_STATUS:
> > > +	case NAU8360_R21_VBAT_READOUT ... NAU8360_R22_TEMP_READOUT:
> > > +	case NAU8360_R41_CLK_CTL2:
> > > +	case NAU8360_R46_I2C_DEVICE_ID:

> > Are the I2C addresss and device ID volatile or do they just not have
> > defaults?

> For NAU8360_R02_I2C_ADDR, it requires a write operation to latch the I2C
> device address.
> For NAU8360_R46_I2C_DEVICE_ID, although it is read-only, its value is
> determined by the hardware configuration
> of the GPIO1 and GPIO2 pins at boot (e.g., 0x1a, 0x1b, 0x4a, or 0x4b).

In that case they shouldn't be marked as volatile, just omitted from the
defaults - they can be cached on first use.

--UVs/AC80Z1SYC8M2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoPJkoACgkQJNaLcl1U
h9D6Dgf+MTFdSAqe+sVth1MJROGJFObulkedu9OA8uG35UgzyoNnZLCBJkQpVIZ4
1px0piveEdCEof5YO8E36u8e6DnBz+J+muskMv1lTEoM0vi6PsNtkLUg8WzCHXdK
uZyxdPv+/442PssImFrXj15dZgIVv4TU5yE5ILxY3HVWmYsIRu7SSTzKzNZxUfJM
TBptlzzjjHTqfOO12fmq4m7JC9D2/HBGpGZ8MKSp3MwJogC5/a54Pb+R7Z5CxVez
x914kR1dNsvlpgRFTLCC2CGXLZMXIaXSAQMaDsWAkpyhl5aVky111iJRQhmHsdYd
aL9m3xbjCglFXQmN+Am3B+kL4DQ5+g==
=ySQG
-----END PGP SIGNATURE-----

--UVs/AC80Z1SYC8M2--
