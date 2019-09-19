Return-Path: <SRS0=hSRK=XO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E61DC3A5A6
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:34:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89002067B
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tIlSLH3G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="jghkJ8ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89002067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00FDB1676;
	Thu, 19 Sep 2019 16:34:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00FDB1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568903697;
	bh=ebpObDKUzokZArhn5+0wQdkg0hOCxU34hl2N3Wwbfcs=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tIlSLH3G/pPA2u4lsB1nVd4y9iaQv2RpUq4UQsjxRon5Jyhqs+SOhVn89bYznYiuE
	 wqYzWq4gAT4PPo373P2vkw25EmLFVRw8uGBuxncaN1uGq26FTlD0F05bDX2grCNcsU
	 KjJPXLW5ZpLLnuryXVT9mtV+ehDgj9gpr8QukizQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 888C9F8048F;
	Thu, 19 Sep 2019 16:33:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBAAAF804CF; Thu, 19 Sep 2019 16:33:19 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D081F8048E
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2019 16:33:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D081F8048E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="jghkJ8ni"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1sx8mKM+Bqm7cSb1Up4PL3u1Qlhzk3VQwMObKwWPKAQ=; b=jghkJ8niX5s9SkPtmb5Vk052N
 dGOo/9p/fCMyxtvd6uQK5Tdxl4yN7ZOW7+pTUoKfrX0Ro4pQVYHWsxaVvpNiRJb9xy9LfsKKCv+Yk
 /goRd7N7GK1W3tQ+/YU9X9qIXsDBB7xX5yezln/lW84i3v8o46OqS69TYlkrkiElff3Eo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iAxUh-00042Q-4N; Thu, 19 Sep 2019 14:33:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 89B272742939; Thu, 19 Sep 2019 15:33:14 +0100 (BST)
Date: Thu, 19 Sep 2019 15:33:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Message-ID: <20190919143314.GM3642@sirena.co.uk>
References: <20190918104634.15216-1-s.nawrocki@samsung.com>
 <CGME20190918104656eucas1p1d9cad1394b08d05a99151c4fbc9425ce@eucas1p1.samsung.com>
 <20190918104634.15216-3-s.nawrocki@samsung.com>
 <20190919075924.GB13195@pi3> <20190919125020.GJ3642@sirena.co.uk>
 <20190919143116.GL10204@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
In-Reply-To: <20190919143116.GL10204@ediswmail.ad.cirrus.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 sbkim73@samsung.com, patches@opensource.cirrus.com, lgirdwood@gmail.com,
 Krzysztof Kozlowski <krzk@kernel.org>, robh+dt@kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Subject: Re: [alsa-devel] [PATCH v1 2/9] mfd: wm8994: Add support for MCLKn
	clock control
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
Content-Type: multipart/mixed; boundary="===============7455469996246503444=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7455469996246503444==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 02:31:16PM +0000, Charles Keepax wrote:
> On Thu, Sep 19, 2019 at 01:50:20PM +0100, Mark Brown wrote:

> > Yeah.  IIRC when these were added a machine driver was grabbing them.  I
> > don't think that machine driver ever made it's way upstream though.

> If you mean for the Arizona stuff, the machine driver using that
> was sound/soc/samsung/tm2_wm5110.c. Sylwester upstreamed it along
> with the patches.

No, there was a WM8994 thing before that.

> I think on wm8994 the clocks probably are only needed by the
> audio part of the driver, so probably can be moved in there,
> although as a disclaimer I have done a lot less with parts
> of that era. However on Arizona the clocking is needed from
> various parts of the driver so couldn't be moved exclusively
> to the codec driver.

Yes, they're only needed by the audio part of the driver.

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2DkakACgkQJNaLcl1U
h9CyCQf+MMpoS4FlVQq+9Xt+0Uket4UES+rOnjdNVAtME5x6rwp/rW3bJeTlegL3
qviOHfnz9mgXwuCeR5RxotyqaZ6WB0ihYC/Y1TXFxaM5mN8Xqg4s3tWs0roBVc5q
wFKYpZr1heeoP8/2Meitj68poZHiUIGcU5E8Lgs9qDDJK5hwzVZ/1hJTvY4Dx5GN
ZuWslKMKAitY8sH2wV2+kDB1JY0poPsScarR/z3MozVoEIg6ABbc/EwX8MObf4a5
0QiV/9mSwrQ2Ctjd1nnr8/a8wOMkKdqiHYbCRYB5dy432Dh3oWZ5eRqUodDDR9eK
uLi3a+I6dtNmKmWHdMYaoRG//ylGlA==
=ebz9
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--

--===============7455469996246503444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7455469996246503444==--
