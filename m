From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Show the returned values
 on error messages
Date: Fri, 17 Feb 2012 13:55:36 -0800
Message-ID: <20120217215535.GB21717@opensource.wolfsonmicro.com>
References: <1329514838-30933-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9059174169149079740=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 761F9104005
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 22:55:41 +0100 (CET)
In-Reply-To: <1329514838-30933-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: tiwai@suse.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9059174169149079740==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2012 at 07:40:38PM -0200, Fabio Estevam wrote:
> Showing the returned values on error messages is useful information.
>=20
> While at it, use pr_err/pr_warn whenever possible.

Applied, thanks.  I rather suspect a lot of these should really be devm_
rather than just plain old pr_.

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPsv1AAoJEBus8iNuMP3d8yYQAIdcpFaRAGVT14BavzIw2ajr
1VXCO4ZjWmpijwIE5Q7t3HqovVOb5jGaQyhrnbr0wuQotAgoSN9ky486siiVEHg6
EytMNjJR8HElx3d3R15sJ3IDyy504xd48tTLaSg5f7RRARJeKM2yHZ2Y6Yzi/DEf
zDG6YzWTuLkDs3Gm0c7X2P5djVlQ/svROBL5bN7uTQXNb2gkBg9bPLtPRz8grlko
drMR3uUMbomXAZGuPkYXafDtvetdjXFutUvyS85n0GnCA9k6CZoRX0ASmGa/yjwG
3nGU1MPQHhhhi7hig7MD0enSsDN5ZboYnhKXqEmjYp2odm31hyiVlv5EvFo/oXK5
7k4MPbMWC+Uepq6m5WZzOgraRZRgXeO54EUfD052Gi4ZqwCWr560ZcVH4DCsjIIl
0PFficT2JZKmdnlCFMbh4LMaY7Qbn1DiBNMMZ4QGcD9FeC+4jSDDTiUKcAQgdV2I
+g57A9IsUi0onAjx9QRS+POnB2YV59h93KGxRiB9e52TezRtz+GAL9ouyoe20XBW
PjF6jg/nRm0Zq/8ggU4NuwizTf1qEnZMtDnWCtqIa4LbI0YIZNN3dq1Wj+30hQNb
Ar5+7/BdkfOaHUmq6eJE3TZIew8HpfepfNGT9MhVTMdYC/KScMiTOMVWmnvMvjlo
M+d29iSUZ3n50VueQ6ZP
=MQkp
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

--===============9059174169149079740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9059174169149079740==--
