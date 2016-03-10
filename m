From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Intel: allow for DW_DMAC_CORE as
 module
Date: Thu, 10 Mar 2016 12:45:06 +0700
Message-ID: <20160310054506.GN3898@sirena.org.uk>
References: <1457062599-10032-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1457062599-10032-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160305040303.GY18327@sirena.org.uk>
 <56DDBF29.2010809@linux.intel.com>
 <20160309024326.GE3898@sirena.org.uk>
 <56E0581F.10500@linux.intel.com> <s5hegbj7em9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8760844716523091026=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0529C260614
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 06:45:12 +0100 (CET)
In-Reply-To: <s5hegbj7em9.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8760844716523091026==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Content-Disposition: inline


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 06:19:58PM +0100, Takashi Iwai wrote:
> Pierre-Louis Bossart wrote:

> > > My point is that you've written the above in a very confusing manner =
- I
> > > have to think about what it means while just a dependency would be cl=
ear
> > > and obvious.

> > Are you asking about the intent/functionality or just a simplification=
=20
> > to do this (un-tested):
> > depends on DW_DMAC_CORE && (SND_SST_IPC_ACPI =3D n)

> A=3Dn is usually written like !A, too.  So a simpler form would be

>   depends on DW_DMAC_CORE && !SND_SST_IPC_ACPI

Right, that was what I was looking for - the way the patch was written
was really obscure.

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW4QngAAoJECTWi3JdVIfQoX4H/i9+wHyKjheicUhaf3pD7Qve
7/hWJZaMJLIBdGXPC05FWTk70p71kpCXMgsXalnsTD5mCOkfdtK7rw2WBEojc3hU
kqimUp5IIhJmJz3zkkVvW6QMSgtue/0Nagktp/6SzQ0TbQ2P/ZPQOW9bXbD63krv
+H4VtcbFXzqpyFWDWk5chxNx1uM/ZJ3TYI5W9i/0Q2Xzom5rdwe4JI6lHdOV1dzU
9+QsUO5H186HzKo3Sw3xt2d3w6l71MZhjWzojotfgpTaSK3pQuCuZ5NAClaPv2nx
2mzAODRg4PRqRuBpTKdN+zEVVtCjShn9GLM1MlgmUdUqpGqbKcxcuuu8gwIgw+4=
=wCPQ
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--

--===============8760844716523091026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8760844716523091026==--
