Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAFDC3DA4A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Aug 2024 13:57:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 683A25485;
	Mon,  5 Aug 2024 15:56:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 683A25485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722866228;
	bh=iGUTNdIJJvIFkpyGmePf5kaDeSVLBg5IovSkLKyC8t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oPLwQsw7ddTEyWV7SecbwNlfMFdivcM3RHXfPfV1cSWTdy/5N2lVMAyGuiw3R2sea
	 WNqXI1znZ8ComrGpWqzuB667mPqAd1n4xNz6T2ZYqX1Wok3I3tusOkRrMSEUQjQjOr
	 qwZtzGBXCbIS2ea22TXIfX/KgEVgRIfpKTiibNCo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E64AFF805AF; Mon,  5 Aug 2024 15:56:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E1E2F805C2;
	Mon,  5 Aug 2024 15:56:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 335C2F8057A; Mon,  5 Aug 2024 15:46:38 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AC2C3F800B0
	for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2024 15:45:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC2C3F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nEmvIRCx
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 177A2CE0AC8;
	Mon,  5 Aug 2024 12:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0211C32782;
	Mon,  5 Aug 2024 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722862589;
	bh=iGUTNdIJJvIFkpyGmePf5kaDeSVLBg5IovSkLKyC8t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEmvIRCxiABGzW2Z5iMSJa1yphXfsvZDuvb/yfmBVnTR/y8fo611rthFswuVkBV91
	 NTqofQ+qdYOr4LEpSPkPe8XQhTFy9v0zYKdjRVFNF0A1vMXDiRneH3oSxxwXnIw5G0
	 +GBOlvymJf0g93UqNRwMiNHtKFlejfHm+3vMfyFw0JDsCAzu5g4cskvdVJQ/0j6+sJ
	 QJjKGbzGQDArRyn81mR4rVTgI7fSwJ5Gh58oS8adCerMXTGn37K2EjZBbqH5SZW9ex
	 bAyj6nvSX9y7zjFtR+eoqm9GVNq0ncq9S7fLfJN8DHzQLkTfIRAlqlp7IejtVvU2hu
	 EYIRzb1SBnLCQ==
Date: Mon, 5 Aug 2024 13:56:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: remove bespoke trigger support
Message-ID: <4f85d952-7468-4b4f-9b33-d82474e7461e@sirena.org.uk>
References: <8734nrll6x.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jOkNWXXaIWPOgXx"
Content-Disposition: inline
In-Reply-To: <8734nrll6x.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Poland has gun control.
Message-ID-Hash: YV652GVRXJWE3TJPWP5ZR2OEO6I57F63
X-Message-ID-Hash: YV652GVRXJWE3TJPWP5ZR2OEO6I57F63
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YV652GVRXJWE3TJPWP5ZR2OEO6I57F63/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--9jOkNWXXaIWPOgXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 01:31:34AM +0000, Kuninori Morimoto wrote:
> Bespoke trigger support was added when Linux v3.5 by this patch.
>=20
> 	commit 07bf84aaf736781a283b1bd36eaa911453b14574
> 	("ASoC: dpcm: Add bespoke trigger()")
>=20
> test-component driver is using it, but this is because it indicates used
> function for debug/trace purpose. Except test-component driver, bespoke
> trigger has never been used over 10 years in upstream.

This doesn't apply against current code, please check and resend.

--9jOkNWXXaIWPOgXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmawy/kACgkQJNaLcl1U
h9Bv5wf/c/pZGKQSr/Q6SAYwo8VtRKtycP93g7mX02sbLaEb96lNy7cw26UVVGsC
oZDpcJMUztzip5dy1Hxq2LEQ3mJh88cEkZZEjr82aBLeKrB76bNqOlD3IBZmLkSw
ATUD47FmfcY5IKZ+p7A6Ne5MWFw+hrBvBXEPHqp37Oh+qONr9SQrr3Rbt9N5jxMe
ljVh24tlE+v0ORoJCP9WyGqwnfNBNuvaxHU98RqCZm0bJdw81ppqGRLGRdxWIeKn
1Hj/zeoJAJPRMwej3/4mU1QXHf5omBD08ohWv4m+ecX14AhNuoP5teVK4MNT98an
I7jd28e1w/FQYAhUindqfPv5KWRqgg==
=e82k
-----END PGP SIGNATURE-----

--9jOkNWXXaIWPOgXx--
