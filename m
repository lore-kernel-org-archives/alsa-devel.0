Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDDCA9EB6
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:38:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CC921872
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hRVjse6L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="GHTHs7e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CC921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 771B384C;
	Wed, 23 Oct 2019 18:37:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 771B384C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571848695;
	bh=X8qwMJFb/eLO+UawDLS3zrnPNYvAnCBR77ebL2fW9Yc=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hRVjse6LvtnLEQ1iRbd6FLzys0BpT0y+VgCLmOcwAnpkuP7a8mD6ee7sQ9SeziFJj
	 UNKKDK2AADXIT2HGn4imwW8LSMmpXEQDA+O203QGIcvl8V8FTLoMWTZMI1OQDysz7V
	 0i2iNm422uDqOunov1UkyoIzC+7zVeNSbjDMC5C0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0CCBF802DF;
	Wed, 23 Oct 2019 18:37:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51ADFF80321; Wed, 23 Oct 2019 18:37:23 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11EA8F80274
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 18:37:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11EA8F80274
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="GHTHs7e4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u1nK+otPEe3G560oBE1oCtldypj4KPY82cjK27fxBuc=; b=GHTHs7e4tnbeVA9/04kQM9TeH
 +1rDG/ty8SraGi0CQrltsOx1j+aTrlLmvaUOcQz/laCC/deD5K/8zx7LAnrIiR6DsjWippUraR2Bw
 NYuxzeOyxcZ0yPGOCXZ9lJRIAuv2s6dLOvOzM/oIwDmREOMc4t5EjPoABt/DeCpklqfwE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iNJdN-0000wn-HX; Wed, 23 Oct 2019 16:37:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 0CBD32743021; Wed, 23 Oct 2019 17:37:17 +0100 (BST)
Date: Wed, 23 Oct 2019 17:37:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Message-ID: <20191023163716.GI5723@sirena.co.uk>
References: <20191023161203.28955-1-jbrunet@baylibre.com>
 <20191023161203.28955-2-jbrunet@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20191023161203.28955-2-jbrunet@baylibre.com>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Russell King <rmk+kernel@armlinux.org.uk>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 1/2] Revert "ASoC: hdmi-codec: re-introduce
	mutex locking"
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
Content-Type: multipart/mixed; boundary="===============6904864415180696934=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6904864415180696934==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 06:12:02PM +0200, Jerome Brunet wrote:
> This reverts commit eb1ecadb7f67dde94ef0efd3ddaed5cb6c9a65ed.
>=20
> This fixes the following warning reported by lockdep and a potential
> issue with hibernation

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wgbwACgkQJNaLcl1U
h9Dh8Af/US8PJypFTsEoI+hUXoaIwo9Pkf8kQ/nRECBygZ9Du+Xgizqb2Q+bRKy8
vVDRT2Qqgp7vN/oFjVr84iCHECVcAfFVFPJZ+n8NuFf9XYDS7zcmmPejSFczhmMq
Z4rmmAd2250VHzXCnjGLpyw7zloVUGiYaxZICMLlnGGbfPxzED55Iuzj4+Q7G7/h
QjPgzkCmo2hNuM2QHVKqsgWHXbH+uChPAF5K3KYs0CwTUpf8U+McKRrU4NWxX5Im
KTfjd62qXybkErrXt5vchfsynx0eBUmcbz9jDAG09jGTPW1lLTm/4v+/vPiCzA4X
f2fsV5jif9Ad5oHC+2rs+VoUVnC7Aw==
=6sCE
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--

--===============6904864415180696934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6904864415180696934==--
