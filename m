Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CFDC47258
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jan 2024 13:06:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEFCF857;
	Tue, 23 Jan 2024 14:06:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEFCF857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706015180;
	bh=NC2SBjf4G4LZDr8Uy1pZIztgxM81v01wdVZC8CaieWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Kz99c6q4NX3cI5cwChuLIAIuhFZjPTBX7ndGQy0YRsqIM7GvWyDUoS6haKQZ4ctsg
	 lvwZFJ2XB0nTIvfNvgD4mJbdAPp9fJIS+q5BYAG3OavPJGRCP8ta0PkdstIz+ca5cQ
	 e9wBK3HZ1wke46V430c/+CNiosG94ijsCzf2eYfw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA1A9F80588; Tue, 23 Jan 2024 14:05:49 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3359F8057D;
	Tue, 23 Jan 2024 14:05:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBF9BF8028D; Tue, 23 Jan 2024 14:05:43 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3CA4BF80149
	for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2024 14:05:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CA4BF80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ctr0fBBH
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CDAF861DD2;
	Tue, 23 Jan 2024 13:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1CBC32782;
	Tue, 23 Jan 2024 13:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015126;
	bh=NC2SBjf4G4LZDr8Uy1pZIztgxM81v01wdVZC8CaieWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctr0fBBH7qw/d81eOGdjaoGoJLrOTMoko1RFXnVe1w4UD8O38W2UFMNfPoIGFN2Hw
	 9qEY7yeNv9BIMnnjCV7h9Kxomlcfg/FSDUYbICnxB5IabrU7qTyeum9WdRbz3zyilU
	 KiuQ2Fo1CnXHf7GlyqnXtVBbRhP6vMXTvmToh2+CVnlxLqwtTVqfpE5n3w9sjYRi67
	 uPljZxLusAMZKADs/9xUd59GiosAT1HIBThb3bZD8HyKEYXFmwXHNFs5d4MbArkYdX
	 5X+U4r6UGz3lWHtLbTYS9TT0IT0rj/EEn3KP7I6JS3qJCHUSDmRMnLT+qUTdKf0EWI
	 +BCCQoce5ORnw==
Date: Tue, 23 Jan 2024 13:05:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] ASoC: qcom: volume fixes and codec cleanups
Message-ID: <93fee0e1-ce92-4aba-8e4b-0861f78c32c9@sirena.org.uk>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <170596045016.161959.16318695944363636291.b4-ty@kernel.org>
 <Za9xnEXYczA5rsw3@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f373qjpYXgEyzeWN"
Content-Disposition: inline
In-Reply-To: <Za9xnEXYczA5rsw3@hovoldconsulting.com>
X-Cookie: Stay together, drag each other down.
Message-ID-Hash: 6A6ZRFTZX3MPBCGBMH3BH3TAM4JWL3JW
X-Message-ID-Hash: 6A6ZRFTZX3MPBCGBMH3BH3TAM4JWL3JW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6A6ZRFTZX3MPBCGBMH3BH3TAM4JWL3JW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--f373qjpYXgEyzeWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 08:58:20AM +0100, Johan Hovold wrote:

> Could you consider applying at least patches 1/4 and 3/4 for 6.8 as
> well?

Please check git and resend anything you think has been missed.  When
you resent the whole series rather than just the problematic patch that
most likely confused b4.

--f373qjpYXgEyzeWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvuZAACgkQJNaLcl1U
h9ArUQf/fqtc9mZcxQYwBT78ghoI6k7z1q3af7Iqh0gpSRanrp2nFO0pSY0zQBDy
9+/cFUdlbrSqX2ldPE0vNIgM79WOp7nAUyVQfY6qntqSgYEaLbl+W50m8n8pknyt
tnF1tCz9LWsEr4qw/9p3G/aNM2znSQamjXyiNVAXHSjDR3oe713e+OtpTMsJq8D9
6x5c7K0I2FGmNEfvcjp3zn51GWp2jfnkbO/x3ikbKJsKFYbfzoic3RXFXlRHmAz4
/ptS3k4pB0iInw/a2E2ma59NxxvzkUjzJVzRHLlAC51FqhBHags2j5jFWfD9lAV2
7dnlGWlAbdS0kExjFwxAwc33hzkjVA==
=Be7j
-----END PGP SIGNATURE-----

--f373qjpYXgEyzeWN--
