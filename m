From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Failed to create component debugfs directory
Date: Wed, 21 Feb 2018 14:40:25 +0000
Message-ID: <20180221144025.GJ8334@sirena.org.uk>
References: <CAOMZO5D071pPr4fL7eLwWgX6h8Mppwic2u4mUCGzUZiss-+3MQ@mail.gmail.com>
 <CAOMZO5C3joR2QS+yFDmQUs1Q69PfuVw8tBMNd+F+cjDnUMEPSQ@mail.gmail.com>
 <5b591fd8-d4d5-27bb-0850-a376da20d7f3@metafoo.de>
 <CAOMZO5Ai-EtFo--OYLKhsB+63u6D+Vyjx_hKVeG3EGXbHkY5jw@mail.gmail.com>
 <99ce1244-6646-6292-2c50-151819b01cfa@metafoo.de>
 <CAOMZO5CA99p+2DYrbWQnLzh5Lj8syX4j18V8R8WPV2KDZz-DVQ@mail.gmail.com>
 <20180221130241.GI8334@sirena.org.uk>
 <CAOMZO5DZ0W5q6OAvrRWv+8GNbWn5ttLk3q035H=4fLton-1mgg@mail.gmail.com>
 <CAOMZO5B_H0EN7c8+dCwuXvP3_KOoLz=94KQO9oZOM9PoeMX-1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0808772485714561655=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 582A3266FC9
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 15:40:28 +0100 (CET)
In-Reply-To: <CAOMZO5B_H0EN7c8+dCwuXvP3_KOoLz=94KQO9oZOM9PoeMX-1A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0808772485714561655==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJFRpmOek+ZRSQoz"
Content-Disposition: inline


--IJFRpmOek+ZRSQoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 10:47:45AM -0300, Fabio Estevam wrote:

> Looks like this can fix it:

> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -442,6 +442,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
>         if (!pcm)
>                 return -ENOMEM;
>=20
> +       pcm->component.debugfs_prefix =3D "dma";
>         pcm->config =3D config;
>         pcm->flags =3D flags;

> Would you like me to submit it?

Yes, please.

--IJFRpmOek+ZRSQoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNhNgACgkQJNaLcl1U
h9AFKQf/XXdzBRUi/GUgeE+nfpqvkZTxpYTNZmPZZzas4BmPpFf3dETO2Lzs/w1E
4n5oznYKW/bPmfto9BETeRaiS6bfqBfaVOeYzuxaI45FgI40t1y70tLL5/IzFS66
MAVaLwEXdAaA2cV3OLP8Npv8lrHEYawdkBaYMGXhheFBouNcV2R8V6O7aiZ8Khfz
Ek7tUbsinGix6tp5/BqUB+D3CPj6QDMCCsZHtIu40g7LJoeP+Xr1RM+/M+fe+QjT
jqWFgTfDzaLsMD+Jh362t8+LSyzRSWgr1l0a67J0NaghMoMkUneflm2PaneQY+/U
8CQRfB1h3ji8lZt6kH6eDktPFYLImg==
=x95j
-----END PGP SIGNATURE-----

--IJFRpmOek+ZRSQoz--

--===============0808772485714561655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0808772485714561655==--
