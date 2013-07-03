From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 01/10] ASoC: imx-pcm-dma: DT support
Date: Wed, 3 Jul 2013 17:02:18 +0100
Message-ID: <20130703160218.GO27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5049908821415017243=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371734429-6081-2-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


--===============5049908821415017243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bk1rFQtr5T/2h+/m"
Content-Disposition: inline


--bk1rFQtr5T/2h+/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2013 at 03:20:20PM +0200, Markus Pargmann wrote:
> This patch removes the NO_DT flag. The pdev pointer may have a proper
> of_node with the dmas property, so we can use it to request DMA
> channels.

Applied, thanks.

--bk1rFQtr5T/2h+/m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1EsGAAoJELSic+t+oim9gQcQAI62FNXD2MxYK0gDI10wETU7
GAduvJehRbWv9dfNJHgTjOD6JKDk/G/MH8oCcWaue8l6ZdtGp39/xd1S5ld+tHzG
6LkvfgpUZvLRxuggdHyKg1euSNFghAzeZbH0eUUQ7aF2tyYCnFghA5Mv32JRl4wP
8Bkb28xgQLtyqewxvu2+jQ/iWKxG75I+tUscQYOXRDfooECKnuYHaKe4UrhvUIsf
ouYUbc6JGVxHCDxX+FuoM+KO2URy8Tp2+f/NUrQYWvZpHKjqVfTAz1HiZftZIUBa
PhXH02GRQsMOPzlXpzK/pKVAd3ubWyzD4ebUp+wyRcRcWkFrmDJdkA55y08o2i/M
Ms6x+27QOswQXhPfF6giPCXSJvJKBYd9HS6u0iyapa+s64SHUP5FlYV9dDu0XQ0u
1M1COe8c9dNViIeHZ0aUDpE+6j7rx8NxoJc+51Fv16PLiD9iWLVuSFWLxL50l+D4
fZ2lqdOsEnXmbeK9MmuLw4RJo6T8X1qTWHzPBYghaHicueADgzGFnxP+CGDK1k4H
K4+OwaoiJeyz9CCHLP1ql0gV4jLKW3YB2habivq+eU0yb4T3nT8lsYlNtcLd9FgR
rCPOsYjUgyzvUyR3rL+SScas4gBoLSPsUMbpI8MuujVKdJKFwc88O3iOzIA2+1cg
uZDjuloXF0NtQkMU+JCh
=jGU6
-----END PGP SIGNATURE-----

--bk1rFQtr5T/2h+/m--

--===============5049908821415017243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5049908821415017243==--
