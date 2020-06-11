Return-Path: <SRS0=5dB9=7Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB2BC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:42:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B297D20656
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ke5phZna";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGxrGjOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B297D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 461B31614;
	Thu, 11 Jun 2020 10:41:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 461B31614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591864959;
	bh=QsS/tOLm0lwVFkLv1bvdt7t2u82usdSBFhe+D9o/m6U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ke5phZnakj5HmznOQpmdgV/Geac6e7GV16lfxhhATfvArje184LFF6G11NlyCTJj9
	 7a055r/y+CbyeFfPaOlrCOxJkcyoR2kOdjjwpDYWaWXJtkWmQygUur0egbzxBm8hsA
	 LryQmfLL+PPLpaWsjwxedQaTp3aDQcafqXVM6r3s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FD50F80278;
	Thu, 11 Jun 2020 10:41:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F34AF80149; Thu, 11 Jun 2020 10:41:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C00A7F80149
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2020 10:41:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C00A7F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bGxrGjOW"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1BA8207C3;
 Thu, 11 Jun 2020 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591864898;
 bh=QsS/tOLm0lwVFkLv1bvdt7t2u82usdSBFhe+D9o/m6U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bGxrGjOWwMM0evGPt5Ai7y8Msl/Mu9rWs4Jh+j+NCI+6ybG4fyAaQG95heLlaEva3
 18bYty9pvqxD+hm6te8k4z6gksi6PrmTG4hZWVEF1PU7wVevrLjQuqzz9Dv5e4v7Yd
 RktG4MAt4nWzQJi9xmao8Qt2Svg+PlTXwDUaGDd4=
Date: Thu, 11 Jun 2020 09:41:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200611084135.GB4671@sirena.org.uk>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <20200610173711.GK5005@sirena.org.uk>
 <20200610180118.GZ3720@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20200610180118.GZ3720@piout.net>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Alex Elder <elder@kernel.org>, Vaibhav Agarwal <vaibhav.sr@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Greer <mgreer@animalcreek.com>, Takashi Iwai <tiwai@suse.com>,
 greybus-dev@lists.linaro.org, Johan Hovold <johan@kernel.org>,
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


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 08:01:18PM +0200, Alexandre Belloni wrote:

> My point was that if we were to keep that driver, the goal would be to
> have it out of staging instead of simply making it compile.

Yes, definitely - that should be the goal for anything in staging.

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7h7j8ACgkQJNaLcl1U
h9B1NQf/eAOKPLkgcd+pMevL+wJlH7JsRYzk65f9i97F+wSsVXn1QDXkKiiOR1bD
rkFO3C0++31H/brsYSkLpsxhMtika0T1WqwxskXs5xER584Xt9SEfONh6yX7Uzyq
Recbx5h8Hwq16z0jC2SAemnXl2pbz5LMQYGIPP9jj6gRY4KImCCSqPbl763oYHKE
jvUH4vyHODWSzAmSYqGv3lIkRE/oZbcNKatDxgPzFrcXFilmuZt/hRt+PPQ5vtiK
r/9vWSGxW/UO6K39svmHjEMOQXtGC8S70/GT1ODLxesgEqRX3NCHZAuWR3TOFfM4
nHoamPxEb2LydXYOKZmETMIlngmTcw==
=nIE1
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
