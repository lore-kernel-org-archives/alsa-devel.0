From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5677: Support DSP function for
	VAD application
Date: Tue, 14 Oct 2014 14:28:06 +0200
Message-ID: <20141014122806.GT27755@sirena.org.uk>
References: <1412584251-29167-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2750027961804426051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 800C726055E
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 14:28:27 +0200 (CEST)
In-Reply-To: <1412584251-29167-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2750027961804426051==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Djp5PRGHu2Cmyd8M"
Content-Disposition: inline


--Djp5PRGHu2Cmyd8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 06, 2014 at 04:30:51PM +0800, Oder Chiou wrote:
> The ALC5677 has a programmable DSP, and there is a SPI that is dadicated for DSP
> firmware loading. Therefore, the patch includes a SPI driver for writing the DSP
> firmware. The VAD(Voice Activaty Detection) has be implemented and use the DSP to
> recognize the key phase.

Applied, thanks.  One small thing which I fixed up:

> +static struct spi_driver rt5677_spi_driver = {
> +	.driver = {
> +			.name = "rt5677_spidev",
> +			.bus = &spi_bus_type,
> +			.owner = THIS_MODULE,
> +	},
> +	.probe = rt5677_spi_probe,
> +};
> +module_spi_driver(rt5677_spi_driver);

It is better form to remove the _spidev from the name.  I fixed this,
the indentation and the redundant .bus initialization.

We really should do something better to tie the two devices together
though - but I'm not quite seeing the elegant thing.  I'm wondering if
the I2C driver should defer probe until the SPI driver is there.

--Djp5PRGHu2Cmyd8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPRbVAAoJECTWi3JdVIfQCUcH/Rx5yHoAVHMeRay2oZMkxxzs
EvLh0dOsUkRf4TrOJupoQkyZPh1fqUAILAcumA2G//osEShlSIcP1/0AHiGX6ySJ
SZybNUX+S+eDkQApa+Ikw24QoT4hwjoxDE5csofDACNJsaU66+vnZwQfbD3Kurh8
cHdLSnWruc4IO7TL5RBaWo9tPBGJZKuE8ds5zpapBGMi2XPybsP7tti6CZAX1QxF
4u8YBLRQLiV3K6EOsvkIJDsGKK68SeTHSxw58sbkJMjkSyPW8lghGZT3NHQWeDVN
h71TRZbexY4GaaIzCTEI4TGsDQIoo721Mqu+UX5uHadIoEsUxwKBY9gKuDgqXUY=
=FiGm
-----END PGP SIGNATURE-----

--Djp5PRGHu2Cmyd8M--

--===============2750027961804426051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2750027961804426051==--
