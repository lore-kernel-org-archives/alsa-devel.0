From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v1] tlv320aic32x4: delay i2c access by 1 ms
 after hardware reset
Date: Mon, 11 Feb 2019 15:04:25 +0000
Message-ID: <20190211150425.GE22391@sirena.org.uk>
References: <20190210154519.2506-1-ps.report@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1077717703361859377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8202B267465
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 16:04:29 +0100 (CET)
In-Reply-To: <20190210154519.2506-1-ps.report@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Seiderer <ps.report@gmx.net>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, b-ak <anur.bhargav@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1077717703361859377==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 10, 2019 at 04:45:19PM +0100, Peter Seiderer wrote:

> @@ -972,6 +972,8 @@ static int aic32x4_component_probe(struct snd_soc_com=
ponent *component)
>  		gpio_set_value(aic32x4->rstn_gpio, 1);
>  	}
> =20
> +	mdelay(1);
> +

Perhaps only do this if we toggled the GPIO?  If the device wasn't in
reset then there's no need to wait.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxhjvgACgkQJNaLcl1U
h9BpKAf9G+y8nQsDTzqkvK6vjYpwPnr3Staxy0uTlswZLshRAlNWzqorA+k9ySK0
9rnjMVjD0bG+qQcUUWXKIciQVdx2yaqHYCNROB+EloqA/8ADyivO3DuaTh3OPI8S
95q5gnMJyKnWiJq9kxSqhAtfbDt6/F3ITZYy2XD7N4IXKktVbrPtKU3NZhentogy
w2NS5PwuVERZ2NvvmVZY5gZNShpvfFmX/U1BY8/RCGxscmsK6jYRzlKnkQBUymQr
vbs+MuYM0xnu++cz1mEqXhLLbW4wdTujq93BhQm6/zSgndiJySIyKaWBw1KmF1U0
ICvazgSYUkopGbQVe9Dbwkp9j+g/Zw==
=fgqh
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--

--===============1077717703361859377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1077717703361859377==--
