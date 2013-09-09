From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 2/8] ASoC: davinci-evm: Add device tree
	binding
Date: Mon, 9 Sep 2013 16:21:46 +0100
Message-ID: <20130909152146.GK29403@sirena.org.uk>
References: <cover.1378738436.git.jsarha@ti.com>
 <2f2fa45507656c464b413a9761c7dd2059f4590e.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3130553680514307624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 380BD2650A0
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:21:48 +0200 (CEST)
In-Reply-To: <2f2fa45507656c464b413a9761c7dd2059f4590e.1378738436.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: oku@iki.fi
Cc: Darren Etheridge <detheridge@ti.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============3130553680514307624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIHsHaVgx5AQzhyz"
Content-Disposition: inline


--jIHsHaVgx5AQzhyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 06:12:13PM +0300, oku@iki.fi wrote:
> From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
>=20
> Device tree support for Davinci Machine driver

You need to send this to the device tree maintainers and the device tree
mailing list (not the old one you CCed).

> +  Codec pins:
> +
> +  * MIC3L
> +  * MIC3R
> +  * LINE1L
> +  * LINE2L
> +  * LINE1R
> +  * LINE2R

These should be documented in the binding for the CODEC and referenced
here - if there isn't a binding for the CODEC you should add it.

> +	machine_ver =3D (u32)match->data;
> +	switch (machine_ver) {
> +	case MACHINE_VERSION_1:
> +		evm_dai.name		=3D "Voice Codec - CQ93VC";
> +		evm_dai.stream_name	=3D "CQ93";
> +		evm_dai.codec_dai_name	=3D "cq93vc-hifi";
> +		break;
> +
> +	case MACHINE_VERSION_2:
> +		evm_dai.ops =3D &evm_ops;
> +		evm_dai.init =3D evm_aic3x_init;
> +		break;
> +	}

This appears to have binndings for two completely different CODECs...

--jIHsHaVgx5AQzhyz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLeeGAAoJELSic+t+oim9h88QAJ0O5SHCgfNFe+fgTk4daxfu
CESQN8WJpwmQwrUEjTNNYoXdy+LlriH79IuiIXMxu38lCGrd1SNyraO0hIrOnJiZ
DrRlCHoUpc/5PevrUWH+us6GeKi4ep0QdxrlwqcUrf8iidUdVgWgJJpQ8/LDSsW+
3mEHl3hVDOJhBt82JHxQNa46l/WOn0+AyZb88JygBCA6AIbhCjGujSu/PReVzHZh
I+oXDLElujeNKlRrU0Rtivj04IJ5iJoB6LYizPk/M2eMKijZ9r+mIvtX0xqK4Ytt
IbrCbaFBBMXEmhlqZ37gPcz5UPbrybqQuGdXPRvuq8pie79RGIp4ASgumZL1KO/z
LECdSlUJHMJj8t1mY+NcJSkeJTpVl90dE78kYX/Jk+Sa/b1zBzzzmCojne7sGC1Q
1SUSVAfh+enNE7K5Ae/znee9qdbvOBJRI19wWfxV6+J7Qsi/G1sYHjYSrsLbZHUz
3xTsUGiWqsMWMdXZkBNqOpvkXTFoV/zNn5nUwEVtxezA2n2b7b+dDJ+YCxt5eUI1
bHlc572t9qvxhuoMVkJUVdCi+Y7CdqT/MaOobLHEzYo2CRQr7jCC2e44fohU+XHN
vencR+zHVNt9jrfwWWgyhmRMZxiJbqXKsHsSXO6soUBFkrwckWLbZNentvX/C4y+
VzliPns2A7uCDYH2hksw
=EVYG
-----END PGP SIGNATURE-----

--jIHsHaVgx5AQzhyz--

--===============3130553680514307624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3130553680514307624==--
