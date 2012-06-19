From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix snd_soc_dapm_put_volsw()
	connect
Date: Tue, 19 Jun 2012 12:36:42 +0100
Message-ID: <20120619113641.GL3974@opensource.wolfsonmicro.com>
References: <1376117137.2888145.1340052088940.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3616398699430290790=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75D5D103F39
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 13:36:44 +0200 (CEST)
In-Reply-To: <1376117137.2888145.1340052088940.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3616398699430290790==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TlDjLAx2PuPdVSSH"
Content-Disposition: inline


--TlDjLAx2PuPdVSSH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2012 at 10:41:28PM +0200, Beno=EEt Th=E9baudeau wrote:
> snd_soc_dapm_put_volsw() sets connect incorrectly in the case max > 1 with
> invert. In that case, the raw disconnect value should be max, which corre=
sponds
> to the userspace value 0.

Applied, thanks.

--TlDjLAx2PuPdVSSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4GRCAAoJEBus8iNuMP3dgFQP/RDhkt4DB7jiChKhDQXFvCb4
0LlINW+rBSNLcYFvZfMfoVz/E8BChoCvGzN8BF+9V5tPQE88SwikPgbzDtTxi4ZB
V3soDZCiMRXS4NoWFxW3Eqyd+sr0x+yK+tKAhuh/HQm7dmuBPyrdpDIjOBXcdf7g
EmhhlLW3pws8srQHbsfrru6/+Bgi7kJodUQmRG11itVsjGvPSwxusx2iVRol+usx
vyxsjNzkDTG8Ffr151Yu8OYpTX1ToAY/PBevYdxjKDp4MSWk+WMto4wlavqcylGH
AlmVW/jbZb/vyvqY5GL22QA0C/6IZ6h9P4uyBLjDwUqHxZNoCHNP2/7p5n3XH+r+
YSjH8C7shAaPi8vp4HvB2hSsH3DboPpWN672ze0hWaKU9dnMQJBAP+0X58Tk7XCP
//SIB1WfHChMk3BcLXXForU0Az1S7OVloDC44JcN3mQ5WUQMy4UgaST6YfkHgBha
vTVBaIrbtGf9ytbBxJDf5CITr3SsKmXGgYpKDFGmgDVXf8B8p8wLGtQzMq2i/k0o
q3ZlxXqLrsKfM252rRYm23EqxVH689BhIbGj8Q95DOoYaxCEGLYWSFlWAp3OB8Ol
OKQPwx0L3motduA0yufMqwUYW3skGmIZllfNH6TqSnn/JFyqh2RuUx6dxz91r/K0
Z2fe787ZRpUILPZwD09L
=lLYC
-----END PGP SIGNATURE-----

--TlDjLAx2PuPdVSSH--

--===============3616398699430290790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3616398699430290790==--
