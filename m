Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D10DC2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:12:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0C52070E
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 16:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O/h9EA3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0C52070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C3ED166F;
	Wed, 29 Jan 2020 17:11:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C3ED166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580314336;
	bh=fzZPUluOkKnlmLi/W2A9zWkNcwTU2DQte2HfGA1aaGY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O/h9EA3nSHdj9uMFeXde9TFbZxBaTq3Ohj2I/SriBPvLy+LyAhV7QF4z5z+/m053c
	 ehm7FVLNDBWFxaJzN7A+hK2eM1zo/WohTM7/DUfzuKmIkFE3hYtHxAqtWeHgNeEsRl
	 RD6UShoYRgHC4QUF4K3YHP1Jq8/gbX9v46FJ1r+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CDFFFF80218;
	Wed, 29 Jan 2020 17:11:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 726CCF8021E; Wed, 29 Jan 2020 17:11:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 296A1F80122
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 17:11:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 296A1F80122
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9897A328;
 Wed, 29 Jan 2020 08:11:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 171023F52E;
 Wed, 29 Jan 2020 08:11:17 -0800 (PST)
Date: Wed, 29 Jan 2020 16:11:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Sangbeom Kim <sbkim73@samsung.com>
Message-ID: <20200129161113.GE3928@sirena.org.uk>
References: <5e31aaaa.1c69fb81.a7667.f187@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <5e31aaaa.1c69fb81.a7667.f187@mx.google.com>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org
Subject: Re: [alsa-devel] next/master boot: 148 boots: 10 failed,
 136 passed with 2 untried/unknown (next-20200129)
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
Content-Type: multipart/mixed; boundary="===============6753911349523547415=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6753911349523547415==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 29, 2020 at 07:54:18AM -0800, kernelci.org bot wrote:

Today's -next fails to boot on Odroid X2 and XU3 with exynos_defconfig
or multi_v7_defconfig with SMP=n.  It appears to get stuck in a loop
probing the I2S secondary DAI for some reason:

12:07:05.997409  <6>[    6.421596] exynos-bus: new bus device registered: soc:bus_mscl ( 84000 KHz ~ 666000 KHz)
12:07:05.997653  <4>[    6.429763] samsung-i2s 3830000.i2s-sec: DMA channels sourced from device 3830000.i2s
12:07:06.006838  <4>[    6.439652] samsung-i2s 3830000.i2s-sec: DMA channels sourced from device 3830000.i2s
12:07:06.015764  <4>[    6.448666] samsung-i2s 3830000.i2s-sec: DMA channels sourced from device 3830000.i2s

and so on ad infinitum.  Vanilla multi_v7_defconfig is fine and just
displays a saingle copy of that log message.  Full logs and other
details here:

	https://kernelci.org/boot/id/5e3176467f121dbdef2824fc/
	https://kernelci.org/boot/id/5e317b7322dcdaa3e5282500/
	https://kernelci.org/boot/id/5e317c0f6bfd765fb42824f1/
	https://kernelci.org/boot/id/5e317517be8559c7542824f1/

I don't *think* it's an audio issue as mainline seems fine and all the
ASoC changes have already landed in mainline for this merge window.

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4xrqAACgkQJNaLcl1U
h9ATugf/ZQktKxJUE958PkbhFp8L06jo/MfX8fgEE6ntse19PBpXeuilaGQUAPJ7
JMfQp+W9juAvCnOSh9WFvc1jzs+gVNS8KgxuPNVwNsFf2IrRRegGtC/WnnadBjJ1
Ud/4su9USIquKP1QAI/6J/PayS06xyzkwWIiO9F7YqWHUQlS3sijE3rR2ik3NqRU
Xelgon/8TonC//tBv6OSP3aX2y1US/l1P8fqtZBpQL/wz7ZBxuaWaK5Mk46ppSmk
O2X9aooL11ie3Bo2erGOQomMcy8/i70DqCzGwCXdoay1BPENPNZ9mMTmCBrEvHfL
amhYBa+Zwl2H9Gl09SNTzgjQY7b/Ow==
=2GQU
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--

--===============6753911349523547415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6753911349523547415==--
