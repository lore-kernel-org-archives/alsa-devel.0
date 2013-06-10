From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5] ASoC: fsl: add imx-wm8962 machine driver
Date: Mon, 10 Jun 2013 18:08:38 +0100
Message-ID: <20130610170838.GP1403@sirena.org.uk>
References: <1370607974-6895-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7771442502429973862=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370607974-6895-1-git-send-email-b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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


--===============7771442502429973862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aC33ObtQAkNdOZ6b"
Content-Disposition: inline


--aC33ObtQAkNdOZ6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2013 at 08:26:14PM +0800, Nicolin Chen wrote:

> +
> +struct imx_priv {
> +	int hp_gpio;
> +	int hp_active_low;
> +	int hp_status;
> +	int amic_gpio;
> +	int amic_active_low;
> +	int amic_status;

These are just recorded in the struct but never actually seem to be
used?

> +	struct platform_device *pdev;
> +	struct snd_pcm_substream *first_stream;
> +	struct snd_pcm_substream *second_stream;

These aren't used any more.

--aC33ObtQAkNdOZ6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtggTAAoJELSic+t+oim9Bt4P/0covOO1GK9wFGRpgDOlFGSW
NbbodlteBWgPu5Pdy7tjbCoS53lSc53KonsqW0CFrgC4vGeGkfgnwdjIbN/TK+6i
g+62sZYF7Dplmt6FMO1du9xsQdSk3QUb8Zoi90btdI3AVUEU8ar/10tm4S0lPzIl
foUJghRisH9WhQlbL4tZtF8Xub5FV9M92F7Vox+sarPifKhFgRJFPIJyz4xCn4SI
xKQhXEzVLUBOKmO+QC8z9EdXyB4PB5dT2V9CFfu7mY2ji37ddGiRapneMW84/grp
T+wSju/1+3hhT0kDdOEP9UfUey6xteDYDSHvm7GgnouHGl0KQnM9H91t9iLAuFrM
IetFM8ibQbaIqyK0fsWNLsp74vYE9dlTlTy8lKKR71flvRd/Yk2+F4lifsO+A7ZN
877/AZfcyGBup3GUTrNj9GiBKIy7iXqirF5i2b2ZyihuxNrk2N0i1LzXIcUv5MlS
DkDsgOMyR84gjlu+fkZFgJeuCznJonskBhytvxD6YtEOoloV9xRDjUpiVYt8F3pc
hYyZqfAc9qaBtTmJzBnrUkvxN0PzoqAE5UXFZ3BM1cswxZmlgXS2jHEIBIbmlAjn
BHFo/SoXvqmnLOaAROqceYoRsO4H2xE0XlwAy/FGVpZQXRZcmiPVOuVKc5j0JuVG
yZ+LLN4uMGXNP2n1ByMx
=49wv
-----END PGP SIGNATURE-----

--aC33ObtQAkNdOZ6b--

--===============7771442502429973862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7771442502429973862==--
