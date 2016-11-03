From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 01/11] ASoC: topology: Make PCM backward
 compatible from ABI v4
Date: Thu, 3 Nov 2016 10:12:20 -0600
Message-ID: <20161103161220.jtyujjm3qu7je6l5@sirena.org.uk>
References: <cover.1478071138.git.mengdong.lin@linux.intel.com>
 <7a2aa610eaf6f0768936bdd2ec2ea34dba518ed6.1478071138.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4425128297509834741=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D139F267256
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 17:12:36 +0100 (CET)
In-Reply-To: <7a2aa610eaf6f0768936bdd2ec2ea34dba518ed6.1478071138.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4425128297509834741==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x5ucqcxcr6aw6tcc"
Content-Disposition: inline


--x5ucqcxcr6aw6tcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 01:00:16AM +0800, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> This patch adds support for old version 4 of PCMs (FE DAI & DAI links).
>=20
> Topology ABI v5 added new fields to stream caps and thus changed PCMs.
> Since user space may still uses v4, kernel will check the ABI version by
> comparing the object size. If user space uses v4 of PCMs, kernel will

This only applies on -next, not on v4.9 but this is a bug fix which we
should really get into v4.9. =20

--x5ucqcxcr6aw6tcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYG2HjAAoJECTWi3JdVIfQSzoH/3gqOni1AjnCj+LjffMxmtdp
YMV3Ai8t/EL2eGsGm9A/L23YEQOa8WcGmlv1DtYzGtddeJAiwGVU+NlCe2VaJlLa
+zMhGPI41r0YeAy05s0cY0ZtzIyB3C4SH/E9G04+EH0vGJPoCe5P0KITRbAIiCNh
QeLcMXnXfz0jgXVW0eqtFVwN4Js7IPpWzMGdk/fbuBTEo4g/otNLML5iVAyzuA8z
KnWzii0lLdtaydDJn1otdKK7F/4541XjrnCWHs8NqF3kG+ohlH1tHuEWdF5/RHH8
y+FRXbJOlWQ6VgCp93EL90LL3v6ia/R5i4lLu5Ukw2gTYGKlzENt4v5Qf0dqlZY=
=pnDb
-----END PGP SIGNATURE-----

--x5ucqcxcr6aw6tcc--

--===============4425128297509834741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4425128297509834741==--
