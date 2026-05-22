Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40557CD5BC0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 07:53:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F6006021B;
	Mon, 25 May 2026 09:53:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F6006021B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779695633;
	bh=UIknwACMAxgEunNRtV3bAT7TZOpJMLTTt8PlxuNbck0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fTjWajXOGO/2bMzbZgZAMN4J/3Nu5KsIKLJhYPN2f7kZm/wOEy6pzlUcBy4B50FGn
	 CgnqQ/TsScrd26476DrD6tGYGIQ3DBjz75MuX7RzTKElyNHkKydA7p0q5GD/4zST0G
	 57t+xtFcWmuSY+r/qJ9sJtfW3k8p5UGaBYqL1tyc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42C32F805F6; Mon, 25 May 2026 09:53:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 01E15F805EF;
	Mon, 25 May 2026 09:53:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A08BF80557; Mon, 25 May 2026 09:53:08 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5523F8001F
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 09:53:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5523F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nAjIxpFn
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 721634391B;
	Fri, 22 May 2026 12:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839971F00A3D;
	Fri, 22 May 2026 12:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451483;
	bh=HCPwTQq0tQXvSVvR2aTbISaAotAZrWdg6HAfI2wlJw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nAjIxpFnS1ea26kQoxmuN3K5zC+LfHMJW5WsuEFMyp7KNpGgZ6SpFJwaXvd2Tm7DM
	 0duzwd7iX4VU11gJoETf0H1N8ObLOppwQjBuZUTfmx68KddZV2Lz93QqYLIai+7Wcx
	 gs+uOhrI9AOt9MqUv/zGkrvi3hjt4EkoWWSGUZZsRDukNqOzFsEbHO44UAID5kEJ7D
	 sOaHTRxCY4JjJ4CTaeOOm1HNB8+neO6Dx7fyXqgKd3BgK2ewbo5VOXp/4tVXZAWcAK
	 77rZ/7eonI/e58dnmCt+p0Cf5l6v1THafdmY8dAV2f6wEpc96myviYKek1lMf9IKlY
	 pNRBxBa4R1Vlw==
Date: Fri, 22 May 2026 13:04:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Joakim Andersson Lee <joakim@helsingborgslabbet.com>
Cc: hasunpark@gmail.com, alsa-devel@alsa-project.org
Subject: Re: ASUS TUF Gaming A14 =?utf-8?Q?=28FA401?=
 =?utf-8?B?RUEpIOKAlA==?= could you help add an ACP70 SoundWire quirk?
Message-ID: <9c7b3941-bd1d-47e7-8a55-6c2c6a398413@sirena.org.uk>
References: 
 <CAHab4-0EBRkKVVv0zvKVHqCbSCsjvr1aE1m8bdi-cAvSareHig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J3/oV5/fxi344jGR"
Content-Disposition: inline
In-Reply-To: 
 <CAHab4-0EBRkKVVv0zvKVHqCbSCsjvr1aE1m8bdi-cAvSareHig@mail.gmail.com>
X-Cookie: Celebrity voices impersonated.
Message-ID-Hash: 43CNXUMIOQ6NKPX2AKRAJUE4H675LNOH
X-Message-ID-Hash: 43CNXUMIOQ6NKPX2AKRAJUE4H675LNOH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/43CNXUMIOQ6NKPX2AKRAJUE4H675LNOH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--J3/oV5/fxi344jGR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 08:41:46AM +0200, Joakim Andersson Lee wrote:

> I hope you don't mind me reaching out directly =E2=80=94 I was wondering =
if you might
> be able to help me with something.

I'd suggest contacting the AMD maintainers as well/instead.

> My laptop seems to use the same ACP70 + TAS2783 setup. Its DMI is:
>=20
>     board_vendor =3D "ASUSTeK COMPUTER INC."
>     product_name =3D "TUF Gaming A14 FA401EA"
>     board_name   =3D "FA401EA"
>=20
> From what I can tell, it might just need an entry in soc_sdw_quirk_table[]
> (sound/soc/amd/acp/acp-sdw-legacy-mach.c), mirroring the HN7306EA one:
>=20
>     {
>         .callback =3D soc_sdw_quirk_cb,
>         .matches =3D {
>             DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
>             DMI_MATCH(DMI_PRODUCT_NAME, "FA401EA"),
>         },
>         .driver_data =3D (void *)(ASOC_SDW_ACP_DMIC),
>     },

> For what it's worth, the speakers do work out of the box on SteamOS on th=
is
> exact laptop (only HDMI-out is broken there), so the hardware seems fine =
=E2=80=94 it
> just looks like mainline is missing the FA401EA entry.

> I'd be really glad to help however I can =E2=80=94 I'm very happy to test=
 patches and
> send over dmesg, the SoundWire enumeration, or anything else useful from =
the
> actual hardware. Just let me know what would be most helpful.

The above sounds entirely plausible, though I've no direct knowledge of
this hardware (and never worked directly with Soundwire stuff at all).
Did you try it, you said you were OK testing patches?

--J3/oV5/fxi344jGR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoQRlcACgkQJNaLcl1U
h9Bw+wgAhfIrAcSIEfAaEp1iBZGB6aryLcBnkbhg2uXyGggJMwpPgCnTlvPdvKqW
PZh3ol+O8RehhLJm3mB0VQbPWGTUFUqDAWggH5c8RbiVDLB7wXwevvyIWS2EKsrV
X+iD4lRo/g+qCVuHqI+L4FH9N/CpEJleeB2F3d0OlVuPcOHZy7rGDZJL1WqRMYxt
soMXMqrG4H8z7rNzJy1OZbs5arVPp/8v7Ufe6fkmvlG15PiMMAXxbsPAEfedvsRF
gr6H/ZQrs37CzjIzFxMR1AeQP9ls/wwtj6ldALvJBUgD+k1w4MFBYIm7/gQE3gEn
9tMPrkYeemzimSjE8maj+PjBLRHV/A==
=z+N7
-----END PGP SIGNATURE-----

--J3/oV5/fxi344jGR--
