From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 7/8] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Thu, 26 Jul 2018 17:31:16 +0100
Message-ID: <20180726163116.GK2414@sirena.org.uk>
References: <20180725005055.18138-1-pierre-louis.bossart@linux.intel.com>
 <20180725005055.18138-8-pierre-louis.bossart@linux.intel.com>
 <20180725114745.GN3661@vkoul-mobl>
 <bdff9535-3443-41e3-5866-698253eb28bc@linux.intel.com>
 <20180725162914.GX3661@vkoul-mobl>
 <20180726145812.GG2414@sirena.org.uk>
 <358b0fb8-7346-066d-62e9-fd210e80b2b3@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7289181619586147831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B47282677C1
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:22:51 +0200 (CEST)
In-Reply-To: <358b0fb8-7346-066d-62e9-fd210e80b2b3@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Vinod <vkoul@kernel.org>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7289181619586147831==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="enLffk0M6cffIOOh"
Content-Disposition: inline


--enLffk0M6cffIOOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 10:36:08AM -0500, Pierre-Louis Bossart wrote:

> Ah, makes sense. if that's alright I'll use the following style then.

> .h files
>=20
> /* SPDX-License-Identifier: GPL-2.0 */
> /*
>  * Copyright(c) 2015-17 Intel Corporation.
>  */

Yup.

> .c files
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * Copyright(c) 2015-17 Intel Corporation.
>  */

Lots of people are doing that, I do prefer that the entire comment ends
up C++ so it looks a bit more consistent but most people are happy with
that.

--enLffk0M6cffIOOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltZ91QACgkQJNaLcl1U
h9BYrwf8CZiwYxcOEgdFgV86nna/zGMALSzI9So0owmM7SarraMXF2wvBhEciAQZ
W4dnUVmmxq4lenTXFZNXprraQsHhABKKir1FicJ7jv3d4vozaKbx37lFqSCcovVP
TCxT4iOnDYD2rt+dDyUj5lYm9H9wUXhJLEilZ4bwRvv2bz30DCMH3LROSie1vhUy
0D5mOSsOHxEAV/tzYzOtfF2OB7q3WX6thBhhI3FRzBZahI1UwKFc8p5uO8+KzTab
EouAmiiX/5VWYmnIMDdBJ2MJ39MsPxYFzrqNv1bOUT2gQJFqsR/mLoQkSC7DYA5m
c3LbkO8sszOQEBBWOU07FOsGR++h3A==
=aCEG
-----END PGP SIGNATURE-----

--enLffk0M6cffIOOh--

--===============7289181619586147831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7289181619586147831==--
