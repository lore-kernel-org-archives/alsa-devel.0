From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4] ASoC: fsl: add imx-wm8962 machine driver
Date: Fri, 7 Jun 2013 11:25:21 +0100
Message-ID: <20130607102521.GP31367@sirena.org.uk>
References: <1370600053-14808-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2627312918996094243=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370600053-14808-1-git-send-email-b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
To: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============2627312918996094243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oGyU6H+2dQ5x0Lt2"
Content-Disposition: inline


--oGyU6H+2dQ5x0Lt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2013 at 06:14:13PM +0800, Nicolin Chen wrote:

> +Optional properties:
> +- hp-det-gpios : The gpio pin to detect plug in/out event that happens to
> +  Headphone jack.
> +
> +- mic-det-gpios: The gpio pin to detect plug in/out event that happens to
> +  Micphone jack.

So this is for physically distinct headphone and microphone jacks rather
than a headset?

--oGyU6H+2dQ5x0Lt2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsbUOAAoJELSic+t+oim9qbIP/iyfMdm115GJ3LbkJOCf0GNf
d4n8o9UpYHUo0BAZJxZC7cX5hXMGSbrnDvACDBUAaFX0JX8Mf9EBV1UQpZVqEN3w
dkBgyFwuAt4ZrhnWfT7UHWsJaqGHaTmUxZKUh5XJpX8jkC+1jfNJCSpmcPoh5hyr
eyD5vBQS/pT4YV2SgCiQhm95N/eH/ONOVb8i7U7BskRyA3PIli0jrN7KgbykwmsN
7Pa6JWNJvk1VKojeZvV/13qO+NItVlsXo5BW8uCBRE/BulXWb6kE1zCTedMjVxhm
WXH8XyFB5duTdzw4HbUBt9s61Z/UfYXhAxjakPEWuvwcAPxbgKE0j6mxAckNOGex
z8IxtnNDHYNlEeO7cC4TKGzmukIolUJayCt/eu1pl8k0JHyGR0q0/ISbMybPsTZ9
IWZX1KvnFj959IRHQcYjpP2rggjUjCj5tdttDX2gXbVBWOL1J6TFVqU53Qm3dh0y
ONcFRULIHWuGb9eVcDscmpsh60WnOhvVg8R0wPSq8lj0KftQRgNJgFtiX2TNPuKw
y1yP4g268hYmnA0RRBwknMk3l51owN+e8xQ6LJdEmWaNs7Hmk3ke9h838qt8eNdf
HIOAWUyIexrw7s4Kd+EwYEv02n+4CF64Ulud4zukta+ArX2NEk9lWe0wA0wLzB3M
yXG5bBQeeE38KGk+xkyq
=ZsYu
-----END PGP SIGNATURE-----

--oGyU6H+2dQ5x0Lt2--

--===============2627312918996094243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2627312918996094243==--
