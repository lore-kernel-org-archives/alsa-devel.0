Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B094C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 18:30:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAAC610D2
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 18:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DAAC610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11E4616A9;
	Wed, 18 Aug 2021 20:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11E4616A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629311420;
	bh=gl29wp4oNfqquxl83ShE1Js3Ixdx/PtvHL8j0+Mcrbg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ts1sAUreUVUGxKYTCUGoRpG47tK8Vc7stlvv8g9R2hjUanD50p7Z5Sa5NrYjk1h5F
	 TvM9mWOlZeZ9tULyXqgYPV3LGF3HrWSqGja1VcPXDDhkb0pUOu1i0p+RbxajTHKEdg
	 JL1ZQ/qW6v9fpTiWgtMQ5cpLFdvFb12e7R3ZGvZ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0637EF80246;
	Wed, 18 Aug 2021 20:29:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28505F80249; Wed, 18 Aug 2021 20:29:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CA78F80169
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 20:29:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CA78F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nZ3J84co"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DD8060E90;
 Wed, 18 Aug 2021 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629311337;
 bh=gl29wp4oNfqquxl83ShE1Js3Ixdx/PtvHL8j0+Mcrbg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nZ3J84covXa3OELnwC1PBi1CRL5MHamI7VUkQFDdDB6N+AiiMdFWjPJuNowBVnNch
 ybdCHuTefoEhRLcxBTwi12owt7fGrhiFBBEqfIG7eBNyLXS9Fm7fqiuEtmVNFpRCTm
 8icicOdaAWWKPJr8kvMEYOXtXhO6E6J0ib00RfbNRy6V3yqqXLMfS1nvLhXUpscqlg
 iElsWvJ1tFKQNPJcSTp4wp9jj9+ZW9pvsFP0o3DLO+5nEcjOME2SmlVlGiHefK9GC0
 Pc5HXMZZYdJ33fJr9w+h6HzreA7bvqYXfT/VDrMJYN0+boKBY8O7mZXZ+vIccu99EX
 fjW8wEeS9VYpw==
Date: Wed, 18 Aug 2021 19:28:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] driver core: export
 driver_deferred_probe_trigger()
Message-ID: <20210818182833.GI4177@sirena.org.uk>
References: <20210817190057.255264-2-pierre-louis.bossart@linux.intel.com>
 <YRyeR6imvSwOOasQ@kroah.com> <20210818115736.GA4177@sirena.org.uk>
 <YR0Ji7DQXoo0z4vP@kroah.com> <20210818134814.GF4177@sirena.org.uk>
 <14235b8d-d375-6e2d-cae9-33adf9c48120@linux.intel.com>
 <YR0nAcC3wJd3b4Vu@kroah.com>
 <be1ea414-b2ad-162d-192a-7b55e40b3754@linux.intel.com>
 <YR06L+gTzyiYY/rG@kroah.com>
 <244b3030-0d24-300f-354d-46878b708056@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <244b3030-0d24-300f-354d-46878b708056@linux.intel.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 tiwai@suse.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 vkoul@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
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


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 18, 2021 at 01:09:44PM -0500, Pierre-Louis Bossart wrote:

> I initially looked at the component framework to try to express
> dependencies. It's really not clear to me if this is the 'right'
> direction, for ASoC-based solutions we already have components that
> register with a core.

Historically (long before both deferred probe and the component
framework) ASoC used to implement a mechanism that essentially did
deferred probe for the dependencies - it'd maintain it's own lists of
dependencies and then tell the machine driver and all the components
when the card was ready.  Once deferred probe was there we dropped all
the open coded deferral stuff since it was just reimplementing what
deferred probe does in a slightly more complicated fashion (it tracked
the dependencies in a finer grained manner, though the result wasn't any
different).  See b19e6e7b76 (ASoC: core: Use driver core probe deferral)
for the conversion.

What ASoC is doing with the cards is fundamentally the same thing as
what the component helpers are doing, we could in theory convert to
using that but unlike with probe deferral it doesn't really save us any
work and we'd still need all the card level tracking we've got to
connect the various bits of the card together and order things.  If we
were starting from scratch we would probably use components but there's
far more pressing things to be getting on with otherwise.

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEdUVAACgkQJNaLcl1U
h9CFYggAgsVIGWE1ir5ASVuduTYuxo7utFvIOGL8x4iAc2FRSLZF/OnyPc1udNVh
MTFcjd73PmhxIDu4ZhE2meroZiCHoVGQszZbkwKOUc/Gu3YTO22oRt5xaTc4W4yW
0GRtZ5AbYWXj5DJSorSB9rXbSjdPN8TV4Vd+VPTwYhSgwqkJX9byG6aZPzKhIQBG
dnq3C+O2CiRFyt57Cfs6yhTgyJwPTKc9P/SUhKU0acVYpbYWxbwbja+2t5GIHF4n
pJUZ3da5PtCziiOuDBYSxMdcFQvn1cLQwM18PFWvNCanzEh1kagPoB2vKLqvzu1x
P5SVZ35bf/aNcKfMHxuLk+s8DsF3NA==
=oFCB
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
