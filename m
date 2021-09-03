Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5060AC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 12:32:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD4261058
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 12:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BD4261058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4466017F4;
	Fri,  3 Sep 2021 14:31:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4466017F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630672357;
	bh=hmbJgJwiNK+Qia20F9mGeaaWddLJV+HFpX0pUXYn/kY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tek8+KyZATpK65vB0WxiHJoMdHv0TxDQghA6hzEm7Bzdcr44+KxcjSb+vLcBjnWwa
	 VCTK3m/+jUmrShWvgqTT1YuiN12OAV/alCwYw0q4kdxHa4ZP1MGgadxLudr3//RqcJ
	 XuntHqZFeaH7YQCnt1W26yZKWe+RVDcUzH1dLqBc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE8A1F80227;
	Fri,  3 Sep 2021 14:31:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0752F80254; Fri,  3 Sep 2021 14:31:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5644CF8020D
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 14:31:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5644CF8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aSOpcQOm"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C11A61057;
 Fri,  3 Sep 2021 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630672291;
 bh=hmbJgJwiNK+Qia20F9mGeaaWddLJV+HFpX0pUXYn/kY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aSOpcQOmaJEPs6yk7I0kyH4oRVQ2A2kbVhvZXSqU9Z3EuMjmAL1h5kcnZ3Fn7L0vO
 6IVbUgHlHl6HMhrOW2HTVtqhc2xiemkjRoiN26m1VGAOdUmnRTU0Z+oF/LTnYIcKUM
 FM5imUZ2Vbm/OmeGd5BVZ4ltHtkZze7h5YfwdVViDBAqQxdaZmDj0+mgKKdSGgOn2p
 BYiwPKJfVWK0/rNSiVLh9nhtUDZ6i2HYzLfgQh4g/vvl/iYJPZ0VmxI9l5fh/bv6BS
 IDutKel1ZSqT7KJWz++LN2wpfT6t89QaoozY6pG7Ejx5WtdSE6pecV5DBT5L4drbUw
 1MARZTEcGhuXg==
Date: Fri, 3 Sep 2021 13:30:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt5682s: Add driver for ALC5682I-VS codec
Message-ID: <20210903123058.GI4932@sirena.org.uk>
References: <20210826080938.14872-1-derek.fang@realtek.com>
 <20210826121412.GB4148@sirena.org.uk>
 <e2ad57c54ea0422d8083bbf2b116563c@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Content-Disposition: inline
In-Reply-To: <e2ad57c54ea0422d8083bbf2b116563c@realtek.com>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Albert Chen <albertchen@realtek.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 27, 2021 at 05:59:30AM +0000, Derek [=E6=96=B9=E5=BE=B7=E7=BE=
=A9] wrote:

> > > +#ifdef CONFIG_COMMON_CLK
> > > +	/* Check if MCLK provided */
> > > +	rt5682s->mclk =3D devm_clk_get(component->dev, "mclk");
> >=20
> > Perhaps factor the clock init out into a _probe_clks() function and the=
n have a
> > stub function rather than the two ifdefs?
> We want to factor the codes like below to reduce ifdefs.
> Could you give any comments?

That looks fine.

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEyFYEACgkQJNaLcl1U
h9DwTAf9HHYgPfZDOSSJ6IwYCQdZLzxTTkVmR46N9gMLeapdzyNTcclDK6uNgRid
HFBY6sCRzdNfv4YPXl9tPhwtprXHa0j7pQFIN34ekImErzxvAFbP10sJ6CKV2Rix
wF5ETD6VNhVgYUk6MpGz/NFaJLpKIAjCcAECrHeKKBYVQS1ZRoa7tsqjyhjjwZgJ
RTv1jCwgn/k50v9IR8w4uwqpnYssGoPHnnaHw22/6foqfskfBHZat6NV65XhUKRo
UbgBIgTOGCDHZE1JMzxgjAxQuBB3r87ksLM0oXDuFcRxCLl6cq8hxm5yYqdVvGwy
BAA2u/FYc3qWaWJ7mpNkfdJHtYkjgg==
=SDOy
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--
