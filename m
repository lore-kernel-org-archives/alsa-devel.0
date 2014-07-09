From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix driver unbound
Date: Wed, 9 Jul 2014 10:13:15 +0200
Message-ID: <20140709081315.GG30458@sirena.org.uk>
References: <1404754008-31861-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2639213243124849329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7B93261B31
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 10:17:29 +0200 (CEST)
In-Reply-To: <1404754008-31861-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Julia.Lawall@lip6.fr, alsa-devel@alsa-project.org, rmk@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--===============2639213243124849329==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gqO6s7S91gFL8ZIQ"
Content-Disposition: inline


--gqO6s7S91gFL8ZIQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 07, 2014 at 02:26:48PM -0300, Fabio Estevam wrote:
> Using the sgtl5000 codec driver as a module and trying to remove it causes the
> followig kernel oops:

Applied, thanks.

--gqO6s7S91gFL8ZIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvPmYAAoJELSic+t+oim9npoP/0v7g8Hc2N916Xb2GG75nLUe
i1aLcBWZF07LdMzRsKe3b3Cn5DIbqv5F1GHyMuerv/dTF5bJI8yXbcJj2PYwI8QU
snM1DzYD6/i819zjkkskr3CRkPfTnqA39TbUXviIzYTUuF/mtE6cE6xTnBnV8oIQ
r3HAXTqnYapAZDkIa0ChuI0fdo5nQcusErvOfofAUsGhXBiAm6/ut97sT5fMabiu
+cx2f0cE+TiC0h3uNgIBWJIm+tM+PTFlUqxHPB0p992HzrVNLjTUfAKPcupd5oWm
LD5fBQae+zSZwnyuNoFjpCfVPyHdCV2IbjSwmh+go3c0s4ap3as8/wEy7A3Mnc57
vle1pJJcrElJbxKu6gPpZqmcoonHW2MJZjBQLwyroOGZ8vP7u7T/a5sID7UaOVmE
VDu/mC/9NQOEPH8sng9JbEMmAlEuJeKEfgUDZvFYDiTBeeqb0vjaHS3dIZpovZRD
ennFyXE3+MGlkmon3Z/b+7u5VoHJOeCorF1LrptXF+/tptNmFMV6P6tmr/OhNOIm
tw2NIARinbAb+POjqlv93guH9u2xKAnWb6/sIr24/g8KMer4x3y45g0HfFPlhg/h
84jWs+bxDxpbxqeZ7Ag5HtoX4a1/bf80A49OW/qXX4WrSgN+ykRlq7hbh2riZx0/
9h4D+n86grD3IUfkx4NC
=KMfK
-----END PGP SIGNATURE-----

--gqO6s7S91gFL8ZIQ--

--===============2639213243124849329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2639213243124849329==--
