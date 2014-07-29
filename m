From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_asrc: Use 'ifdef' for config
	options
Date: Tue, 29 Jul 2014 20:15:59 +0100
Message-ID: <20140729191559.GI17528@sirena.org.uk>
References: <1406661016-1478-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0424729839001865348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD8FF2651F2
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 21:16:05 +0200 (CEST)
In-Reply-To: <1406661016-1478-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Guangyu.Chen@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============0424729839001865348==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b4/McbcP8l1brYvY"
Content-Disposition: inline


--b4/McbcP8l1brYvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2014 at 04:10:16PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Fix the following build errors that were observed by building with
> make ARCH=3Dmicroblaze allyesconfig:

Applied, thanks.

--b4/McbcP8l1brYvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1/LrAAoJELSic+t+oim9cIoQAIqrD2BMz9M1l7wP7XHDdacJ
JJURyKZxjsOnusowyiWIZT2UDcJRJ+YnNLvwgxBzlfQa9527aJqP5OvhB+S2TujP
bgBBZ39jylVJ9v3pBMIPPrqNhj/ckraRC1+KQBDrMpPue6W6INowUIBiJsuQgmYi
Rl/pcZtG0VLr30ScBC0z/pmtN5vSU2Y+Tw4bW/okEC941Z6sAqoibYaCS24QOZfp
dXh+EvlvxROBqua3bmfG81Q/H9j7/InG8qdTbbqyeod1E8a21eAfPFG4njbuWoOq
2KdzRS1g4FQ2KVNr6UEumxZNX4iO8wehqilWhYPQX3k8pi0EP1m3EKz/EuwzI1T9
bMeT3d9eu8z8Y80FTM4KWH+cXZhz7VbQAaxUhcnB36FzWTbhKtFoRqvz/o1bgATq
0Dzw9iqDzs4tQigePoNivUEFdZvEesN/vUGY7dKvPkvtem7zc3Z8WWUJuxF7igHH
VSMQXkuY0paajUuifP72qG4TVBLY3RpV7IIPyUiSTd/ozaf8xkqL6YQ8mR+Slv+j
3TW8pw7XCaKTjgncFHwpjU7r0NmcqLJlZgBOE5RbCKpGx5zB+X76Wict2MZYaOlV
SYf8LShO22zt0XFjBJn/CrVqMz2mG7XCBCWqLbTU39vawpybUFyA+Xo/LbY2Q3pT
DqM+ZyH9DOPjAL5adJ0K
=6uL0
-----END PGP SIGNATURE-----

--b4/McbcP8l1brYvY--

--===============0424729839001865348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0424729839001865348==--
