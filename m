Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89466C52D6F
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:14:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED26A826;
	Wed, 21 Aug 2024 15:14:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED26A826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724246083;
	bh=0IJdrwvZlOVrYjrZK0JjwnyefLlluWU7tnjU0UTDeug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=g6SoRDiVSyrkGt+Wbuw64n8kzrksk47OZ3bIFC7nfk5jLdpYaEbvBmYYzEwdkpTcg
	 xecTAOeMNG+l/UqHqgVi01QJwIly+CmgOfl0KYsJxkAK+Hr9tY4eg1gtwKHfw3A3+d
	 fA131LqQhBKq9ySTJMCXaXYL3uJ9u5/ZbXWXF4Zs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F8A9F805AE; Wed, 21 Aug 2024 15:14:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 72EA7F80579;
	Wed, 21 Aug 2024 15:14:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E217F80496; Wed, 21 Aug 2024 15:14:03 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C23DFF8025E
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2024 15:13:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C23DFF8025E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XIFCpH7I
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D5994A407DF;
	Wed, 21 Aug 2024 13:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB03C4AF0C;
	Wed, 21 Aug 2024 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724246037;
	bh=0IJdrwvZlOVrYjrZK0JjwnyefLlluWU7tnjU0UTDeug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIFCpH7I9CRnXW3bVGrRQpsQpbr5JXIYWvznJapureEfijN2QopV7IZd4t3kJ5yYD
	 YAk3bOa5i8o6MZgYm8jRy4Bh961mkvN5o3+lxNyth5q6Vo60bzcEWKevnsZLOzsBqc
	 VAQ5ECfZmy+mhrfv9TaJ/X+It+/y2BkMkMFKAIZHXlyFgTJ/79UzR8lojTu8pglgrV
	 aLrYN2mvaCtCmLPXKfdbS5jo1c4J4rvHCVAx/+Y+yoToqjfU5R9wcy7kgZW3mOcyPb
	 Vb2EuKtgI7nLmWA9ioHK5jSrEXLl5U93D98L2WQ54qqhG9qBumEXLsPlvp+qyy+d5I
	 HqeLzxJ2TrO2g==
Date: Wed, 21 Aug 2024 14:13:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 2/2] ASoC: soc-pcm: makes snd_soc_dpcm_can_be_xxx()
 local function
Message-ID: <110f01db-f5e2-46ff-a3cf-90e1b00d289a@sirena.org.uk>
References: <87le0qa9tc.wl-kuninori.morimoto.gx@renesas.com>
 <87ikvua9sf.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbDesKWLKWfOEQzB"
Content-Disposition: inline
In-Reply-To: <87ikvua9sf.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: You are false data.
Message-ID-Hash: GCVDXSEM3N74Z4A63MOQCKORBNNLGUW3
X-Message-ID-Hash: GCVDXSEM3N74Z4A63MOQCKORBNNLGUW3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GCVDXSEM3N74Z4A63MOQCKORBNNLGUW3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--wbDesKWLKWfOEQzB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2024 at 02:29:04AM +0000, Kuninori Morimoto wrote:
> No driver is calling snd_soc_dpcm_can_be_xxx() functions. We don't need
> to have EXPORT_SYMBOL_GPL() for them. Let's makes it static function.
> One note is that snd_soc_dpcm_fe_can_update() is not used in upstream.
> Use #if-endif and keep it for future support.

We should just delete the code if it's not needed, it can always be
re-added later.

--wbDesKWLKWfOEQzB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbF6BAACgkQJNaLcl1U
h9Cy7Qf8CfxEWM/Qf7lZcctJ4y69DA2nncgO3HPyIqJ2ggxs6qlyD+PuEi8b70up
d+zVz1LT8LbDTKKuRnR1fmUpD/F/znM2L/9NeTmPw/SwPs0Du6syxdPx36Bar4LD
K44OOITKQeyz1vRPjr/Pv/GGyYfVOUI0ewNMuNf28IeJlWqe+mScTRko5Hkrj4Ww
4eVk6PVB/Q6tS+I1K+kHtN6w/HT0QKZ8By4x7huFu96bq4aDHeRfGDkucbL2YZsp
pEQtS+tzCtBgyyGd/DXgIyt7kVoHuYZdwDoZuhyCAMFjwetG8vlwJx5fcRe6qVMt
tKGnTWwkwjSoN3fkzyGb8N2jzhycRA==
=584L
-----END PGP SIGNATURE-----

--wbDesKWLKWfOEQzB--
