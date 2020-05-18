Return-Path: <SRS0=lMNw=7A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220ECC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 10:26:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A261720657
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 10:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rkp92xVt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="esCVAepP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A261720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3EB016CA;
	Mon, 18 May 2020 12:25:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3EB016CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589797576;
	bh=Eaeopgb7k64NvMRJRFgKStNcTRQI/XLC/CYzyt+WMZM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rkp92xVtDQB7F0Bnj+9YpCUBGuK3Lmz+oj0ON/31mldp8NHX9liKyyZon6dyY5fJQ
	 wTpjm4QTJl3tGVXBF34G08qZm/dp34M3b4fp6SgBnt4a1+p/jE8PyoHcid1bxBAB9C
	 UiI/MqST0CqXwgQr5TPUYau1KnCu0gwbx9FGB1Jc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46EB1F8015C;
	Mon, 18 May 2020 12:25:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87DFAF801DA; Mon, 18 May 2020 12:25:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 526C4F8015C
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2020 12:25:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 526C4F8015C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="esCVAepP"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9047A20657;
 Mon, 18 May 2020 10:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589797516;
 bh=Eaeopgb7k64NvMRJRFgKStNcTRQI/XLC/CYzyt+WMZM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=esCVAepPOf2uIfV4GcU4IVH5KCwyFK5iyZq5UBUM6vL5beEz3krpBi66kjN4sfuV5
 +LF+4ve0dcSh6BUfua9fo+3rjQztB9nZwNO6hv1Pfz4UwXeYbWolvR6PuLOKQiGSVS
 YMF+XTc6C1RuWqZm0egXkJ6G3zGXdbI7n5CkvwIQ=
Date: Mon, 18 May 2020 11:25:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: Fix format and unused assignment
Message-ID: <20200518102513.GA8699@sirena.org.uk>
References: <20200518074405.14880-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20200518074405.14880-1-tangbin@cmss.chinamobile.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
 linuxppc-dev@lists.ozlabs.org
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


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 18, 2020 at 03:44:05PM +0800, Tang Bin wrote:
> In the function fsl_micfil_startup(), the two lines of dev_err()
> can be shortened to one line. And delete unused initialized value
> of 'ret', because it will be assigned by the function
> fsl_micfil_set_mclk_rate().

This is two separate changes with no overlap so would have been better
sent as separate patches.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7CYoYACgkQJNaLcl1U
h9DxVwf9EjET5pmKEmkJIyEEevXgdVBnEiqOseuE559viDAK89WlL+AGIO+0E0+P
rALP/qUBAX1MVom2U+GtBsuYLlSYKjP4g7vTwcKihKhapvLL50UyRD41wdE0sYAo
cfZd+cZrNUKRtyoUjpEMssa8xiz2f6ygBWbvqOO3MRCLyEraQ5bF5+OkcanGY9j+
k0L5GL1cjdX5Ts6QkdO0EF1JOgCzgUKOETwQC/U8KKw26Gvn6pngBVRJZGFEvI83
cKKf3NQeVZtsO0g+qsl+mU4jXuIdkTv0Z1ptdvCa/MhhYkbzLWoiJh+jqoldRJ3s
Jcb75FYE6uBLd1xSoB8ybjT/KGOY9g==
=CoR6
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
