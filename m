From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Let the codec acquire
	its clock
Date: Mon, 10 Jun 2013 10:27:15 +0100
Message-ID: <20130610092715.GH31367@sirena.org.uk>
References: <1370826467-30399-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6183509354770680928=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id F16372608ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 11:27:19 +0200 (CEST)
In-Reply-To: <1370826467-30399-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, lars@metafoo.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6183509354770680928==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GjBY/PO0t/9sFN0J"
Content-Disposition: inline


--GjBY/PO0t/9sFN0J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 09, 2013 at 10:07:46PM -0300, Fabio Estevam wrote:

> -	if (IS_ERR(data->codec_clk)) {
> -		/* assuming clock enabled by default */
> -		data->codec_clk = NULL;
> -		ret = of_property_read_u32(codec_np, "clock-frequency",
> -					&data->clk_frequency);
> -		if (ret) {
> -			dev_err(&codec_dev->dev,
> -				"clock-frequency missing or invalid\n");
> -			goto fail;
> -		}

Applied but this means that the binding document needs to be updated to
remove the clock-frequency property.

--GjBY/PO0t/9sFN0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtZvwAAoJELSic+t+oim90coP/i2FnzTT81SwhJpMNLNuHSUu
UTBREs2fP2pu4172oO1WDzKn8e9m0bTx+UXy8E+QkfibWcpc/gM8PGDgwY9G4QbC
42lNEewadyA/wVQ2+bv2ZQX52dXKQ5agNyEx6BYwO2iLmzSMaTMAJktf/DpqhPU6
ArC5H0ixq6kpVqN9VoedALsOqcTR6Yr4qkvSaq9cnMC/ZDzhy2Zc9gJgPzgO5LTd
9DKrn5wDqW+tXIbDyuuwsRgRaQpnun/lbGUvP4mHDrZlcurF9nfUdOn/SDZCsMec
Dg72vxY6askK0brrQNr+UNeXM4wrdi2qhvPBXcuQpJBdg28c7gq88MiH59PMaFHP
FfPh5o2ikP2pwjqGRaBvuNFpy2y15SUDwoCIbWOhy7NkRqr5ekGcSupaO+65S34m
v8vC/ROsBognYkuB/0z5SQN26rVQmbofZRehXgz+UyFylDuY1qX9nezIhpg57jme
U1lR/ZWWXlT+eGpbjqQBrcusWJO4agmdjv/hWklHKE9voyN1HXiFAGZ4g2gd9qAA
US2kK5nznjvlnTNN860ul6A+rSyIUJpFx3zFamL8cMQMtWc3gM6QL0QeMjHksjVA
WsliQ+p9GiRh6Bfhf4Y2fyrK6GPADCFnFV5OnhQUycH7EfeYDHjWIxh9u3V2cEyO
KWgBjGGNDQoN2VFcrYG/
=8xzX
-----END PGP SIGNATURE-----

--GjBY/PO0t/9sFN0J--

--===============6183509354770680928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6183509354770680928==--
