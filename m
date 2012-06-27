From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Remove const attribute from
 lm49453's snd_soc_dai_driver
Date: Wed, 27 Jun 2012 11:17:51 +0100
Message-ID: <20120627101751.GA308@opensource.wolfsonmicro.com>
References: <1340782476-5626-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1491958560868764334=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 35CDD2446F
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 12:17:55 +0200 (CEST)
In-Reply-To: <1340782476-5626-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, mr.swami.reddy@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1491958560868764334==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 09:34:36AM +0200, Daniel Mack wrote:
> Fixes the following build warning.
>=20
>   CC      sound/soc/codecs/lm49453.o
> sound/soc/codecs/lm49453.c: In function =E2=80=98lm49453_i2c_probe=E2=80=
=99:

This has been fixed for about a month...

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6t3HAAoJEBus8iNuMP3dzq0P/2iL4R7pOxkXIA04+bjbbqWm
jzBrs2W6eHoWgURZTVV7SVSL1qomKzLRZJK+UlyTv19QYccbpMqgfyln5OvE+Z9B
inp7CMFhHa5E5SOO1FsDrDZEVTG1Ci+WKrWcJBSPzo91aY0dCqfN783azEnfIap4
e0QEslcCQQuFAQh/u51ARMH8wetTU7i8PDa8s4fu7QOWDJ7NRf1opMvM3dTNRcvA
QQMQ5Qm4EoGM3ITYFciWYCihg4oH6UxKmUkR3U+yOIO5HTM+Gs1XfL8F8cK5evrV
A1K648aMQMufHM2oT/moKXqShM5J0ZNue32DzJ3oltJKegwBEfNiMPZ0UYvxIxvV
bR+YjoHKjSnZMjg5KooBUHV6fPK8RDzDV+yapqXCovGdbX58n05R/R5uc1QTNHRd
ZCG7tnBU5x+FwWofw1ag1MvhOly1IkXJnNEeOEYYWrxdxf92mQeUVZ29UtN8BdPG
jH6hDJ7kKzCj90xZsRFMM6I1dZKOFyp0HwurpknQSZpNSNJXCi6zZH16j4u488hw
9tGMGIRy99brpLH8hJu9rsehN3NBLDrWSngsfl9lh02zJgSeZBubI9HtR+j4SaBC
fqJPsRLu1EuiqfmFhe+yEzrWQ/S62cpS4JF3fXOoixWR907fH+CsltmJj1zUhhvJ
dBOeWedx1PbHls70U8IO
=r0wl
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--

--===============1491958560868764334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1491958560868764334==--
