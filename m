Return-Path: <SRS0=DUcU=XG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4D5C49ED6
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:52:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC4420CC7
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ib2daWg+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dmS8IhYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC4420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 950A2171C;
	Wed, 11 Sep 2019 12:51:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 950A2171C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568199150;
	bh=oX+hmEj/8vxco2SyudQzvgMylUQHKSx9QkL+sCA9CCE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ib2daWg+tRYWoSO9Irywy2oJxeJ8XSYRmB3UT2eYwT4j2bjiD2ukjXnImnBqvpzAl
	 Sh0PpG8KUAhfkvWo8be6YNK1sdickrzrbASVsmN1Rbvo2pQmIH08pyNoxVJn33TnOV
	 CMjHfb5NrKkl/mbbLeF/Vz2uZr3Dxi0ndfQPvYfU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E6BCF8031A;
	Wed, 11 Sep 2019 12:51:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D140DF800A9; Wed, 11 Sep 2019 12:51:37 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5647BF800A9
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2019 12:51:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5647BF800A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="dmS8IhYz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fb8QmfcM6+bHa12eOMWxQHKCXWAsQRSOTaIAwdUDGXE=; b=dmS8IhYzgJSx2wo+NEVFycnHi
 UlsetVnoOcYmgqf4uRccXocYARHtxRtkKS0Pudu1zhZ5F7Alsrvdss/TTak172MmZznVuzuq5g0id
 hyWWCrMJFPL6/3TG1eT9DX3RTN7oWeqF0nUdyKSCe4GhBmD5Ztp26fJg6AS//5YX/OKFA=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1i80Dk-0008Jn-0H; Wed, 11 Sep 2019 10:51:32 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 5A1D9D00330; Wed, 11 Sep 2019 11:51:31 +0100 (BST)
Date: Wed, 11 Sep 2019 11:51:31 +0100
From: Mark Brown <broonie@kernel.org>
To: shifu0704@thundersoft.com
Message-ID: <20190911105131.GY2036@sirena.org.uk>
References: <1568197529-4385-1-git-send-email-shifu0704@thundersoft.com>
 <1568197529-4385-2-git-send-email-shifu0704@thundersoft.com>
MIME-Version: 1.0
In-Reply-To: <1568197529-4385-2-git-send-email-shifu0704@thundersoft.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, navada@ti.com, tiwai@suse.com,
 robh+dt@kernel.org, dmurphy@ti.com
Subject: Re: [alsa-devel] [PATCH v2] tas2770: add tas2770 smart PA kernel
	driver
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
Content-Type: multipart/mixed; boundary="===============3447118801827446179=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3447118801827446179==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H7DA0n3a+SnB4bJ2"
Content-Disposition: inline


--H7DA0n3a+SnB4bJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 06:25:29PM +0800, shifu0704@thundersoft.com wrote:

> +++ b/sound/soc/codecs/tas2770.c
> @@ -0,0 +1,954 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0
> + *
> + * ALSA SoC Texas Instruments TAS2770 20-W Digital Input Mono Class-D
> + * Audio Amplifier with Speaker I/V Sense
> + *
> + * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
> + *	Author: Tracy Yi <tracy-yi@ti.com>
> + *	Shi Fu <shifu0704@thundersoft.com>
> + */

This is a C style comment not a C++ style comment.

> +static int tas2770_regmap_read(struct tas2770_priv *tas2770,
> +			unsigned int reg, unsigned int *value)
> +{
> +	int result = 0;
> +	int retry_count = TAS2770_I2C_RETRY_COUNT;
> +
> +	while (retry_count--) {
> +		result = snd_soc_component_read(tas2770->component, reg,
> +			value);
> +		if (!result)
> +			break;
> +
> +		msleep(20);
> +	}
> +	if (!retry_count)
> +		return -ETIMEDOUT;

This appears to be the same as the previous version?  It looks
like we still have code to hande the device randomly resetting
underneath the driver - like I said we really need to understand
why that's being done, I'd strongly suggest splitting that code
out into a separate patch so we can review the base driver and
hopefully merge it while we discuss this reboot support.

--H7DA0n3a+SnB4bJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl140bIACgkQJNaLcl1U
h9DPdAgAg5/Xr71P8Q6mf/bfG1iLz+/TfNsplKMTskvGTVVtUue5zPE1ptG6WZ5L
2fYEJ/CBBqbuGg2faUb8m0hBIGYcS/hTuOG/ZpQ9qJqZKYCYhHf9Vq5vnPEodiTx
83K1JQrBDmNPmkgxMuGs6Bw4Hk+d4Rneyu/kPfRx3bi5FcwbdPYK+cUb0s/I31s9
IWVodTlRPi4yhdEfjemx68QplB2JrQCDTDSLfKTlMRTzzxDJ1qGWxQ5JZji1yYhb
JpfsEMRIZzoErRhlEu52AzJL0Fdb4OCejmlzpBfQ54xiyoBM7ZuLV++9FPWdlSYi
PMt4GcEJZ6gS1UtdPYtizHwco2a1kw==
=mutQ
-----END PGP SIGNATURE-----

--H7DA0n3a+SnB4bJ2--

--===============3447118801827446179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3447118801827446179==--
