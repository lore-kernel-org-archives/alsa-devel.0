Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E925AC77B7A
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Apr 2023 15:34:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9659AE9;
	Mon, 17 Apr 2023 17:34:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9659AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681745692;
	bh=Of1iyBIjBEh9nZ5iNrJ2Hz9ItpKyyzRZp3zaPHpda+g=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uUP9VC+kb+b92+amhBsKc3rpbJFLMVXnfh1Og2rPYaoEQ4Rj1ot8SpYDkHqDV4Ziy
	 pW+fhKph5E2ykL7X+TNkIu+y9fQI1qLN18V/IE4m7IONogwXgT/tNJLHjqRw2xjln7
	 KEWHG+H9roTeUCnN5XXxgq5CGPD7T5ZEp0OgDE/U=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6541AF80266;
	Mon, 17 Apr 2023 17:33:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B86EF80266; Mon, 17 Apr 2023 17:33:33 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE070F8023A
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2023 17:33:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE070F8023A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GRTIq5/Q
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BBBAA6275B;
	Mon, 17 Apr 2023 15:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD825C433EF;
	Mon, 17 Apr 2023 15:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681745586;
	bh=Of1iyBIjBEh9nZ5iNrJ2Hz9ItpKyyzRZp3zaPHpda+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRTIq5/QZP8i8pkBucK4vD1OmtyXVRctn+mh38NX2uyIHMrxUHLXX4gYAdjQDlSiI
	 Wwum6txVgPPXDsb8Im48Stkhsm3QseSExG5Gbs9DumkH6AWzw/g3z/SshpEXJpu0Ik
	 6lLTqh5ozJ9tEIRMURHs3bLnIpCheEbJwDdDNJCHqgxvMfLoicJ80TT2IT8X6bJnfj
	 xr0WMOoW/+dGRhEXKj4c/LczjGrgHDS+y8CWxOD5Tsu6OPTHG1b4gsAr9Zw3+HCu5/
	 rcTC3xogJjH1LP01CA0/gE9yLRCpVASs6KPtTuNYTLKw/cqcFLTNoC+akjPtTsZvnf
	 TabMN70vfu86w==
Date: Mon, 17 Apr 2023 16:33:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Message-ID: <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ym9TkoocYsNsRt4"
Content-Disposition: inline
In-Reply-To: <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Two heads are more numerous than one.
Message-ID-Hash: F3MTWEDIUPMMEXFOIPZWTVZ3J6P7WNXI
X-Message-ID-Hash: F3MTWEDIUPMMEXFOIPZWTVZ3J6P7WNXI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F3MTWEDIUPMMEXFOIPZWTVZ3J6P7WNXI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--7ym9TkoocYsNsRt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 17, 2023 at 04:14:51PM +0200, Krzysztof Kozlowski wrote:

> Code can be a bit simpler with dev_err_probe().

> -	if (IS_ERR(wcd->if_regmap)) {
> -		dev_err(dev, "Failed to allocate ifc register map\n");
> -		return PTR_ERR(wcd->if_regmap);
> -	}
> +	if (IS_ERR(wcd->if_regmap))
> +		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
> +				     "Failed to allocate ifc register map\n");

This is a functional change.

--7ym9TkoocYsNsRt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ9ZqsACgkQJNaLcl1U
h9A0ogf+OG0JbKZGQvMMWHRl8olMh98p8FksZOl3Y3/QuuIvqo7CYBIl995DrU+4
SS1BgTs6c+ICkyry2pG267o+rKIEa/Tz+MeN7uvvOlEN/o7gg7Ie9Fs0kbhXLZyp
a7ZSeW4uq97nZ9HLI2FBsxnqg3nQ7KudHAg12InyY7dvmJRYQzsef/KO2eSOvsM7
++7VfbfyI77uSueGjDN1OcXIGM0AUSSDwh8QX7j/fbSBMVGmwl2rHWf3nsXS0OGa
vSL8PPbglcpbkI1bqTm2ge+tZUj/evRx47QozNAFZ4LfiEfaMwqcIrEU/H4wE2X/
xfN2YaNfcMxdY7/FrsYs3Skej9wjtg==
=dy1p
-----END PGP SIGNATURE-----

--7ym9TkoocYsNsRt4--
