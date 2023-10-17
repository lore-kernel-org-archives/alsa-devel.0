Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1370DCDB482
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Oct 2023 11:30:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16407857;
	Tue, 17 Oct 2023 13:30:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16407857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697542255;
	bh=LP4csdsL40nCe4OI51VZDntZqUrXlSQ7yWdsMFKaLak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BlsFr2tj+onUiyyA0K9j24SlhLmkLYZNSlCmqGpttNSjMpBTrWp/ep9HeJz3OXTGG
	 ILSjTdotpDmMJm+vIWHoYTFznrGrxN1ngjqv+Q1zbtJUcuUFcnkYD0qojWHGL+ktW7
	 vl0fRIZmPoP8f2GetWbVDOqMzQdjSQ/45z+BdO0I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 96BD5F80553; Tue, 17 Oct 2023 13:29:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 92AB8F8025F;
	Tue, 17 Oct 2023 13:29:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D84FEF8025F; Tue, 17 Oct 2023 13:29:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 769E2F80236
	for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2023 13:29:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 769E2F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=M0Cmq2C+
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 43C456135F;
	Tue, 17 Oct 2023 11:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E0DC433C7;
	Tue, 17 Oct 2023 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697542156;
	bh=LP4csdsL40nCe4OI51VZDntZqUrXlSQ7yWdsMFKaLak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0Cmq2C+o4Ccul/EWW2mklmE9X/PrY0lNRXHgKvtY3w4oCgdpp8BFoffq17cNW2q4
	 /YosBj6Mku4+8YMfTAcfVGVPyGRkEhEaZGfnFdxmyZic8NU06T8oPaOEYAs4/O3P36
	 uQol5micnCXAOrPBNDNbscb1aN1kKtHuv1AiZqddeTk/GJECc6L0zop6tMWh4pofAq
	 0ossgeXpAJ/DPcA1zWayBKkKTk6TPIW1CMr/Osx6D2oyo8q2cK+6+L/LXv00xMt+SJ
	 Tfg0AoN6ua6akDRHgjClxdF0NNTFjeo3ejUbWV4G7ewHDoKyIFEQn6WkvcmKJMZtPF
	 jTR0SUq5q/qDA==
Date: Tue, 17 Oct 2023 12:29:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Beer <daniel.beer@igorinstitute.com>,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: tas5805m: Disallow undefined
 properties
Message-ID: <0498f609-357b-4242-b3c1-d53967f1faa8@sirena.org.uk>
References: <20231016155547.2973853-1-robh@kernel.org>
 <20231017-blinking-barricade-9e068a5fc602@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b2wBVIPRJdO8J3Zq"
Content-Disposition: inline
In-Reply-To: <20231017-blinking-barricade-9e068a5fc602@spud>
X-Cookie: Santa Claus is watching!
Message-ID-Hash: 5EJBXKRPOYSTVUWL3NJZEXSOF66FPSD2
X-Message-ID-Hash: 5EJBXKRPOYSTVUWL3NJZEXSOF66FPSD2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5EJBXKRPOYSTVUWL3NJZEXSOF66FPSD2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--b2wBVIPRJdO8J3Zq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 11:50:42AM +0100, Conor Dooley wrote:
> On Mon, Oct 16, 2023 at 10:55:47AM -0500, Rob Herring wrote:
> > Device specific bindings should not allow undefined properties. This is
> > accomplished in json-schema with 'additionalProperties: false'.
> >=20
> > Examples should be last in the schema, so move additionalProperties up
> > while we're here.
> >=20
> > Signed-off-by: Rob Herring <robh@kernel.org>

> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Rob, I don't have the original patch for this.  It looks like whatever
email troubles you were having are persisting - if there's anything else
you've sent me I'm just unawaere of it.=20

--b2wBVIPRJdO8J3Zq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUucAYACgkQJNaLcl1U
h9A31Af/bVFGDwltLpFkDhMtgvv5mBtHMksfRt66A8yyK173lHwQv671KtfOouGV
Me5R/4H5X7taXZ5i29SzDGlKwvKEo05OoXVWCD1WXgpSBXQQO/m+5Lpw3v39mzj+
VUmhmFhXnVPZypXscP7Mf7e+J2rLNA4HcTphoqF2Ohprk3otRwQ+7GH7dUsjBB8j
h2psO+rfr0IxAK90iFfgLp/3pJyIfubRHgHiNMz/AeiPiJF4NZLPPxz2U+hpgdh+
kcQ95YVWFT3c9RPxPXUrcqolaBbXkNxCm3ErwHEWVA024Z/Ldx1YmO8jwgtmmBA3
n9W3o73nz1xspcS/4beeKkcZ7fH3jA==
=vvnq
-----END PGP SIGNATURE-----

--b2wBVIPRJdO8J3Zq--
