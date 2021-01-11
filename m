Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24801C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 17:59:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AE0223C8
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 17:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AE0223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C85BD171F;
	Mon, 11 Jan 2021 18:58:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C85BD171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610387988;
	bh=l9BECwPh5Uw1xsnT6CBJ//g1d59ts1A3zWVtuCkzoJY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=auAzT4jbDkJP3WLp7frk3ANvqzvIxY5dcBYnKZxRrYCkoeO3m1Hkn59i5LWsEcAa2
	 BOaCuqA3rtd6Nu7HBOzj4FNjF6U/gWIirZ6Vup+7/uZJx4y/AD/uffaLAoKqah7fi2
	 mMpFuzaM9VtAhxOgljNTUBzXZ8uHmeWMvqH3Bo44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CFA7F8016C;
	Mon, 11 Jan 2021 18:58:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7029F8016D; Mon, 11 Jan 2021 18:58:56 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8F3BF80113
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 18:58:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8F3BF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d1+EiBSp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 368A3223C8;
 Mon, 11 Jan 2021 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610387925;
 bh=l9BECwPh5Uw1xsnT6CBJ//g1d59ts1A3zWVtuCkzoJY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d1+EiBSpawyQ677csW0iNpD59tJDqpWFYDwZz4nKjt0Y9Al9lI7opSvj8kTSUGTNj
 O6Y+MOWGgOs1KX/rFdNcBol0oLWJHStoHBwYpDYry62Qiczcq9iMJIUNZXLZheY4iS
 2CwuicaCpop9rxRtKh68mCr8RcbeGe4i94QmoG0JUxVwUOJWEw8MijkN8Qm/ENkvq+
 04dz7pdgQZlyIw+EYn8jLSCbMUpUBiRI88YayrW0BvXmEicRn6E3O6df9bH3R6nIFp
 +vZUoMLPcPRCP9RZ6JKyXEti2kiyeihkazsxmXG7QhAMjdlnBw9V/any77rK4WR9S6
 70Amgsr9TZ+5g==
Date: Mon, 11 Jan 2021 17:58:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: soc-pcm: Fix uninitialised return value in
 variable ret
Message-ID: <20210111175812.GK4728@sirena.org.uk>
References: <20210108123546.19601-1-colin.king@canonical.com>
 <20210111163551.GA33269@sirena.org.uk>
 <9bef4fe5-0eed-03f8-9505-909b669ba49b@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Content-Disposition: inline
In-Reply-To: <9bef4fe5-0eed-03f8-9505-909b669ba49b@canonical.com>
X-Cookie: Too much is not enough.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, =?utf-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
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


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2021 at 05:37:36PM +0000, Colin Ian King wrote:
> On 11/01/2021 16:35, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> ..both set ret to non-zero, which I believe will throw a subsequent
> warning messagethat's not strictly related.

> my fix was acked by zhucancan@vivo.com, so I'm now confused what is the
> *correct* fix.

Quite probably yours in which case it'll need rebasing - IIRC I looked
at the various patches at fairly separate times and didn't connect them,
my workflow is based on queueing things for automated processing later
so I won't always remember seeing something similar.

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/8kbQACgkQJNaLcl1U
h9DAkwf+M1VbQOU/Iy6orX+mjHXlUnvmVyBAj7mzFuZiwwbG0+Eh3ZdHM1zNcNO4
oLc75RxJJjJu4LVtwB2yNCi/ecE6wpn4RCQphOUqC0JceV7Fmv1g6DbgQm7FAEg6
c51rug8SVBRaNw3MisdINNE6LOAuO7lRTJYzCINoei2Bc5VvhGva4E2mhnXvr7Ht
o6T03efSI+GFHGtXt5UzmzwSJd55bx/I1hmzPSSkIgqLhgMsCiqEAm/ksQrUD7Hl
cIZBh4puCJwHry9XMaqDK1FX8l4eg1Ey6suXcsBBvbsXUJG/C75zFr5rgLb38y0w
yCqLHIaGdltiVwB+kQAZ/MXBZct/Dw==
=6anD
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--
