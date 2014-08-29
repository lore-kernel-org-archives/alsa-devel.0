From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4 v2] ASoC: simple-card: remove
 dai_link->cpu_dai_name when DT
Date: Fri, 29 Aug 2014 12:51:20 +0100
Message-ID: <20140829115120.GS29327@sirena.org.uk>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com>
 <8761hdia86.wl%kuninori.morimoto.gx@gmail.com>
 <8738chia5n.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4399712389637229287=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE0082610B0
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 13:51:28 +0200 (CEST)
In-Reply-To: <8738chia5n.wl%kuninori.morimoto.gx@gmail.com>
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


--===============4399712389637229287==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ig5MTpp3LwprTX9"
Content-Disposition: inline


--3ig5MTpp3LwprTX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 08:08:06PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> f687d900d30a61dda38db2a99239f5284a86a309
> (ASoC: simple-card: cpu_dai_name creates confusion when DT case)
> removed dai_link->cpu_dai_name when DT case,
> since it uses DT phand in soc_bind_dai_link().
> This binding will fail if it has cpu_dai_name.

Applied, thanks.

--3ig5MTpp3LwprTX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAGk0AAoJELSic+t+oim9xtIP+gJiSkJFXCRTVcs1zp+j4Fju
hjUQKkp5/ZzvXQkZl9Ld2QPyxt5HC/docBApB13iKpqfRcG/RWAaoxPtvaY8JR+r
4MkBPeC2XGeUPI6ge7gHZvgNEbgaJwniGnMj7HbqxeOX4oBvYS+aQFfjUv/yaIsL
wxYe5s4GP15TcWKhuK4PynWVfCZCKhzLVl4hRMVfErdKQ9NbNA+kWU41Tg/Fuqad
Ecj1pVskXYDEGCnMqcZBadcrCebT7eMeIBsTghJh2QpTqwNLMwsWt5pLZYXs5if9
0j2JgTDajJW4g/p6XtGwsaGVpAi4JgkqsrMAdKu8pywu+djb1+DNpZtfabaAVVSR
k5w+3eMXKGaQOPfp7jWLPLxmOvTOf8+YBrVBfbqhkfbkALQgWp77ucWsWxAQ8GcA
aZdH9vB59EtDUiXMgQeerImV100zNDPg+8NcZFYODzHtVRkM9gHqyn7emI4igC4x
M5zaMLnK13tbHSfrmuPXqdsHgj0qiox0sZd/02hFNDsLByzZm+UfSVNbz8pUGHQW
UVwccRY/Dpmd2pRbcbRiZ61TF2A2+glhomat/6VYUqmKpWUFLpi4VmYUYTfILD2C
f/36VEjjJwEH+oxonaazzOojilfftbExTu2R7VA0QX3EOKwETPXeezQESB/OyKa7
Dwwu7D8wIMaDKix8+is/
=HL3B
-----END PGP SIGNATURE-----

--3ig5MTpp3LwprTX9--

--===============4399712389637229287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4399712389637229287==--
