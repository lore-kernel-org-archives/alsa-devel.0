Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD7EC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:23:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673C520692
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YU9pHuYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673C520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83EB21657;
	Mon,  9 Dec 2019 17:22:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83EB21657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575908613;
	bh=s+he4v7QIbP32xVX3/QyusbT8+KIm+6Ivbzw0gZJDbI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YU9pHuYr9ZkSXxfOxKOUB6lMri3j/EyMHyx95L0wQ8ofGRQyVY9k3ufTRUnOk5HTh
	 9hpZuOhJditpy1tCIscnrMWx9A/Ms88gfuP0GzbN6Ybb+aZ+4tFhpTjicPxuOh0b0a
	 s4dwBsAnim743tPVoj2pxjusSAflVn8jNywxGehg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F35E0F80234;
	Mon,  9 Dec 2019 17:22:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C925F8023F; Mon,  9 Dec 2019 17:22:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D31B4F800C4
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 17:22:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D31B4F800C4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 909FF1FB;
 Mon,  9 Dec 2019 08:22:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5E63F718;
 Mon,  9 Dec 2019 08:22:35 -0800 (PST)
Date: Mon, 9 Dec 2019 16:22:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
Message-ID: <20191209162234.GC5483@sirena.org.uk>
References: <20191206075146.18011-1-hslester96@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191206075146.18011-1-hslester96@gmail.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>,
 Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs35l32: add missed
 regulator_bulk_disable in remove
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
Content-Type: multipart/mixed; boundary="===============4849470410604287614=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4849470410604287614==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 03:51:46PM +0800, Chuhong Yuan wrote:

> @@ -501,6 +501,8 @@ static int cs35l32_i2c_remove(struct i2c_client *i2c_=
client)
>  	/* Hold down reset */
>  	gpiod_set_value_cansleep(cs35l32->reset_gpio, 0);
> =20
> +	regulator_bulk_disable(ARRAY_SIZE(cs35l32->supplies),
> +			       cs35l32->supplies);

This is a similar situation to the one Charles pointed out - the driver
is using runtime PM to manage the regulators so unless the device is
active when removed the regulators won't be enabled.

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3udMkACgkQJNaLcl1U
h9AU4Qf9H2kZfcwmeY5MnJNJT2wlY1Tz0Bn4avIuaWh6VHTc2FK9mHpLixpWBCeL
lviOMF4oPXUBhG28OeW33WoWQ2ZYPKyUFEZqRAmy/UYFFRhk8yJHjtrgwcD3GrGz
bFNKyeixLFD2s1a+P6mlTotWCHm3coCexdV3PnvdstSIIgyCPm/NmnRZ42jNhlQ/
7VA4R1z6bX5K8yux74SO+QH43m4Zveh+52BMT//oC72pspDAy6KwmgVnYDmfWiY4
wWTYSoH3R7Ol4BUcv0VqV5laqa8vZ/rcFpOOUPxFXbdRVPVCGyL6oJinOzd5t//I
40Zl4lBKeSRR15moeKPfk7fWu3R/cQ==
=FYnw
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

--===============4849470410604287614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4849470410604287614==--
