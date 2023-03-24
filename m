Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B09C74A5B
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Mar 2023 00:05:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E8BDEC5;
	Fri, 24 Mar 2023 01:04:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E8BDEC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679616307;
	bh=XUAQX7WLfPzAunVs66lGMtCyPb+vveo57jrK8ZTvSfI=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kRbchSnZyB8Y2QZcNWgvjzKqLJ/2iBy5JoDRoRe4JCdpxt4/oUqfpCi0/BCMqi4s3
	 OumMmNVV5htpSQ4NfiqkbSdIPHIRdKxvFNzEQF6ZJjD5WWrqf0d3yjdm5dgeUr1a0g
	 0Ygbml/Evnb0f5WEDWtrwrKkCOpWGnbng/mbHmgM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EE6DF80093;
	Fri, 24 Mar 2023 01:03:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7FDF4F802E8; Fri, 24 Mar 2023 01:03:51 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8771CF80093
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2023 01:03:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8771CF80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rtel7lrE
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C777762914;
	Fri, 24 Mar 2023 00:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E68C433D2;
	Fri, 24 Mar 2023 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679616223;
	bh=XUAQX7WLfPzAunVs66lGMtCyPb+vveo57jrK8ZTvSfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtel7lrEL0i9v7PLBlT4+t+EzDejq77npMxgGV9XvuXioojGieXhZ0XVTf4kMPYyM
	 1CPybuqC5B1X5XsAqOo1j8pyBcIS0NKbBq3yPCwcrDl4fQrZ8BiYkx9SiluFiRg39x
	 LEk1DdjrNojzkJYOnhv9W1jsDR2nMgDLyS443cpXobYuv2LZNcsRbZcWgGWhsEJPTF
	 8qdYh0yXHjeJfjbLv0woEt+Lv/9HxHFe7lVBT1Q1ibCYRgWbH8AurM9lWUNjo/2F+O
	 ZjR1nvwhRwUl7rM7y0AErIblD4VWy69HLjeQ80RiwCimBXnWUWJu00iDh32ScGZ/eB
	 LgkIso8S/zIBQ==
Date: Fri, 24 Mar 2023 00:03:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: alc5632: Convert to dtschema
Message-ID: <13480aac-019d-40cc-b785-00ec5614e284@sirena.org.uk>
References: <4a553ab8-4cd3-4ce4-8225-20f43b70a5be@sirena.org.uk>
 <20230323193709.5176-1-danascape@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p7P/9WEWSNzZV5B+"
Content-Disposition: inline
In-Reply-To: <20230323193709.5176-1-danascape@gmail.com>
X-Cookie: A lie in time saves nine.
Message-ID-Hash: PXHXB6QDC5F5G2XFNS4VPVGQVL7SOLT5
X-Message-ID-Hash: PXHXB6QDC5F5G2XFNS4VPVGQVL7SOLT5
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
 devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 krzysztof.kozlowski@linaro.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 Leon Romanovsky <leon@leon.nu>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PXHXB6QDC5F5G2XFNS4VPVGQVL7SOLT5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--p7P/9WEWSNzZV5B+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2023 at 01:07:09AM +0530, Saalim Quadri wrote:

> +maintainers:
> +  - Leon Romanovsky <leon@leon.nu>
> +  - Mark Brown <broonie@kernel.org>

I know nothing specific about this device so shouldn't be listed.  CCing
Leon for him to confirm.

--p7P/9WEWSNzZV5B+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQc6NgACgkQJNaLcl1U
h9A61Af+NpVYj2Eus5eln0oJJ2sFYS7Mhz/F06ddXU1O2kQP+pqzInt2TSjWuQra
8jK8DFTpEroGGBhX4NnqHAISeWXzz9g9zu7LuipuMYmhlYtQdLmLzRCEm2tqFTC2
sl1ZH7JpN8kwD/0jEVu6fzRoHv2+wgqKz+M4HHndXBJBIwOkSDZDEiny0ogEXrsY
XIHFZULrLnF5RQTH61GU8raCPF2p3ixhtOxPh+ju2eoLwoz/aX9mUPk+4lpwP/0f
DaRZIrcwHpOh1TNgZlLwNWwJQOAY/atQCncRANcOEERV96PLJMAhPvKcScadebgU
4JT7biBiQbQp8Jyl1qF2MJklQ7OIlg==
=UK0B
-----END PGP SIGNATURE-----

--p7P/9WEWSNzZV5B+--
