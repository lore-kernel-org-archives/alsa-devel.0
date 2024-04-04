Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFE8CD1284
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:03:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4232F2CAF;
	Thu,  4 Apr 2024 14:02:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4232F2CAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712232182;
	bh=kIGTYF5q2RwcCjP/3s9rY9dy93vicoQcmtJgFKZEB/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aBDSXaP26zJ0yGXZLUxNhkVLdEDN7C43mXGa4MuPw7zZPN1y+D1IBuCDqlLNEN9e7
	 wCmBCpT/8FAlYdnTc/FbsbHCH5QQKBQ3Z9uiJlvfMLuwBsxV+nh46zQlrcInxnQ138
	 sjgtGB4YhdmF91+SaViRBNHHHBIz9AcxtNHGznCw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8915F8057C; Thu,  4 Apr 2024 14:02:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 679FAF8016E;
	Thu,  4 Apr 2024 14:02:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D998F8020D; Thu,  4 Apr 2024 13:59:18 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7DEB4F80130
	for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2024 13:59:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DEB4F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GfwHTOxL
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 519D1CE3131;
	Thu,  4 Apr 2024 11:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8A9C433F1;
	Thu,  4 Apr 2024 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712231936;
	bh=kIGTYF5q2RwcCjP/3s9rY9dy93vicoQcmtJgFKZEB/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfwHTOxLtpvJXU4cjoqfRsRxbWtQe98G4d6msbdRDi9sJabMlQdaeAd11SyykyxQq
	 XwjEMYPtJIjVRquIVgZbGt4PoSOk7RGJH0wM3ZGZo3btFUwjEVxm3j2te+wdZxVRKM
	 B7zto/EllNMSDlECscm/8xiqfTax25+3UDkBDQdmUtQtJ7giDWwZF8lROQtVmYHOvn
	 KeuuixluoIDdsyxxmKhN4Bu22jlGbCwbjPrOGgbJYF45r02+Pb6vWWwcRXLl5sBD81
	 dK+6MVdTBNFUlVNzTmACBrv0zSwy7XaHZT6I9JGNlmX3KowjH2gaP5ZQvSPEJVzZOL
	 pSLKMOS05UdDw==
Date: Thu, 4 Apr 2024 12:58:51 +0100
From: Mark Brown <broonie@kernel.org>
To: derek.fang@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, jack.yu@realtek.com,
	shumingf@realtek.com, albertchen@realtek.com,
	nico_cui@realsil.com.cn
Subject: Re: [PATCH] ASoC: rt5645: Fix the electric noise due to the CBJ
 contacts floating
Message-ID: <a47bb219-4a47-41ca-9c11-d6b4d87403b5@sirena.org.uk>
References: <20240404035747.118064-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kgPI9+eUXISyaCX4"
Content-Disposition: inline
In-Reply-To: <20240404035747.118064-1-derek.fang@realtek.com>
X-Cookie: Buckle up!
Message-ID-Hash: YY26C7MBP3EUXTAYNZ6GR5POPCXGHMSR
X-Message-ID-Hash: YY26C7MBP3EUXTAYNZ6GR5POPCXGHMSR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YY26C7MBP3EUXTAYNZ6GR5POPCXGHMSR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--kgPI9+eUXISyaCX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2024 at 11:57:47AM +0800, derek.fang@realtek.com wrote:

> +	rt5645->gpiod_cbj_sleeve = devm_gpiod_get_optional(&i2c->dev, "cbj-sleeve",
> +							   GPIOD_OUT_LOW);
> +

Please also update the DT binding to document this new GPIO.

--kgPI9+eUXISyaCX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYOlfsACgkQJNaLcl1U
h9CKswf7B2HR4VEzB9GLzY4Fo1cPZVyZs23/74NxdfbGVqNvr7RiZNlT2taefB8M
1+LuEFJCfOBCN1jQ0YCnmUpiR963rwGx6motvE9mfhrCKLxdrSoUT3fzyJkJ3Qcu
XsU98W/oJLLtqnBLvRuhtKhQ4PpSr/J5M9WZGeCkhP/8MRBHubKbVUpW0SmR/Jo+
zs9QgxHtj0e1Q8ko4OkgKlmuydipy/1i4PPh8ERg1g+iakghdSWfq2mWrSHCR44Q
S1nT/3uSlkhaYMtJl68gAzWjR4Cu9yVq6m1kFHwl2gM7UE2p/CZWFIhBNqVTOyVz
49WBCAk680daC2DBLa0iJeYutOj9vw==
=o8SL
-----END PGP SIGNATURE-----

--kgPI9+eUXISyaCX4--
