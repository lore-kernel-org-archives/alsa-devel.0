Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AD5C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 13:58:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207A0613C0
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 13:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207A0613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21E9E16DF;
	Tue, 27 Apr 2021 15:57:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21E9E16DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619531925;
	bh=jPeMa6bQgcvHjGoeGNbSJl4MmWawTNbeg7cAL28NsDg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fk1nBmxLN3V7x3LnmI74JSccHsLHCEHQgvmhHLtpftoqKXySbn1PCa+zAIbyRvBnz
	 0YY0YrZ40d+MTT64gibMC9n51pz55iP5ACqAY2ziyhf8vXhkYsoycjqZ4VVhoPO9kR
	 onpr6mB1n49FqRLw+kchbo88J85y/cMzFg4rKr+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F0B4F8012A;
	Tue, 27 Apr 2021 15:57:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29471F801D8; Tue, 27 Apr 2021 15:57:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5EE43F800C0
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 15:57:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EE43F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jQCMYwAo"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5594613DA;
 Tue, 27 Apr 2021 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619531855;
 bh=jPeMa6bQgcvHjGoeGNbSJl4MmWawTNbeg7cAL28NsDg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jQCMYwAotMQoKidFAt2uEgtgE8u5agPtgjQHKrO0C8onNioJm8qTTHOItOV/04MaQ
 0+vabOzj4zViGDd/fvqdN8QXqHMTGA4y+r5pWdRQO82WuMVRuLGu1Anff1byWRNnmd
 UYQmkVqHaKCuSfOtHvEZyO0bcysM3lEnbszCyjh+XyHa/VYw7rVGwG0GLtBjSkEzMX
 8rOauMOT7sK40U4vT/PL+e8LoQf7xfBM6vvByY7mb9Yhla4anK2o7V1+pw3b5WGZHi
 lPwqg9rc+uAY7dqXeLJdqs4QDZKnCDGx7qUCWvnwjR2jVqh4QWiSjR0dyjcuA/MOh2
 0yfaav+O/EGzg==
Date: Tue, 27 Apr 2021 14:57:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Michael Walle <michael@walle.cc>
Subject: Re: broonie-sound/for-next bisection:
 baseline.bootrr.asoc-simple-card-probed on kontron-sl28-var3-ads2
Message-ID: <20210427135703.GH4605@sirena.org.uk>
References: <6080e82c.1c69fb81.cd60c.2a13@mx.google.com>
 <3ca62063-41b4-c25b-a7bc-8a8160e7b684@collabora.com>
 <877dkp5141.wl-kuninori.morimoto.gx@renesas.com>
 <20210426144242.GF4590@sirena.org.uk>
 <8735vc4r59.wl-kuninori.morimoto.gx@renesas.com>
 <20210427101926.GA4605@sirena.org.uk>
 <ea2b6dae-3087-67d3-8473-410255a51e23@collabora.com>
 <e20b9c8a2715b5d091a8d1f37ba890b4@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <e20b9c8a2715b5d091a8d1f37ba890b4@walle.cc>
X-Cookie: Don't feed the bats tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jon Hunter <jonathanh@nvidia.com>, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, kernelci-results@groups.io,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Heiko Thiery <heiko.thiery@gmail.com>, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org
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


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 27, 2021 at 03:43:42PM +0200, Michael Walle wrote:
> Am 2021-04-27 14:51, schrieb Guillaume Tucker:
> > On 27/04/2021 11:19, Mark Brown wrote:
> > > On Tue, Apr 27, 2021 at 07:28:34AM +0900, Kuninori Morimoto wrote:

> > > > > > If so, all sai1 - sai6 are using "fsl,vf610-sai",
> > > > > > all saiX doesn't have .name. I think it should have different name.
> > > > > > In your case, at least, sai5 / sai6 needs to have

> > Heiko, Michael, is this something you can please help with?

> Sure, just put me on CC and I can test the patches manually.

There was a question from Morimoto-san (quoted above) about the hardware
configuration so he could confirm what patches to write.

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCIGC8ACgkQJNaLcl1U
h9C15Af/QNfGiyPJ2VGFceEZARHChEBEgKKDaNzmi1eSlJxQVCeXRhagH7OB9NlY
EJ4bWQsZr9apBwi1EWw3QB9NW+W9oaDte8C6InH9+s5F6q4DN7XxtInRiUVuaV8M
vItMEHyVyHLP11dbOid+aSI+7TfakpjxiswnC6ABzslg6398XaV8e46vHdDeZaTR
zObQ2B/LvM02rn6kR79dn3BtuuKFnuB6B3x4+gm8THsO+T4/EGgVY1rgQvcWZpaM
wc8Hrv5uU0CCH3BBTSVgVsGAI/kqKrNHV9MC4Fyc5OKf6WwzbchiCehgJC/S28kr
8rrhgHz9tcsKSjbnjX+2K9X2VMgJ8A==
=WHgm
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--
