Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DF4EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 13:10:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C32C682B;
	Wed, 21 Jun 2023 15:09:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C32C682B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687353014;
	bh=8rei6Srdj2hOeoUrA3FxQyYSVAkO4eKByya+vrCiMow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lYl+LsX/T1icKU7Pcmdv7zNdjU+OeGfSy/XQIW+QNVSrrvBBz0lwRonRYl4pqCKmu
	 nh5T4Wh2ik+0wr3qeIS/9uNbzSBVhQOq/idZTf32fh6+a6fqbVZFRWVwdTRAxoPRuH
	 IhqLPyfaG17ue2cR3z7icXNVK7JAQ9dK67n/xqJc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B497CF80093; Wed, 21 Jun 2023 15:08:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44848F80141;
	Wed, 21 Jun 2023 15:08:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06299F80141; Wed, 21 Jun 2023 15:08:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 69351F80093
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 15:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69351F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Jzdbg3X7
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 35F0C61480;
	Wed, 21 Jun 2023 13:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F99C433C8;
	Wed, 21 Jun 2023 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687352925;
	bh=8rei6Srdj2hOeoUrA3FxQyYSVAkO4eKByya+vrCiMow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jzdbg3X7R2R5aA3l8Bd5J468BcoyvZBbSNoW5z+bFd+uFHYr1hhHbrrbcXsJlunb6
	 RRtpi5CAMalVtBG9vvSqM6C5QpMzt7OdwQIcW2TO3CSc+L/uHJDuOaJqKvYwFhBd57
	 2SSve45pWiVdVg6dY8nlQNVJ9ktQDejU8ZmG5VqnOR5pOIIU99tEYhg9A8RncBiNmd
	 UsqW95s+2dzAa61gQ8bB0RFNUCnZNkvXKvi1YNf+X8FW/YRSxSgNZQn4Et8139Rn1l
	 rGoMll5XO4YOTdPbpbBdZSkcqEf7e9jCXwNlIyrcbOO/VeqQt4v1WalbRl4ud0xEAh
	 bwiFENJzWPQTg==
Date: Wed, 21 Jun 2023 14:08:40 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>, Shuah Khan <shuah@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration
 from 4 to 2 seconds
Message-ID: <33bea0d3-b8dd-4936-812e-392166df4437@sirena.org.uk>
References: <20230620220839.2215057-1-nfraprado@collabora.com>
 <20230620220839.2215057-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XuUu5UqlTitESjDI"
Content-Disposition: inline
In-Reply-To: <20230620220839.2215057-3-nfraprado@collabora.com>
X-Cookie: When among apes, one must play the ape.
Message-ID-Hash: LY4O5BLZI7WJ3Y5SFM73BSFLBES4QGMU
X-Message-ID-Hash: LY4O5BLZI7WJ3Y5SFM73BSFLBES4QGMU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LY4O5BLZI7WJ3Y5SFM73BSFLBES4QGMU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--XuUu5UqlTitESjDI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 06:08:26PM -0400, N=EDcolas F. R. A. Prado wrote:

> -	const int duration_s =3D 4, margin_ms =3D 100;
> +	const int duration_s =3D 2, margin_ms =3D 100;

This doesn't scale the margin with the duration which will affect the
sensitivity of the test to misclocking.  It should make it less
sensitive which is *probably* safer but at least worth noting.

We might also have issues with some of the lower sample rates, IIRC some
devices are constrained in ways that mean they want a minimum buffer
size which is harder to satisfy with very short playbacks and low sample
rates.

I don't know why Jaroslav picked the 4s number here.

--XuUu5UqlTitESjDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSS9lcACgkQJNaLcl1U
h9DvRQf/Sa8yVLTUhx/xI7Go5M1j3MnEnA2L8Kol2HP04viW/HKYX9nikxkUgxKI
30UMmR4G03BqyUEpOcDV2fxkvkeHCJXpvC9fRR16FWeTQbSFb/RNXMDxiP5tQa90
DG/qLbm2FEoOgPYARMmqwI/E1610i63eSnsj0toP87QQxGc4H8XRL1HH7u3/tl5D
BhFVvN2xaiZCnQROs1n4yDcslDNZLIdGR1yWUW9nx+e4dNIWOQ/AW4yluB3EFv+J
tGfFR5SPEsJNtIqVAtKb+NPBGYcEl52aUFRCbB30gWKSQIsq6gris+8EOTTjHs+x
L0tFO5FBQfrA9J3lK6eOwSQTx0Ob4A==
=yDSV
-----END PGP SIGNATURE-----

--XuUu5UqlTitESjDI--
