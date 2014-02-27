From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: cpu_dai_name creates
 confusion when DT case
Date: Thu, 27 Feb 2014 14:07:26 +0900
Message-ID: <20140227050726.GR9383@sirena.org.uk>
References: <87eh2r9169.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7862199069529627561=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC355261737
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 08:46:39 +0100 (CET)
In-Reply-To: <87eh2r9169.wl%kuninori.morimoto.gx@gmail.com>
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


--===============7862199069529627561==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jcwRHPSxFqmwpRFb"
Content-Disposition: inline


--jcwRHPSxFqmwpRFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 10:06:09PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Basically, soc_bind_dai_link() checks
> cpu_dai->dev->of_node and dai_link->cpu_of_node in DT case.
> But after that it will check
> cpu_dai->name and dai_link->cpu_dai_name too.
>=20
> On the other hand, snd_soc_dai :: name is created by
> fmt_single_name() or fmt_multiple_name().

This looks like a valid issue which still affects current code but it
doesn't apply due changes on the latest topic/simple branch.  Can you
please check and resend?

--jcwRHPSxFqmwpRFb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDsgKAAoJELSic+t+oim9Kq0P/1XrxSvZ6UG/2LgJP3W0mjEd
vikD/P21WPha+unJfp4nOWV10RXE8opEcbN0J2GmaMltsusmoU0pALs7I5+J1Q5x
Ke+DeLY1CzqfIp0gSWi1ZAh63XLYvEDwMr41S8eZw4MboFRfyYYrLVN8p80PmIUQ
0d/QWscdQDVOFrthPdnXRsvrK67brgfIyOoofqnQErADjypvspL7FZ4tSu2lF1Xk
LJUUXJC6eNzjeaSXsNzxFw2pHJsyfcT7oIiHGceJdEAlh1lv2aHyalfolHxMtW2F
0q+/AuW72FxgMqeYvq4Y6b3uYWbhoFuhcwFTg/jj+zGm9yfLemgreiVyzAYfpqPg
cNozCKsOf2uU4PJkiRjJkHvZdYzfR6T4iJBx+9ruEKMWfyBsWBE6ioK/r/ScIF2p
aIVJd67zKH9rG5x4laZ7IADRgqiSOXJFssaRqwMSRbAB8bV9OuSMZRjfLKtIQ0iL
N0+Y0YVk5IehW9MjzaGE82kdkUDPgABSsij15UYwn4HyM9vrTlRxLmUAiUucc0Zp
KO1U9tqY721TKJNMnhjiNEXVXh/MJ3hukPZU6al1SSBq8EzszP0JnKYhRD8TQJyS
YQFR0IjeiQqnTnDAkEyPjhWaE4oYtN+BNk7zTKKCXA7sDKRJ8/h5ZzzFYAJ5hNlr
aMkjZLdCLbr6nc2KgM5H
=IvxA
-----END PGP SIGNATURE-----

--jcwRHPSxFqmwpRFb--

--===============7862199069529627561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7862199069529627561==--
