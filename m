Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2529C04A68
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Jul 2022 14:57:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC54315C3;
	Tue, 26 Jul 2022 16:56:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC54315C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658847461;
	bh=8LCAQ/XKhmCI8QLqG+ep4teGmM1x8rveBJ36yESzFnQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ggi5fmDtYtahb1Vm9HWI921joL50mElhPwSRgIiUbo5IEnzsbNA2vNRdsLpRZ2ZFW
	 hQK9wR29NZsLsNumbmWEgRyDuiJ2TL1cY0YyehU0UPBkZwjLEM2gFtg3REOLDL8dbx
	 7gYkEOPnFYpZ1vB+tsNzuue53yY4SoiaaSOp6G54=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45D08F80153;
	Tue, 26 Jul 2022 16:56:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4EBBF8025A; Tue, 26 Jul 2022 16:56:49 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF8E3F80153
 for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2022 16:56:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF8E3F80153
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tqfjuZFK"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id ABAA7B816BB;
 Tue, 26 Jul 2022 14:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7727EC433C1;
 Tue, 26 Jul 2022 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658847401;
 bh=8LCAQ/XKhmCI8QLqG+ep4teGmM1x8rveBJ36yESzFnQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tqfjuZFKjR8gtO2uTx0fXkzBl0z6mAWvS2GB1WR9DVQHWBY7D4azRyDmmsBxOoYBF
 +Z7rC8XIMEIaqSm1xeE1SDFjn/KMfZ8TQDpyDrKLuzZom+Zh/TbzCZ5o78T4zvwgHV
 qqVLR/BgTBY8lCjTkjBm0WTWt2bDNyeYyex0LSQ4Gze8GQEM1CEi6HoMRTaARHLCll
 W+TsBGW7635bOcv1t4ythrjUX4NM8UM1d4YBA89lUXnwUSYP3163ojJuUELkIslEYd
 S+BBcZw6Lgs1E0BsM5LsgEh0a/iYBn1nVQGTK4a77FRGJq1rS76/u60cWrtPvQwsEm
 +iJiKI1cxWT0w==
Date: Tue, 26 Jul 2022 15:56:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: add support for ES8326
Message-ID: <YuAApMG8XbxOoGIv@sirena.org.uk>
References: <20220726131747.127992-1-zhuning0077@gmail.com>
 <2f031e44-4d8a-a69f-697f-1bb83ba1f9f9@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rSGISV+IhT6QpsQ0"
Content-Disposition: inline
In-Reply-To: <2f031e44-4d8a-a69f-697f-1bb83ba1f9f9@linux.intel.com>
X-Cookie: All rights reserved.
Cc: robh@kernel.org, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 Zhu Ning <zhuning0077@gmail.com>, devicetree@vger.kernel.org, tiwai@suse.com,
 Zhu Ning <zhuning@everest-semi.com>, David Yang <yangxiaohua@everest-semi.com>
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


--rSGISV+IhT6QpsQ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 26, 2022 at 09:06:10AM -0500, Pierre-Louis Bossart wrote:
> Much improved version, thank you. See additional comments/questions below.

> > +	regmap_write(es8326->regmap, ES8326_CLK_CTL_01, ES8326_CLK_OFF);
> > +	regcache_cache_only(es8326->regmap, true);
> > +	regcache_mark_dirty(es8326->regmap);
> > +
> > +	return 0;
> > +}

> One question on the interrupt handling: should there be an interrupt
> disable on suspend and conversely an interrupt enable on resume?

That shouldn't be needed (in general the interrupt enable/disable stuff
shouldn't be needed at all).

> > +	ret = clk_prepare_enable(es8326->mclk);
> > +	if (ret) {
> > +		dev_err(&i2c->dev, "unable to enable mclk\n");
> > +		return ret;
> > +	}

> I am not really following what happens if es8326->mclk is NULL. Why
> would you call clk_prepare_enable() with a NULL pointer? If you look at
> the code in es8326_set_bias_level(), you do test for that case, so why
> not here? Something's not right here.

> Could it be that this is a scope issue? This block should be moved under
> the scope of the if (!es8236->mclk) test, no?

The clock API will happily consume NULL clocks (it uses NULL as an
equivalent to the regulator API's dummy regulator), there's no *need* to
skip clock handling if you've got a NULL clock.

--rSGISV+IhT6QpsQ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLgAKMACgkQJNaLcl1U
h9BUTgf/fWzI+fU9MnDWLd5w605hoXAlREJU2+Ix5LTMCtZQyKvgN5C9bvUYDTrr
rWIOESYWdVxxPKjX/QSRB9fI2e/w2ABagOs6kOgd6L6WbHaN3JSnSIJUQHsvArQV
w4r/4ZQv1e7Qpn6qBQIECOqECtT+UDEipAUttdAHCXjYi+VhvQH3ddf/Tem+RIhR
CPM5PcPjLj5aoQk2Z0KxPRmrFdX2eswOqFTJGq0mmgpxBf3gnUdoGeWMU36Ye3pU
yc42gip6dKMo4c4IGKpxqYkN0eeLpGf1SWp1enEAwKZtLXY6WFxcW7+QEKGaUdPb
HXuPdBWnZnIRtl5PyQ0MbxcMMGr8RQ==
=RMZJ
-----END PGP SIGNATURE-----

--rSGISV+IhT6QpsQ0--
