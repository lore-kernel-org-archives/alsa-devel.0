From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v7] sound/soc/lapis: add machine driver for
 ML7213 Carrier Board
Date: Mon, 19 Mar 2012 19:21:01 +0000
Message-ID: <20120319192101.GG12384@opensource.wolfsonmicro.com>
References: <CANKRQni1k4hv40j0hTzVMdS9aFccM7xRrHis0-cFuBvSZe+9CA@mail.gmail.com>
	<1332158525-14968-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7227553120722746791=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC6162414F
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 20:21:04 +0100 (CET)
In-Reply-To: <1332158525-14968-1-git-send-email-tomoya.rohm@gmail.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7227553120722746791==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 09:02:05PM +0900, Tomoya MORINAGA wrote:

> +static int ml7213_hw_params(struct snd_pcm_substream *substream,
> +			    struct snd_pcm_hw_params *hw_params)
> +{

> +	default:
> +		pr_err("%s: Failed not support format\n", __func__);
> +		return -EINVAL;
> +		break;

No need for the break.

> +	snd_soc_dapm_enable_pin(dapm, "Speaker");
> +	snd_soc_dapm_enable_pin(dapm, "AnalogMIC");
> +	snd_soc_dapm_enable_pin(dapm, "MICBIAS");

Why are you doing thiS?  You never disable these things so if this were
needed you may as well do it on init, but since the default state is
enabled anyway this shouldn't be doing anytihng.

> +static int __init lapis_ml7213_ml26124_init(void)
> +{
> +	return platform_driver_register(&snd_ml7213crb_driver);
> +}
> +module_init(lapis_ml7213_ml26124_init);

module_platform_driver().

> +MODULE_ALIAS("platform: lapis-ml7213ioh-CRB");

No space after the colon.

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZ4b5AAoJEBus8iNuMP3d9TAP/3tTjXTNH3mm2E+4SE/KKIKd
A8QZJ0BzlW/uXFbxzgaYyn45dOsS+pY6T6lUFrfdZSXjJDzsC9h39eBCoMKSK4XS
Jrp5xf73cbJYOkQAm47nSC4K0pIoaNZwrmXfdKGtjzb+024MOPniQBAqF3z9LZyN
XhXWSu9zYAx9sNdMg0FGmPAbP1VVeVoLbxJ9BD9UXYYyAzKEsJhyO/M3opcp4iyw
5YOGfbJWK5O52TAPLBnVGSKQwfhF+mhawebYkO1jrGXYLI/mTF0UepI6hzwqvW5g
1tDUP2b6Q6S1YLVxMpxrmB6NTq4mrHjOkHLUHO6+BBs7/fqrITQhtO9O1vEWlzgE
XwhTXFQwugkbRBKjN9souV6s/zxE+3JbDNrMpZDGmZs22+lehY8ganmc2QjzijuI
PPcDYYM72bOYyKDMG3uB/UgApDZ08UBS1KcWh4xV0tHqp34LmTojfwj7ZnVofGmk
gZHrwcJF1j5/0coXVc8zF2VPs8lbTNt/nb7WqakzOgb+VhMPzmulcgv8lZJy6Mn7
GSnh60Vbl77ge/jcYSdDmnofidNLbvo107Zn/24W9VpzZdjKTazE5aI3kJBaB04j
ZclqPeEAam0RZFoluAybyDtIewxXb6EBfKIRmgaYNCdQQid7BmLNsTspv8EEQDOB
p5LHth+5/iJiu6WFVp0O
=APYd
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--

--===============7227553120722746791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7227553120722746791==--
