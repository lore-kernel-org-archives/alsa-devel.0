Return-Path: <SRS0=NKE9=43=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3CDC18E5B
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4F124692
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SZOjg5XI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4F124692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDD601661;
	Tue, 10 Mar 2020 13:51:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDD601661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583844715;
	bh=0Jj/DqofcHaCL2WvJfTvYHW7eRvf4VsoRX5NP/41rHo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZOjg5XI3b6gVbDJkWrU3ZOvNPAM4SDkeNg/t5jlgEy4Hcy3DoYYZIb8PdbpTVMBe
	 kMZvB7QeOUc0sYo+gWiMLFZjNFHbFC1tbP4TCU+YouuAMWIT2Pebw8k0QO/QNi/7LP
	 eDfOtnqCZgTX9hwbPIj4MUR/jOFgf+wa6M+J35sU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40550F8020C;
	Tue, 10 Mar 2020 13:51:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4D9F2F80217; Tue, 10 Mar 2020 13:51:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 7D2FDF800DA;
 Tue, 10 Mar 2020 13:51:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D2FDF800DA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0554030E;
 Tue, 10 Mar 2020 05:50:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B5AF3F6CF;
 Tue, 10 Mar 2020 05:50:57 -0700 (PDT)
Date: Tue, 10 Mar 2020 12:50:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/3] [RESEND] ASoC: SOF: preparatory patches
Message-ID: <20200310125055.GF4106@sirena.org.uk>
References: <20200309170749.32313-1-guennadi.liakhovetski@linux.intel.com>
 <9cfc4182-1f22-9f28-52d8-f8aac1f7bc0b@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pyE8wggRBhVBcj8z"
Content-Disposition: inline
In-Reply-To: <9cfc4182-1f22-9f28-52d8-f8aac1f7bc0b@linux.intel.com>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 sound-open-firmware@alsa-project.org
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


--pyE8wggRBhVBcj8z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 05:05:06PM -0500, Pierre-Louis Bossart wrote:

> To get a better picture of the directions, reviewers are invited to take a
> look at the in-depth documentation written by Guennadi since the initial
> patches were shared. This documentation was reviewed by Liam and me and is
> really required to understand the concepts:

> https://thesofproject.github.io/latest/developer_guides/virtualization/virtualization.html

How does this relate to the virtio audio spec that's currently under
review?  It looks to be doing something much lower level than that.
I am concerned that this looks to be exposing DPCM as a virtio ABI,
we're trying to replace it as an internal API never mind ABI.

--pyE8wggRBhVBcj8z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5njS8ACgkQJNaLcl1U
h9DVaAf/aTFm7PGttGIpMffo89XaGKSJqlQbrKDXd0pAgOeUTLLLPfr1z57prmmo
P/QJWonwruXMJr3CNeEsUONqZvTqFCNtY9gAyeGB1l/Brq4LZMMI58IQg+Q1MWw3
Ss3eA3Kd/OGlDhVRYsNHybpeI9z5u+qz3CL2aS/n9pvjswf/fJV7hFpH/B/xvO32
oGCmU37XsMxsfiLcxmVjKTa1Kioco9Nk99nU2SGr9TCIj6LIxIBS+jXtt98RbJoH
M11ZC281IC8uI/PHjiOUzEUzoLb4yCZBiF1lxYEx7HueYur6JslhXdDNA+uNi3Xo
I6gt5/1onX2o0gK6zJaFEIrzkRS+uA==
=8aKs
-----END PGP SIGNATURE-----

--pyE8wggRBhVBcj8z--
