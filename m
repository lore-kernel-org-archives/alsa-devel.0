Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5546C2BA83
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:39:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ADF222C2
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 11:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a06/ojKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ADF222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C9284165F;
	Thu, 13 Feb 2020 12:38:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C9284165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581593984;
	bh=pNU6vStSriR/RPnYr/5LoSvm19yHut2QceQoMgUbCKQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a06/ojKMDDXsj8kZ0vyEA65Aie+7L2l68nEGbMNFE0QUjKM3dv6uTtVDNxvOjyvmB
	 gdxy0/IcihIjV2tk6IGneMvpq54b6PS+BZCzhMIpKQb2rxhjh+CIq5WX3RBapIGyer
	 6g30yXTSQQOribEQQWG2PXZksuBQR3/F5Q2uyeh4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59631F8013E;
	Thu, 13 Feb 2020 12:38:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4A94F80145; Thu, 13 Feb 2020 12:38:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 0FD78F80139
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 12:38:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FD78F80139
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EC491FB;
 Thu, 13 Feb 2020 03:38:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D795B3F6CF;
 Thu, 13 Feb 2020 03:38:47 -0800 (PST)
Date: Thu, 13 Feb 2020 11:38:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Message-ID: <20200213113846.GB4333@sirena.org.uk>
References: <20200213061147.29386-1-samuel@sholland.org>
 <20200213061147.29386-5-samuel@sholland.org>
 <1jpneialqa.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
In-Reply-To: <1jpneialqa.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
 linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: simple-card: Add support for
 codec-to-codec dai_links
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
Content-Type: multipart/mixed; boundary="===============1205119423915401796=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1205119423915401796==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 10:18:53AM +0100, Jerome Brunet wrote:
> On Thu 13 Feb 2020 at 07:11, Samuel Holland <samuel@sholland.org> wrote:

> > +- codec-to-codec			: Indicates a codec-to-codec
> > dai-link.

> I wonder if such property could be viewed as a Linux implementation
> detail ?

Yes, it is.

> Should the card figure out the codec-to-codec links on its own or is it
> something generic enough to put in DT ?

We should be able to figure it out by ourselves, we already have a link
between two CODECs - we should be able to infer that it is in fact a
link between two CODECs with the information we already have, probably
by looking at the two devices that are referenced.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5FNUUACgkQJNaLcl1U
h9AQ3Af/XaLbts6WjJP/3bk73GDv0QmGgaskQL8b6m1D39K+JlBEpJFtRFU8dbwI
lRAtiipudev/YrYxB1zTgCbspo7bZ+p9X+lKGs3duT/Mbu/S19AJXn1oczaI9bSr
ry8cckwgoWfaT5KEgf32ZKhLPL2RYOGUfxK8YD3V2SVj74QapjdY3S4cOWFYCGSy
G9RP0+ReSirSQ9p4MFiA3zxj5lLgNHnCoMkVrIUktLtLfbE9T6vyW0eZhc0+9wXC
td2NQln5v755wOwxzGvfZ0hmO1Zil4FZEoCCdGT/izv7joqZaB18lG/XVlBCHQbn
Sm25vTaxFqSe2wL3vQlqmRW5BEYsTQ==
=eGwg
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

--===============1205119423915401796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1205119423915401796==--
