Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEFEC77B73
	for <alsa-devel@archiver.kernel.org>; Tue, 30 May 2023 21:32:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 585BF6C1;
	Tue, 30 May 2023 23:31:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 585BF6C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685482367;
	bh=PrlL1qfJ4X4PgO5aGdikpfSveOZTNv2Z4rqYo4OiJts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VI0E9oNLqss7P2WQ67B1xv/rqllJFKYrqbaNRmWZnDQgxIj4nX1j1Bmc/HM2cjr21
	 O+H/U5jZLurhjfzsVgG27O6HHm+lGVTVReGM0hyrz1vc9Mmb1RJ31CQ2S/SxbvTjss
	 NOCHVqOme8aDccVGteKNS34rjMgLnW3/+OtVBIRY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3003DF8042F; Tue, 30 May 2023 23:31:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B8B79F8042F;
	Tue, 30 May 2023 23:31:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04F73F8042F; Tue, 30 May 2023 23:31:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 305A1F800DF
	for <alsa-devel@alsa-project.org>; Tue, 30 May 2023 23:30:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 305A1F800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iBLPvGkJ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8EBBD62510;
	Tue, 30 May 2023 21:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869C2C433EF;
	Tue, 30 May 2023 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685482253;
	bh=PrlL1qfJ4X4PgO5aGdikpfSveOZTNv2Z4rqYo4OiJts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBLPvGkJZb7R3XA/E6T8YvG3XN3DGpqP+dWwEAjFyBXDGCduGXbXAq87fVbsr2MLp
	 JCRGsqL8OjIS7OoZJV8H6VAT7RvnFilBArfPFhq2v/H8IECnEiskUYB1tDdwx8Seaq
	 zzjYXil1T7WjAoNC7cVfQTKVQmZMoz42iM4N+mzCxvPPwy48NSWEbUz4NJ6ZJUqXDF
	 rWbjPpjQpkA5/r0r4F8/P1WgC3iPCgGNPbYqM5Mv2u8seoTuyTR9gh72kit3EGIMMX
	 DKOzBWAZNwrqDv73tchVsncDT35LregvMV1mNTFEr3rSan8EnhhEhfRqCBpPkh0HR6
	 4plYDAsXS+qeA==
Date: Tue, 30 May 2023 22:30:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org, vkoul@kernel.org, robh+dt@kernel.org,
	conor+dt@kernel.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] spi: cs42l43: Add SPI controller support
Message-ID: <171e2054-e41c-46a5-b478-f699909c5bd7@sirena.org.uk>
References: <20230530122112.1314458-1-ckeepax@opensource.cirrus.com>
 <20230530122112.1314458-6-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LUy+8fUc7Rrtf09J"
Content-Disposition: inline
In-Reply-To: <20230530122112.1314458-6-ckeepax@opensource.cirrus.com>
X-Cookie: I've read SEVEN MILLION books!!
Message-ID-Hash: PJ2K5UM2ZAZIUZ4LDG4R2B6IQGS6AJLA
X-Message-ID-Hash: PJ2K5UM2ZAZIUZ4LDG4R2B6IQGS6AJLA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PJ2K5UM2ZAZIUZ4LDG4R2B6IQGS6AJLA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--LUy+8fUc7Rrtf09J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2023 at 01:21:11PM +0100, Charles Keepax wrote:

A couple of small things:

> +static unsigned int cs42l43_clock_divs[16] = {
> +	2, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30
> +};

Do we need to specify the size of the array?  I just had to count the
number of initialisers :(   Should probably also be const.

> +		for (; buf < block - (sizeof(u32) - 1); buf += sizeof(u32))
> +			regmap_write(regmap, CS42L43_TX_DATA, *(const u32 *)buf);

We're passing a byte stream through a u32 here - are you sure this is
endian safe?

--LUy+8fUc7Rrtf09J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR2awUACgkQJNaLcl1U
h9BLMAf7B1to2LkSkIjsJGp1+2cKMbTn+WNW6z2CuH5pGIv8uv6hHT/yakD/DAtD
xqM8doMGB7ckoPBvhosXpSmd7TODf4nrrADZEB9yL5ZgAyPl9tgk7ZrNldZUr8bV
KBRZASEbj3MNDA4EzBe8oG7jn3vwgF+Yes6wYzvhiUkQFL1alr7u/7IQ4lJlKWTL
hnYHrP4S/2ZbZzJO16dLz47zIYMAtERArGEfrKYdQ1rmWazZMGFJ8MwboxkC8ZMQ
gR2K6dVAAsncxp3ruAEB520UX7td4j1tm2rcJgyNTbgXbJsn7wVZ882YEXAF24L8
oRslOoGjnPOB9/vkdOYSL79Zyx1Xyg==
=Yi++
-----END PGP SIGNATURE-----

--LUy+8fUc7Rrtf09J--
