From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] ASoC: fsl: add imx-wm8962 machine driver
Date: Thu, 6 Jun 2013 14:33:42 +0100
Message-ID: <20130606133342.GB31367@sirena.org.uk>
References: <1370420501-8410-1-git-send-email-b42378@freescale.com>
 <20130605115544.GX31367@sirena.org.uk>
 <20130606124952.GA19153@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4677791175056170414=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130606124952.GA19153@MrMyself>
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
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============4677791175056170414==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Rpt4tnX3EsKWamm"
Content-Disposition: inline


--6Rpt4tnX3EsKWamm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 08:49:53PM +0800, Nicolin Chen wrote:
> On Wed, Jun 05, 2013 at 12:55:44PM +0100, Mark Brown wrote:

> > Since it's easy to define a fixed rate clock (there's a generic driver
> > for that) I'd just require the user to provide a clock API clock and fix
> > the rate using that.  This is going to be less error prone and makes the
> > code simpler.

> I tried to use fixed rate clock as below:

> 	data->codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> 	if (IS_ERR(data->codec_clk)) {
> 		of_fixed_clk_setup(codec_np);
> 		data->codec_clk = clk_get(NULL, codec_np->name);

No, this is silly.  Have the board define the clock in the DT.

--6Rpt4tnX3EsKWamm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsI+zAAoJELSic+t+oim96BgP/RHI0Mat3JfVw5fWqZz4Suph
06euQ4/jRRpYcmU0To473qWxfJJpN9aXJC6zL5R41OWYVsCgvVO1AkCGrtcSodeb
korRbbT8EuLJpu0PngRxJwRzl55pTZ89OhVtEsUWixKHddjrDzVELZl4JQ3caX1w
zVD3f/noi3Ecl1k7YI2x7JmXecHqdVo0gZZdYPn67pLSsukK4qnIAfC7oGPkmiat
2QWseRKeoqNxIBQBD+Ozgj5aIyiC7XgWGPBYLfXb3jTRqUhDCbz9UzzMHoZszHy8
fZuYuCCZctXNBrC58ko+u7DcOLSHb3anPBgz1QTp5BVQq9NJ2E9mGpet4+BElz/L
rVi+kewFCtHhqWbVTppV2p0ldkgho2mvGGlGQXOQGQfCaaEvM3DKhUpGGwlZHTmM
iUWv4mtUy4kxl0fBkKWZK7fGlvC5n8hOXuoGU8dQ0MS6kW1EyllzGxTPn9H9zqOy
Bs3bLy3AkwbYkTBZt9VmfAFXAiksD3lmBkvl6NOZsyfGoU6TtHXkhkuHpmeUdOPS
G4Cb45s29kFeMVxmWER30oba6VfE4T+bc3hR3MsqXxegsSW6VoAlgSuq7fRzs45J
iLnksf9n9/DbSGuKNNcSAdN/HxcR/AV4wSujoWzet6bP9G71fBdPqEVftAhkYoL7
QUlwaZxpKQjp027AdEPC
=9plb
-----END PGP SIGNATURE-----

--6Rpt4tnX3EsKWamm--

--===============4677791175056170414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4677791175056170414==--
