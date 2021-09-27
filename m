Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F9BC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:31:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539AB60F4A
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 539AB60F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 601721696;
	Mon, 27 Sep 2021 19:30:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 601721696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632763890;
	bh=sWthEd8thvF+XGkVYUkeFMxlWcXd1BhPEpZoeT80pWI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BVgNlWMrNx5GV2ZmK4v4YYAy+Q5E1g263u/nSmbaeGZc8tiIxvrCb2mF3dZbT9U/2
	 1oirLrriulTdouLk+j8vU9gHQ+TYfVWbPYvg7DWNoy3kE4sSCVy2j65isvrSIZtvXR
	 HPknt1MTWstvYPI2U/WzXw3gnH4kTmvnv9vCl4os=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA656F80147;
	Mon, 27 Sep 2021 19:30:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 517A3F80227; Mon, 27 Sep 2021 19:30:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 512D1F80147
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:30:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 512D1F80147
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Yj9QDrwh"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1077460FC2;
 Mon, 27 Sep 2021 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632763828;
 bh=sWthEd8thvF+XGkVYUkeFMxlWcXd1BhPEpZoeT80pWI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yj9QDrwhkQBZSYAsOsJBGq9Bs62/LBNlL9bIz12/+OpRqNgkiDGQddJVl34MckGmw
 hetcjddDSGIMNkUTFPku0iGvxUApsEkE0V3M9lJ6WsGiRc5qo3b0GPHJKl64xZjc77
 Q6QbQzt8/j7qLWs7gF7CLXfGsObT0BCH2dJpjcy2BQbNQ4f3F7s2bDYAoVC1FP8t6K
 sWsI32VaGlnB23kxsY/ODXVkEyGTbOob1WGekA+v4+KpsA0IMnb/SBp1Mtx5L6OCrm
 MRONKGJ9ANY8FQ9hbtnyXxMY+wO+w+P63c2JDPkIWG095BvGfWMDpoX/Fu2kcM3l4t
 9/wHzy6aCAysw==
Date: Mon, 27 Sep 2021 18:29:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
Message-ID: <20210927172940.GH4199@sirena.org.uk>
References: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
 <1b21bbf1-12c7-726d-bff8-76ec88ff8635@linux.intel.com>
 <SJ0PR11MB566107A6AB3D18ABDEDCF245E7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
 <20210927160622.GE4199@sirena.org.uk>
 <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
 <20210927171033.GF4199@sirena.org.uk>
 <0af258d4-e33c-15ec-5dcc-a1c9961c0740@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <0af258d4-e33c-15ec-5dcc-a1c9961c0740@linux.intel.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "guennadi.liakhovetski@linux.intel.com"
 <guennadi.liakhovetski@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
 Ryan Lee <RyanS.Lee@maximintegrated.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>,
 "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
 "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>
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


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 27, 2021 at 12:23:06PM -0500, Pierre-Louis Bossart wrote:
> On 9/27/21 12:10 PM, Mark Brown wrote:

> > A quick survey of other drivers suggests that this pattern should be
> > factored out into some helpers as it looks like there's several ways of
> > implementing it that look very similar but not quite the same...

> No disagreement here, we tried really hard to enforce a common pattern
> for suspend-resume, but i just noticed that the maxim amp driver is
> different on suspend (resume is consistent with the rest).

There seem to be several slightly different ways of writing what I think
is supposed to be the same thing in _io_init() too.

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFR/4MACgkQJNaLcl1U
h9CnLQf+I7rNZH7/UAxm+ygPqR5wyC07ln6SF8HTbd4RVPRcbgoUpr/zRLV0AdET
WF6koeLuHvqZ4HyJhvBcPNacTCBldtRTa/cWQzhV85mVLHWIeHfTBk6ySO860z4o
S9cjLuFi9upjkRBL7L1P40vl1Ti9gq7vUltipE4AVNfea697+lSy9C/H3Dyvlgig
8hKLejhr3ZcM5l8eQSZ1E878xyCNGRP3M4K5OoHydJeKBBAO3OiOyaNjlhgetsb/
8dELrjAtM9NsedKLfNBm6jAqcJ3zFJsjoMKfVB54FOBOdfMFoYPC1PoNWnj8vZQQ
Dw/6qpGr4yVYpZNqUqVNCtzlsHm5VQ==
=Q6Xg
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
