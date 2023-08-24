Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A23C3DA6F
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Aug 2023 22:14:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E20285D;
	Fri, 25 Aug 2023 00:13:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E20285D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692915269;
	bh=fxrovyzR2qyC/35gzQwS0Hw3bLbJVs+APQFunkdyr+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XjzMVxXRxLKcVkTQ73axfEO7ULPW6hBwxKupvSuXca97bDNgqQThhhzprmx0DvWTI
	 hXvVt8aQVDk14jsAJN/YzyV84i0jdSBNk22wzz4CtHITCfYxg4xEiJ57VxIkEeijsg
	 6by+410ksvnPwP3U50UKrwzAmfD/qmudLmahlqP8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB132F80580; Thu, 24 Aug 2023 23:34:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65F26F80587;
	Thu, 24 Aug 2023 23:34:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9CFBF80587; Thu, 24 Aug 2023 23:34:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C908AF8057E
	for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2023 23:33:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C908AF8057E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SB9N2Q4p
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BC13267179;
	Thu, 24 Aug 2023 21:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E23C433CA;
	Thu, 24 Aug 2023 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692912835;
	bh=fxrovyzR2qyC/35gzQwS0Hw3bLbJVs+APQFunkdyr+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SB9N2Q4pPc0p20vrS5xm9Ra/6gEXNj9Rq8yx9+uMQF0dT1+Ycd4QWR5N1Eh5ZuVlX
	 7t5JG/98gp4bx3e/EQUX3nybfGmZIxRt6KhZrACpvamWAkk6YpdtqEFtvwUwSIglxi
	 85R15dricbrSuvbUWHOEhDcbhlcOZB59TAWhDzNqKM9RFrkYxnsQvo1aOlNZkXKmbC
	 guO43Yo6pI+aDlfZ2LWhEBDsl+/tN2K8FhOtM3moFF8N5V4fhXEo7tH8Y8SOIkroAb
	 Nmob/8H8SaCszKMhLbFWqnJDamlab9UFqEhHYULA2TbuzoqjlcamlO6ln+QYhpja/D
	 scNvCvztPtluQ==
Date: Thu, 24 Aug 2023 22:33:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Marian Postevca <posteuca@mutex.one>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: es8316: Enable support for S32 LE format
Message-ID: <ZOfMo4Cb2zd1Km3H@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-2-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="izoXqi0eacbdbANQ"
Content-Disposition: inline
In-Reply-To: <20230824210135.19303-2-posteuca@mutex.one>
X-Cookie: Give him an evasive answer.
Message-ID-Hash: Q3ASJEL6YHGPJSRFQ5TQILWK52KHKQGT
X-Message-ID-Hash: Q3ASJEL6YHGPJSRFQ5TQILWK52KHKQGT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q3ASJEL6YHGPJSRFQ5TQILWK52KHKQGT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--izoXqi0eacbdbANQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 25, 2023 at 12:01:32AM +0300, Marian Postevca wrote:

> To properly support a line of Huawei laptops with AMD CPU and a
> ES8336 codec connected to the ACP3X module we need to enable
> the S32 LE format.

What's the issue?  The AMD code looks like it supports plenty of other
formats in most places.

--izoXqi0eacbdbANQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTnzKIACgkQJNaLcl1U
h9De4gf+NyKcVoNzicgu5JcsQYUbDa6aMnVmNzuump5WcxgPiDL0KM43cksATvmN
5MBo7FmLmm5IYP/mAkMTFZuJG8zLhSxYEgTasFi17DvbLUC8I+FxkOFkMjdW0bV0
J9wZqlTsLt770U2ZV11rZ8wiRKBJSlS7PxpUBYxLq/urPHnqUoMbE93+og5qFTgC
WDVGKmoNIsVgt7ntjjhaFCRgup/Cjh4bP4ye70ing6jIVdr27CNnGBJsB0GvmXbo
z5DgT7ovi76hPqZfh6Bque5142yJZDrR4ETyKwyT1vWvpawNQlCkG4tVCYWa3SzI
DzHpDfMrm/tlNoxrTQymQbT+FBLtWQ==
=QjEU
-----END PGP SIGNATURE-----

--izoXqi0eacbdbANQ--
