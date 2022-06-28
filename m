Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F0EC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jun 2022 12:08:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D33CB15CA;
	Tue, 28 Jun 2022 14:07:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D33CB15CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656418088;
	bh=z5OjCT3nc19eLNtb3bsYhXpvCcbtCznS3whYvyHxodk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CT3LzkMaAg2Ccv38HKOe0JkG7cPiv2OG2EY2shWQmgY9E1vq65X+c/2+PrTofs/Hk
	 vbkafd+J/E0A1LHWJTydIuah/CUo300IynHV3Oe8dVq2smlBS9ELOtXW/vYVqJkLDr
	 x8cVMR7a9PjC8wCFXn5yiokx6K5UQ4/KF8blqISA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81A9DF80115;
	Tue, 28 Jun 2022 14:07:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A3DFF80167; Tue, 28 Jun 2022 14:07:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 462F3F80107
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2022 14:07:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 462F3F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ReN0NpDT"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DA2E660F6A;
 Tue, 28 Jun 2022 12:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91CDC3411D;
 Tue, 28 Jun 2022 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656418032;
 bh=z5OjCT3nc19eLNtb3bsYhXpvCcbtCznS3whYvyHxodk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ReN0NpDTYy0QZEH56krpsxVGks3JFd1kmFVqzjWUMhwTRrVn1gaiv2RjONHbRXvAF
 HQfpV+AVrJ8rLJyNcHG5qc20TL4C4RyaQDLtJkq/NCo0CPsG4FrqNsHuCxIKaf1uEa
 zOueVqyFMhKwy7K7J0I6J3MYrfIuHWNR7bA51PlGegwqVHfjU4BmUGxJmIV0AJSagS
 1yYN/NWcLQPVZZEbWqvKht5zhnh8atfwyH9TX1QwX9K1S6ryMwk5r5G4JilwwQJoP8
 SoOGsZcMdOwp8DdKoUv23t6uCkznNTVwBItvM3quyDeMNrAUvLmbXzyUUrOPWTt9lQ
 KGUegb0D90dLw==
Date: Tue, 28 Jun 2022 13:07:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v4 1/2] ASoC: qcom: lpass: Fix apq8016 compat string to
 match yaml
Message-ID: <Yrru6n6HnEAAz/2Y@sirena.org.uk>
References: <20220628002858.2638442-1-bryan.odonoghue@linaro.org>
 <20220628002858.2638442-2-bryan.odonoghue@linaro.org>
 <Yrrf5X8wstW+DXHF@sirena.org.uk>
 <14f6b7eb-cacb-91a5-ce06-9702618513b9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m6y3rTZ9Hy28L98D"
Content-Disposition: inline
In-Reply-To: <14f6b7eb-cacb-91a5-ce06-9702618513b9@linaro.org>
X-Cookie: I like your SNOOPY POSTER!!
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, srinivas.kandagatla@linaro.org, krzk+dt@kernel.org,
 bjorn.andersson@linaro.org
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


--m6y3rTZ9Hy28L98D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2022 at 12:48:20PM +0100, Bryan O'Donoghue wrote:
> On 28/06/2022 12:03, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> What's the tree you are applying to here ?

The ASoC tree.

--m6y3rTZ9Hy28L98D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK67ukACgkQJNaLcl1U
h9BxMQf/c11z9HnjtIVAySWTm44Etd3FMGBAUWdP+DRawtcvJxYskI+Nul21MWeW
QPbH20+sOmrqsaUe2RmUWNOQVS0/utHKdXgsEIZ7Y4RSKsOS1cJVl7I+33p3PPEh
LkhrieDP5yGuFizHlr03MKgk1dXElQpu+Fa50HsJ0O3EhRwURV0AHXrvjpLI1fCs
mOmBq/4TcVdXBrB4jQFEzydRc/Q5DE9LdkiNjI+1eLxmqexRN1K0IXrNb4KLb/KI
Bgb2ESehfL6I2s6U4KD7Y1Zhj+mBf0qYa7ohcLGVSD+GYdQaky9V3nd2xZHqMSkz
QAs1WZIIqqVKJVFyUwWOwqmxmyFK6g==
=oIbf
-----END PGP SIGNATURE-----

--m6y3rTZ9Hy28L98D--
