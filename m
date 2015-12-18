From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
 components
Date: Fri, 18 Dec 2015 09:35:34 +0000
Message-ID: <20151218093534.GX5727@sirena.org.uk>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk>
 <5667EFCB.3010402@linux.intel.com>
 <20151209203836.GI5727@sirena.org.uk>
 <56694E6A.4090402@linux.intel.com>
 <20151211202208.GS5727@sirena.org.uk>
 <566FC9F6.8050107@linux.intel.com>
 <20151215112324.GX5727@sirena.org.uk>
 <567121DC.5080601@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7375950743655908557=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AFA8265191
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 10:35:42 +0100 (CET)
In-Reply-To: <567121DC.5080601@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7375950743655908557==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nfnKjHknX58/oBIK"
Content-Disposition: inline


--nfnKjHknX58/oBIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2015 at 04:33:32PM +0800, Mengdong Lin wrote:
> On 12/15/2015 07:23 PM, Mark Brown wrote:

> >>2. Why we need the rtd array 'rtd_aux' for the aux_devs?
> >>    If the codec has DAIs and used by a DAI link, the ASoC will create =
a rtd
> >>for the link.

> >There are (or were at the time) assumptions in drivers that there will
> >be a rtd there so it was easier to provide a stub.

> Can we remove this rtd array if current driver does not need the stub?

If it's unneeded we should probably remove it.  As might be obvious by
now I've not yet had time to dig into the code, sorry.  I've got two
weeks of vacation after today though.

> For the replacement of aux_dev by aux_component, can we define like below?

> struct snd_soc_aux_component {
> 	const char *comp_name; ... no longer assume they're only codecs
> 	const char *comp_of_node;
>=20
> 	/* machine specific init */
> 	int (*init)(struct snd_soc_component *componnent);
> };

> The ASoC can use the comp_name or comp_of_node to find the components and
> probe them.

Well, that's just the existing struct with a rename now I look at it -
init() already takes a component.  Given that can you not just have
whatever code was going to use this work with aux_devs as they are now?

--nfnKjHknX58/oBIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWc9NlAAoJECTWi3JdVIfQrvgH/RMFMxPE1HgOVezwKPSamWNs
N2+UCC2EeWEJFSrrIpCsPxi354S2vAEQnWK7nJfRwtWINLzP8jwHH5/3j04zonNB
8X0EzTlf1jC88z3CQark+eIfns/tXh3zOFC1VlUEVk3NY4d1Ah3SZdUVBIC9kMFI
qlHqfWNw6tIGkMhT7DhojDEs9Ho86MM/fgijYMvFfjZEPzy2849wxo2V5X9B9hZo
kvM/qD39VtMbb9U4hRdIb1yK1PWuwgx24nO2ZLGhrFkmVFWApYdGK6SlP4xtVPr4
0PfEMFNzD1ePy7svfRzdk4EqF8ZOtbAfbPSkYNTrn5TfAmEIK7TmHU3nsAfs4ic=
=5hwd
-----END PGP SIGNATURE-----

--nfnKjHknX58/oBIK--

--===============7375950743655908557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7375950743655908557==--
