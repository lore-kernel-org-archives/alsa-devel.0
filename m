Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE811061B04
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:39:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 825C360199;
	Mon, 30 Mar 2026 16:39:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 825C360199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774881591;
	bh=zuNqdI63WU+uP39XEYJ5Wz1sL+kNweFLUbuSzdbd60U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=po8H5nvDz/lr8biw794BQC0hF+IpBQvcxFDa3vMxX4faY3NOkNX65L0pgzCppySZA
	 EaANyM7ZaXqpIDBEpOfVI9Bh1DPNtA52mydBc0wjb0sHH/IRFCmU74kEYwnCcrZAs5
	 DD48BMQr9bW3RclRdfPCx8Zgap0qcAoKZvGLlFBI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B23B9F805E9; Mon, 30 Mar 2026 16:39:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11024F805F3;
	Mon, 30 Mar 2026 16:39:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1285F8052D; Mon, 30 Mar 2026 16:39:11 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 71F4BF80087
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 16:39:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71F4BF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JMAQ5L4b
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D672600AE;
	Mon, 30 Mar 2026 14:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28921C4CEF7;
	Mon, 30 Mar 2026 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881546;
	bh=zuNqdI63WU+uP39XEYJ5Wz1sL+kNweFLUbuSzdbd60U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMAQ5L4bFtajrDYViOk5IkNZNAzcyH4ohFlQYLsCUaIvoXUA68pu8r/rXUeoA6Hez
	 uIAEKPGV9ry3Ce5U1tuex6YQnmA9TNxFmQHAkKxuAySCyWIUJYQRz4mUDjO4zAVL+h
	 7IEB2GikTaAq+gXGxVc2GKm6hHxaoxsHwp8v8yVeT9tRDKVqhAXtBaZSFiDZR9le3y
	 Lepqazc0otZNxqwIT37E9W3EfT9zddR9jXY3tdP7uMlKHktvZntTI9wIzTINwuViJE
	 WPIcoSLGbZZeh7yr8Mn1ifgY7FchIWJugmrbV0ztTAMit8T07tVM7SI+/6p7iZTgxE
	 n9YAsHm4Q/uaQ==
Date: Mon, 30 Mar 2026 15:39:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Syed Saba Kareem <syed.sabakareem@amd.com>, alsa-devel@alsa-project.org,
	Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	"open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: ps: fix the pcm device numbering for acp pdm
 dmic
Message-ID: <3cd20e58-e204-422b-96bd-465c9e3855a9@sirena.org.uk>
References: <20260330094642.3088923-1-syed.sabakareem@amd.com>
 <510b78db-d04d-4283-9ad7-42c0420e1db3@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/UCji7vj6W5B1FOL"
Content-Disposition: inline
In-Reply-To: <510b78db-d04d-4283-9ad7-42c0420e1db3@amd.com>
X-Cookie: HUGH BEAUMONT died in 1982!!
Message-ID-Hash: RCOMREDN3DWHK4WSC5KJ3YLEUOCBU7E3
X-Message-ID-Hash: RCOMREDN3DWHK4WSC5KJ3YLEUOCBU7E3
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RCOMREDN3DWHK4WSC5KJ3YLEUOCBU7E3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--/UCji7vj6W5B1FOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2026 at 09:15:53AM -0500, Mario Limonciello wrote:
> On 3/30/26 04:46, Syed Saba Kareem wrote:

> > Fixed PCM device numbering is required for acp pdm dmic pcm device
> > to have a common UCM changes.
> > Set the 'use_dai_pcm_id' flag true in acp pdm dma driver for acp 6.3
> > platform. To fix the pcm device numbering based on dai_link->id.

> > Signed-off-by: Syed Saba Kareem <syed.sabakareem@amd.com>

> I suspect we want a stable tag on this too.  Maybe Mark can add when
> committing.

It also doesn't have a Fixes:, and also doesn't apply to for-7.0 so if
you want it for stable I'd suggest rebasing and adding an appropriate
Fixes: tag.

--/UCji7vj6W5B1FOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnKiwQACgkQJNaLcl1U
h9DT7Af+M/L2Mbhlr5MO2ncCnG/FuDSl27c8q+/v2RNj0g7zbQ2rwLJ6AtHSnefY
fuRLNNLuWNLohybpHR76KNsNhbtDl/TOo5BxkHGYeCI66zvs2UG2WUJS6Pf/cKpH
KQbSEljDglTdfpzTGXZIO6NFjhx8Uvd+b4ESuqpF4xJRBoIknEqC4/sLnuFPqqMb
0CFFg2A0IQCu0ogObEtOozsseHp2CgLB9BCBv7C9/NCGFxkuivI2eK3IWYnfOZcr
2tQ/9e5l7FQ1fmnBUrNuIG/JcS3dstH6vaIZYJ1HHNYZxklwz0GbE6xY+4G5p3/F
OGopQ4YYk/wjFtygG7uJkKmXv7ikoQ==
=YlcV
-----END PGP SIGNATURE-----

--/UCji7vj6W5B1FOL--
