Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D757CC55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:34:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6BCB60219;
	Wed,  5 Aug 2026 14:34:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6BCB60219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785933263;
	bh=IOXF4iwM91kjyEy6yz5RlBIB1d3t0dHZ88LOzXTrmi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NS+DXi+8pAcg050LALmByHMHrsz/JAmJ21jDsgjaN7G5lDCcBIQYL+wvwhzimcVVt
	 Tg9/sWxrs6WXj21F28tZENKRuY/d5oM3Hv6dI6+BBNM8kZ+dhUpwMC++gbj3P/4tgS
	 gcQfr4wSKx+NLHSq1FT5FTAC5v+lEBmGtl8XBd70=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C080EF80601; Wed,  5 Aug 2026 14:33:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0BB0F805F9;
	Wed,  5 Aug 2026 14:33:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D9E5F8027B; Wed,  5 Aug 2026 14:33:43 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785933222;
	b=P75c9YVg15NIjBar/5477WMIFpCFq++eBb8PcG0JUFjLvJh2YIBd04DcEgi+lHCVKDiu
	 L9oA4JHxtZh4bazLVhXHQQTkIHr36nJkMqJ6/hCqXNRRA0+QSdMqWHajmbi8QOIeaUjFW
	 t4HFCoI8EWZv0xLDZ3vitfuw6/PnnWuH1kN4P8hu2EC5qRNRuzTe/hnq4xl3WdxxYcBaO
	 D3qBwY+xHIc8nWz4ZgHfXT37DOnuWHc09GWyPv+pQxuCnGh/ApyEyJFd8R2pnjgX3slCU
	 /ZPr8hdZCv53E9bScwNloDJb6kyo7tN0qCW232NQY+8XJZ/bK2J9UZDoGmT1BKeEeTA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785933222;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=IOXF4iwM91kjyEy6yz5RlBIB1d3t0dHZ88LOzXTrmi8=;
	b=T376KP4kmzsGavfbjviFaou0YbEeOMJoO8WMy4GJHi9Jgs22MSL7Hf5Re34qJSWX1dDv
	 i4eLl0YkR9dEFefWLMN6PLBe5GVA5n0PknVH16kM++VYNVl9RM7Wgqsu6p2KnVfnuTQxM
	 CBj0zm2vheK0/VRHW0lLyytb81Foi7RRbI/x+LG3GOSn2bHuyCY9ukvpBZBd/T19/rWlT
	 +sYOkqAXJq55YPC1crdXSWGd79Q1YcDRAVfA8sED3IobggLKDHkCNHc0yFh5NwA9xyqS9
	 DMq+bWakTLPWX1lw2tIlkyftamI+HiQOmHeT+Teqgo0cEeVEPyZFOrISOGiNhF0IS4Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lQ9lZ2mg;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B6ABF800C1
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 14:33:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B6ABF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lQ9lZ2mg
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B42C241296;
	Wed,  5 Aug 2026 12:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B611F000E9;
	Wed,  5 Aug 2026 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785933217;
	bh=Qw41i8oMVAtT9zZZhqei2R3Y11YzA5K4okzr4XSsA0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lQ9lZ2mg72obnYpA//eFBR7gYDrdbF5KJkuJ3g64sBnoldXxErvEZ4sUKkgVxGLZe
	 4YbhVfhN1x5S91q92JFbYdrMIwWptZV31nc/oNoLg1eGP8gA6d6qhXL+ZTbuXJUFYJ
	 kSPboQYZED+bcDea+uPD0tlviFwbcrGuUV/vIroX01HV/VF+p1BFcSWjQlEz0r8zs0
	 mTta2WU+d99cPITCYdCwSTwwl6KFMLfqwSCgTiyR2IAnyHkl1lAsVzoIogA4/jldtw
	 4guCT0EdcKZ2hT+NWcEMhlmI6laCYE5JLWg3rEJaysigUyH7npDCldylSlv8sV31R8
	 3Iyrc2TcsVLzw==
Date: Wed, 5 Aug 2026 13:33:32 +0100
From: Mark Brown <broonie@kernel.org>
To: YLCHANG2 <neo.chang70@gmail.com>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v7 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <b59b4f33-d939-47da-abbd-04950a9909f6@sirena.org.uk>
References: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
 <20260804032951.1069901-3-YLCHANG2@nuvoton.com>
 <479efa04-2c02-4b5d-8fdd-e3d4c6e49c4f@sirena.org.uk>
 <7691eac8-5798-c1b5-5ffd-19c780b69a3f@gmail.com>
 <fe60dbe2-0626-4d52-8be3-62445a35ddaf@sirena.org.uk>
 <79bc356b-e727-7e40-9faa-e622c9a24ee9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="83eftdZLdGcHI6SR"
Content-Disposition: inline
In-Reply-To: <79bc356b-e727-7e40-9faa-e622c9a24ee9@gmail.com>
X-Cookie: Stop ahead.
Message-ID-Hash: AGD3OTLXXXZWPYRZKRBBY2OOFQE3FV2X
X-Message-ID-Hash: AGD3OTLXXXZWPYRZKRBBY2OOFQE3FV2X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AGD3OTLXXXZWPYRZKRBBY2OOFQE3FV2X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--83eftdZLdGcHI6SR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 05, 2026 at 07:34:28PM +0800, YLCHANG2 wrote:
> On 8/5/26 18:30, Mark Brown wrote:
> > On Wed, Aug 05, 2026 at 05:03:01PM +0800, YLCHANG2 wrote:

> > > Does this mean we should avoid configuring them via the machine driver
> > > entirely? If so, what is the preferred way to handle clock fallback when
> > > playback stops or MCLK is absent
> > > (e.g., via PCM shutdown hooks or DAPM events)?

> > What do you mean by clock fallbacks here?  Presumably there's some clock
> > still running, if that's the only one running it's reasonable for the
> > device to switch over to it.

> By 'clock fallback', I mean switching the clock source back to the internal
> clock when the MCLK stops, in order to keep the DSP alive.

The driver should be able to just figure out to do that based on the
current input clocks it's got I'd have thought.

--83eftdZLdGcHI6SR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpzLZwACgkQJNaLcl1U
h9A8TQf/ZxGJNDh8TMhO+OoEeP94hIURXmaTWJx3Fm3Ruxd43yvpp4234XhYjd4B
eiY8Nchl3+x8NhfmJvB5xAfjCUVimDmYMHeFqUhDygNTMe3S7WbAtZ3QNi1E7aUh
Dt8m5uaEEYZM0cJjWKpRJLfnRopLKfbTcjSR1KYvqRMlJOEeygCMvY9H2k5b0KoF
NSEFP7RCmPlvUB69FChVnv7B5YoaTmCJPcnEWdaGqwFKyav5jdb+J6i2+pfF0Nvj
k93JBgaX1qbDjOjXUsV9Gq25K0M2RxWCeAT/tYtnRF+NfzDH/pOg8KDRK2ka2a/O
11V9Hj10/lsdtxUlEKo3w3PPAXLCSQ==
=OiHI
-----END PGP SIGNATURE-----

--83eftdZLdGcHI6SR--
