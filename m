Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F638C4345F
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Apr 2024 23:54:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ED1D10BE;
	Tue, 16 Apr 2024 01:54:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ED1D10BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713225268;
	bh=orUlYHyjE+Fsuyczn7ttXZtthS+NFhge/WbdK12NWag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZvvgKYjihdxBomLMkeCHfENdIkR+Z0Jvcu9iyLJ4ES+l+Sbh0oiTlSXoJVnjnP0Xt
	 SoJPem4wclJ0lM50pv532vksgJJ8WyKQrC7TKUTqjFUCGfjFLRV7gBJN2GsFpNLjW+
	 mh56AtXx0B+F5LfWPwS8R6y3PzzY0Uau5tFtqHis=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 115D0F8058C; Tue, 16 Apr 2024 01:54:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 412D8F805A9;
	Tue, 16 Apr 2024 01:53:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7116DF8025A; Tue, 16 Apr 2024 01:46:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D3F32F80124
	for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2024 01:44:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3F32F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XoZ82dAY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0444F60EB3;
	Mon, 15 Apr 2024 23:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D06C113CC;
	Mon, 15 Apr 2024 23:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224685;
	bh=orUlYHyjE+Fsuyczn7ttXZtthS+NFhge/WbdK12NWag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoZ82dAYgkQuTlUWyFmhMpPLLEbDY8ZT2GYuOwWC4m6+rOiMMze6OXeot0z1OTGXg
	 srvdAb5GEaxr+PRvT/llu7pV5cZ7M9mfRj8nbWeDsi4NDSbtwcnTfeIfKjWltil10t
	 t+m48biEH4eoDfHqGm1D6+toccRtDBfRKhyIri+XgOUtYZkpEy4hdiekIPcLxWje73
	 pXGSgzlH+h+IW3aQa1ZqmUmHDBPLaIY4l1Eexjc6GmXfe15jtMng8WNoJM0PkfUikL
	 Fw+ls+axMZyHtMftXmvOJo3Cgjf6UOepSv2/WhoYJPlkEgDJ5mAB5lQmzrOcU9ADsI
	 75J7rjZ+K1sCw==
Date: Tue, 16 Apr 2024 08:44:43 +0900
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: =?utf-8?B?IkFtYWRldXN6IFPFgmF3acWEc2tpIg==?=
 <amadeuszx.slawinski@linux.intel.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v2.5] ASoC: Replace dpcm_playback/capture to
 playback/capture_assertion
Message-ID: <Zh276/YWtIyzz5Vx@finisterre.sirena.org.uk>
References: <87msq2kjvo.wl-kuninori.morimoto.gx@renesas.com>
 <87wmozcy3l.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AZ1b8d0NtEewcE63"
Content-Disposition: inline
In-Reply-To: <87wmozcy3l.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: You might have mail.
Message-ID-Hash: TSLFBAUP5VSBZMQSWBJM4CQZA4Z2ET43
X-Message-ID-Hash: TSLFBAUP5VSBZMQSWBJM4CQZA4Z2ET43
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TSLFBAUP5VSBZMQSWBJM4CQZA4Z2ET43/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--AZ1b8d0NtEewcE63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2024 at 11:40:14PM +0000, Kuninori Morimoto wrote:

> I would like to fixup my comment above.
> Actually, I have no objection about current [BitField style].
> If there is no special opinion/objection about this, I will post
> [BitField style] in v3 patch-set with assertion flag
> (= dpcm_xxx, and xxx_only compatible).
> Switching to [Flag style] can be next topic/patch-set.

> I will wait comment mail until end of this week.
> If there was no comment, I will post v3 patch then.

I don't have super strong opinions either way on the style here.

--AZ1b8d0NtEewcE63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYdu+oACgkQJNaLcl1U
h9Dd3gf+M98lggu5EL7bQkly3Pevn/cRZAWgEYi3vmk47nKTDFv1U2AtJMicce5q
szfXegXehMxA6loYpl1xhBEYySEa8cWbnRJuxNyiuScxAr7WkaGgWBWwxy1x0DkS
E37d0Ld+73ZhnPaJEN0qAPcbGl3l6xOl/ZuT9cIbN9ZtycdQD0dqIHR5q3vU/81v
EUzVAMphiz0CfOZTPrDd8oiGCIb4E1ArF/7RBt4v03BCsUnmrDnYPX8RgE7fwGGU
WvhrmhkrdN6zfCfP0+xAzxH7p/zJsyum7RkMDRokCQ27hphUXV5cgIyOLB59Kla8
YndEOnLBviBsH0/nB0YIe3iEpQ40Cg==
=DqgK
-----END PGP SIGNATURE-----

--AZ1b8d0NtEewcE63--
