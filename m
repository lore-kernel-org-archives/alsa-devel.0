From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8822: new codec driver
Date: Thu, 27 Sep 2018 22:22:21 +0100
Message-ID: <20180927212221.GY20825@sirena.org.uk>
References: <20180720110412.19125-1-CTLIN0@nuvoton.com>
 <5BA06283.9000801@nuvoton.com>
 <4c0cc49b-2426-2f5e-028c-f161f2e6553e@nuvoton.com>
 <20180925165613.GO20825@sirena.org.uk>
 <20180925175247.GA18430@sirena.org.uk>
 <26ac5971-f05b-77e7-c3a5-4fd799fcd64b@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5767644223044868024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E374A2678C3
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2018 23:22:25 +0200 (CEST)
In-Reply-To: <26ac5971-f05b-77e7-c3a5-4fd799fcd64b@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: AC30 CTLin0 <ctlin0@nuvoton.com>
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5767644223044868024==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rd/3IrB17klb+Ksj"
Content-Disposition: inline


--rd/3IrB17klb+Ksj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 06:44:45PM +0800, AC30 CTLin0 wrote:
> OK, I will resend a new patch.
>=20
> However, from my last patch file, I can see DT file where is located at
> "Documentation/devicetree/bindings/sound/nau8822.txt".
>=20
> And don't you see any DT file?

Ah, that's weird - I'd not expect the binding to have been applied for a
new driver without the code.  In that case everything is fine and no
need to send them again, perhaps just add a note saying that the binding
is already there in case I forget.

--rd/3IrB17klb+Ksj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlutSgwACgkQJNaLcl1U
h9AA9Af9GP9MK0iYRB6aq2O5IN5DoVJvlk2ZpB4pmdeei10bfXO7gGp3SIdoX57t
P35XxvvUuMTHdSuUb0JinstZ8NENPl/L9fWPZ6rd9znpTo88UF76KyCkmV0ZFMoi
7PGzaqwXhTdzbT88RGKkevwNnClMw0GelouIc5sOvjmVnpIWom/ipjDo0RfsxH2n
M5GTv3392N8d3u2TK12wBAx6OGbe07+2u0RUwaso70C7QrCMbkaHimI3z0+ThQVt
ulOVofnElOLONXxHI9MAISDKqzNZn7EXNcwg/WuBq+eKuIj2zf2D1+XiuBQ6gqpE
LuGYe7ZjofDYokwK8rRIxGxOgGX5HQ==
=amEX
-----END PGP SIGNATURE-----

--rd/3IrB17klb+Ksj--

--===============5767644223044868024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5767644223044868024==--
