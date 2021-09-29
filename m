Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5350C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 12:07:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA086140F
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 12:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCA086140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA8F61690;
	Wed, 29 Sep 2021 14:06:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA8F61690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632917230;
	bh=/Oy3Mndy6azcpoYhz1fOxwT8aReLekYCOnbd7v8PabA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXM0rgCzinKvS21x9yCmDIszd/7wgP9ZLE5hUlAQlSkqD+tr6sMtjpmMAvQG98NZd
	 53ZKGe9lxuvvukVB6ZajTN58/MjGMzZ+AmRlGeUxct5CSzMkGlQ0IRtWDar4E9w+To
	 svst9efG23MYc9PCp+YXhbaN4JVkmXQSkYVzAiTI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49A74F801F7;
	Wed, 29 Sep 2021 14:06:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 18C24F80227; Wed, 29 Sep 2021 14:06:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E58BF80113
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 14:06:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E58BF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iTTcs4Nk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 496CD613A7;
 Wed, 29 Sep 2021 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632917164;
 bh=/Oy3Mndy6azcpoYhz1fOxwT8aReLekYCOnbd7v8PabA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iTTcs4NkCgY6ujG1ZqjSp+YcybgKab8k2XF6TmfDdwYS9LndxKspuHamfXvWGZ0iP
 GlmgWUUoyeHXXrlsDgY/jzQyaoasGCLo7LFf9glxTMBzdTJ3lAUa+QtIu/9/1vzoEJ
 K7VYh4ZcGemnYIE30pRTa7emuRwT1MYHdAPAabBwn4gnSRM5zQM7HW0SzMIxgKUdjb
 D0Vw/FGyn0qZ6mJr1yIiy4NydpegI+WMxgRU4aI5KRyUdkG1kH3MoLgehcMRLsa8w/
 1kcCkHcHic4bQYv1PMJhRFQX9skk0QJFBYXmcG8momHNiN07XOULdJ40sjxH55Fkl9
 57bbB6Zv5wHYQ==
Date: Wed, 29 Sep 2021 13:05:15 +0100
From: Mark Brown <broonie@kernel.org>
To: derek.fang@realtek.com
Subject: Re: [PATCH] ASoC: rt5682s Minor modifications to look more sensibly
Message-ID: <20210929120515.GN4199@sirena.org.uk>
References: <20210929111820.1022-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zbynv6TNPa9FrOf6"
Content-Disposition: inline
In-Reply-To: <20210929111820.1022-1-derek.fang@realtek.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, shumingf@realtek.com, flove@realtek.com
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


--Zbynv6TNPa9FrOf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 29, 2021 at 07:18:20PM +0800, derek.fang@realtek.com wrote:
> From: Derek Fang <derek.fang@realtek.com>
>=20
> These modifications wouldn't affect the driver's behavior,
> but the code could look more sensibly.
>=20
> 1. Remove the volatile reg (0x0000) in reg_default.
> 2. Use dev_dbg instead of pr_debug.
> 3. Revise the macro RT5682S_PLLB_SRC_MASK to 0x1
>    because the mux is only two-source.

This should be three separate patches as they're three different changes
which don't really overlap.

--Zbynv6TNPa9FrOf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUVnoACgkQJNaLcl1U
h9Cupwf9FvMysMqi0rQWFD6ST4y2bE8OlSHEo7xH6n4M4dCKOeV3bQEIa7cdy9EM
Xw41EWwAolBG2ThKAjS3FKjd+MwNLzVmGnPPy3utRLtlZo5Bkt9zLv+CgaGgFv43
gbmmHZUmE4tAVoX5N8tW8r6xTOU0ip2R5stMknLMD1dyUEgDQ9SxJw1u4awzFre5
Hg7SDOFsBnWcdJUU0p0N/Csd42ytHh2zxDdM+CER+FyIrfOKpPrwKkSZR2RuTyEV
prKTgCG/hQpNOKwELcoZSgXXlcZd6dRu+eRX6TYGWHbVNiUBTC2Jd4mzyRmWx/WY
yci/TEr2rh2NYh4NujjHNVoC3vxkaw==
=3Bnx
-----END PGP SIGNATURE-----

--Zbynv6TNPa9FrOf6--
