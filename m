From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adav80x: mark expected switch
 fall-through
Date: Thu, 9 Aug 2018 14:46:31 +0100
Message-ID: <20180809134631.GE6132@sirena.org.uk>
References: <20180808191933.GA27767@embeddedor.com>
 <20180809093002.GB6132@sirena.org.uk>
 <a68c854c-013a-8cb2-49de-5bb109b27fc3@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3538999113096314307=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0892726791D
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2018 15:46:33 +0200 (CEST)
In-Reply-To: <a68c854c-013a-8cb2-49de-5bb109b27fc3@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org


--===============3538999113096314307==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 01:23:58PM +0200, Lars-Peter Clausen wrote:
> On 08/09/2018 11:30 AM, Mark Brown wrote:

> It is. But it might make sense to re-order the code to look like
>=20
>     case 54000000:
>         if (source !=3D ADAV80X_PLL_SRC_XIN)
>             return -EINVAL;
>=20
>         pll_ctrl1 |=3D ADAV80X_PLL_CTRL1_PLLDIV;
>         break;

> It is just as many lines added when adding the /* fall through */, but it
> makes it more obvious what is going on.

Yes, it's much more obvious.

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltsRbYACgkQJNaLcl1U
h9ColAf/b3zsDx1DzEB8I/VXJaCz65P+JXcCj/ZN5peRT9ab2DqWsuOR9kENYpPo
dCdbDihUX2xJQHczo8kcWJ04jRIv6CYW7AfUx3mGPIobuhlpBbBgBlbUGw8MsV5T
RQCLuiQK4NM+mmJtRqOzEh9nfzXaR0ZzxYSNDs6b3r4qcVcoNN4Or8AebOyrpH1C
f8SdozqynmFfnfeNJVAE5JEEReEIjW7PO5MrspoDG0ZcmPdF+Qtwgah/sRdaU14k
ReVk1XQSHicQYkJlUJWB9S5XKe3gDaW6BtW3b6lmwfKtlR7QieuJtxnRxgDLDKe8
vsoTG7ZxMpWHmBzKDJ64iOY2JmzDog==
=oCwW
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--

--===============3538999113096314307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3538999113096314307==--
