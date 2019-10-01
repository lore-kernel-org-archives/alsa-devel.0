Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD9BC388F3
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:04:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBA421855
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TSr6jmex";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="u6Q8yJ0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBA421855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 289AC1661;
	Tue,  1 Oct 2019 14:03:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 289AC1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569931461;
	bh=anGd/FGISSYRWr5Fjz/KzG7pOh3qHEtQRwQcO32XieA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSr6jmexChrJm8lbDHzEstaEdStCy1NzRSOS5xwMjdhc74WUbGZQJBrmYDR6tb1IU
	 MN+zV1poKqq2qrZot2nhxJp1A95KcLwIhC55su5TjOKmfAsPUPSj9cTBeQODub9lc7
	 5kEqPiLLapD+ITyU8nFTs9pZvWjstmu8iL8kUdNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E884F805F8;
	Tue,  1 Oct 2019 13:44:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31192F805F9; Tue,  1 Oct 2019 13:44:19 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39D72F805E1
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 13:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39D72F805E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="u6Q8yJ0d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EvWNvJMXaksJlF9wvagA6fpqLd2/rERWUg/jBbuLB0s=; b=u6Q8yJ0dimSfXH+3jCenyMK8p
 KPk5EbEnqQJ09VOUOD1iZcpZSy0uHzSWmaqmKJ2iTA1JoOh9Z21U28o7X8J2h+cbl7vYs9sZLSUKK
 ZfpmzWsJdgBsNP2xyY5l4vx1Rg5PpS43Zr1okUG+X9LJ546oYK8eoJaAD5uGonQkXz7f4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iFGZk-0004b7-7u; Tue, 01 Oct 2019 11:44:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id A8E5A27429C0; Tue,  1 Oct 2019 12:44:15 +0100 (BST)
Date: Tue, 1 Oct 2019 12:44:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <20191001114415.GB4786@sirena.co.uk>
References: <20190930165130.10642-1-ben.dooks@codethink.co.uk>
 <20190930165130.10642-6-ben.dooks@codethink.co.uk>
 <6d6ae684-dd5f-b180-9114-dafe12886d4f@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <6d6ae684-dd5f-b180-9114-dafe12886d4f@nvidia.com>
X-Cookie: Keep refrigerated.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v3 5/7] ASoC: tegra: set i2s_offset to 0
	for tdm
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
Content-Type: multipart/mixed; boundary="===============6457369030198270429=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6457369030198270429==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 30, 2019 at 09:52:15PM +0100, Jon Hunter wrote:

> My understanding is that the difference between dsp-a and dsp-b is that
> dsp-a has an offset of 1 and dsp-b has an offset of 0.

Yes.

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2TPA4ACgkQJNaLcl1U
h9A+Owf7BGtMUWznPui3fHwOqsLBFqxq6KDL31MqnMLunEAAFc0EbKlVFjUvi6Bq
eGIj2OxGZ8hk8qWRiqAyVBh2RuDk2xzCBpVcz/H0pk5Lm2Uhn6O++7K2i2z+e3BC
p7KP1hvskrS3Oidev2vyfy+xoV2MropXU61RMSSKQevM3TbYXsupYQR5kuwwXdKo
XK2Wd9YZuk7FWJdUa7ArEdXOqdZu66SjGOMijN71vfJ2A4M+ds1+jYh5umMYjWtl
aJbUUr+kvk6Pjxsr0kMwgei6tT1iJ79VPMBuEsSt4UUD47YMWF/oilqldjoMNT0d
X5z6WuReKXFlijI1XcrpjFgEGVZ30w==
=TrRV
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--

--===============6457369030198270429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6457369030198270429==--
