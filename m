Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E1ACDB47E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Oct 2023 12:37:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DF1A1F1;
	Wed, 18 Oct 2023 14:36:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DF1A1F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697632628;
	bh=IzeKyhweq1AWLlQfKTFic0Ns1rUrAh3cIE6nERCkITs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V4eW40hsdd+l6vVdOMvX1Zr3fi04rBTujYJd2/0txkZ1zi5rhvSbzE8YYK0FptRj1
	 Jbb2WKKiXsOrrKP/RiDGDnHTH3lJO+CMppmKEOb5gmG5aOgouEP73u8fgXSxyHbgyy
	 UWk0Xzwm2/wtHONXqOro8BSMvGmQbefSaZCCYSKs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA8D3F8027B; Wed, 18 Oct 2023 14:35:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C721F8025F;
	Wed, 18 Oct 2023 14:35:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCD49F8025F; Wed, 18 Oct 2023 14:35:53 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5CD6F8019B
	for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2023 14:35:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5CD6F8019B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YcSC7Jo6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 637F8B82339;
	Wed, 18 Oct 2023 12:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C09C433C8;
	Wed, 18 Oct 2023 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697632548;
	bh=IzeKyhweq1AWLlQfKTFic0Ns1rUrAh3cIE6nERCkITs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcSC7Jo657eM8tIi2pAedw6dTC23LfnzfpUvTnfeYeQryq56M5FX0LWqykW3Zde5z
	 kPhKUcFnZFggluYnd5Tf7P2YG8mQQ/Ite0cCrmrMoVBexhmbne4X77jfbLSXIeXOEd
	 1pXGEFi6RIx665WWvDBavqie2GpwxSnYLet1H/dgt+VzIn4cvfzggZJzx0QmQi8f5P
	 oTLz6+l6fT9mpgEH0b8ubg0NM7CO2+QIN7qVAEhw3xgEZN/Wt8dfXo46KDSmoNL25N
	 WesDoXZstkDvoTc1jWXMCwS9NRKwFJAlLC0OFNnsu7yFE+gv2CB7/Vgexi5Xpqckm0
	 yZRIlD62AsWNw==
Date: Wed, 18 Oct 2023 13:35:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wsa884x: allow sharing reset GPIO
Message-ID: <3aa9e3a7-9417-44b4-87d8-fcf1a8b46daf@sirena.org.uk>
References: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p00VV8kk1vH04gU8"
Content-Disposition: inline
In-Reply-To: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Santa Claus is watching!
Message-ID-Hash: NWKAQ4UHFDJP6B4VEKAYHZWQPZIO3WYT
X-Message-ID-Hash: NWKAQ4UHFDJP6B4VEKAYHZWQPZIO3WYT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NWKAQ4UHFDJP6B4VEKAYHZWQPZIO3WYT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--p00VV8kk1vH04gU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2023 at 12:00:55PM +0200, Krzysztof Kozlowski wrote:
> On some boards with multiple WSA8840/WSA8845 speakers, the reset
> (shutdown) GPIO is shared between two speakers.  Request it as
> GPIOD_FLAGS_BIT_NONEXCLUSIVE to allow such configurations.

>  	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
> -						GPIOD_OUT_HIGH);
> +						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);

How do the speakers coordinate?

--p00VV8kk1vH04gU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUv0R4ACgkQJNaLcl1U
h9DM3wf+Ox6S1h4qHtk5rsc4MfEIG9YfVXZ2Dbwm1s+8OKlAzkmarLvnx7aIoe6A
K7KDIqZa56KFb5V98aCgLdOrKReHACqAd3aQxqyP3I+lNkaKS+hSywdGJfCS/+ze
IUGmrH7xrcdfLpNb1K5vbq1Y4xsvoczcLcd76kV2FO/vx6NYlivAmMA6+m7LXdoo
XXNG4DCilqMpUtNPjNaw3CFI7/X2O7s5Mb/blmWAB6neNbAJEc+vefr3gnmR7JQU
j/TjQY/kXSUJHeRt3l6Kdrkot+xgKL6XsgUKFzhyv1FsJcIEOJ47nZcjyHlkFMK+
padfziLK0UyF/yTXkDl8uHDep4q/aw==
=nLXY
-----END PGP SIGNATURE-----

--p00VV8kk1vH04gU8--
