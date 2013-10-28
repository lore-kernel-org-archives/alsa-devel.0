From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add pinctrl PM to components of
	active DAIs
Date: Mon, 28 Oct 2013 09:44:05 -0700
Message-ID: <20131028164405.GK13643@sirena.org.uk>
References: <1382695544-20946-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3345634882187894181=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2004B261A88
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 17:44:16 +0100 (CET)
In-Reply-To: <1382695544-20946-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3345634882187894181==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pN9MePJoZbRKbUk1"
Content-Disposition: inline


--pN9MePJoZbRKbUk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 06:05:44PM +0800, Nicolin Chen wrote:

> @@ -807,6 +814,13 @@ int snd_soc_resume(struct device *dev)
>  	if (list_empty(&card->codec_dev_list))
>  		return 0;
> =20
> +	/* En-active pins from sleep state */

Just "activate".

> +	for (i =3D 0; i < card->num_rtd; i++) {
> +		struct snd_soc_pcm_runtime *rtd =3D &card->rtd[i];
> +		struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
> +		pinctrl_pm_select_default_state(cpu_dai->dev);
> +	}
> +

This is going to put the pins into the default state during resume,
that'll mean that if we're resuming a device which wasn't in use over
suspend it'll be left in the default state after resume instead of in
the idle state.

I'd expect the selection of the default state to be part of starting an
audio stream and to only do something to active streams on suspend and
resume.

--pN9MePJoZbRKbUk1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbpRSAAoJELSic+t+oim9Du8P/igdzEjvnPKJGHbi15UQIw5B
PFVhex2NuefrOMpNgncBESBW2RO88xby0a52BCy5+VUWbioKSxkcnjizYVMFDRYZ
feTeo/cmDF7pO5IX0uvaq8Jd7FVMq2mPjEiaeELVGKYQIqdi1f2Wt4YIHNDrOd8F
5ffTO7WL3H5QhmU7St+VCRbvCO1Cn6nHu1QJ+pyKS+r2Tc9k1uIa8tELhN3hAkQ5
Zxsjuw1Ya2aMGjpNrLCcN3pZmGf590lox7KdQkGIFsd3/8qeG8GLaz7bKK/bYmJA
VJ3NoVyrZXBhDSZxTyJT/2WbTQ92O2FKPuHaQ8p+grF8+bO0eJpQKaYBv3npVFUB
A+FnVEA4JeHWQBLf2evKUqvBbZ8//+NZd1eTnb0e+8sKoQabfUR1girx9B1t/bSC
I3Nwpby/XqV3NFrDuEBQWbVJGi9JyiPkQixV36dISlYGHX7uq8mNz5t23tecDpSu
b4RvDtPNpVnCLe9GPYBdKy1J72USctR77qOu+zoKjYAd/7FHKJMBbdIs1XbDKeOe
qVppiDBJsuV4MTPA+9YecD25mGOAt7fQ2F30DC7N5yX4wYg8n9qSGTkz17PUyRJJ
P/zhfQaw88Vj4XjAVBrTyD8QV22DDEchxoPSOjrF8VNpioqQNpu03JnK4eXJMRb1
8tC/RzvyGsnv6Bq1JhFt
=vbO7
-----END PGP SIGNATURE-----

--pN9MePJoZbRKbUk1--

--===============3345634882187894181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3345634882187894181==--
