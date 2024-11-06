Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F11DD44D75
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:06:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73AC914DF;
	Wed,  6 Nov 2024 15:05:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73AC914DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1730901965;
	bh=j1W9k4oVkIQL68KFIkXY480BVKIr5DP71SiPlfPiec0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=L4/cF2xLZ8ae4nMRbkVOqtXPdOHTS/aqnFug8vFjHccpiJy4D9ohMBLcGPNOUg5KA
	 KTisRIBNSlwCKNkuo/Doo997tYIL9//UwxRX9LGGS9LcydO7g/qtj/PXvqIZ8PnO6E
	 8c7spwgkmuKuWBnFUeNvm+A0KfhW33Ilrg4zBOag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA32AF8058C; Wed,  6 Nov 2024 15:05:33 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 52F0AF805A0;
	Wed,  6 Nov 2024 15:05:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F8CBF8013D; Wed,  6 Nov 2024 15:05:29 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BA959F800AA
	for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2024 15:05:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA959F800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WGC5ALmY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 895B5A43D25;
	Wed,  6 Nov 2024 14:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D01C4CECD;
	Wed,  6 Nov 2024 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730901926;
	bh=j1W9k4oVkIQL68KFIkXY480BVKIr5DP71SiPlfPiec0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGC5ALmYPQWR5iJ2S0XpFdPr7MjA8d8poSP2BqJbGh/BYlBL54G/wFDKbktAYTLfY
	 r9fIDGuk73SjSSUaXu3ir5NPlwkCnXyzZjLy5enuQm1qK6GemkA+PjQzx4w53VY8A7
	 lxMjqzUS+UQtIi1DwGkbt/b+WsgDcLro+ATkj9tkzCxYpol6WBsd8uUq3b28PkiFLx
	 7OppV9IBsVa3SUGRvk3b0hBMFReSK4o8fLx+9dflAw2UAiFP5oHBuBJFo3oUAuggUS
	 u/4/o760lT0O7ZWQ3r3hL+9SdV7fp0TDF44aWJozT5stfWXU5//2yGwxjzIDxSQehh
	 d3vRdyBCgpxUQ==
Date: Wed, 6 Nov 2024 14:05:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT
Message-ID: <092cfb04-378f-4997-88e0-35c247b8c445@sirena.org.uk>
References: <20241106005800.7520-1-kiseok.jo@irondevice.com>
 <20241106005800.7520-2-kiseok.jo@irondevice.com>
 <kspk7qajv7r5glbcawmecbup36cv4wi3hjrgyfyyejjectwwt5@u5nx5y5zirsa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x/ijW8mKOHC/k6vi"
Content-Disposition: inline
In-Reply-To: <kspk7qajv7r5glbcawmecbup36cv4wi3hjrgyfyyejjectwwt5@u5nx5y5zirsa>
X-Cookie: Include me out.
Message-ID-Hash: E3CLIH2BZBYAIIVG2MDGQWDMTYD2MJ24
X-Message-ID-Hash: E3CLIH2BZBYAIIVG2MDGQWDMTYD2MJ24
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E3CLIH2BZBYAIIVG2MDGQWDMTYD2MJ24/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--x/ijW8mKOHC/k6vi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 02:55:21PM +0100, Krzysztof Kozlowski wrote:
> On Wed, Nov 06, 2024 at 09:57:59AM +0900, Kiseok Jo wrote:
> > This adds the schema binding for the Iron Device SMA1307 Amp

> That's a v5. RESEND means you send exactly the same or the same plus
> tags.

No, this is actually a resend - he's resending the v4 that you replied
to just before this one which was sent with mangled subject lines and
missing changelogs.

--x/ijW8mKOHC/k6vi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcrd6AACgkQJNaLcl1U
h9A9EQf+IMZncqsxypZL+DNHZLVibRmnJzwUQ3E0MWBrX1jUxeu1XYC1FYLY8oez
t1TYTsBkYw+dbZt1Ia7M3PkEAo4KxcAY/nFr/wUjWt7RYRpNUEi1Fcp8qNCRumnx
yPpanG1xxPgDx0hJ9/lQo3x781dcEOjy2wZQjyxYiiJdhSNFbXxpxSVoScG9xhXo
1MZisRDS2wUEqORD3E+ejcDr9Sc6fnEr0fshHzfK5dlReGjDAjMw5sTfd7ww73mU
IC63KnNvtjMSJEdLlTSYZRH7L/Hx4cgDE5JYDrAWCgybiba9MxwDPolhGNIw42Eu
1ibvbAhNnALQEVMv61Nyke46/X60uw==
=C9SO
-----END PGP SIGNATURE-----

--x/ijW8mKOHC/k6vi--
