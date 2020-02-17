Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A5DC34022
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:44:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93385207FD
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tlnsmXjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93385207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E8BFE83D;
	Mon, 17 Feb 2020 15:43:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E8BFE83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581950662;
	bh=gWcyInVWYkGQYLY6TE2AxRBHe/rEdM11rLQVFv7/aU0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tlnsmXjg57Hhma/23Hw4awls+K2e9Q+kUoMyDueIA48y96+rJ7gzIJSFkK85sSjxU
	 +jlHQh9fq1dV2YLD4K+TrrCDy/hg/N4nyobXnR2Ndxrhqtj0gLbGmGDA+WKTCUItEZ
	 5+55m1SoBvMCW+ms+MgOukDN9W+iaTSsPHe5f4OQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 611B0F80172;
	Mon, 17 Feb 2020 15:43:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB814F801F5; Mon, 17 Feb 2020 15:43:28 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 7928DF800C4
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 15:43:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7928DF800C4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A28BC30E;
 Mon, 17 Feb 2020 06:43:24 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257A83F703;
 Mon, 17 Feb 2020 06:43:24 -0800 (PST)
Date: Mon, 17 Feb 2020 14:43:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Samuel Holland <samuel@sholland.org>
Message-ID: <20200217144322.GE9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-3-samuel@sholland.org>
MIME-Version: 1.0
In-Reply-To: <20200217064250.15516-3-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>,
 stable@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [RFC PATCH 02/34] ASoC: sun8i-codec: LRCK is not
	inverted on A64
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
Content-Type: multipart/mixed; boundary="===============8255929010299751292=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8255929010299751292==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 12:42:18AM -0600, Samuel Holland wrote:

> +	scodec->inverted_lrck = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +

This is going to break the moment someone finds another quirk for some
variant of this device, it's not scalable.

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KpokACgkQJNaLcl1U
h9ALhQf+KpZMG6XlWXOf5M+RQbrrlJ7G6eHlAz9WNWS6pBlAdaLNxekgK+nHQJos
xgRQQ+WfRPwkVwkQqQ78pknN7GNtJA47rvXZskBUGBiYErsA8awxR7NQ0MdVgHt7
IER95dS+HOIU9qzfu/qXPJzL7FYmNiBgxG2766bd5rboIqr3GXhAsYa7phl3XPZo
HBwmnZ8DP2xN4op0fRBwZ/L855fSoATnNyoSPMabDa530WwUYyiUk+2BXYk8TaRB
Ck+OXm50qHCp8JHXoQox+uQzIyqVjtjp4czaGJeMlHQ+7ocwLa8ltTMkCfDUlzU6
zdaJIgMVGilYkB59EaFQL0UQ8j1TmA==
=ggb0
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--

--===============8255929010299751292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8255929010299751292==--
