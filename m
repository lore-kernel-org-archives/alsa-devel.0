From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/9] ASoC: Intel: Skylake: Add pipe and
	modules handlers
Date: Sat, 15 Aug 2015 22:49:12 +0530
Message-ID: <20150815171912.GJ13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-2-git-send-email-subhransu.s.prusty@intel.com>
 <20150814213031.GT10748@sirena.org.uk>
 <20150815125513.GC13546@localhost>
 <20150815170302.GL10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8986296849826132673=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F338E2654BD
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 19:17:11 +0200 (CEST)
In-Reply-To: <20150815170302.GL10748@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8986296849826132673==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 10:03:02AM -0700, Mark Brown wrote:
> On Sat, Aug 15, 2015 at 06:25:13PM +0530, Vinod Koul wrote:
> > On Fri, Aug 14, 2015 at 10:30:31PM +0100, Mark Brown wrote:
>=20
> > > What are "mcps"?
>=20
> > Million Clocks Per Second. This represents the compute requirement of a
> > module, pipe and driver needs to track it so that we don't exceed avail=
able
> > MCPS
>=20
> So expand that acronym somewhere people can find  it...

Sure will add in rev2

--=20
~Vinod

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVz3SQAAoJEHwUBw8lI4NHZBAP/RsAUWltxiVIhgdEFxuPPkCb
3Mu7Zo8Sb3qb7Z0qgQA+pln6Q7h2qaDU72dq4HiNE25fVrshdzUvWNTs9rIhDSit
WajN/Kg9C/PSpr5dwwdeqFkbYcoSShEpWBXogFqqG5OBSOHESWzsrMJIY1163NBF
7IkDf5vH7MVb3pJ7gVXbt5zfPQ5JpIsDxoHz/+m0Xb2KO+rSwAnqf71gTpzPnUf0
qdUmQNBkRfeqdI4mhDfc23yl6EtihN2emmpfym/VTm00FrMFI5liG/wpgDJTYWh5
zLgtmRAtHtg4Gcwi+8ACtFlZgouH/e+ERW+xwG3cRNlP8RKenSuUYrJKiYQlrEez
N0Hsz9j0r1nuLARknLtmyaiJcpxko9cSvVpkwNXvFSxglzKSSx544armfHmOtN0j
fAmltIi066Z/6XJ8k5PFo8HGS27pqI+2Qwlq3dDsPzBr/lBTYK5cMJBxt07uRZ0g
+DHdQ/kUsaAcTmblHlMYS7js4hb0ydo0YNfIkQVJN89wqf2iwbhJThoB1MRRhlKM
mjP1Eu4WpqD0iJdjXL1H3ZN7j+TWFOkEok2GG2o6xou5b6fJUF+v6SuQo4BAINxU
ZHKoHm3KExKhzj/D25VmJwDu6cG28xInkIwaQKd3v9n+UOfu860O2RzQf1H9rMm0
YvJhD9hPemqlmuxq/3rx
=I7OV
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--

--===============8986296849826132673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8986296849826132673==--
