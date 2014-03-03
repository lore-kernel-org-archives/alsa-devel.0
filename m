From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/19] ASoC: rsnd: add .set_sysclk on
	snd_soc_dai_ops
Date: Mon, 3 Mar 2014 10:18:44 +0900
Message-ID: <20140303011844.GA2411@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <874n3n90qt.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3737434929325076587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8493D265532
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 02:59:21 +0100 (CET)
In-Reply-To: <874n3n90qt.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============3737434929325076587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 10:15:25PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> This patch adds struct snd_soc_dai_ops :: set_sysclk.
> But, it do nothing, since rsnd sysclk is controlled by ADG.
> Without this patch, simple-card init will be failed
> if DT case.

We should fix the simple-card code so that it does not need this rather
than adding empty functions to all the drivers - I'd expect it to handle
-ENOTSUPP as not an error.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9hrAAoJELSic+t+oim947wQAIgsH1h4VV7STWgrTHXAYeY6
foWoKWGCvoyIFyF/Z0O23W2INRYQBEyhmRrJV2hPG9f3VJQtGWReJC45oaCubtXQ
17TPUJIdhcZoKLst0giM9HxHt5ixMSuw3WNegC3/Z1GCoYx8oQUbk98mBT9WeAbS
4oLiMdziarWTjodWWpZgztIJNzCa+5geJersuwQlVkaRHZ4d6uXLGNewR4enS94T
yJx0GDHQLyQAoHkmF3QTo+BdJSF4JzSPE96rwjGVaKX6gjz4kBSH/ZeaBDE/NsM1
1h1alZtttaT34zEtipPNlE/fZVdUae5vqqEMOnXgArneWzexFqpG2WPWWRrmwSlB
s2ObvkCNtg5ueFUV5pPDcSVDjY0fgalCdPhCNOO7PeHuaij15qPkt7hNWELzi5MC
xSptwn80i4IaHenKSol4q2L1xhWa+9Gt9WbvmgRvSycf+DEnylwPQuMfAfma7BCT
uPkCaoYLN6tOnkQpRruK9I7wozyXaSnP+S6LEdHP3+eAiBUDObLAnLpOhKIHWRj/
i4p40ueGjjUtzhBJWMPEDWkm1dEJLl8wILQ+ph3olhIbt0rhScK+X3yEX/2HvhBw
Dx7i4scVmCDD/nE5QGvBlBbbcQjcvMImefXIRHkxc8Xz58PaKxEsg2c8DUXlsl4k
GCQZEkPPoa2uw8FmRbov
=D+8Q
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

--===============3737434929325076587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3737434929325076587==--
