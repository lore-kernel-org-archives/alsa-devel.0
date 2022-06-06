Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D972DC43334
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jun 2022 16:26:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86AB41A8F;
	Mon,  6 Jun 2022 18:25:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86AB41A8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654532784;
	bh=6C1ftIq2+/BRnNYkuG6cpMTzXy2fGebCcPyZI8FE7QY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gwjDCaFImcZZ7iFbvLNLUGze37Y7KJzfkTgEqBWIuC5+LEcIhpVnw0oy9Kmd9YX/r
	 LqkJWAp39eUgjwffpCskzP0a0xA5GEJXwQrwOVFZUB7q2fLaHQTty2aKnY4+JvUFBV
	 QAtBxOqug+0p+NHA2IbTfTCitg01YBWdK2Sb1WcU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20F21F8012A;
	Mon,  6 Jun 2022 18:25:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 348D8F801D8; Mon,  6 Jun 2022 18:25:33 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2A1AF80116
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2022 18:25:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2A1AF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dT9bzhjn"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 240CCCE1BEE;
 Mon,  6 Jun 2022 16:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF35C385A9;
 Mon,  6 Jun 2022 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654532724;
 bh=6C1ftIq2+/BRnNYkuG6cpMTzXy2fGebCcPyZI8FE7QY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dT9bzhjnCTxPZn6QGKfd2z5w3YR63nDpB85aUWVor/+qPkxj7euBfWwutI92IpNJo
 jYzF4WDXCDrYD42/9X7z4ZFjcxw2x+YiyMA1neI0cankclhKPfFFVnBOxx5eYyxEcQ
 Eriz84kRzcbOKMTUlqh9i9em2Ag5YuV0nWk45McC9Vqtd96giRayypcn71FLM1u27q
 qk4a8d/ufM6q4/TpojKDoPY1q9RKYaPppcufBW3ByirZNCd/3ib3VCwl+omCNQ/88A
 m5Kc3ljj7Cpg4unwcImz2B63DKlQxhrLyj2Wz6CKsDW7ULMNGjBaviiZjrmizqphct
 XlOSo+BFiGSfg==
Date: Mon, 6 Jun 2022 17:25:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 3/3] ASoC: wm8940: Mute also the speaker output
Message-ID: <Yp4qb5jaGYf5qnxt@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
 <20220606154441.20848-3-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vbR2GMX70upG8Py9"
Content-Disposition: inline
In-Reply-To: <20220606154441.20848-3-lukma@denx.de>
X-Cookie: Bedfellows make strange politicians.
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
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


--vbR2GMX70upG8Py9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 06, 2022 at 05:44:41PM +0200, Lukasz Majewski wrote:

> Without this change the BTL speaker produces some
> "distortion" noise when test program
> (speaker-test -t waw) is ended with ctrl+c.

> As our design uses speaker outputs to drive BTL speaker,
> it was necessary to also mute the speaker via the codec
> internal WM8940_SPKVOL register with setting
> WM8940_SPKMUTE bit.

This will not interact well with both the user visible control of the
speaker volume via the Speaker Playback Volume control and the analog
bypass paths that the device has - it'll change the state of the control
without generating any events, and cut off any bypassed audio that's
mixed in.

You can probably achieve a similar effect by making the control an
_AUTODISABLE one which will allow the core to mute the control when it's
not being used in a way that's not visible to userspace.

--vbR2GMX70upG8Py9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeKm4ACgkQJNaLcl1U
h9CkDwgAhJX7tOT+yGFzvFc73mwr1jkFi+2f+NgQ5Vz+AFyNn8C7GgMClt6+gXhI
GuqETDHalU67stNb4ke1NTVdlKM1qI5rdGl20VfY/mFCb+itbR/fE/vxwMHIQSCy
JY4dpCv2Z3yDKLSjSarJiTWV6dxaJ01tJYp3z3+i2Za9Di4v6K3j2wRayIZcczSt
sxPdAt/4AL265LDctA6PmI2VCE2wjo3l4YgfInO1bGDpH5gjnZFMdJo3cKHD/Vrs
JLRuB6A1guLo1oURYQOKLrvpMPRkKoF/XaoNlCA/Tlsd/p0l3Up8sk6zBY8Gr+f0
uNDYRwQnGcy/KqQT+B6Ytqa2i7pMqw==
=2p+e
-----END PGP SIGNATURE-----

--vbR2GMX70upG8Py9--
