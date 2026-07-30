Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216F5C55160
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:26:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E97C0601F3;
	Thu, 30 Jul 2026 14:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E97C0601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785414372;
	bh=MumdI4JR+WBHqH0kej/Ux1Vio4K/6sjnOIilDqmUtJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Zo5vzPrc3q1t9L8MnMaRbm/H5MhLawZU5JdXvBC/oH57zXetGIJwsbr6IYzKKt1lJ
	 bIMm7nq7wUEWw8owhtL3/nReVQn65gmRKlIoE0xePbRqKMgJy4Jd80gEhdR5HxUWXV
	 stKrGu9Yx++d4LVD0a6QjGCqvAHb0Z2+z5T6JUEg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CAFA7F805F3; Thu, 30 Jul 2026 14:25:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A612F80600;
	Thu, 30 Jul 2026 14:25:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51C80F80496; Thu, 30 Jul 2026 14:25:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785414330;
	b=F3jY9/lvqnWWkuabNAq1nWx4LP+WSbKvFNSNPeCDjgi1Y7ZFUnkpio8Dl64XuHMcsc9Q
	 WEygODV5mTIzFHMMpvx+aJVfUC+3hIq4s4SsJ/HcjvsKlI6uFtbRx8vC6kZW8r3P/4NMD
	 PR0WuSvLNcSKXUQDhHk488wARruGXvZsGDykQbY0QfzxydZ0y3y6OoW8nLrqRegLdofMC
	 Rco9BUtNDKYrdI9nWVzcxr8dFYC6x0xmY+1BADQRKELWr5aR+yWTcyk2ngmUMeQz4X3gz
	 ai6U6VRbyG/WMbVndSNXjKC7ObY8FZ/iVS/Vo5L/8LhLyHHvbGLN1y5Mng/K2uI3Qug==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785414330;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=MumdI4JR+WBHqH0kej/Ux1Vio4K/6sjnOIilDqmUtJw=;
	b=G7KmJBvFuJmjXXVqoi39lEXisnFDkLrAK3DEIHZzAJDQsWBvQ4EaNGnxNGqMhoYU57my
	 lBGD9y89v6dWCE4JG40LgwhJS6iavBTAlsFMZ0b2vuLHnVOIRdaLsN/oOeaEVN1vVijRg
	 vS9pwChl4hiI2Ba6w5glLYn/PteaUVHScmJirDzUDUU5GIBKDQqySiRjUpVphz31NRXxS
	 u7D7klkJ6rNZYnOqJSq+XmBpijaYolvh1rKOQ5uVMPMRobxMBSaRz5GlFJxdWYQDPr6a2
	 lmYQVSGAgdSQPycPpXZhmKF0ID6/Y/+cmg/0STc65RP4xeE3SqdELf/Y5mRsn1rMcZw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jawTBbR5;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BD7FDF800F3
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 14:25:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD7FDF800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jawTBbR5
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F56F40BE9;
	Thu, 30 Jul 2026 12:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459D31F000E9;
	Thu, 30 Jul 2026 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414326;
	bh=wGE66fqoAOi42BJeUWn9tnYYyelGa7aacpfpaDrHoXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jawTBbR5pol+1U2PUFwFgdIcgM7jQ8X04I93SiWcU3qGTul8K0Rav1co9jkZx6Cv7
	 pu8VgV89IgvjafPiQV8JWP0g8NE8vKfB8nz2mc6BlqD+ReWBdsXb/kV987zYv1cXrW
	 ffORq/LUiRv82ej/Bx126T8B/4xBUKGr8VWqwGCwZ9F78M9Q+ZuFt10CZ2oy9MIQR9
	 nEhcMM+0vRz8AsyDTtk76wBLVict4BdP8wxILQZZEwKSFk4TTK2qt0i22jqZIITXfb
	 UouJ8chcG1jf8HfnIp/OoJFGMuhT8nvFyz/NlYybXa97/vuP5E0ZO6AZxh/LYylNrk
	 YMPfB6FRxzvig==
Date: Thu, 30 Jul 2026 13:25:21 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com, Trevor.Wu@mediatek.com
Subject: Re: [PATCH] ASoC: rt1320-sdw: Add settings to support more base
 clock frequency
Message-ID: <430b1778-26cc-45eb-884f-37d3c3417b1b@sirena.org.uk>
References: <20260716061536.1563252-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eRTYXyYyrGhBGX5/"
Content-Disposition: inline
In-Reply-To: <20260716061536.1563252-1-jack.yu@realtek.com>
X-Cookie: In specially marked packages only.
Message-ID-Hash: HPERZMYJXP3HQUT6KRP7PMUHJL455QCM
X-Message-ID-Hash: HPERZMYJXP3HQUT6KRP7PMUHJL455QCM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HPERZMYJXP3HQUT6KRP7PMUHJL455QCM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--eRTYXyYyrGhBGX5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2026 at 02:15:36PM +0800, jack.yu@realtek.com wrote:

> Add settings to support more base clock frequency on different platform.

> +static int rt1320_bus_config(struct sdw_slave *slave,
> +				struct sdw_bus_params *params)
> +{
> +	struct  rt1320_sdw_priv *rt1320 = dev_get_drvdata(&slave->dev);
> +	unsigned int clk_base;
> +
> +	regmap_read(rt1320->regmap, 0x004d, &clk_base);

Do we need to set clock_reg_supported?

--eRTYXyYyrGhBGX5/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmprQrAACgkQJNaLcl1U
h9BXhgf7BOaSx/dc7QVjpeMHBdYRmhN/HlivMiUTY/sPYSwqX7DxjnL91KJzMaPg
ZSjmq9pQ3u9xUY9NIgqHc+6VkLaZJkcib7CahuNGPzdOoOm+luGYRWEJcdG3PGl2
o3jyfxtnNCgc3nlia9JZPel0DlpAdVY8/qqTZESY98o+b1DbDSetC47dLXuzQICG
nc8QraCc0VNUPQ3Vav7nrwKDWX6NVAGkz7uDPLYItK0DrrrHX6kPm88EePIeJj7v
P5RqsZ8nZel1HcgyFRHi7TmSMTmgScxaayFzV+a5WKsaZ7qGJai9mKeiA6KeZmk1
UvVfBuD6ccgjreYqW3g8Ndip+0m7Hw==
=GCAE
-----END PGP SIGNATURE-----

--eRTYXyYyrGhBGX5/--
