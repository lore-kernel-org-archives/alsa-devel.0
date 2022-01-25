Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8AEC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jan 2022 10:26:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE137280D;
	Tue, 25 Jan 2022 11:25:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE137280D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643106368;
	bh=YerMbkc6dlBfEzftLB78yr0Bys2g6geU05DzpcgGsj8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gJDQwFY8Y80zmstTW72wHfwDz8IUBuvwVSxd+vQmeCCBFAIwg7BjLqbTEnPunAaQh
	 apNkGN+ZUfUnLkOV4WC9qxUDQ4Th37zRCrH8dsrtnZYh59/pIRY0NiclDDzHpC2S+J
	 78nBDq6XScDysd4E2uwG1oD7TUMnRWqdZ/7xXJS8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FDF2F804D1;
	Tue, 25 Jan 2022 11:22:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5104AF804D2; Tue, 25 Jan 2022 11:22:22 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04289F804C3
 for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2022 11:22:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04289F804C3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ap6R05pz"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF3361631;
 Tue, 25 Jan 2022 10:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532EDC340E0;
 Tue, 25 Jan 2022 10:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643106135;
 bh=YerMbkc6dlBfEzftLB78yr0Bys2g6geU05DzpcgGsj8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ap6R05pzhynxijnMFSvcFKPnA6pyHpu96dSMyF8tmgX505u9TjTeaJ4j6KcENlWdA
 TNVB8Tx3sWDKspGQTD+2stRIykbj3h8X9bdIIm1VWNYmpJIqs8X6kH/hTonCFN7n4q
 yC4+DtUQQnmIafTQjjANist0cTR+355iEoAavlCbQ7wcGAvdoaS1rzvXhKKHM/HVRm
 m8AytoReg6Q+xiIk/GfvbQlUdSL7HMb9O9tTKtXrj5v3V790D33BEIzm4J+U2jvhJd
 t4gVBqOtA4bClDnKmc1hnd3i6Q6d7sNFlw1DNRUClc0C1EQyVkqw4Vv2fFu9tUFtIK
 pgcOULKq4hQcA==
Date: Tue, 25 Jan 2022 10:22:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/5] ASoC: sh: rz-ssi: Drop calling rz_ssi_pio_recv()
 recursively
Message-ID: <Ye/PUmxc5NhMB1qL@sirena.org.uk>
References: <20220115012303.29651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220115012303.29651-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D9HilRlcR5U8gm1B"
Content-Disposition: inline
In-Reply-To: <20220115012303.29651-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Cookie: Absence makes the heart go wander.
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Pavel Machek <pavel@denx.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--D9HilRlcR5U8gm1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 15, 2022 at 01:22:59AM +0000, Lad Prabhakar wrote:
> Instead of recursively calling rz_ssi_pio_recv() use a loop instead
> to read the samples from RX fifo.

This doesn't apply against current code, please check and resend.

--D9HilRlcR5U8gm1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHvz1EACgkQJNaLcl1U
h9AuXAf+J482bfctfHGgzaSOcZn2LDDxwFGwOwLtquLzILu5bPTVG/quNGfYgtEU
HGqK6idi7rHuKvuUdwtoK0VySpDxWPuKZ91xtGSh/UYdweO4OpXBo/Yl6Fsel056
CMrksjPT+WyZ+Veo4gpfgUlAyhV+gbaklVKBdPq9wjBTZJHaUkQ4YiugUbEL77gl
Bmj9bty8bX3U81PkNwgFhZYMgDznwy1IphYe29R/twQdDYUrZ2kfptRv1fQdRXt7
EIsxu1wrAyMdqVeDbMEEzA65XJV7cEtziHslAZC4jnCbYXTAcrWH5eS6Qz+rFYII
nSEJKsZsmMUEHqi3jbXZclzF9jXwVQ==
=fdPr
-----END PGP SIGNATURE-----

--D9HilRlcR5U8gm1B--
