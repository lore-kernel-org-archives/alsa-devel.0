From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Implement TDM support for
	Arizona devices
Date: Tue, 3 Jun 2014 23:06:07 +0100
Message-ID: <20140603220607.GD2520@sirena.org.uk>
References: <1401822370-5324-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8101939355304068214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9905C261AB6
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 00:06:31 +0200 (CEST)
In-Reply-To: <1401822370-5324-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8101939355304068214==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 08:06:10PM +0100, Charles Keepax wrote:

> +	if (tdm_width && wl != tdm_width)
> +		arizona_aif_warn(dai, "Word length not equal to TDM width\n");
> +

Is it a problem to have say 16 bit words in a 32 bit TDM slot?  One of
the reasons this stuff sometimes gets used is to help out the other
connected device if it's having trouble configuring the "natural" clock
rates.  Ignoring LSBs shouldn't be an issue.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTjkbLAAoJELSic+t+oim92foP+KsRCHJ8VGcw6yPF4eR9qiEl
t+f04J/x3JPLvJ8EJD+HJT/fDghW3iEHrvOxTbek6t78f8m7NdNY8zFHxoVrUlPm
ZfSJLlOhIFMr0/zIR/rZvLf5yHw1Ml72cL2LLDHiq/2p1GpVCdzfmpVookErXGSD
slyB4WSePj/n1He9nZUt5xONbAG+XOeWfQ6BMgqtnlN4xFUi3Sw+Byw3P7VX9Hpn
qK1hTV/M2xzZoImeNnFV2t5qMtrDPvii1tx6FDa8mfEyP3zRdQLAupDpiX5C+df/
NKBD/KDiMbmCDlvqBl4ojbtDhm8BovAImC9TQbJjec2auG+Dc17uH9Pu5lnPcNgD
xHpXS5WduYGjBvig3wSeEGacThdSjb/eEHPkXGFz9bCterO4xRn6xaLTDJW6Bq1O
Rmp++T4ZBn3m1mCs4WxHsLvbzxSjOlCq+9xbbj+yHt1p1Fig2k/H1QXwljxhI69Q
N+BcThvFwnk8KEoq2bMqJ2ehcGD8VYccq3KMM2J/RElo6mOK3g5L0w0/5A07yXJR
4W2FoprS0CUGURAIbcULAhpCffpASeV+OnDlJhCBHI3nPXOFl5KoTvXfkDybDv+3
vh4lwQGSeRJlNBDSrs530Ajomx9jkDaoHH5wJgHslZTikBRvz+G9aipZjR5COcPf
561AVz0yogPQKUP12/E=
=faFT
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--

--===============8101939355304068214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8101939355304068214==--
