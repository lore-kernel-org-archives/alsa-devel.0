Return-Path: <SRS0=/8xD=2R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2CBC2D0C3
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 22:46:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6537120838
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 22:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JQbv07pr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="tP3qhjwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6537120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AABD61778;
	Fri, 27 Dec 2019 23:45:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AABD61778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577486778;
	bh=YPb9AE5abLBw81VcaRT+lLxqawuAnExpaGU6j5a4+CM=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JQbv07pr87ML0a12D+ndDPNgPG57m+Pu30XzgiKxWGDU3b2IA0Nh1Pyr/NXTIPgVi
	 XHWeT1vV/Z3l6ZlQrytW5N1XFIHdr7BK5wECuUC48ordjabvqeEeSxTAq2aqSqxv5Z
	 tWtJ+0erjO2baO/vGrPUpnfG3koFV38fUYiOmvQ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2FEBF8027D;
	Fri, 27 Dec 2019 23:43:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0E7D3F8028A; Fri, 27 Dec 2019 23:43:56 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3B17F80132
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2019 23:43:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3B17F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="tP3qhjwC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f/BaAzN/B4zZGG5c/BBQIcz7jRbc0KgYPq9T/PT+PXc=; b=tP3qhjwCEQuwzFSnbi5zPBeeH
 2DRHUAYmEwPxP0/Mgv70UVBEbGkWtveOYNY9EPbCBWxrxBQoSqVeB1GwhORyMzJncJ1LpIyHztptw
 3ucqshefdgD9UKxOKgRzoBHNNIAqInLWBIPTys1c9n3RtGDr/OQSpqw4KRCMAjKCuXUWs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ikyKn-0006aD-GF; Fri, 27 Dec 2019 22:43:53 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 0B66FD01A22; Fri, 27 Dec 2019 22:43:53 +0000 (GMT)
Date: Fri, 27 Dec 2019 22:43:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Message-ID: <20191227224353.GN27497@sirena.org.uk>
References: <20191227174055.4923-1-sashal@kernel.org>
 <20191227174055.4923-5-sashal@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191227174055.4923-5-sashal@kernel.org>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Tzung-Bi Shih <tzungbi@google.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH AUTOSEL 5.4 005/187] ASoC: max98090: remove
 msleep in PLL unlocked workaround
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
Content-Type: multipart/mixed; boundary="===============8707414027786884469=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8707414027786884469==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Content-Disposition: inline


--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2019 at 12:37:53PM -0500, Sasha Levin wrote:
> From: Tzung-Bi Shih <tzungbi@google.com>
>=20
> [ Upstream commit acb874a7c049ec49d8fc66c893170fb42c01bdf7 ]
>=20
> It was observed Baytrail-based chromebooks could cause continuous PLL
> unlocked when using playback stream and capture stream simultaneously.
> Specifically, starting a capture stream after started a playback stream.
> As a result, the audio data could corrupt or turn completely silent.

This causes regressions, don't backport it.

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4GiSgACgkQJNaLcl1U
h9Ba1wf+JTLm9Xy9IZQEHitz8MmDgSB05uohq6xgipaiVvBS+AE9dV5vS+WMl7MD
NWtX6HLYJkfZ5c07WbFfK72FcgbST7ppoGkUP7++wc11ltb5oL39hMSoS/y/d6bF
D2QSiwg/1o2NJYCkAtxWDZDUJRVaqkegyP1yeSiWm/fMO9r7NLiU8sbJxSoHxGTv
QtqJu/iWAm8UBvYBsQEM6t3GMCctVlsVq64vOSle1TnjdPjhI+FnLTv+H0C8BztO
qVLM0p0sQG+SbL7YgijpTBI10A2w2Z6Dkqncspf2iAuppjxV1mxsPHWk2Bo/vn+1
VxVYBVB2Vh7/PAnWjL0n86N46IajDA==
=mRDX
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--

--===============8707414027786884469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8707414027786884469==--
