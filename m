From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 02/10] ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
Date: Wed, 3 Jul 2013 17:02:31 +0100
Message-ID: <20130703160231.GP27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7640909895019689373=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371734429-6081-3-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


--===============7640909895019689373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xncXys66qXuJqdVV"
Content-Disposition: inline


--xncXys66qXuJqdVV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2013 at 03:20:21PM +0200, Markus Pargmann wrote:
> Cleaner parameter passing for imx-pcm-fiq. Create a seperated fiq-params
> struct to pass all arguments.

Applied, thanks.

--xncXys66qXuJqdVV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1EsTAAoJELSic+t+oim9kfQP/2HBvXTcMimz6CuDx2GGfQQI
BnUcNlWe6VFyMaM6S4MyKWYbPDXiRnBS/i20x5S09xbJ/M7Td079pAt76xpSPVCf
+SW/1dnu/jbVl/8oZFHA67scj9EAODf41UmKvkNqbnSZF9x5XW9+MDqMy6CWYvsQ
NOTXHg495snE3zjs601Q368XtVJJKn88GzAawKN/fPK3XvCSEj3ba6CQY1JP70vq
1iPyXep8knOyGb2b/EwWVhYlF+RZlWl1tM8ySrA9+GLayvf7uBW3tuoG+DOU+8kU
aMiW9ZafDtBEBpFAclEWktyiwlzQBUDpnM1euZ2F4dspHgD8t0bQSKIbowp+yCY5
ECq9W58HT9UnaZMZIX6UEOr4i7ROdeC0FbojabQSSSg0jBVsqvaUB+tEk3U1omMr
bHTYdbIWlpVJYOOVq8fesJ068wrrwCEkF2QWUQ+Nis4CFpxBliLN7iTTWdT8qBEx
jheYVwNhspJypouK3lEgjQckfqj253EnQr39BXM11j4zZkcFwMunfktKVF+1HWYk
Jcc7CvFh4z2gICnTb+RfIcwF5zrICn6mkLOnErm5W2Y4bJr0CcwAZYPw5H/HJ/EM
vtGBEvA0+1Rr3IfYzvwpOPr9xpC5VSxQHZUp6X3BIuXKu59pRJjwZnBP5DpzlYzf
CMpODqvrEObotZWPztPw
=x1tW
-----END PGP SIGNATURE-----

--xncXys66qXuJqdVV--

--===============7640909895019689373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7640909895019689373==--
