Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC1C56201
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 16:28:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B3720757
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 16:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JChr4rH8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyjYlDNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B3720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2034116AF;
	Thu, 19 Nov 2020 17:27:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2034116AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605803309;
	bh=/2m0UE5hapRt4xJpiOoTf2TgBaWZK9N+sr6VYXqk/x8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JChr4rH82YD1sirK4FG7AkfIeNI2IXSpOVlfxtwYxW6hcU7xobnQQR0bG5Xe3E0Y9
	 gaP4M89y0ZXoz1Ufw4AUf/9kzJIbyLbktQwUE9ljlORsyOlN+yYCtOMzgOImvNQa6P
	 dR/mtPrqd0kVv7ANQLvHFroAo5XDdMkDffDWvz30=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A896AF8015A;
	Thu, 19 Nov 2020 17:27:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61B24F80169; Thu, 19 Nov 2020 17:27:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E475EF800C5
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 17:27:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E475EF800C5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WyjYlDNb"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C10322264;
 Thu, 19 Nov 2020 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605803251;
 bh=/2m0UE5hapRt4xJpiOoTf2TgBaWZK9N+sr6VYXqk/x8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WyjYlDNbHSZv76PQ4zRZDZguqFWthwVKkK3b6h5A5Zke0STt50ZD3F0VPn7r12TIe
 OY+67VcNRWbP9pI1egGTini2nwbt2WAC1yXfW0S1CYiYHwD9tBFNZNfteIsjFIkUxs
 3+kax8D0seJooMkdHfECXXtzJsZ0qbdVkDjW4K6Y=
Date: Thu, 19 Nov 2020 16:27:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [RFC PATCH] ASoC: ak4458: use reset control instead of reset gpio
Message-ID: <20201119162711.GE5554@sirena.org.uk>
References: <20201116222036.343635-1-viorel.suman@oss.nxp.com>
 <20201117173901.GH5142@sirena.org.uk>
 <VI1PR0401MB2272061C958E91FCAA239EB892E20@VI1PR0401MB2272.eurprd04.prod.outlook.com>
 <20201118115500.GB4827@sirena.org.uk>
 <VI1PR0401MB22726479D60E9B603A6848BC92E00@VI1PR0401MB2272.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <VI1PR0401MB22726479D60E9B603A6848BC92E00@VI1PR0401MB2272.eurprd04.prod.outlook.com>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 "Viorel Suman \(OSS\)" <viorel.suman@oss.nxp.com>,
 Lee Jones <lee.jones@linaro.org>
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


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 19, 2020 at 04:22:42PM +0000, Viorel Suman wrote:

> > Flip side of that then, how do we know when a reset has actually happened?

> I don't see how this can be achieved - I'd imagine some "shared" reset
> framework notification mechanism calling back all "listeners" in the moment
> the assert/deassert actually happened, there is no such mechanism currently
> implemented.

Yes, I'd expect some notification via callback or sometihng.

> In this specific case the GPIO purpose is to just to power on/off all codecs.
> In my view with this approach it's enough to know that all codecs will be
> powered on the first _deassert_ call and will be powered off on the last
> _assert_ call.

In general it can be useful to know if the device was actually reset
since then you can skip any reinitialization you might need to do due to
that in cases where the reset didn't actually end up happening.  Not a
blocker but it would be useful.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2nN4ACgkQJNaLcl1U
h9Bn8gf+Nb8Aw5P4LUp+fdufSBFwKEGFetQnq1XD3TvBypHN71zl/v54c11k8sRy
LIPaUtApaaXa20ln6E4WfvGv0AWkpK2kHw2Uoc7hfLvcnVY4MOabqyZ1NstDE9yT
WPW4uvLwJjDeWWNdMRLyqNoi/2XkqE5f6/Jy2HsflLnEX7h/vOQF/mjUq/leUSws
H11EIM1XKMtnIhnLuhcOLIXIse7i9nPLML7FGwn7Y7ShLP1PPpzANAa5Cn9AzonK
7Wa1hrq6eNuZRkdU3aZ5THDTphhQpbOAfhD8j/zsuYtoVhvu2za6LjQx6srTDFWc
O6uQlQpvWMyKCRrA0sLHmp8YRSnu6Q==
=LLq9
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
