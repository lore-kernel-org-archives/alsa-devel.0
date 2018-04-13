From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/5] ASoC: max9860: switch to SPDX license tag
Date: Fri, 13 Apr 2018 12:19:27 +0100
Message-ID: <20180413111927.GC6854@sirena.org.uk>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
 <20180412211437.21599-4-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180412211437.21599-4-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 12, 2018 at 11:14:35PM +0200, Peter Rosin wrote:

> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Driver for the MAX9860 Mono Audio Voice Codec
>   *

Please don't mix C and C++ comments like this - it looks unintentional
and messy.  Just convert the entire comment block to C++ so it's
consistent with itself.

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrQkj4ACgkQJNaLcl1U
h9BenAf/W/JDwlbxh9fUKL63ITIAECbCWfVFrPyFMGalYh/tM3Gt+w4aSNENJa1P
Eu6RrNVVhreEr1TN1GcJzPu5o84WHMGSBQRsBRWM7VFzfE46TByeMAq23FhBZUTl
UXCEXc4gGpMji0GqWWDF2gVniWIXQBquaDv1+96YdrDCLCmKs5SSABktrO8daHDy
7GRbovvhdqlaMPE76RYm4W+xnePcNwxqpTNKW3/70MGJR63M04May65NyRRmqNZp
YFhUYinQZ+43UTCX3mBkfYBqmVUC9EmG54e3pot/2IrcLTT+hK40KvWqGHdMr09A
NRJg712HVhRbMSYG9qzDBldAC0a0yg==
=9021
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
