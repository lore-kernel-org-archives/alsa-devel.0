Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C43C77B7A
	for <alsa-devel@archiver.kernel.org>; Wed, 24 May 2023 10:38:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A47A20C;
	Wed, 24 May 2023 12:37:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A47A20C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684924689;
	bh=hi083FkRexhMLoidEEKy5XWziKKRM1PgNlp/EQlYmVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e+03L4kRBW10o0Ip/zN/tLpHUnSn+bIsSLK5Ve+wgAk6H8wkaafOb5LzCy6AoiGs2
	 rbJwQzYfj4zE9l9St3ZFaO6FKuRhh86cyuvsfMrmuebpKj/3tCVdTcODxTayroXpMa
	 8Bh1HG1Qimd4QKPRxYR6DLKxm+oeRGI0lAKes/Zo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9129F80544; Wed, 24 May 2023 12:36:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73809F80086;
	Wed, 24 May 2023 12:36:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A0DDF80249; Wed, 24 May 2023 12:36:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E0B7AF80086
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2023 12:36:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0B7AF80086
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=asbJvu+1
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 00B0760E9F;
	Wed, 24 May 2023 10:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E84C433EF;
	Wed, 24 May 2023 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684924601;
	bh=hi083FkRexhMLoidEEKy5XWziKKRM1PgNlp/EQlYmVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asbJvu+16MZuQTh7gbxpwMrJTcvjfHd4T6JDwAkJJlFE/EAssy5B+lXSI4CsJooAC
	 GsqJUEODGl0h+lSkFnrAGaSKtsjZyM9UnsBZ7/5iQuEXWxCu9MtWGvUah3EfzjUKsJ
	 QSid30r06xwGLXYnUiyHdLWw1lLxCJGQBPrJUBuXftC2w05fbnD99Gxuhy8RsYgaYn
	 vgBek6q58SIUmwO2S1J7KPifsFHaMUVdadB7YXrhUyCpXuJ/gtdnRbnRZQe0mORPuK
	 w0owrUkSjXbYqiGRyJCx4+Zzu4ta9kd9l+GgUAXRugyIQcdZVmvgQdKxk43Ra66Cba
	 T4ZmRgdhGlZqQ==
Date: Wed, 24 May 2023 11:36:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Zhu Ning <zhuning0077@gmail.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	David Yang <yangxiaohua@everest-semi.com>,
	Daniel Drake <drake@endlessm.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, kernel@collabora.com
Subject: Re: [PATCH 2/3] ASoC: es8316: Do not set rate constraints for
 unsupported MCLKs
Message-ID: <16e818c0-6917-44d9-8cb6-27bbf41b896c@sirena.org.uk>
References: <20230524074156.147387-1-cristian.ciocaltea@collabora.com>
 <20230524074156.147387-3-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BL18BDqPwAF3M+kF"
Content-Disposition: inline
In-Reply-To: <20230524074156.147387-3-cristian.ciocaltea@collabora.com>
X-Cookie: You will be divorced within a year.
Message-ID-Hash: LEJZKIZSKRXVDP7O6ZSX45X6BFTRSVB3
X-Message-ID-Hash: LEJZKIZSKRXVDP7O6ZSX45X6BFTRSVB3
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LEJZKIZSKRXVDP7O6ZSX45X6BFTRSVB3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--BL18BDqPwAF3M+kF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2023 at 10:41:55AM +0300, Cristian Ciocaltea wrote:

> -	es8316->sysclk_constraints.list = es8316->allowed_rates;
> +	es8316->sysclk_constraints.list = count ? es8316->allowed_rates : NULL;

Please write normal conditional statements to improve legibility.

--BL18BDqPwAF3M+kF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRt6LEACgkQJNaLcl1U
h9AHVwf+KYnUvOtkX0kkKv5bSX8q6lynYNs4cwPyEYa4ElWGkL05TG7EvMqFyl61
NAFr7ZbaXS5F6bk9tM+owkDvWBUl7XF0Wgi3Bgkch5xmKSfeYDCXnP7ptpiS8wxX
2giK/jQ7VoZ2vRo3qAquYD+hBmoLOLdsF/CIpUONtUhzfKldB0zyhPP6MFtK7n9J
8s8a4b2r2qszuEXCWQ1NvyikCLMcWoWIoopwEK8pN3371eXvEBvOyex42sEXweDX
e8dv+hwlxnEV+LDLxHFUPq+bnxgneJgv6LWdXaTHdI2V0LC1s4vkBmI0jGn+4ses
8Cd5IhmPalyR6EYRq0qoQPY3e4ipWg==
=Bx7i
-----END PGP SIGNATURE-----

--BL18BDqPwAF3M+kF--
