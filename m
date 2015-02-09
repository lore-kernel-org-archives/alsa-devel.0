From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rsnd: set device data before
 snd_soc_register_platform/component
Date: Mon, 9 Feb 2015 16:24:39 +0800
Message-ID: <20150209082439.GF2593@finisterre.sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87iofj7qhc.wl%kuninori.morimoto.gx@renesas.com>
 <20150204205503.GM21293@sirena.org.uk>
 <87a90nwlur.wl%kuninori.morimoto.gx@renesas.com>
 <878ug7wltn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3029093455773302936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 62D53260438
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 09:25:10 +0100 (CET)
In-Reply-To: <878ug7wltn.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3029093455773302936==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2015 at 08:05:22AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Set device data before snd_soc_register_platform/component.
> Otherwise, it will use NULL pointer if user calls unbind -> bind or
> rmmod -> insmod

Applied, thanks.

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2G7GAAoJECTWi3JdVIfQyLEH/2Zw6VrMmq/hvd2Rh30RUZAV
Bip8OF2st/Udk0rB5gN1yOlUVituKAS2gBiggq2RuCps0bvigx5nSZG7nJVBsPD1
+vJp2ey6hjfC8VQtDc01r29p6T1nHASQbpjsO0lsAxGdDBY3hLV8354YQB3HmwLO
MyolsAvs+2YQDByQ2a9ELz9feOhs8y6fqEJVN0Q/ZORVeL6CdoQ1fIPKcb8rUz7U
EyXttX52Mc2uxfG1kfIaj9Py+3Fn7UDkwofc1M0wq2nzdTOG7EZWAgnx1vASl/B8
zkXAbifbbRwd6zMGbjjHo1HkWw9ne1l9JywQiS7r/eiP4tXyW962pNANkHRl7gk=
=+vor
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--

--===============3029093455773302936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3029093455773302936==--
