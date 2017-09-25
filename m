From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4][RESEND] ASoC: add null_snd_soc_ops and
 reduce NULL ops check
Date: Mon, 25 Sep 2017 17:34:23 +0100
Message-ID: <20170925163423.caxbemanyhwqtctg@sirena.org.uk>
References: <87k20npnwd.wl%kuninori.morimoto.gx@renesas.com>
 <87efqvpnrf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6452319506125346498=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 03FFA266ECE
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:34:56 +0200 (CEST)
In-Reply-To: <87efqvpnrf.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============6452319506125346498==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvpv6y2uprmxyijz"
Content-Disposition: inline


--rvpv6y2uprmxyijz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2017 at 01:39:12AM +0000, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Double NULL pointer check for ops and ops->func is difficult to read
> and might be forget to check it if new func was add.
> This patch adds new null_snd_soc_ops and use it if rtd->dai_link didn't
> have it to avoid NULL ops, and reduces ops NULL check.

This doesn't seem to apply against current code, please check and
resend.

--rvpv6y2uprmxyijz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnJMA4ACgkQJNaLcl1U
h9DS1Qf9EZto3AB18S2vtrI5HwKKcXJvVz7505/LIKyVhfLJNGy1XVFvh1Zw2SZc
4rSJLtHabEod1cu7wPf/x/sqmqXp9Bw5/L3bpRmv+B7nBhUdxj3AqNuovtV70JK+
w5FaRlPDqSx0l6omIWuEUzzSKutsJhkjqWo/aP8JyKaCjrizPaNkODpb7T57oS7b
xgKKBkR29k4ZHWtUVCCweHIhye8vp3LAibVrteGOCX5EMAW9fyjilG08qppJuKHO
QsXu9JJnPj6bnCEQ60SWt/N1Cu/iP7ni0IxKA6yRza7MHMS8IUQnloL2tNAq3e27
KrFYZYeYbeBkLKxMS7yGshdugWoftQ==
=sCo6
-----END PGP SIGNATURE-----

--rvpv6y2uprmxyijz--

--===============6452319506125346498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6452319506125346498==--
