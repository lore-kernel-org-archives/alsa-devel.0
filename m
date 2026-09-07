Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEF5C79F89
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:09:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8930E601F4;
	Mon,  7 Sep 2026 14:09:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8930E601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788782971;
	bh=biYw2wB0Py4pbHn2BhygOpvspdOcowmWtnaTlLrDGZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gOWCWfOz/0ToeMbSpPbaYk5ZBvrhbzmu9i+BqfKSR5WfFpmapJWd4bs+EmqkyVWhm
	 GUyEBuM+ARZvh+vY4Y+DB4vhKKhnBugfTgEE0OoLom9DkUqeGs7TST0e/LQAlvKvT7
	 Of4lXCA1ftNiwpkCuTV4g/8tXqHazf1PwEIbzYCM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D05ECF80601; Mon,  7 Sep 2026 14:08:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D049F80601;
	Mon,  7 Sep 2026 14:08:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A9EDF80571; Mon,  7 Sep 2026 14:08:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788782931;
	b=mTFDyQO/wWMtjc77ZTzX5W2Mm90wLFGGBbf5nIb+wl8LxOS6fuq8inr0FxoFVzO7CFtQ
	 7hX5cvZ3WiVdATXmp1obxbNQeyHCdqnOx1a9ABwhn3J8Nv48PgPavOJGUiLEvr65j4fqY
	 e6Qb7oJ5zohtFSNYRJcAm+SFqEBecMa0w+8FMPwmmrsRnxAhXnwDUDZcWVzOYKTyuLHPV
	 CfMwb0ahCIn3tQH/CAWoCv6U7td0znReMMwnOEjuTcEVMVojXe2tJT+SlAW4JQGKWvZKS
	 6O6fUe15PhG+Qi7LbeUoMm54RgTRvFprafpCNlOX2NHldx5Ic4eER6FBKnixEInMWIw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788782931;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=biYw2wB0Py4pbHn2BhygOpvspdOcowmWtnaTlLrDGZQ=;
	b=WsWGHB74GO0/LRMEAz/6fTCeppaZcGf4knW0fJLcC6orUifufG13QQTK0L1nCxTy6vuG
	 eM2HZ6mcjkheMRgWw1584ehajofM2ACHscRRZwptgiMQ2kSXvS317RQZ654DOO5eqnX6x
	 HvNaGMnVlccy914PU8cpPtY0/vYW2MaD9cufKEO5+oPPMy4Be/wvLiBIxy1vTczO0/KKZ
	 y1pkrlNnKFGLcSxLQHHpkIF6nT5+4LpAl7JBH1Lp7DLzP8u7qnnhXUhqoseHwovWI5Nxj
	 nG9achNgffYiDOiNxcuO0ng6Svo4IviOKF8/69PhjTcqW7EYOgs/2A/gxnwbFhYLLPQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aPE6Gp0S;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 93C91F800BD
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 14:08:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93C91F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aPE6Gp0S
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 54DC942D71;
	Mon,  7 Sep 2026 12:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040F21F00A3A;
	Mon,  7 Sep 2026 12:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788782927;
	bh=biYw2wB0Py4pbHn2BhygOpvspdOcowmWtnaTlLrDGZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aPE6Gp0SESAgXCgga7cyGEzkDzsxkx1R3I8AVPrNBq5EF4CnCbb63VYFmdtb9B4kQ
	 2AZPg3jwlw+64KMA0YfSZ0TXi0MGW4INyx5sKmLXmqmabCBZpRypX5sbivIGvvp34f
	 UMmbNFV+DqrOETi7C/oaRNoMeqDMauBxab6PG/6/DqBlqSo3pgy2VJFbFP4MthPQcM
	 V9M7OtJj0yLh1LkKnjEwRW3E55L9KO7t9VcpMvHmPcSaT+09NL3K8PkGg2mp06ABUh
	 jSA45ZJt0b6z7ws/5bScBODYwiXqvkF5iGx//tzsFTibKPAyoLcV2clShzapit1wKQ
	 53KMWJLVCbCzg==
Date: Mon, 7 Sep 2026 13:08:42 +0100
From: Mark Brown <broonie@kernel.org>
To: YLCHANG2 <neo.chang70@gmail.com>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v2 1/2] ASoC: codecs: nau8360: Set DAC path to bypass
 mode when DSP firmware load fails
Message-ID: <b74f633e-85f3-4ced-af78-82e664cb91ba@sirena.org.uk>
References: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
 <20260904060035.196399-2-YLCHANG2@nuvoton.com>
 <apsEO6K6Qo1ADH-y@sirena.co.uk>
 <a5a983de-44f2-45ed-9a71-0839f5349d46@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G9WZqs0xGJIBruP9"
Content-Disposition: inline
In-Reply-To: <a5a983de-44f2-45ed-9a71-0839f5349d46@gmail.com>
X-Cookie: Who's on first?
Message-ID-Hash: TJ25COBEKDAKH6AZP2FOBV7XKTSBPKO6
X-Message-ID-Hash: TJ25COBEKDAKH6AZP2FOBV7XKTSBPKO6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TJ25COBEKDAKH6AZP2FOBV7XKTSBPKO6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--G9WZqs0xGJIBruP9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2026 at 11:45:10AM +0800, YLCHANG2 wrote:

> Thank you for your review and suggestion.
> I will remove the register update (NAU8360_DAC_SEL_BYP) during firmware
> loading.
> Instead, I will add the following check in nau8360_dac_mux_put_enum() to
> warn the user and block the path switch
> if the DSP firmware is not ready:

That seems like a sensible approach.

--G9WZqs0xGJIBruP9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqeqUkACgkQJNaLcl1U
h9AfTwf/X356fqC0l1bdCY6UN7dCumPayT9K90eYSBlWUAHxLhL6AHuZJsYK4e/f
JLiRqT5iUe1yo3F0uHep04BV4ohQzK0pIfawAWKTN49sUninu+PqkKngtIPylHVg
/6cw9mgQxaTutRCNXfnqK+O+X8EeKej4ZGRXCocTZccFNZ6G+5kZNayUe4U2vuWg
14PUjKy/+9ibOG1anCId4vlz5fGxjBOsQpMGdpoEYczOsgU1N9DJxofoPikkkePV
l/CvQNoRNAmzP8H6Uecvgl/eGnXnixosIHRUMbowuzgyuTCh51fVqKZVLGq6yufm
kqjlpQRUGzLzDc8TC8eRvPW2ycjt2g==
=a+nT
-----END PGP SIGNATURE-----

--G9WZqs0xGJIBruP9--
