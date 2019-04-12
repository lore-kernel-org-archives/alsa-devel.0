From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7][RFC] ASoC: modern style CPU
Date: Fri, 12 Apr 2019 12:56:19 +0100
Message-ID: <20190412115619.GK6909@sirena.org.uk>
References: <87zhp144vs.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5625631549793290756=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A20DF89616
 for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2019 13:56:21 +0200 (CEST)
In-Reply-To: <87zhp144vs.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============5625631549793290756==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 11:31:01AM +0900, Kuninori Morimoto wrote:
>=20
> Hi Mark
>=20
> These are RFC of modern style CPU support.
>=20
> modern style dai_link needs CPU/Codec/Platform array and its size,
> but it will be very ugly code. To avoid it, 3) adds macro.
>=20
> 4) - 7) are sample code for switching to modern style dai_link.
> 4), 5) are good sample for single CPU/Codec/Platform.
> 6), 7) are good sample for multi Codec.

> Almost all sound cards will get similar patch.
> I think these can work, but I can't test these.
> So, it is very useful if someone can test these.
> If these are all OK (=3D test/review), I can post patch-set
> for all sound cards.

This looks basically fine to me, hopefully someone will be able to help
out with the testing - thanks for your persistence with this work!

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywfOMACgkQJNaLcl1U
h9DBEAf+J+YxvEVLK7u1xUJEQllsnYGyKFfp4c4PD/41nafNDD108aPWNYvs2mOr
RBtG3PKMHVvq0RocCghj9uJ866JqufUuRl8YOwRxp96wcYTkuUKorD8rkPDzEA7i
O/2aGNldsQN46+AZ+bbYdFQ3s4T5rU46G3QWKgfOYAD91ZfvVNreZFHY0neBmT72
U0LaTcYLQTMH3A49tQiaBstisEaobkWJcx5cxc93YfYv0+kj0yq0RPmLbW+Nzx2n
zbTcv37e4TQZsX6WFgkx3LvE49JAyarfZpTaXrhCUGA1+QHQ+dcFseZMk8WjXU3u
I0Th7Zqn8wwheO0qQtT4M0Ma4wH9SQ==
=dcK4
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--

--===============5625631549793290756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5625631549793290756==--
