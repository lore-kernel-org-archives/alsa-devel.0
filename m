Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E897C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 12 May 2022 10:54:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF14D1A28;
	Thu, 12 May 2022 12:53:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF14D1A28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652352849;
	bh=LCPGdta7p+6aXKFPfhnyvHZTQKRdcvBKmz+5TOPyuVc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZN6lpXH0tvxH0zj9p7ANY8uE8Hbrp5/sShyYjrRfpp30n+at+1nnMP2C5QL2f+2OR
	 zei8vOSYf5jmIcAvmDfjX9ETyIY+0f7Ujva0f+Bm8LbonMU5Xn9u/8JFfoM1u838wU
	 aUHzwskWpV6y3+vm8uItgENn2FDZJh/e/F78sczM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63BFCF80154;
	Thu, 12 May 2022 12:53:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B364FF80245; Thu, 12 May 2022 12:53:17 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57363F8011C
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2022 12:53:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57363F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gAd2qfIU"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AC8B561DD0;
 Thu, 12 May 2022 10:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6243FC385CB;
 Thu, 12 May 2022 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652352792;
 bh=LCPGdta7p+6aXKFPfhnyvHZTQKRdcvBKmz+5TOPyuVc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gAd2qfIUiXBmaRgfEgtCQahrXW6XIgCGFsV21I2lVUtQGFTbzaAM09z4NYekEmOsm
 /L29phErbXupFGBYVkRPJ5dFWNctHOxu3lToissjFtRnJpksDOCFnb3+7tP9NzMo75
 rRT4Kg8v21UZTibd+gQjZVC0Dud9qQUXslFFYFnztzr0TawxejiX+773/CtPnqh2OO
 9IHNikr53Yom2cEsp59d3gepLYO3njzn1fTadKSjbVtFFwV86UMntXVvaH4LDydwJ3
 A8ZWebclliFzSI8SS0NqlGidLU1Aj8X2F7fIx7bzMs3JVx2tEK7P/DC3kM58wy+ptG
 KhirY3FY/8psA==
Date: Thu, 12 May 2022 11:53:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <YnznExLDOvRpXNVh@sirena.org.uk>
References: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
 <YnzdcubW7m+CwnvN@sirena.org.uk>
 <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CKVB2CjTPqpFtP1S"
Content-Disposition: inline
In-Reply-To: <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
X-Cookie: Oh, wow!  Look at the moon!
Cc: alsa-devel@alsa-project.org, linux-amarula@amarulasolutions.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linuxfancy@googlegroups.com, linux-kernel@vger.kernel.org
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


--CKVB2CjTPqpFtP1S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2022 at 12:46:42PM +0200, Tommaso Merciai wrote:
> On Thu, May 12, 2022 at 11:12:02AM +0100, Mark Brown wrote:

> > These look like they should be DAPM controls since they're controlling
> > audio routing but they're being added as regular controls.

> Sorry again. You suggest to create a new structure for these entries,
> for example:

> /* Out Bypass mixer switch */
> static const struct snd_kcontrol_new max98088_out_bypass_mixer_controls[] = {
>        SOC_DAPM_SINGLE("INA Switch", M98088_REG_4A_CFG_BYPASS, 7, 1, 0),
>        SOC_DAPM_SINGLE("MIC2 Switch", M98088_REG_4A_CFG_BYPASS, 4, 1, 0),
>        SOC_DAPM_SINGLE("REC Switch", M98088_REG_4A_CFG_BYPASS, 1, 1, 0),
>        SOC_DAPM_SINGLE("SPK Switch", M98088_REG_4A_CFG_BYPASS, 0, 1, 0),
> };

If that's how they fit into the routing for the device, yes - you'd need
to define the bypass mixer as well and set up appropraite routes.

--CKVB2CjTPqpFtP1S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ85xIACgkQJNaLcl1U
h9DvDwf/e+ofKzwgZXoBDaBr7aGL0BNyy6uJeFn8xgNBBkoMYpIVAOtd/mjeCq59
iJnxneFalVb7PAaICPVnVHiMmhM99HdY+PHzexxB/Ep0edkqvyvKzto0It8agD2i
FUw/1u/JG60D1NWq7csC/aGzWEdznAat+unlmdMUmNpG+gM+gQyJmvUbLMmD2fAS
pUo9WARMg+63ufOfpYSkKKnHcZD4NlBW/QM3yxt6PcOCDxOufmdg0YbWzFEnSgZe
5/gTDDJQ5fORpmV/qlT5kYudiGjmNuG9fZOjd2Uu3Qx8cgrYXI0jRlOIlRsI0UP/
M4V/w2MBcHZgULbvfttopdB4/Gj9hQ==
=MmmH
-----END PGP SIGNATURE-----

--CKVB2CjTPqpFtP1S--
