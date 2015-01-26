From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Fix capture volume setting
	issue
Date: Mon, 26 Jan 2015 19:16:31 +0000
Message-ID: <20150126191631.GF21293@sirena.org.uk>
References: <1421995869-30435-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0628938246691040175=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C269A260473
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 20:16:35 +0100 (CET)
In-Reply-To: <1421995869-30435-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0628938246691040175==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n5G3y24fV3/VEqbx"
Content-Disposition: inline


--n5G3y24fV3/VEqbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2015 at 02:51:09PM +0800, Bard Liao wrote:
> The purpose of rt286_adc_event is to mute/numnte the ADC mixer.
> However, it will also set the capture volume to default value.
> As a result, "ADC0 Capture Volume" is not working if it is set
> before capture start. This patch remove rt286_adc_event and add
> "ADC0 Capture Switch" to mute/unmute ADC mixer.

Applied, thanks.

--n5G3y24fV3/VEqbx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUxpKOAAoJECTWi3JdVIfQe4gH/jqpXbErHeqO81LtRQ0xMATw
rCnbgezANvVLmukiJ3iw6MrgSJIMItiHQTjFVyhNMucxZS6GW5tsD+1lebreM2xb
DSnFK1nILuc/taDA1r9LQQWPhBaRE18iH3ZNMEOl7d0lgVZAQwouqH3JQ96Fc/5m
vqLncXyA0LjkeI2dkWpOnEsEAyRs1U8zxhcyobDEOKZS2593Egi13rDaLpO22Y0R
VI/WspJDa7PHDcoYF2ihLOB4Wzm3WEV0Npc8os8SrGiw1yEb1mA4Enmip10N4xOV
lNV6KEcfbPZ/vXPivJ2HaOWi8iIf5t0gEsACQM0icZAEsnOIP1w1DjIUGlVbSlU=
=zvg2
-----END PGP SIGNATURE-----

--n5G3y24fV3/VEqbx--

--===============0628938246691040175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0628938246691040175==--
