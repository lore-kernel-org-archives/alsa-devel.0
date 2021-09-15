Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9954C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 17:53:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F60611CA
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 17:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33F60611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C45DF181D;
	Wed, 15 Sep 2021 19:52:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C45DF181D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631728418;
	bh=RifiKVy9HpJF8Xmn1/xntTua3qMYa4VQFXxujm16evs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ONgQf5TlNP8fRXhcNRtlNsROM3ojHjZAfT+8hI+5y8V1y/sI1r74iPslYquhHRYFl
	 h5HnJWEJ96EhmUHMddqBcZkhP9KKaekCdnrbFqGDsi+ZqD1Eo2+C6WFE//XNyP9KIz
	 OW7s5KweYqXTHmK+jlYGV45aTBcYhw0HcdyMkfqs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A58F0F8032C;
	Wed, 15 Sep 2021 19:52:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C135F8049E; Wed, 15 Sep 2021 19:52:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31E27F8027C
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 19:52:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31E27F8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tKmoG6Ap"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76B1D610E9;
 Wed, 15 Sep 2021 17:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631728348;
 bh=RifiKVy9HpJF8Xmn1/xntTua3qMYa4VQFXxujm16evs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tKmoG6ApHcSdRYNpWBxZWlV/T5tE3+MbptGNI3vjGvNKJ5mN36/ChHZ6E4XMbRQ/+
 X44A3nppHhMmZXTwRTKQvOqFGpvHUm5k0d4JtX999Yn/2dzyJqW8JB82Mg2ClGYEpv
 MwxeYEpr2y9rme0bkP5pr1Hvg5jeure2VsdJgnlv0riza22OqqQT7bn94OafHNhsrE
 c0B774yTIbLzTxci/mZH0reI8tVvCL5GTat5Zg6qnuSGbvCnAUSooBfCbxVMmNJmp2
 +EjOXo9xeWBwHIhpVdu86HRo0oAUDZYgDF4u8hggL/A/lffFkmzGZZUc+y6D01HbHt
 O+gR4K2TVc6Eg==
Date: Wed, 15 Sep 2021 18:51:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] ASoC: atmel: Convert to new style DAI format definitions
Message-ID: <20210915175147.GF12513@sirena.org.uk>
References: <20210915174244.38062-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
In-Reply-To: <20210915174244.38062-1-broonie@kernel.org>
X-Cookie: The more the merrier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
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


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 15, 2021 at 06:42:44PM +0100, Mark Brown wrote:
> Convert the Atmel drivers to use the new style defines for clocking in DAI
> formats.

Missed including a few conversions in SSC and sam9x5_wm8731, fixed
locally.

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFCMrIACgkQJNaLcl1U
h9DyIwf/Xhig1o8+zlizlvwkWM8OO0sk8mpkqMe9HQk26sxHVzOjV/YXJWA1nNvb
WJGUklYSo3KdCV3gRP0aipF+qJlqSATABKGVDDg/wWhf3Bf/si625WuBp05lWAy0
ev3QZsa42Q1CeSOEjACuEOt8EfDQLKZlmccmSdbZRSNDISlqSVOZGonvjNbIRBWv
HeW5S38zNHXqO7VeumQ2P2TxqesUctzxN3kxpsNLe/iu9rfvU5eGdeucDHpbBdTc
J0b4YTcJEtWCmPNyYACqH+D6lrBd0bDiXJAqoMb12Gtm0g0uzSDEM2GkC/l7mgyL
q0lCHCQdzjgkipYuN/cCPrEmMFRNWA==
=kSzP
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--
