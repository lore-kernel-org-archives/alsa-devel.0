From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: codecs: Add support for
	PCM1789
Date: Mon, 5 Mar 2018 15:59:38 +0000
Message-ID: <20180305155938.GL8588@sirena.org.uk>
References: <20180305124817.7421-1-mylene.josserand@bootlin.com>
 <20180305124817.7421-2-mylene.josserand@bootlin.com>
 <20180305154910.GJ8588@sirena.org.uk>
 <20180305155715.GJ3035@piout.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7806872185062814237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EAC90266F68
 for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2018 16:59:47 +0100 (CET)
In-Reply-To: <20180305155715.GJ3035@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, michael@amarulasolutions.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, thomas.petazzoni@bootlin.com, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
List-Id: alsa-devel@alsa-project.org


--===============7806872185062814237==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j3olVFx0FsM75XyV"
Content-Disposition: inline


--j3olVFx0FsM75XyV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2018 at 04:57:15PM +0100, Alexandre Belloni wrote:
> On 05/03/2018 at 15:49:10 +0000, Mark Brown wrote:

> > Please don't mix C and C++ style comments in a single comment like this
> > - it looks unintentional.  Just use the same style for the whole thing.
> > You also don't need to include all the boilerplate with the SPDX header.

> I think Linus made it clear that he wants the SPDX header to be a
> C++ comment, the documentation has:

Sure, so make the entire thing a C++ comment then.

--j3olVFx0FsM75XyV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdaWkACgkQJNaLcl1U
h9CiUgf40Hp+gzXwR2TkhGpq5wjdnZSOKngsP8WUfonuZTnnEkE2ejOVjAMVgpOM
U0ljr1dg/Hg6tfbWNFRYflY31V+PPjfw+KnPuqNxjNFYj1t5GTL3sTrjrLf8RwSU
v1mgbevFejwxwk4vDhhdx869XZIiWUfnGk7vfAxJIQDi0BWfB6b31nBQmPv11sO0
pXi/l/ZBtmP29pfLoM1XxzKC3zwZ3dn9ESVkKMgKlnBUGGjsqHpNZTEmj+VB3KHL
Sg9nTyqmF5zwiNBNnddqriWee+2M+/7ZUBUWj+inCCfC7mLkbFZfB43BHVfl20cl
kY2El6N9CDLWgJHJUYA4Y8RQRhAe
=er+z
-----END PGP SIGNATURE-----

--j3olVFx0FsM75XyV--

--===============7806872185062814237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7806872185062814237==--
