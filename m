Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F85CC6B16
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:30:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E954D601E0;
	Tue, 13 Oct 2026 17:30:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E954D601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791905456;
	bh=ZOPUCQMM8nkcHGWziwCpO3Y3wMiuUu4TgjhMNHQ4XaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aJihn4SeZoDDytHgvQw8NWnEZ4zkYQ3YMgwj8UARo3B8mU1mwGVYKg0gTzvaDRZc6
	 ZRIYbdyxyvzR25KU7feH7N4Y9f2HfGdCFvuRtcGrOwneJ8icJKefU5a4n3fHQujzP6
	 1pvYRkVLNOP1/ZpSrcno8aPXJkXmvU3SrhX5xyJc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C68EF805FD; Tue, 13 Oct 2026 17:30:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D57EFF80600;
	Tue, 13 Oct 2026 17:30:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F289BF80495; Tue, 13 Oct 2026 17:30:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791905416;
	b=nz6E4pCR1yUWNiX0dMEUdEZx+7MMbHMmW5krqBrfZZ7YEx1WOdoGFBdwV9bRb1Zgn4hc
	 dp9MG550jIMbuHW3xIqHMy5y/8fb2FYpPuW67HZhpxxnPiXVxaaD+eIwuhcXakKXnkADg
	 IRN9601OqLAI3ll01LSh1Uz5OGur3TfRH8u73y6WaIUFap99zhI9d6jx9zWRg87ZzE0et
	 OITwwGdVbf/3dCKuhNEjVenhKVnp/Yi/pJL7BHQefQpOFczx7TXXJ9L07r3IZ88QOig/5
	 J2/UOcVqOQBQI7XlCxj158WEhb+zAvGLm0PvMxjeg+J0emVpgNStv9j/cxyh9Hx9E7Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791905416;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=ZOPUCQMM8nkcHGWziwCpO3Y3wMiuUu4TgjhMNHQ4XaE=;
	b=gJXI4fqHeQRcNnKx3HTLLbttsJjSA3CdP6VS6TLJNRtVGkBtQAQDumGSBcoaUf6SK7F7
	 4tqbr5Z+r3lMVHFiysi0MN7lYKhjGDfq8p5RYdgXcQ8YB4cvAYZpApkh2/IitKUD/33tD
	 M/Ie4uIbIMXTw0x9NUwjRlI30/HFFStYGekUp6wnfnPwYdAKbzWqs6AiKjYCjmHuDvQsu
	 xQkiZ56TLvzaJ4vhquzNUuxdM4MI9dqs7YsI3UX2aQN0JJqUIJOna2Mel4bF77K+Z162W
	 yKjFK9Vv/t15HyG1OXlgqlH9vX21XFfbA/9a+hkXoEuTZNoo2Y1Cd0aue3Z+q+Ho6Rg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SsWaM+4h;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29722F800EE
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 17:30:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29722F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SsWaM+4h
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 900D6602C3;
	Tue, 13 Oct 2026 15:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C721F000FF;
	Tue, 13 Oct 2026 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905412;
	bh=rAyS/1IzCRzhQpaDoMl4P3Lp0Bb3HZwrOWPnviM0hWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SsWaM+4hSp+Ys+cxgjxBS3ZayZIjvihMlYlrDPVMkAJS4Yylmz62GqcdCsD55ls5Z
	 uie2zdIzyo3GBEzfHW+jI8i9O3rpRIlXLRYSfImk3wAGCJfbicasbPriEZFHY50uzu
	 /CYqWCbgDQEpZF5weNvjew8iJNOvBmtklZfXU7PZFg+2EuiFdMeOvsXLjPSz/1B5Ct
	 g5XtkoOT8tTVmS6Ji9JlNqCKSUkxzxZ02P8WeigdN8PnA0Rbt7SjQd9C2OnSQHJwRc
	 MxcaUohUTggj68fnyPaWYiTRzfo4VzoHZ/0m6O45AGteKQ5lk4PsDpWjKphLn0JOe5
	 A0K8o3UtPSlJA==
Date: Tue, 13 Oct 2026 16:30:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Mingxuan Guo <gmx472@qq.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] firmware: cs_dsp: clear dsp->running on the
 cs_dsp_run() error path
Message-ID: <775ad338-0c87-44e8-937e-8c8408dcde5c@sirena.org.uk>
References: <tencent_B839C5A92D762B5717B9637A5CFA0841C608@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sJCKWyzMQlEu4TzI"
Content-Disposition: inline
In-Reply-To: <tencent_B839C5A92D762B5717B9637A5CFA0841C608@qq.com>
X-Cookie: Some equipment shown is optional.
Message-ID-Hash: KECVSZTBWGDQLCJKXP4CHKL552PL7G7W
X-Message-ID-Hash: KECVSZTBWGDQLCJKXP4CHKL552PL7G7W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KECVSZTBWGDQLCJKXP4CHKL552PL7G7W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--sJCKWyzMQlEu4TzI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 13, 2026 at 06:23:58PM +0800, Mingxuan Guo wrote:
> cs_dsp_run() sets dsp->running = true once the core has been started, but
> the error path below it only stops and disables the core, leaving the flag
> set.  The first thing that can fail after that point is the post_run client
> hook, and it is reachable in mainline: wm_adsp registers
> wm_adsp_event_post_run(), which can fail in wm_adsp_buffer_init().

The patches in this series aren't threaded together and don't have a
cover latter which makes it hard for tools to work with them, you might
want to look at b4 to send the patches, especially it's web submission
endpoint which avoids having to configure mail:

   https://b4.docs.kernel.org/en/latest/contributor/overview.html


--sJCKWyzMQlEu4TzI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrOTn8ACgkQJNaLcl1U
h9Bgxgf/Tivc2rORB2SWKwCmH3Q9XKTDAtQ2QyXDaS6VE+jIO6IqBEk/a9F7C/TI
DBuYnMhSDmKN/wTftBcNjVdVoA5G1Q9sVXxjQoG7+QeTh2sefibqpP6Saw14R0FR
DTxxs4EeCE1cFupGFkxZ7VCWjwrHLpQ3oyfRa29/0TL10m/LrB5zClj2zLpfCPJ2
BHT8NB4Em0X1Gw7o/xYU9YxIhxzNL0yVnLueLwRIata/RXTyAe1hgFycc7DM0tnL
yXAnWqfbrb6FZkU4+Pk8uXIvU9sYz8Q2hli71P6h3arIsiUnGChuJ02A490b8kEK
1Cm37BM3UOw6ag+ENLgUfLtNiIUGoA==
=Jkro
-----END PGP SIGNATURE-----

--sJCKWyzMQlEu4TzI--
