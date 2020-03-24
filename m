Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894F5C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:31:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E414E2076E
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dnYPOosL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E414E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A93086F;
	Tue, 24 Mar 2020 14:30:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A93086F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585056706;
	bh=JiUJt1PGd0iokHwRzBHQ3LVubzM54z5IIcs3J098DDM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dnYPOosLIbitfV0C82GodrpYLnyHZmzbtialcjp8fQmjcetGVsILKkWOhk2QzcDoE
	 WHJdxwJh6UI7UiukZus8VSogVecFxjPW75lUZ4Xn6VTdnaxus2LcrByukWy2STU80J
	 YvoItnMCLR4IPAHQxFlO2igovrisc0L4Tf6ZTD0o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81E70F801F8;
	Tue, 24 Mar 2020 14:30:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71A84F801F9; Tue, 24 Mar 2020 14:30:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 757B5F80095;
 Tue, 24 Mar 2020 14:30:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 757B5F80095
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13DC91FB;
 Tue, 24 Mar 2020 06:30:44 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B3C43F52E;
 Tue, 24 Mar 2020 06:30:43 -0700 (PDT)
Date: Tue, 24 Mar 2020 13:30:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: SOF: initialise work immediately
Message-ID: <20200324133042.GB7039@sirena.org.uk>
References: <20200324122921.29582-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20200324122921.29582-1-guennadi.liakhovetski@linux.intel.com>
X-Cookie: I feel ... JUGULAR ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
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


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 01:29:19PM +0100, Guennadi Liakhovetski wrote:
> Fix uninitialised work errors by moving initialisation to directly
> after allocation.
>=20
> Guennadi Liakhovetski (2):
>   ASoC: SOF: (cosmetic) use for_each_pcm_streams() in sof_dai_load()
>   ASoC: SOF: fix uninitialised "work" with VirtIO

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl56C4EACgkQJNaLcl1U
h9Cafgf9FzXgO1Sxg4XYM/bB8k1p0NsTCrMMdmTObwM43Z6bJsCt+RLSg6N3s430
b/cpM2EF8wTZhw54bXG1JoYwL9hfgl19s1FWi/NvjOAFDuWATjd0jzd3E1a6nBTR
AVtZ3diQ9j9QEmQiwkHpqZ7XXhWu5Y9DFM18AlBkMv1p4kszNScH7Ecxx8UQKtbx
h8x/o698AvQeMzEBOVpF8CChGlJEFyOm9Jv+BzMN4k9twk66wJjLT7o6aDy8x+l1
pRInJVBqLfMACkdUE9Lx3m3pLyfZPYEW0xDziSW3VDUQ8Xl3f9ozGNPIC8m0/94t
oobhWhWGhPThw77cAwb1g1QSEcVZTg==
=g8DH
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
