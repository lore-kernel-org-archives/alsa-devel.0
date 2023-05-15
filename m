Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA82DC7EE22
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 10:52:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B48591E3;
	Mon, 15 May 2023 12:51:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B48591E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684147953;
	bh=io4J5rFtWRubjfwy7aiwD5CIoNUnGdBdd48t4O4XGbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fZ09z6+nl19fyEzmQK6EVDVEmowZzJ5b2V7vhP72r52aDFc+4Aopguu9KIhMiSpHe
	 pm81Aq7jS/0hvj00Xzarsw0YqnLRsSoLozfCgohkj2+MELDhkn3Ie+aSiRjZrQbPw9
	 fSX+ApBMyLfEWQ9yQcoWRjzjtI1UQT5GWFl6aGVw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3D9FF80544; Mon, 15 May 2023 12:51:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19254F80272;
	Mon, 15 May 2023 12:51:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41700F80272; Mon, 15 May 2023 12:51:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 873AFF8016D
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 12:51:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 873AFF8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lPhi5hYE
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5129C61448;
	Mon, 15 May 2023 10:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB75C4339B;
	Mon, 15 May 2023 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684147868;
	bh=io4J5rFtWRubjfwy7aiwD5CIoNUnGdBdd48t4O4XGbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPhi5hYEqrh2Bq2YZS6bCRTjHMGCiqPxcEGfOH/RW32uvF2vxqB/EWwBq7cBibMTM
	 1C3BzSbQJH9K2Ovo9G14Nk4ytYtz0/V+2BYs5ahZHB4fldSqWYXk3jcxiGXwAZ2zgD
	 sDqlgOzO7s2wvMiH2vOegNgHeYkg2V/dgJaxOWe9b+OPYBF8JDUNto8AwztpSgqdmJ
	 JvkBWag0E+qGBTVl+l2/XACqvOfPGBp55tGqdaGPw/QV++kA+hNbBCCrh1uTevdBG+
	 7IZmKxGE7EU2H8jQ78uUYiz0FSPGDEl8l/NdyM3aTelGqsrQ7Xz57awJGIJOkgMoGn
	 EM5Xec3sGxmmA==
Date: Mon, 15 May 2023 19:51:05 +0900
From: Mark Brown <broonie@kernel.org>
To: Walker Chen <walker.chen@starfivetech.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] ASoC: starfive: Add JH7110 TDM driver
Message-ID: <ZGIOmWyxPGOuWHx+@finisterre.sirena.org.uk>
References: <20230511091549.28003-1-walker.chen@starfivetech.com>
 <20230511091549.28003-3-walker.chen@starfivetech.com>
 <21bc5b06-3d3e-5a30-a90d-ea9f7abc6575@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nLJs/sEpOhNQJzse"
Content-Disposition: inline
In-Reply-To: <21bc5b06-3d3e-5a30-a90d-ea9f7abc6575@starfivetech.com>
X-Cookie: Avoid contact with eyes.
Message-ID-Hash: FPN2TTNY33YMBF3LEWAXHDWN2FNMEJKD
X-Message-ID-Hash: FPN2TTNY33YMBF3LEWAXHDWN2FNMEJKD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FPN2TTNY33YMBF3LEWAXHDWN2FNMEJKD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--nLJs/sEpOhNQJzse
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 04:29:07PM +0800, Walker Chen wrote:

> I have submitted new version of patch for TDM driver. Could you please he=
lp to review and give your comments?=20

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--nLJs/sEpOhNQJzse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRiDpgACgkQJNaLcl1U
h9CHJgf8DPHBxTaAmn9FNyXgqSV4aT0FqSJQ2RK6Jgls0b5SpIQuIRWFyk+OHUiw
PlCg9J1Ohg+YDGsgvrzwqbvU0VcUmxl1IJjEcT4o2di/bm70vkqv5L/Kfm1Vfu35
SBMzYSScyEW2tk/7A1VJK4ngJssreMyJgu0O1rePTl+fkwxJaFiEnMQCVvcltvfA
H5lQp1qhqS2zz2jpBbjQJFu6vlvvDIscznZ4ItCfHPGaazC3rO9qbpLSz9jdk1aX
36mhrJEWN2Q0YEZatiFIb5B2ItoUCW3gj+QLcfaf8dN6gwGDPk+zF2hFbyE0fweh
k/dF9R3SXQCMhuxtL9ipJ9rVNjD5xQ==
=WDUc
-----END PGP SIGNATURE-----

--nLJs/sEpOhNQJzse--
