From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 04/10] ASoC: fsl-ssi: Add support for imx-pcm-fiq
Date: Wed, 3 Jul 2013 17:06:37 +0100
Message-ID: <20130703160637.GQ27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-5-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5476273638503086282=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371734429-6081-5-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============5476273638503086282==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0BR6GWi1HhdMNcLr"
Content-Disposition: inline


--0BR6GWi1HhdMNcLr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2013 at 03:20:23PM +0200, Markus Pargmann wrote:

> +	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
> +

This binding should be documented.  I'm not sure it really needs to be
a binding, though - is it not possible for the driver to just figure out
that DMA won't work automatically (for example by looking at the CODEC
in use)?  I'm not sure this is a good name either, it should be saying
why the FIQ is needed rather than saying that we should use the FIQ.

--0BR6GWi1HhdMNcLr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1EwKAAoJELSic+t+oim9WYsP/3ne67UUTnznuFgP47O3eQpt
LrOhgs1C7wyvymC4X4SB8PiC5yvFSxaWkYHg5J0bc+tCD9F0bw7CUbGJuYmxKvyz
/zN8XPueLx0J0dtVuReChLkGbTu8kEK71+R3WDlClyonoYqg4rsxvXhQvpNkz017
JXZaL1AOLcYcisn0XBCf4y9i6NhfkRz9jfSs0BSI5jkYkVr+t8eBdbkyFlLOEXBi
6zIy9U81avrX8Q9IL/hih8uDei3HMJJnZvDMDdbbIGXJFCBDMMCX7g4y24WruojJ
lQm81PKKV0mMq5JyCqTpZZBnHTzrSGBxdExQx8WLqt+ZzH4LLTvLA7uP9Y1McC7l
R4sAXW2iUktH9ej9X2jksUXInsHp2xNBgEOYfwLj5RVoefeXeCB4XhQOmFe378AK
NSsfjjnCutneKDjubjpaBsx6p7eQNf/xSwglkEirB4Lrc+pOENKtCYIO59CPDlfW
Z2olez5QqbMI+N6yJjEeXtcQMZAYGDuWhhPSs5J6YuI2hWv+Hy718xppDg2/oGzU
iqQdc3Az0KMjfs6YVMyknRLA6hgcHZfIP7GfFzHCu6Gnw+/BQ+tHmT5P02l0Gf2J
tEBbmQOZedH+bgYIBU2iZ9vQu3iPaDHaPspHxdbm1PDpWR8+tv5LA99wL2v+kASY
QKUbiqlYgAFqOQyoaQHt
=hrLH
-----END PGP SIGNATURE-----

--0BR6GWi1HhdMNcLr--

--===============5476273638503086282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5476273638503086282==--
