From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Tue, 6 Jan 2015 17:37:11 +0000
Message-ID: <20150106173711.GH2634@sirena.org.uk>
References: <1419997154-860-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1002642008823718456=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F65C2604D1
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 18:37:31 +0100 (CET)
In-Reply-To: <1419997154-860-1-git-send-email-b50113@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <b50113@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Li.Xiubo@freescale.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============1002642008823718456==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pTYhUwqpXRR/mkN7"
Content-Disposition: inline


--pTYhUwqpXRR/mkN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2014 at 11:39:11AM +0800, Zidan Wang wrote:

> +		if (!IS_ERR(wm8960->mclk)) {
> +			if (codec->dapm.bias_level =3D=3D SND_SOC_BIAS_ON)
> +				clk_disable_unprepare(wm8960->mclk);
> +			else {

Both sides of the if statement should have braces if one does, though in
this case nesting a second switch statement would probably be clearer.

> @@ -661,6 +678,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_=
codec *codec,
> =20
>  		/* Disable VMID and VREF, let them discharge */
>  		snd_soc_write(codec, WM8960_POWER1, 0);
> +
>  		msleep(600);
>  		break;
>  	}

Random while space change here and in a couple of other places.

> +	wm8960->mclk =3D devm_clk_get(&i2c->dev, "codec_mclk");
> +	if (IS_ERR(wm8960->mclk)) {
> +		if (PTR_ERR(wm8960->mclk) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +

Why name this "codec_mclk" - the device calls it just MCLK?

--pTYhUwqpXRR/mkN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrB1GAAoJECTWi3JdVIfQGtMH/0dylKfX2NmAWZpMtbYDJWNk
mjKWmeHrIKO4qN8o/aYpi4lNPVO/r2/U11WNaHhbzkKu9wlqiefha5MwKr9TBAY4
NxPa9mUUTkwRKXIPZppS/hloaiKQkXPIooBuHoteEfZOX4e5ohZewFPIiOYMi2kw
htKOaO00JmbF1ZSN1+IQZ2ds5rZcwsiy4eIUyiw+NsBGr00NRXSvCWB2ly2BXKzv
S1o11koos9QkMdjR3bCJMF3R1Rw24fz9+dK7krAb40JAHmwr/3ixM7zETBjFZYuM
dasojOHqVnKIjZHZ2YRsEjQG9LEEZ4mGDPjK3d04/ZojRP6Umy775KPIdn73640=
=DvHA
-----END PGP SIGNATURE-----

--pTYhUwqpXRR/mkN7--

--===============1002642008823718456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1002642008823718456==--
