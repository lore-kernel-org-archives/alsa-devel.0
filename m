From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: DAPM: fix build errors for missing
 snd_soc_dapm_new_control symbol
Date: Mon, 15 Jun 2015 17:57:23 +0100
Message-ID: <20150615165723.GY18309@sirena.org.uk>
References: <1434386871-24325-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5700575086692636041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDBEC26520E
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 18:57:34 +0200 (CEST)
In-Reply-To: <1434386871-24325-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5700575086692636041==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tAdHiH28s3ybHVSb"
Content-Disposition: inline


--tAdHiH28s3ybHVSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2015 at 05:47:51PM +0100, Liam Girdwood wrote:
> Fix the following error:-
>=20
> All error/warnings (new ones prefixed by >>):
> >
> >    sound/built-in.o: In function `soc_tplg_dapm_widget_create':
> > >> :(.text+0x25a90): undefined reference to `snd_soc_dapm_new_control'
>=20
> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>

This doesn't apply, I appear to have this already?

--tAdHiH28s3ybHVSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfwPyAAoJECTWi3JdVIfQ43MH/1XxjlrzBfLMT/Sq4/DhWxMY
5Xy4ye9eFvfG40NP4kJWImRDdC5mwCYx5Fe87Va8RE8tRch+64XtR+hU/5CuBITR
C6zfi7tNZQfJtAWu5X1c4BHgb65g/irzEzFTgRqBl76gcTfdRP0GjdCGs4GjIW4d
enJOfI1yXGqECC7G1VAbd1bctxX7aPg+MBSacMth+Q+Q8cyeTogJX0bsRx8Nxe+r
CJ78aiCYvNJKIwLkeh78mz/aoBKapMeB7tX8f/sUHCq2ZV+ZyeD96AEHqQCR7cgZ
e78OgDNKmTL4V/NxRt+fNwnE2lCJQA+M+mrgfd7DY5dCiIBZaGvKoDg0aOGZ5qU=
=w8VU
-----END PGP SIGNATURE-----

--tAdHiH28s3ybHVSb--

--===============5700575086692636041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5700575086692636041==--
