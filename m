Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E3C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 16:28:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5F6610CF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 16:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C5F6610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8B8918AD;
	Fri,  3 Sep 2021 18:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8B8918AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630686499;
	bh=YsCr1vi/hG7WlJPP12tFvf6pbI6chrdQlXh9KKuB6uI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfcwIp6k9Gam/umrwvXF/FSp2fzRaLtr7fi0pSmctGEgS8OLLFbvmGFB6PUdsHA36
	 Q0GBwQ2I+oPd8apeurYKc8lYdTErmxLj3je3rfUaYSdRTuORs5uRTbkQjgVA+03xdZ
	 PXtGEL6mR3E6V5pDhYavzslk5tAGgRAS+bNAde7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 752A9F80227;
	Fri,  3 Sep 2021 18:27:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79FE2F80254; Fri,  3 Sep 2021 18:27:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1C01F80088
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 18:27:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1C01F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KOcIvFGW"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852A660EC0;
 Fri,  3 Sep 2021 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630686433;
 bh=YsCr1vi/hG7WlJPP12tFvf6pbI6chrdQlXh9KKuB6uI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KOcIvFGWrtOWgZleS0Rnbzp01QM8+3A9zZY5XVlCQdlgiKg6B9t12/Jh4ps73kDId
 Dkp2JFGIqdWug3uDMw7bttpV57j4xkBKbkfc4z3hkJgSGNZ2k+LMnYo8aIzVurzZat
 hXdiGfyQwk65SiMTJkC3sJ207it2pabDCMUduJ8cO5evggROWdzVjM0267Uk/h/akZ
 DJtQaDwY6mTwWse5ffIRdrsL3Qc2jvHtwfS0WMcFZKjzsdCMcnM7XEQXYhqMtXdQLA
 5iPawVHuGaxoWE/5H+wBe2L+vvkcVz3XQ+I/LB9NpkGNnkipH7G8PCD517uTCfeZzT
 1EsluH5f1S42A==
Date: Fri, 3 Sep 2021 17:26:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH for-5.15 v3] ASoC: Intel: boards: Fix
 CONFIG_SND_SOC_SDW_MOCKUP select
Message-ID: <20210903162639.GM4932@sirena.org.uk>
References: <20210802212409.3207648-1-nathan@kernel.org>
 <20210902181217.2958966-1-nathan@kernel.org>
 <20210903102738.GB4932@sirena.org.uk>
 <YTI71k5EsyTgstkn@MSI.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Content-Disposition: inline
In-Reply-To: <YTI71k5EsyTgstkn@MSI.localdomain>
X-Cookie: Darth Vader sleeps with a Teddywookie.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Fabio Aiuto <fabioaiuto83@gmail.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
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


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 03, 2021 at 08:14:30AM -0700, Nathan Chancellor wrote:

> For the record, the documentation for sending patches has the "Explicit
> In-Reply-To headers" section, which frowns on doing this for multi-patch
> series but never mentions this for single patches. I have never had a
> maintainer complain about me doing this in the over three years that I

I don't *mind*, there's just a chance I won't notice a patch that
appears in the middle of a thread which submitters tend to mind - the
issue is that I'm blissfully unaware.  It was more that you were doing
the exact same thing again in response to it being explicitly identified
as an issue.

> changelog section. Maybe the documentation could be updated to frown
> upon adding In-Reply-To headers to new versions of patches period? I can
> draft up a patch to clarify that.

Not everyone has a process which causes issues here (and even for me I'd
only notice if the old thread was still in my inbox), but I certainly
wouldn't be against it.  Note that if you're trying to make everything
super rules based you also need to cover the case of people trying to
incrementally fix a series by sending new versions of patches in the
middle of it which is an even worse mess.

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEyTL4ACgkQJNaLcl1U
h9DZhwf8CTpPqMVMNlBp0ILOIUynnedLfqBM8DUbquKMsQ18R4nQxPK1F+axx0q1
1Ya36cGShO54vRHMQYNekWi58MwDyLB4Nik64vhQEyn5hAWYf5ydL3GxuAyXePGV
f2wD7AFE2FDx475lWV3GMKJHN2g0kZeiDQDTFe4h5wEEME/g+eShfRnnPISn/0+x
SRE8fSs1eEkdScgs1e5p3cJ+w3QnzvhvHuPaxCbDhkQ4viSfJ1tcmcISpGqo5jVF
shdWTiy7LXn/g/eWqKv/ZAXrJ8DVRkK4yfUxhrrxcw7SDGV8EwD4GcOc1J3NYVZy
/L1J7J8UDsqXUyd5Nsba4f7RVZT7Iw==
=3M0P
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--
