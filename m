Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175BFC4346E
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:06:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EA1216C4
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S+V+ZesF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFMIFWWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EA1216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B79FC16B4;
	Mon, 21 Sep 2020 21:05:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B79FC16B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600715194;
	bh=Z+nsJCPU/F5vhcfsVUjdc0LGbpEOpJ8PL57Fv04B9g8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S+V+ZesFY9qMWhTX41KUGWDfG82EAnm37IYLkyH5ufwaBMbu7sTAZsNsvS1YpZbqb
	 IqZRcFn4WVuQicQu6r18ZHtOVNIaZsHGH9yHiR/hJWBET6+Y6UGeIn+RxR3UqjK+tL
	 PCL/5JWPXxPXlD0Weax23PRymcIDd+4KfxWuQTMo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35E69F800B2;
	Mon, 21 Sep 2020 21:05:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BEC2F80162; Mon, 21 Sep 2020 21:05:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09711F800B2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 21:05:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09711F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VFMIFWWu"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8B1502086A;
 Mon, 21 Sep 2020 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600715130;
 bh=Z+nsJCPU/F5vhcfsVUjdc0LGbpEOpJ8PL57Fv04B9g8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VFMIFWWu6zIOeETAyj2qQjFCanjQwssfHT8qiXUTLrcwLSLA+mem9L2XU1jwXcItX
 yyAYl4mVuZnQdlrsROxzX7hDb5bKKLdCmQou4WnZ+vG220ykIxTeNIHpvPuNd0Qm3y
 RX6kif6QzkUabtZU9jz6u3pJAN1ymmIKVXF+KAts=
Date: Mon, 21 Sep 2020 20:04:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 6/9] ASoC: tas2770: Convert bit mask to GENMASK in header
Message-ID: <20200921190437.GJ4792@sirena.org.uk>
References: <20200918190548.12598-1-dmurphy@ti.com>
 <20200918190548.12598-6-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QxN5xOWGsmh5a4wb"
Content-Disposition: inline
In-Reply-To: <20200918190548.12598-6-dmurphy@ti.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
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


--QxN5xOWGsmh5a4wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 02:05:45PM -0500, Dan Murphy wrote:
> Update the hardcoded masks with the GENMASK macro. Also update some of
> the hardcoded bits with the BIT macro

Cleanups like this should come after any fixes in the series, that way
fixes can be sent as fixes if needed which isn't appropriate for random
cleanups.

--QxN5xOWGsmh5a4wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9o+UQACgkQJNaLcl1U
h9DRYQf+OmG7fcyQnhVmWY5UjYnz30wXYinU51PregENPVmAEEpyk/K+Rxcax9jZ
FGbnbx9fha6RTsya4rvHELI3nWt0MGfx4aR4zudhiEWCaYpR++h5iZxIU79COxCT
DlW4wRQqxycA7JNNRHin50FtIPBEUyskpbhlITdaFemnAqDGBGaf800aiAvLAgJq
au85ttHLZkuXvkeCnLcpVcJw9afiKilJjgoBTOaC6qKJ4xpEZK7XAHFY/mNtUi3w
0GfeIwe0S2J0newEHXkPa2y7s8+0rtlVTRkVnZxy1nqm3+EXyROoRImUG0O8koru
WpI9EJTvH2p5CJXHIc2J40XjdbXleQ==
=xBBA
-----END PGP SIGNATURE-----

--QxN5xOWGsmh5a4wb--
