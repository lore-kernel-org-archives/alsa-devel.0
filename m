Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77891C3064E
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Aug 2023 15:14:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C1E7828;
	Thu, 17 Aug 2023 17:13:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C1E7828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692285267;
	bh=pWiJeGGcqHTCNGywMgIQopKlLzfQN2ydYmyGNuoOECM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qTNslH++4yKuNlCVNPKzU0/FDC03QJCJlWeOecidfHWVmsXBJZ5FVDYUqLVETRS4l
	 jvM+7wX1KoiNDFEmymNtOBlnnNe+BTd1BfpAqLnkAWCVGX2myEDMJkVnRKZcx+m8c6
	 MGHciaAZODNVgR720Kv4IauAKyYx/qpUcEk3xFoU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40E5AF80027; Thu, 17 Aug 2023 17:13:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A81E8F8016D;
	Thu, 17 Aug 2023 17:13:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C03E3F8016D; Thu, 17 Aug 2023 17:13:02 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57257F80027
	for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2023 17:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57257F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EM2X0Uwf
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B05516137A;
	Thu, 17 Aug 2023 15:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9046CC433C7;
	Thu, 17 Aug 2023 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692285167;
	bh=pWiJeGGcqHTCNGywMgIQopKlLzfQN2ydYmyGNuoOECM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EM2X0UwfjjEDWxKfSF2kM6PxPJ8eLL1lTN6t1hrbkuuJYN3Thy3zqeEO+1m45eBAf
	 qZ3V0br+zbKNJRMDpArt7XXoO2Y8H11iXchO+/8/NgA1aWuyMcV3yPNF8HYGUsb76X
	 fqmnw3GOVV7z4q//lKducexS2NmdfSsunfubOHhaFHTS+sKK6CZzaQvHGpqBlpvGT0
	 jtNahnXxXxHBcE/KdpeqVpVnqS8ntcvlUI9fxnbfjqOE4lwDUW6SFStttPL8QYjvgm
	 VyeE/RhxAbdJndzN1qbODwBuBmMuWv44qEzNe0PLJSfFTzqiX7hRpXw099AmhtYNiR
	 2hlvXkfvndmkA==
Date: Thu, 17 Aug 2023 16:12:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Baojun Xu <baojun.xu@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, shenghao-ding@ti.com, kevin-lu@ti.com,
	krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
	shumingf@realtek.com, herve.codina@bootlin.com,
	povik+lin@cutebit.org, ryans.lee@analog.com,
	ckeepax@opensource.cirrus.com, sebastian.reichel@collabora.com,
	fido_max@inbox.ru, wangweidong.a@awinic.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	peeyush@ti.com, navada@ti.com, tiwai@suse.de,
	mengdong.lin@intel.com
Subject: Re: [PATCH v2] ASoC: tas2783: Add source files for tas2783 soundwire
 driver
Message-ID: <19414ebc-1c33-4482-965d-681f15f06654@sirena.org.uk>
References: <20230814121158.4668-1-baojun.xu@ti.com>
 <b28b5187-e775-4c4d-635e-9b867a19588e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="inTGoYk3RnzWcyrI"
Content-Disposition: inline
In-Reply-To: <b28b5187-e775-4c4d-635e-9b867a19588e@linux.intel.com>
X-Cookie: Walk softly and carry a BFG-9000.
Message-ID-Hash: IPQXF6OXJKPRU7O5SXYQBJCO3YPHSWK7
X-Message-ID-Hash: IPQXF6OXJKPRU7O5SXYQBJCO3YPHSWK7
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IPQXF6OXJKPRU7O5SXYQBJCO3YPHSWK7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--inTGoYk3RnzWcyrI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 09:17:50AM -0500, Pierre-Louis Bossart wrote:

> > +		goto out;
> > +	}
> > +	/* Read the primary device as the whole */
>=20
> I can't figure out what this comment means

It's part of...

> > +		dev_err(tas_dev->dev, "%s, regmap doesn't exist.\n",
> > +			__func__);
> > +		return -EINVAL;
> > +	}
> > +	/* Read the primary device */
>=20
> What is a primary device?

=2E..a thing where they're trying to present multiple devices as a unified
device with grouped control, it looks like there's some hardware support
for this.

> > +	/* Failed got calibration data from EFI. */

> I don't get what the dependency on EFI is. First time I see a codec
> needing this.

> Please describe in details what you are trying to accomplish.

It seems fairly normal to store calibration details in the device
firmware?

> > +	if (crc =3D=3D tmp_val[21]) {
> > +		time64_to_tm(tmp_val[20], 0, tm);
> > +		dev_dbg(tas_priv->dev, "%4ld-%2d-%2d, %2d:%2d:%2d\n",
> > +			tm->tm_year, tm->tm_mon, tm->tm_mday,
> > +			tm->tm_hour, tm->tm_min, tm->tm_sec);

> What is this about? Why would a codec care about time?

I can see someone finding it helpful to confirm when the calibration data
that got applied was generated to make sure they're testing/using what
they thought they were.

> In addition, it's rather surprising that on attachment there is not a
> single regmap access?

Don't know if there's something different with Soundwire but for I2C/SPI
devices it's a reasonable pattern to only actually start initialising
the registers when the device actually becomes active.  Not checked that
this is actually happening.

--inTGoYk3RnzWcyrI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTeOOYACgkQJNaLcl1U
h9BCNwf9Gcjl+RXFsQvlgzwzotoxeZXlItZgogAodEQ7B7tlsKHfX0o4cQP2K5Rf
i15AsrtNn0lmi5RyetpCMC1HVsU5Ka9HF0GjGg3CDfX8opUNbuHqKWfnBSiMBeVe
sfszjNvWSW6MJmJk3Biw75LyejL4n0jJXsXQCN070Bq2ReAaj3OUg41H7LhOtJRL
EnqZeeTdtmkcWhk/roNBR6g7yUwT/cpMPceKi7fAzkeMrQ83TXLcPqohmfdSC2hA
rjJOQ2ihB4GtAmErPoH2DtfA+PRmbu6H6Tiudktxo56WRifKFgencxh3OdjwaAis
4vPhVXGu6MqbcyYdS49V/rsPxsxasw==
=jOSG
-----END PGP SIGNATURE-----

--inTGoYk3RnzWcyrI--
