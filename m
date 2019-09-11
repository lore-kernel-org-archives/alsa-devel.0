Return-Path: <SRS0=DUcU=XG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F7C49ED6
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:13:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FDA207FC
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qfRJgpEt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="u0FZLYzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FDA207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D6581704;
	Wed, 11 Sep 2019 12:12:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D6581704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568196806;
	bh=r7mkjNLskewbshlHwDU+fSsoGmigYSHsV45k3i19zps=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qfRJgpEtqKm4NmYZ1YM1X3ZKu8vWhQW4NJqmI/BLKQTNKZUOCCKJA2QySU8s2qDrL
	 cYFx7DIegnPksbpq8YHPG4dKxWlNuE1/uzAg/AZe4xVc1zaIK1CogrHTUdOnmHQ4wY
	 LWsb3UOhxfKjR2aHKGLXc6PSuTbjlo2uAdIucwA4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6BB1F8031A;
	Wed, 11 Sep 2019 12:12:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39698F80323; Wed, 11 Sep 2019 12:12:35 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA4BCF802DF
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2019 12:12:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA4BCF802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="u0FZLYzm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ep0j7m5xNfG4CR6HHkPWK2kdBVsDxedxi47kQTEiChI=; b=u0FZLYzmH84kRI/HHbIR4jvdR
 2C4c+MORLpTVFvfvtpOgUR72Ie81FZ0WI5cT7wZG/H0kPOJsJao2htnaEBzSIc9+GXIkGonEV1BjC
 cLWQEUlhORQUEIAUl9+71DDfz8HTcGXwmNVmObPsLP8BfRtYNie3TebUrcKAv5NOAhB7M=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1i7zbz-0007as-AB; Wed, 11 Sep 2019 10:12:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 6E4F0D02A53; Wed, 11 Sep 2019 11:12:30 +0100 (BST)
Date: Wed, 11 Sep 2019 11:12:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Message-ID: <20190911101230.GT2036@sirena.org.uk>
References: <cff8bff1e8d3334fa308ddfcec266a5284e3c858.1568169346.git.shengjiu.wang@nxp.com>
 <08524f143c18521680b724ab98375828fc18ab2b.1568169346.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
In-Reply-To: <08524f143c18521680b724ab98375828fc18ab2b.1568169346.git.shengjiu.wang@nxp.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, robh+dt@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: fsl_mqs: Add MQS component driver
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
Content-Type: multipart/mixed; boundary="===============0777595687737963571=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0777595687737963571==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HywJcj55HbA57jnN"
Content-Disposition: inline


--HywJcj55HbA57jnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 10:42:39AM -0400, Shengjiu Wang wrote:

This looks good, a few minor comments below but nothing major -
it's mostly nits with the DT binding.

> --- /dev/null
> +++ b/sound/soc/fsl/fsl_mqs.c
> @@ -0,0 +1,336 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ALSA SoC IMX MQS driver
> + *
> + * Copyright (C) 2014-2019 Freescale Semiconductor, Inc.
> + *

Please make the entire comment block a C++ comment so things look
neater.

> +	/* On i.MX6sx the MQS control register is in GPR domain
> +	 * But in i.MX8QM/i.MX8QXP the control register is moved
> +	 * to its own domain.
> +	 */
> +	if (of_device_is_compatible(np, "fsl,imx8qm-mqs"))
> +		mqs_priv->use_gpr = false;
> +	else
> +		mqs_priv->use_gpr = true;

The GPR was listed as a required property in the binding document
but it is only needed here so the binding document should say
"required if compatible is...".

> +	} else {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		regs = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(regs))

You can use devm_platform_ioremap_resource() here.

> +		mqs_priv->ipg = devm_clk_get(&pdev->dev, "core");
> +		if (IS_ERR(mqs_priv->ipg)) {
> +			dev_err(&pdev->dev, "failed to get the clock: %ld\n",
> +				PTR_ERR(mqs_priv->ipg));
> +			goto out;
> +		}

The core clock wasn't listed in the bindings document.

--HywJcj55HbA57jnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14yI0ACgkQJNaLcl1U
h9BO/Af/aIFQPppNc8K51nmTQbe5/qlY6KawrXb2O2vnWrT0cZMpaXII/WfVHarC
N5tQrIStSR99l5V93WUkKolVo3SJS2Gg5Opo4XLHTFt9vHlhOYX8iRt0xz5B+UF9
qKo8AHuR0kOSAsRy2w9lEFq07cRPSFR9bQH3axNxUybh7v6YEbo473gX0rRf3qUL
HRfeAMEzjuK5CQz74088qfUQmfiDoVbCC+cbvkUeWhR0/VbZA3zdeos3wbUDRqrA
KJGMzwAyQISn8+uXAEUNzmepdcKl/tec9JJCjZHh/lSTnMQwAwj6/NPhDhIZwCmy
5GYinXK/xsebKn2yLidfvP2yyzICdw==
=GpDq
-----END PGP SIGNATURE-----

--HywJcj55HbA57jnN--

--===============0777595687737963571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0777595687737963571==--
