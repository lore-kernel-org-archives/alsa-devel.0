Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE23CD5BBF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 07:52:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3915F60219;
	Mon, 25 May 2026 09:52:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3915F60219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779695575;
	bh=tYouBRlDDxoBacqg61uRAmC24F+aU8P/+/zOo+fJ4/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RF//YZVJNGxKRh8HcdWcRtqNws4CaJ/o4dBicUgYnKOiazPwZdAYQtIy4XNsjuq/a
	 t4sGKmukhk9MgjYEVe/UUnpJ1X5tQt1T6iYtI2L4xEN6Hf7HgTkFO45pSsi9tck60O
	 DY2urwtItuBcaxE2tnY8KhHDTsnkINgdBMKd/TjI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5593BF8047D; Mon, 25 May 2026 09:52:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EC89F8047D;
	Mon, 25 May 2026 09:52:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68CD4F80557; Mon, 25 May 2026 09:52:13 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8334BF8001F
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 09:52:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8334BF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aZPylxQ3
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8703C6021E;
	Thu, 21 May 2026 11:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401661F000E9;
	Thu, 21 May 2026 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779363266;
	bh=u4L0vkFGR060ckdfUCAcTgtv+O7QylwEkQhg2saZvEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aZPylxQ3dPMAM3kKQPotMm4S2tnZpRpDN1hLXToDDyuVssYyCx0rv95yUAZGMFxv4
	 I5o3XT+yBCuGNSXNU2cDLqL3Bb247k7JPI3X38630LmLTMevwaNhMGTnktwHcJ9/3q
	 47smZ/93Sn8v5RLjPyc7ljJyeb2k6HEg36Xd6mh+ez+6Z9CVwYuXJZMiiA2PiJj1Gj
	 ZQ1MkV0Egb6x2AGhQzyx4of23UOqySUEBMDoUvkFMizq4uLpeZUz+id26ATL0fvgT1
	 dEGXNWydq/lhZE+Z3gjXwvwLPPHVjD1DNukehZUYEJYV25IFY1Lix+2ae88hwGIHbz
	 KpS8Mea8XJV5A==
Date: Thu, 21 May 2026 12:34:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: amd: acp7x: add system and runtime PM ops
Message-ID: <346949dc-d4f9-420b-b208-65a02c4657a1@sirena.org.uk>
References: <20260507181251.20594-1-Vijendar.Mukunda@amd.com>
 <20260507181251.20594-6-Vijendar.Mukunda@amd.com>
 <905bfeff-ab78-4299-a2a4-45fb8f05e716@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="etEcZ4fPKLR4ZqCJ"
Content-Disposition: inline
In-Reply-To: <905bfeff-ab78-4299-a2a4-45fb8f05e716@amd.com>
X-Cookie: Words are the voice of the heart.
Message-ID-Hash: P63GXXB2ES6B6KA4HWN2QRNUIU7JWJQY
X-Message-ID-Hash: P63GXXB2ES6B6KA4HWN2QRNUIU7JWJQY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P63GXXB2ES6B6KA4HWN2QRNUIU7JWJQY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--etEcZ4fPKLR4ZqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2026 at 02:33:47PM -0500, Mario Limonciello wrote:
> On 5/7/26 13:11, Vijendar Mukunda wrote:

> > +static int __maybe_unused snd_acp7x_resume(struct device *dev)
> > +{
> > +	struct acp7x_dev_data *adata;
> > +	int ret;
> > +
> > +	adata = dev_get_drvdata(dev);
> > +	ret = acp_hw_init(adata, dev);
> > +	if (ret)
> > +		dev_err(dev, "ACP init failed\n");
> > +
> > +	return ret;
> > +}

> Both of snd_acp7x_runtime_resume and snd_acp7x_resume look identical. Will
> there be later code (when machine driver and IO enablement come) that makes
> them different?

> If not; then I think you can drop snd_acp7x_runtime_resume().

> If so; this makes sense to keep separately.

Not seeing any response to this question from Mario?

--etEcZ4fPKLR4ZqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoO7bwACgkQJNaLcl1U
h9BJFwf/TgWuvQ/NFuu19UEQCRcFImz0ttnm4CtFkgiEfYTwIuwp+BnZ/yPUW5Vk
ZSOnwFeKQ6X8AITokenw8Au7xhfYuz+2tsK0RDEO8qOgqEeaSCuIBB2B9frAkU1c
VLasKfi2O4/IGjCsXosWwaIhtLG4ciZNb5xYWn/6pxw5Bvz58AXKs+asR+yoNOdG
+zO0BebJy+BwIbifbcSBPl0Uue52eq1/us328JjNxEdqctTw2hYz3XjnpH5GMnxX
eeo7odR4KyEETTXfUB0Mvv3kQ/NjJI2h5lBmX50BTAEAzBKRKqFGJp/ZG8kc7K8S
uCdfJebvBsPeyei/Uln49JKc6m3etg==
=/UjV
-----END PGP SIGNATURE-----

--etEcZ4fPKLR4ZqCJ--
