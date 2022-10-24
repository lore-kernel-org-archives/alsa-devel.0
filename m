Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C422C38A2D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 11:51:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB5E77899;
	Mon, 24 Oct 2022 13:50:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB5E77899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666612259;
	bh=l/XI3CiJsKnOLgsVQc6BqIisIYNhZPrUZPh4AYIN9KY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hpWj7ur+1yVaczGCem83MmFWU8ubAqQqSDCrP70axxI2BHq5VVGVHLukDWMaQk2yV
	 J1UWc8kpn+YqbLqNIYZqEPQWrWjDjdS2xQgPm0trhYqdj570voNajUoElpgnJCd8Os
	 MSzvjf16wP3bC3e80rI6ohrY5+gRHuQ8cAyAyM8k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AD20F80506;
	Mon, 24 Oct 2022 13:50:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6DF7BF8052F; Mon, 24 Oct 2022 13:50:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6900F80506
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 13:50:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6900F80506
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="thh7k93c"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 37BCF61290;
 Mon, 24 Oct 2022 11:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4375C433C1;
 Mon, 24 Oct 2022 11:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666612201;
 bh=l/XI3CiJsKnOLgsVQc6BqIisIYNhZPrUZPh4AYIN9KY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=thh7k93cgCNwV2UH4mQx9y5s/g6abLBR4vV0jfk+XRMc8utp9EIhdJC4lIOGf2jNV
 yxBhIdZCw8PqPJOvwK/Lf1YE2tm2NHXAU1oGnSDVLqZ1/uUVUL0wZfu0DKEAU4gMLq
 5xeujSbo3slyB6EdEcqvcZ0Z0aFfyUypCRVEeFcNeRuzvE235Bl6WIKRRFA7Ixw/5G
 Un5JsjwAZwwgiFeNFVcy/ObJ3ePvZOVI50AECxC0TGKjxRCP1xPX7JLP1zI/vvjlsn
 I7xda0Gmk0T/M9/JmvV/lZS/jwsCbYvNMq8dJIxl4+/CGvINcHOj/ssVCRmcsrRXxt
 VBkkEQvriRE2Q==
Date: Mon, 24 Oct 2022 12:49:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: simple-card: Support custom DAI system
 clock IDs
Message-ID: <Y1Z74/vKHbnaCLrX@sirena.org.uk>
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fXtczi/kKlNHcG53"
Content-Disposition: inline
In-Reply-To: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
X-Cookie: You will forget that you ever knew me.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--fXtczi/kKlNHcG53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 22, 2022 at 05:27:41PM +0100, Aidan MacDonald wrote:

> Some DAIs have multiple system clock sources, which can be chosen
> using the "clk_id" argument to snd_soc_dai_set_sysclk(). Currently
> this is hardcoded to 0 when using simple cards, but that choice is
> not always suitable.

We already have clock bindings, if we need to configure clocks we should
be using those to configure there.

--fXtczi/kKlNHcG53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNWe+IACgkQJNaLcl1U
h9By4wf+MO0f2rw7A/XLJQONuNVrcWtI0Cz17wuuWDvSlDxNWS3cq0OafQbjXYD2
MIN1j9goUvD9Y++mcr65EhFvRtaD5+BEWVIq2/gNTpWOBSTTN06REGvOkyjOrYMU
AxIAuperEJcYDJxlk0Wi8uVD63kmPi3omezXXRZW2xF5wku655JWWowPDtvl+Yqn
WVNsDLlwBG7RpgoI/v5TupZky6kY4YwLUDGYqx0RQazQ1TVSbLPYnXScckY3yn14
PcKloZwkgnraB1dVYim6FJF5xUXakwk02tTdZBK9//oIucjWmhjUoMihjdXU1TCV
ajFepx+RlJ967a/P5vLR9O3qmNhT7w==
=5Xyf
-----END PGP SIGNATURE-----

--fXtczi/kKlNHcG53--
