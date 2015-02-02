From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rsnd: call missing
 snd_soc_unregiter_component/platform()
Date: Mon, 2 Feb 2015 18:38:29 +0000
Message-ID: <20150202183829.GY21293@sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87d25sgbf7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5160089975484968730=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 53DE826066D
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 19:38:34 +0100 (CET)
In-Reply-To: <87d25sgbf7.wl%kuninori.morimoto.gx@renesas.com>
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


--===============5160089975484968730==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ozzXYiujz/5xFLN+"
Content-Disposition: inline


--ozzXYiujz/5xFLN+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 04:54:07AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current Renesas R-Car sound driver doesn't call
> snd_soc_unregiter_component/platform() in .remove.
> This patch call these functions.

Applied, thanks.

--ozzXYiujz/5xFLN+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz8QlAAoJECTWi3JdVIfQLbAH/AllFDud+dSWeRkzecH/k8dg
owmZYNueNlBtO7ayymDVOPGcktAx70y2CHwARe8YSCm8cweBa0Rjv6hO8pocs3F7
xOPHZQW2Zl6qOjNC39Hix95okZ5MSfjs6ApmlZSucc8Q4OxU1CYyD+ZhtPysWcpH
5Jahnv77t59E19rL5hj0terXbzvBT4v9mgyGLQNkTIDdhjxcBQT+vbkSSb5RzvfC
GeAP24Hb0W9FmfY8rJK58DmlSClIygna/fZ4yXvhSdAEpFDFHkNjMZGIYt3Vbudk
EICDCX5+8GCUcEeb76gLx4NVkNW3KL3OY19GPw0o8k2FwBm3Yi4BOyuQV6vdXwE=
=EIiM
-----END PGP SIGNATURE-----

--ozzXYiujz/5xFLN+--

--===============5160089975484968730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5160089975484968730==--
