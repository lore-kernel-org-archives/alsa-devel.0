Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3A3C30653
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:45:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4C63DEC;
	Tue, 25 Jun 2024 13:45:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4C63DEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719315922;
	bh=gVkL9c1qfBeYSrlnBVVM7s6Gf6ME8REfQWEZVE3J36g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=o4sDYvkhcy6fbS/hUj5raL848p9je6DCSe0G8m5wJRUrkwriaN68YFfLZNQmwGlFI
	 1FjPJWYDLPankHVAm2gc1d5YPQVkMnwGZpvGHVS/oHbFKQOHLtweMCHjRyFhFy8ovt
	 klcSQxhtLO8WEwXcrO9irJ8yHTSG529Vd6mjLlGs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B40AF805AF; Tue, 25 Jun 2024 13:44:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D6B29F80495;
	Tue, 25 Jun 2024 13:44:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C256F80495; Tue, 25 Jun 2024 13:44:43 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D83C0F80154
	for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2024 13:44:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D83C0F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rtezupGb
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C7128CE175D;
	Tue, 25 Jun 2024 11:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2136C32786;
	Tue, 25 Jun 2024 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719315874;
	bh=gVkL9c1qfBeYSrlnBVVM7s6Gf6ME8REfQWEZVE3J36g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtezupGbbMIogz6TOnESvbM91E0jKmgNaz34mF8QyT/PNWUT5FpOUzmrlirtl83KT
	 sc346ad3sE1K+Th24x9kgnX5ADCB3X12vCqjBgzZBOlQpmD3sOkMuRhCw5cH8FRDFG
	 /iAkS6erqTecDkzYS5XAWASlrgYjb6+UXPwGSGvJbnyVVEwL6FMs8YoW6nznDPtqiv
	 pWagJm+JxcAJIROpw2WJt+qTdZz1WZwzFWy4ZM/cklgBq8jSV3EHahHhKQdCW4cEO/
	 1NrcwwB+BDHPF49vcL5+E/mDSwddVPWCuaYHkcj+VRmpb0H/NYa15GJY7z8+MGBtqs
	 fRcU7z1wLln5g==
Date: Tue, 25 Jun 2024 12:44:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com, yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com
Subject: Re: [PATCH v1 0/4] ASoC: codecs: ES8326: Solving headphone detection
 and
Message-ID: <1ff6696c-a3ef-42d8-b692-260c29961426@sirena.org.uk>
References: <20240625084107.3177-1-zhangyi@everest-semi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yh/mTefk2cvvOvsV"
Content-Disposition: inline
In-Reply-To: <20240625084107.3177-1-zhangyi@everest-semi.com>
X-Cookie: Results vary by individual.
Message-ID-Hash: MKRGPV5XL3JEROXSPEAFAKCSZ5TD7YNV
X-Message-ID-Hash: MKRGPV5XL3JEROXSPEAFAKCSZ5TD7YNV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MKRGPV5XL3JEROXSPEAFAKCSZ5TD7YNV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Yh/mTefk2cvvOvsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 04:41:03PM +0800, Zhang Yi wrote:
> We propose four patches to solve headphone detection and suspend issues.
> And there are several registers that should be read-only registers. So=20
> we create es8326_writeable_register, and set these registers to false.

Please don't resend the same set of patches with the same version
without tagging it as a resend, if there is a new version then please
change the version.

--Yh/mTefk2cvvOvsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ6rZ0ACgkQJNaLcl1U
h9AxPwf8DuL/W7dCOqqFw/05vscRUBEO5bN2FAL8H2/fBfV2/pNqPHpKhdH1BIbk
PMxv4HzolxNrwwHf8pUrqTL/jhSu+SdwEIpSTWiaVIC5AX+52xeaa54aygO9JwNV
gujCwP8pP8jaDczzEMA/BUlXs3Z9eZFce1lgunbpjQvGY/ezs++sB1Jux5576KRS
EC87XojQI71ZER3vT/NTsNdugKOqY5VRPXjcCsTY6DmEOxLOY6ogFIk0aKjHPLSw
a6ZZuTXyuWBj8pGicsLUVLS9PiJ3BfLJ4fDxpFC9ZkbJd8iOc7h9xNbjtn1H/MOO
Db8pgYbgAF8Ato/QAfPXhVG1tAxkcA==
=HisU
-----END PGP SIGNATURE-----

--Yh/mTefk2cvvOvsV--
