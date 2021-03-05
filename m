Return-Path: <SRS0=qX2V=ID=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF6C433DB
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 18:52:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34C46509A
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Mar 2021 18:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34C46509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 584BB1ADA;
	Fri,  5 Mar 2021 19:51:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 584BB1ADA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614970320;
	bh=3idx5+kPjlauvjxP2U80NOvMnVC9vfiBCM+ajkpdqN0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Le5AZFuiNmRXCdmba9vcUToPOM/s8X2xWNUTH0RapDO79qLqE8B/45QTnqJdC09BH
	 ngcpAO0q3svQMJe3TPFHYfuPWt463EVVgmysPeFMpXGHH4+WAsZe40Ju3Xl8thr4z9
	 7VCyo+jedk/XH4Kr47lRtxScJGHqemj+CcvTOKds=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA45BF80257;
	Fri,  5 Mar 2021 19:51:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BA21F8025E; Fri,  5 Mar 2021 19:51:07 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87BE3F800F3
 for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2021 19:50:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87BE3F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SQ6ZPsGM"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFC8C65090;
 Fri,  5 Mar 2021 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614970255;
 bh=3idx5+kPjlauvjxP2U80NOvMnVC9vfiBCM+ajkpdqN0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SQ6ZPsGMWQO+dcXCO/wPT9G0aO0mTGrViOwMqqZehxl1+nXYf/mV8qznCA/bYj3Az
 WuTVE1uQNVTVSK732zyC57UVpOZi2ShpDtJtfVXcl0J2TZOvXxFkLV4blxrU2p/lxX
 aTAbK0lmorAgGkCCe6d0J4Cn1sCaB0Y0jpVvZ4rpT1X94tNes9p9h5EHCiUL83o1rx
 1JsHvpv/3GtOOqCxHCetLKwO/M/PdJ5M7QSZiTCQJvm8NWSQ6rVQwGU7lo/IObm7FK
 HhNPrJ8ST3nVJwKU84fIKLX1lZzOBroY5Dz77fzESluNEDMgpexg0Vq1wIEiMpM4jX
 Ut1EvIUQwx+Bg==
Date: Fri, 5 Mar 2021 18:49:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH v2 06/15] ASoC: cs42l42: Remove power if the driver is
 being removed
Message-ID: <20210305184944.GC4552@sirena.org.uk>
References: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
 <20210305173442.195740-7-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20210305173442.195740-7-tanureal@opensource.cirrus.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>, linux-kernel@vger.kernel.org
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


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 05, 2021 at 05:34:33PM +0000, Lucas Tanure wrote:

> -	/* Hold down reset */
> -	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
> +	disable_irq(i2c_client->irq);
> +	pm_runtime_suspend(&i2c_client->dev);
> +	pm_runtime_disable(&i2c_client->dev);

You should be unregistering the interrupt, not disabling it - this will
better support any shared IRQ usage that appears and is much, much more
idiomatic.

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBCfUgACgkQJNaLcl1U
h9Ah/gf/V/Gxmbl9IRaNIRZvhenD73EaKj04ZmN5d2YMKVFoGYwvAiPcogZdH7P5
E9pI47Xib3JE2LlSe8/aJKC72tDatgYSDU2bj1zRgx07NEzA5wKyt16j/yD43+kx
IVH3q6ZQKxAQ8poAs/n5FFOrJ05Ii7Sdxzl0l3ns18KiyY4XEetlD9GHcrzn6wrr
wvDdfjOVd0wOAgwC8H3231OEGqrALq/RTSb4zwPdbs/pgEyBj8qB6sSBhKHuq4uE
JDeUa2Ia0KyiRnZGOBy8xpbS5PEKZioZMaLYKsPB0BweuvO0hfaVVY2VpSPKP7ZU
SY+zekeFJ699pBSVx1FmtBbyYjJTDw==
=48aq
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
