Return-Path: <SRS0=CVmM=PH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DEC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Oct 2021 12:07:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17FE260FD8
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Oct 2021 12:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17FE260FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 453DF16A5;
	Tue, 19 Oct 2021 14:06:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 453DF16A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634645231;
	bh=cFUJmIuqaRcFKLfCT6FjSV4xppqcoq1e5ihmWzQnHF8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PHFFijeDFiPbzVJcdduNB4UmBNpucyydLuYqSDgT7Fb/Xdbl/NCBBYPzWqxxJ2CDy
	 YPtEknmfEipp7Wuso49dLDl05/Q8JpwsOs4Lv2u/UckKTTzKixKDlExfSdHWETUMR3
	 o9hsj6cLX106xF5f5ydTknUJue1IpqgDyjegHrLs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2932F8019B;
	Tue, 19 Oct 2021 14:06:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DD75F80240; Tue, 19 Oct 2021 14:06:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59516F80082
 for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2021 14:06:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59516F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SFK7N47x"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFCD1610E7;
 Tue, 19 Oct 2021 12:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634645170;
 bh=cFUJmIuqaRcFKLfCT6FjSV4xppqcoq1e5ihmWzQnHF8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SFK7N47xaGP7p7aL8QNCpwGR06qtWhy+hSeW45uG485jOtRZ095PQib/sQge43GIY
 lAqapsUy2AQgEHIn/yFyMiemKhrGPOzc5Tn+F6sI/dZQk7p4U7jteAXr4ptXTjNFvU
 H7Pb/vj1iF5pySDFOzLOd/qCwvzYnbGMohozhFKEWnA2oEKIksCjDCB1Tmnwiy/5FM
 GLYqRW8LCdAQkp2mKUL4eY9e9aaLlCj7iEh6RDvaB0ZGDLIkP8uSGRUGFRcGYJLmA9
 8844GgLdmyu/R2mGLrUaMCyo3wzP6DQInlu2dEMPJjniHvoSYDLJ+m0DPkppBh83QT
 7zw7M+wpI/3ow==
Date: Tue, 19 Oct 2021 13:06:06 +0100
From: Mark Brown <broonie@kernel.org>
To: George Song <george.song@maximintegrated.com>
Subject: Re: [v4] ASoC: max98520: add max98520 audio amplifier driver
Message-ID: <YW60rmCStn2o7o31@sirena.org.uk>
References: <20211019084914.14622-1-george.song@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S2KRfR5D7PbsK0GH"
Content-Disposition: inline
In-Reply-To: <20211019084914.14622-1-george.song@maximintegrated.com>
X-Cookie: I program, therefore I am.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 steves.lee@maximintegrated.com, ryans.lee@maximintegrated.com,
 george.song@analog.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org
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


--S2KRfR5D7PbsK0GH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 19, 2021 at 05:49:14PM +0900, George Song wrote:
> add max98520 audio amplifier driver

You seem to have dropped the binding document from this version?

--S2KRfR5D7PbsK0GH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFutK0ACgkQJNaLcl1U
h9Aw1Af/TZm8rxRfgLCvDxIdIMvbXWPFtC3j2chVuegRb8xXWnL5jY5xiIv2JfFP
BVCTyX/MfX/IpKQNlYpPrM+Zsdsu2I9vWBp808eJA/NMBAeSRPcKf+QHtPa5I1ol
+IxxvNuMYmLv1kKZuYXD4BonKU4wIQIb+vScjyfKEaVwmTNstd9FRslPjG0b/sxT
29XiNWY5QvCnpSL6zgV1n4i63oydZ8yXk5u3K4QAMEYE9h9ZF+sXbEQR0xkTz16o
MA6f8o1OMdPmM/U+YVC75tLN66dUbKg+W3NKg4E1P8qZhKGyqMP947YMHYaYzX/6
ImtuVRBMY0NmkQc0s8A9TKavaMTcGg==
=TXWk
-----END PGP SIGNATURE-----

--S2KRfR5D7PbsK0GH--
