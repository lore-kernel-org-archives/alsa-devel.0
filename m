From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8994: codec driver should manage
 its own MCLK
Date: Sat, 5 Mar 2016 12:50:28 +0900
Message-ID: <20160305035028.GW18327@sirena.org.uk>
References: <bc33ec0dcfc610657d60d4e1f381545a81147e3e.1456986779.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6913393538974948138=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B81C2669D6
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:41:58 +0100 (CET)
In-Reply-To: <bc33ec0dcfc610657d60d4e1f381545a81147e3e.1456986779.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6913393538974948138==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nlqQHWAaxVORflTt"
Content-Disposition: inline


--nlqQHWAaxVORflTt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 03, 2016 at 02:45:35PM +0800, Zidan Wang wrote:

> +		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
>  			active_reference(codec);
> +
> +			for (i = 0; i < WM8994_NUM_MCLK; i++)
> +				if (!IS_ERR(pdata->mclk[i]))
> +					clk_prepare_enable(pdata->mclk[i]);
> +		}
>  		break;

This is unconditionally enabling both mclks but the device has a wide
range of options with what it can do with clocks, it doesn't need to use
both.

--nlqQHWAaxVORflTt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW2leDAAoJECTWi3JdVIfQoBMH/iYvOSy/FOqyvFJ8ldMUE9Do
SvlSVY0vJBmnITJGtMVLVSAP5wftSb6NFg34IAo6VpyrOqHnyp8OFdUb+xJx0OUG
2D8qcT/iTPWb9xfg1rqaO5NNYTMMjYYGTSXAd6BfdrzOoiew6FyPb3LqK0DShRUf
NYw8YhtywVxX7kahAorSR3Sz+zroaqK5hyh0EWZReQXbH7/RHkZzsrDrmcOixOEq
+9MEeJ2J7addqcYfRNeJ58SoGIdwTo0Z63RxL1lEYEo0F0a4SXRN8Ain2mZNLtL9
S+tqsjlBvGY6PvS/E2OYKSTlHQ97tvjyF7sllPtnNJ9FGxjAIqKFWkcyOgHUvJ0=
=CYuK
-----END PGP SIGNATURE-----

--nlqQHWAaxVORflTt--

--===============6913393538974948138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6913393538974948138==--
