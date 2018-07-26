From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 7/8] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Thu, 26 Jul 2018 15:58:12 +0100
Message-ID: <20180726145812.GG2414@sirena.org.uk>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-8-pierre-louis.bossart@linux.intel.com>
 <20180725114745.GN3661@vkoul-mobl>
 <bdff9535-3443-41e3-5866-698253eb28bc@linux.intel.com>
 <20180725162914.GX3661@vkoul-mobl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8518749236159156536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ECE8426739D
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 16:58:16 +0200 (CEST)
In-Reply-To: <20180725162914.GX3661@vkoul-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod <vkoul@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8518749236159156536==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 25, 2018 at 09:59:14PM +0530, Vinod wrote:
> On 25-07-18, 09:27, Pierre-Louis Bossart wrote:

> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Copyright(c) 2015-17 Intel Corporation.
> > > > + */

> > > same patch different style ;/

> > ok. Checkpatch reports different things for SPDX but I'll align on the C++
> > version.

> Yeah we still have bunch of versions floating out. Only consensus seems
> to be for SPDX line in C99 style. So pick one you like and be consistent
> with it.

Headers are a C comment as they might be included by non-C stuff.

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltZ4YMACgkQJNaLcl1U
h9Abpgf9HqSyF5JXITkv7o+G1ElwNB1ZnKw5AG90IqS0WvNizX1hAz+r648PBIqM
go0B1jd9tvYuPdpTTtet7pExvabuGjk7wnt0aMVsOYFDDIFcp57HThulfOFSvoCX
4FSjSs28EbLBdLqMkUmdYRRghJc0qZB8vIDnYeL6iPfM6du14F1iDQaEsBZeIEYg
fAIv6KjiKiYrYmHUMKsbm0l5H5tJNDp+wvoLEmnvQUvpU3JxXoLvjt5+QMUes39k
9DzHH7bdQj9duf6rO3RJRsRSlyrG83FGNzUUk6zygm/GHnlm8oFDGbvEnhCf1Owi
0xXCRylOHA7rEv2isRNUYaixKwdVrw==
=U4ZP
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--

--===============8518749236159156536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8518749236159156536==--
