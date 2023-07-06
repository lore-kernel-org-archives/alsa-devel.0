Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6987EB64DC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jul 2023 12:19:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC1E274C;
	Thu,  6 Jul 2023 14:18:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC1E274C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688645976;
	bh=SQ/W9RMOyrQORdVtYany7w77017RM6VIUNpmJS+u0fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=m/Cra01s41hxl1yl9PF1Me68d+wN2M3sZKKaXBnJpo/vE1rrA7wWZo9hyw80kHkGa
	 ka+zi0d1Fh4Q5d4xqt5MeEFCcnSlael4dkol2wWstQvYP/yuQPtBOrbQeGlGgKNqMa
	 QnmiokUgXi3PuD0RXCYcvayLdU/uCiQNvf4DdAfs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4250FF8053B; Thu,  6 Jul 2023 14:18:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE7CAF80125;
	Thu,  6 Jul 2023 14:18:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B10ACF80125; Thu,  6 Jul 2023 14:18:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A5311F80093
	for <alsa-devel@alsa-project.org>; Thu,  6 Jul 2023 14:18:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5311F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=mbhR2YaU
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DCD3861923;
	Thu,  6 Jul 2023 12:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A0EC433C7;
	Thu,  6 Jul 2023 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688645886;
	bh=SQ/W9RMOyrQORdVtYany7w77017RM6VIUNpmJS+u0fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbhR2YaUrMzCYKgoN5vHkB02ikh2Rlp63t8ooNSFj4mB2ORnFCphy3WLCwZ/FjvTq
	 rYVKpcSG2/g2X0RHsS33xIuFoS24o4JIQkm2xEJnjWNSGFKOr8bbjGbuukfIBGlq81
	 nFwVBNwd2wpwuGZ92Uv+ypW4GthgFzflidpBQa+QExc6Olo1gAeKcqROU7Lm2plbPM
	 r1oIxRYqN1PYswNG7VWg12pB0l/KyUW9hIe2pjz9FLlueer2g08oPu6YbNCKtnSrhL
	 A986V09qLAAMeCc3fe1aEmd2oMNNCzMQXGM+OGL2qJ4z/vWnC6syUbrO6liEJJWx+o
	 wTwW7vAVpJEFA==
Date: Thu, 6 Jul 2023 13:18:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] regmap: REGMAP_SLIMBUS should select REGMAP
Message-ID: <18425cc3-9a4c-4269-aec0-3f821697bfd6@sirena.org.uk>
References: <cover.1688643442.git.geert@linux-m68k.org>
 <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dr+DpUY6Xq+EybR1"
Content-Disposition: inline
In-Reply-To: 
 <7519324a34015e1c046227269409fef688889f4f.1688643442.git.geert@linux-m68k.org>
X-Cookie: Being ugly isn't illegal.  Yet.
Message-ID-Hash: VSWFNINT5HFUIDO7DYEVVALNIIHO4BHN
X-Message-ID-Hash: VSWFNINT5HFUIDO7DYEVVALNIIHO4BHN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VSWFNINT5HFUIDO7DYEVVALNIIHO4BHN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--dr+DpUY6Xq+EybR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2023 at 01:42:03PM +0200, Geert Uytterhoeven wrote:

> Fix this by making REGMAP_SLIMBUS select REGMAP.

Why is this being done as a separate patch?

> Drop the selection of REGMAP by MFD_WCD934X, as this is not needed
> (now both REGMAP_SLIMBUS and REGMAP_IRQ select REGMAP).

This has always been redudnant, why is it mixed into this patch?

--dr+DpUY6Xq+EybR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSmsPcACgkQJNaLcl1U
h9BPOwf/ZD9cLVc9wr/gWaOiihgTAFnsuEKYyg5HanL/iuwCWpF0wJsIhTVwEFQf
GBSmNLlS3niisAbotm/TZsmx7+/xnQFTumeWg8EwQnjNX1Y4kSSckF8dRlqtCY+Q
KRqs5jLAhjy47O3ELQaXC/+y416fAhAl4ZQpMW9byQLiK1oOYH5Vrni5GpeJGPmM
G1YNi4K6aUNkODVhZwQO9T4rlp2asrc+rnhO2nR952qmPqbXBlF3fFHzG1Q/SOph
Xu2+5LOU/AS8zyO91VrqrP1vfWYbenHI3DnevBUpQ4eNR/vejyVn/d5Do93/t9HL
2JGJ4i8+Z8m8vvsz32Ky1iDozA54mg==
=qA7K
-----END PGP SIGNATURE-----

--dr+DpUY6Xq+EybR1--
