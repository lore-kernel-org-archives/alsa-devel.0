From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add machine driver for
 ML7213 Carrier Board
Date: Fri, 2 Mar 2012 13:05:09 +0000
Message-ID: <20120302130509.GF3230@opensource.wolfsonmicro.com>
References: <1329976011-2251-1-git-send-email-tomoya.rohm@gmail.com>
	<1329976011-2251-3-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9005702500415833997=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ECB9024409
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 14:05:12 +0100 (CET)
In-Reply-To: <1329976011-2251-3-git-send-email-tomoya.rohm@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org


--===============9005702500415833997==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2012 at 02:46:51PM +0900, Tomoya MORINAGA wrote:

>  	  This option enables support for the AC Link Controllers in ML7213 IOH SoC.
> +config SND_SOC_ML7213_MACHINE
> +	tristate "ML7213 IOH ASoC machine driver"
> +	select SND_SOC_ML7213_PLATFORM
> +	help
> +	  This is ASoC machine driver for ML7213 IOH

This needs to depend on the CODEC as well, how have you tested?

You're also missing a blank line between this and the previous stanza.

> +	default:
> +		pr_err("%s: Failed not support format\n", __func__);
> +		return -EINVAL;
> +		break;

return followed by break isn't entirely sensible.

> +static struct platform_device *ioh_snd_device;
> +
> +
> +static int __init ioh_i2s_init(void)
> +{
> +	int ret;
> +	ioh_snd_device = platform_device_alloc("soc-audio", -1);
> +	if (!ioh_snd_device)
> +		return -ENOMEM;

Use snd_soc_register_card() and a real device.

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPUMV8AAoJEBus8iNuMP3dxr0P/2ki+DkK5jq8Bc3havD9b4X0
nbx4Gdv/y+G9hXM2Coe3y7SYwW0QUNFwbYvcSOJ7EPZQ5H5N4da/BC1EuMcmBoEZ
zrKVwpqSiZ157m0Q/pvoqXQh8EnSlepjoI91rwRDKpIKPGOSpWZQW2D+AZ7GjCxr
QLZnxxpvkFUot5OItPh+2S5stU+5QWZxXPRYSeg8EF4b+3LqnS7uLEtdCiiFSJY1
SPqGz6TrEQ/oi0F6zvb0737moQTNkP95Zo4Xz54bmZQ30pBBxUE3dfmucyCUl8Cd
estVPnSswPiSxubvSxYjLukCyTGK8zQVkGwknBcTKD0Zz9WRQPWQpfmGlLg41cfK
Uny0n2A76xxFpR5aspDHpdJ7/OUz8ACCFa7KjGtfZ3P2S+Lh/IqMK2T+quwo2Of/
yxUDdA592LZqhUSL67ow9YKI/tt/k2jGOZkVXb+xjmo8rndz8NsIkiA9z8cWoQTm
KezAC7685iElsMhevNYgSgAHSeKR9g7A0RLMpLj0v17x+x4kQgeQagSZ+Efkl7vf
AQnseFKSv4xHEJ88ZPgWeZ7vae1Ohfsf6iPn8dYU/5e3/jURptTlMJzF4SXsOl3j
FEG4NByyeoYpUR4kFGDPawhs3Wygb4YlbY0bOOxtcFPn3ol28WwccufoiTviUN7D
2kvGVQXC4AAu8GGRs0d+
=+zo8
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--

--===============9005702500415833997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9005702500415833997==--
