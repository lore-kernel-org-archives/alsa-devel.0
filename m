Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11998C3DA59
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:53:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFB05B71;
	Mon, 22 Jul 2024 12:53:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFB05B71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1721645625;
	bh=d/phvPCFH5b62HPy+3QDiw3vQq0Av/LO7MFoVObg1OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kUNrwZxrvKD92sRIqq0UvyXTXQiZzQZwYQtjDkAmJ1GhxQul0mM26sn4C2Y3zNdwz
	 oI8Ui0EZhdH8UzYRivH+UBt9NqpRvsWVC7gOqElhE87GsnC4HojdUK+PDDAxWrmzeb
	 KX7GydENdbsiJwvHrcGlwrNG7e75pk3q6CK3mvRw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5613CF805BB; Mon, 22 Jul 2024 12:53:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E20EDF805B6;
	Mon, 22 Jul 2024 12:53:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B552F801F5; Mon, 22 Jul 2024 12:52:59 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 20991F800C9
	for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2024 12:52:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20991F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IJ+ZojLF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 95A7A609E9;
	Mon, 22 Jul 2024 10:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8916BC116B1;
	Mon, 22 Jul 2024 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721645569;
	bh=d/phvPCFH5b62HPy+3QDiw3vQq0Av/LO7MFoVObg1OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJ+ZojLFM9Wj7orCKE8k7kcHLxHlKDc0UmBL6mlLiI1+nGrswWaYt4dlLn2NCnrF1
	 8OWQtO4pdoDt8x9Ula19MWuGDi/VhCmFklM4ceq/cybFABERPEEIYpPj/RfbmFsXPd
	 4mQNMffonA2NgGqzo2ejWetGC7SncY23MDq8cVuCXHU/nhpTq+AGgwmxabJxqmKEHw
	 PflzdO28df1xUtHspYtlb21s2IvsCv2MKcSyh1TCpRze0tJKnYY38ISnTpcduFPYWh
	 v/S1eRd4mXnsTHHU/CoQpK6r6JbcK9Wc9zUZ74A7bHNInugUMYhUV8EJGD/qtZfmuN
	 FiwFIZhe7GTMw==
Date: Mon, 22 Jul 2024 11:52:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Audu <jau@free.fr>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sti: add missing probe entry for player and reader
Message-ID: <d85590f2-88b3-4bc2-b7b8-9f96a5d5bb17@sirena.org.uk>
References: <20240721-sti-audio-fix-v1-1-a8b1ecf61cb4@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwcgTLsscWO31/aR"
Content-Disposition: inline
In-Reply-To: <20240721-sti-audio-fix-v1-1-a8b1ecf61cb4@free.fr>
X-Cookie: Everything you know is wrong!
Message-ID-Hash: H6OFAAXBMKUU4YXWNE6H3S3LQHQFFLVZ
X-Message-ID-Hash: H6OFAAXBMKUU4YXWNE6H3S3LQHQFFLVZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H6OFAAXBMKUU4YXWNE6H3S3LQHQFFLVZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--uwcgTLsscWO31/aR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 05:40:02PM +0200, Jerome Audu wrote:
> Restores the audio functionality that was broken
> since Linux version 6.6.y by adding the missing probe
> functions for the player and reader components.
>=20
> Fixes: 9f625f5e6cf9 ("ASoC: sti: merge DAI call back functions into ops")
> Signed-off-by: Jerome Audu <jau@free.fr>
> ---
> Specifically, the probe function in `sound/soc/sti/sti_uniperif.c:415` is=
 being replaced by another probe function located at `sound/soc/sti/sti_uni=
perif.c:453`, which should instead be derived from the player and reader co=
mponents. My patch correctly reinserts the missing probe entries, restoring=
 the intended functionality.

This should be in the changelog, your actual changelog doesn't describe
the actual change at all.

> The patch modifies the following files:
> - `sound/soc/sti/sti_uniperif.c`: Changes the visibility of `sti_uniperip=
h_dai_probe` to non-static.
> - `sound/soc/sti/uniperif.h`: Adds the declaration of `sti_uniperiph_dai_=
probe`.
> - `sound/soc/sti/uniperif_player.c`: Adds `probe` function to `uni_player=
_dai_ops`.
> - `sound/soc/sti/uniperif_reader.c`: Adds `probe` function to `uni_reader=
_dai_ops`.
>=20
> This ensures the correct `probe` functions are utilized, thus fixing the =
audio regression.=20

This detail isn't really needed, it just describes the content of the
patch.

--uwcgTLsscWO31/aR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaeOfsACgkQJNaLcl1U
h9C03Qf/QXpJLlhj+1SJvQdYxrSRwLJKrcGsmk/kgcE+JjBKDzZe2iW2nK6+fJgr
sxQtN1ytBBbvvsB2ZYRamU85xpsVdhQ6a10U110NYztC5JJ3HS/XPSuhVjVZk5zs
rH+k1mzi/Zu/hmo6Jbdhf+73wPXF3uW7s+0/Ov3Fm6agDoIzd6xwcTe6BcW044ak
o9c7ObJcKl0G2mdUQZ0RVbrQ/6eME01yqhUJoxPR6ArZ/HBMdKrmLO3lg5vSxzmq
zFxCZJvYa9I/Rug4s67JptLVW86TCQRGzO0gbFWDPfD0t71SjBBDYNTGLyEmvA1p
/Dgv9Is1wL6SjvhG17XKQ75DuGlZfg==
=o3Ai
-----END PGP SIGNATURE-----

--uwcgTLsscWO31/aR--
