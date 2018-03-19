From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: codecs: Add support for
	PCM1789
Date: Mon, 19 Mar 2018 09:23:35 +0800
Message-ID: <20180319012335.GA2186@sirena.org.uk>
References: <20180315161825.5524-2-mylene.josserand@bootlin.com>
 <201803171907.vbmkB7Z8%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4677099683268348733=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 105B3267205
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 02:23:50 +0100 (CET)
In-Reply-To: <201803171907.vbmkB7Z8%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, michael@amarulasolutions.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, kbuild-all@01.org, thomas.petazzoni@bootlin.com, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
List-Id: alsa-devel@alsa-project.org


--===============4677099683268348733==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmZDAlAp7pllCg/D"
Content-Disposition: inline


--rmZDAlAp7pllCg/D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 17, 2018 at 07:19:51PM +0800, kbuild test robot wrote:

> >> sound/soc/codecs/pcm1789.c:265:1-3: ERROR: test of a variable/field address

>  > 265		if (&priv->work)
>    266			flush_work(&priv->work);

This is a legit warning but otherwise this looks good so I'll apply,
please send a followup patch fixing this.

--rmZDAlAp7pllCg/D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqvERcACgkQJNaLcl1U
h9Bz6Af+Obo5cUDzueqjNID4s8PqyHekx1WLIbfKMpBrMnZT9yunB+tKct+xQ2Zf
s9OQ5zNuYVo1SdY4KFKGtqHWQm7UPwLr/aISpEZFov/gRYRVkXibf/LjdhVEx9Du
GNSSnsE6ZYDQ8U5LJB03wofldsHH7HD5ZRJ9+/gAc/uX2qwtF0GTX9RF8q3Z+AQw
r+VtleDfLSr2Ca/83qka4o7IBrbjl3nWgyczY4wRs6I3kUlRfnp0EK6IIHxHnmyQ
Pdwcxi14w9rRHmw3j0IGgiR/9BLUTYlyh+ik9DKm89UslcEYW3LX8jrzxird10i0
csg2pQT3CBA9Eyeq8XXkaGkuva/3dA==
=kJ15
-----END PGP SIGNATURE-----

--rmZDAlAp7pllCg/D--

--===============4677099683268348733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4677099683268348733==--
