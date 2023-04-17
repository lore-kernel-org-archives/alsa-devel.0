Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97C3C77B7A
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Apr 2023 16:00:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04FD7DF1;
	Mon, 17 Apr 2023 17:59:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04FD7DF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681747204;
	bh=Rnzz3GERW74u+MLWW8EQinbIqSNnWVSb2Kn3TBoIaQo=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Vc3rK1XLwQwK0YDit6i8Vyr3o62CEZMpMuuqxCgfwm8C0OukyCO3vhBX8CI99SCix
	 O7pBJJ0OjenNHCos9RSSg6nqcXE2fKoMYlk1eTpKjqjp4EP6sihiTzlQiq2469AoBt
	 3fFvFzcPJFGLSvrbD1oV17KVPwiWaIG49h8j6MHg=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 058D8F8025D;
	Mon, 17 Apr 2023 17:58:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD80CF8025D; Mon, 17 Apr 2023 17:58:45 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2D319F800E2
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2023 17:58:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D319F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lxA4+tDd
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AD8EB61093;
	Mon, 17 Apr 2023 15:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C06C433D2;
	Mon, 17 Apr 2023 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681747118;
	bh=Rnzz3GERW74u+MLWW8EQinbIqSNnWVSb2Kn3TBoIaQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxA4+tDdcZ3QYB4UAIxj/2Z9JfC/1OfhjjMjtRS8Q8uww6uYzQePkd5ZcTNMF6YHl
	 C2T5vT9auWyNRDzTCmW4FrH9hmMzDIJX3qe87EC7+KjfVuItzSpGu4PbWKsVuZcMl+
	 7XX2ugtsXUr3P78cZAHS/C+m2J9lQzzDkuTPHdju+SIKS3FpGwSQ7Dk4cExK9i4Chr
	 JRzAW/dEVLP1xnrlENvhWgsSW/1pyuPIITS4AYkD/1ZK7GJAk2XS9ZuYVCgsJRsrnx
	 16FHwyAEDMm1pkHVZayV/6o7sfAJ9luLu1Y66alp70hutP3KVH133J/FGMXSTYJoD/
	 +8+Ga553plygg==
Date: Mon, 17 Apr 2023 16:58:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Message-ID: <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
 <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yQshKBcUYTpK5P3W"
Content-Disposition: inline
In-Reply-To: <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
X-Cookie: Two heads are more numerous than one.
Message-ID-Hash: 5DVDF66UZ7WPDPKNS7K2W65PGUE5PZKQ
X-Message-ID-Hash: 5DVDF66UZ7WPDPKNS7K2W65PGUE5PZKQ
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5DVDF66UZ7WPDPKNS7K2W65PGUE5PZKQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--yQshKBcUYTpK5P3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 05:43:03PM +0200, Krzysztof Kozlowski wrote:
> On 17/04/2023 17:33, Mark Brown wrote:
> > On Mon, Apr 17, 2023 at 04:14:51PM +0200, Krzysztof Kozlowski wrote:

> >> -	if (IS_ERR(wcd->if_regmap)) {
> >> -		dev_err(dev, "Failed to allocate ifc register map\n");
> >> -		return PTR_ERR(wcd->if_regmap);
> >> -	}
> >> +	if (IS_ERR(wcd->if_regmap))
> >> +		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
> >> +				     "Failed to allocate ifc register map\n");

> > This is a functional change.

> Hmm... I don't see it. Return value is the same, same message is
> printed, same condition. Did I make some copy-paste error?

You've replaced an unconditional dev_err() with dev_err_probe().

--yQshKBcUYTpK5P3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9bKgACgkQJNaLcl1U
h9A5eAf/V44Ba6yb3a6YmDlgNmrPlfJw61Ind9ikhM3isXbEY6mNHHVXK2bTaRyq
S92EYU+HklYIUaooXBh/pqhXzcJVL1vxjK/tFO+j81KW3z9D77dbQ41RiYu43nC1
uqE8Lu0CJbGoja6t2uL3DlBoYiygvARFKCuc0cN4b/Yaf4ynO+6utmd9PrYz+L0+
BhgGmmce+4wK9Yh9NpceDuW7OUCo6YMrWW96dL6z1gcp5+VaLNRUzH0/Ro21IzhC
6hzb/zGlWE3osHk91PRO2og+veylpbXO4LTTCxgrs1ElgFesi7giSiwJ2Y8klNEt
d88QqmfZXTLk9VZzkXRgRozDP/lc/w==
=oifx
-----END PGP SIGNATURE-----

--yQshKBcUYTpK5P3W--
