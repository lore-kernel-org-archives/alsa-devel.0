From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm_adsp: Ensure DSP controls are
 always persistent
Date: Sat, 21 Feb 2015 18:35:31 +0900
Message-ID: <20150221093531.GI6236@finisterre.sirena.org.uk>
References: <1424100349-10520-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4427245171703220535=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CEBE260638
 for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2015 10:36:31 +0100 (CET)
In-Reply-To: <1424100349-10520-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: nikesh.oswal@wolfsonmicro.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4427245171703220535==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vs0rQTeTompTJjtd"
Content-Disposition: inline


--vs0rQTeTompTJjtd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2015 at 03:25:48PM +0000, Charles Keepax wrote:
> From: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
>=20
> Currently DSP controls are persistent (across DSP On/Off) only
> if they were set whilst the DSP is off. This change makes the
> controls persistent irrespective of when they are set.

Applied both, thanks.

--vs0rQTeTompTJjtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6FFjAAoJECTWi3JdVIfQ95oH/2UdFSbqYfIiNVXeaEs0GVlY
BzSwq+zmSMeub6HWA7nao/cYPRJ6NVyvQ0BbsCHYm/G9we0dGlEZqOBTLuiIaOJI
XfDmLICIjg3Ywc9GCStw/DaHeRF0ZJO3cvuRYzl5or4YVzD47GoYO5lAUjrmGS7W
Al2eU203QbOOmDbqg4BWnkPE3OwGRdDaJfYAF9s99U871SAWhG5vVCWAgUwOJF9n
fvWwN3iPf7gp4hIbdNB7Sb+iHwXBqNX7I7R1drWBZyn0MGESmBWSEsG9wQcoar4B
Vl/aKlo/Rk6IAr/MSSPacDOcpE7b1aq5SPJZwEa5szc77PaLwwjSDFHxxHZ8EMw=
=djW1
-----END PGP SIGNATURE-----

--vs0rQTeTompTJjtd--

--===============4427245171703220535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4427245171703220535==--
