From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 09/10] ASoC: fsl: Move fsl-ssi binding doc to sound/
Date: Wed, 3 Jul 2013 17:18:02 +0100
Message-ID: <20130703161802.GT27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-10-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6866564759508376287=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371734429-6081-10-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


--===============6866564759508376287==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mqRNdCMOlOOulWfi"
Content-Disposition: inline


--mqRNdCMOlOOulWfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2013 at 03:20:28PM +0200, Markus Pargmann wrote:
> fsl-ssi was located in powerpc/fsl/ssi.txt. This is no powerpc specific
> device, so it should be moved to sound/ as it connects to differen audio
> codecs.

Applied, thanks.

--mqRNdCMOlOOulWfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1E63AAoJELSic+t+oim9d3QP/20z7x85Ie5FLcDNn//ON1U+
LgwRkme6APviyuwzavmX15v4p4m1lEZ2cfrODD+fR4yl4L2x0xrCs9XB8e5VbdCj
YZYaHSSgqQGZMaxuFGyOmLaiCeZKNoetvmutZ6+Px9ZyDeaGDtSzyxDzlgdZ38AH
rHi854dIJRdwmKjtbH1dgkhm6uOaiWlRG3ccsaE7T+Qa2UPFTFEymGs/jZd0l2mZ
HSxBA3Tbw9RWoNeOxnwJfR9mULR9+eNbWnRUeQYdA2Y/J8FHynr7Y+xF0H8bHcvk
cAX3kkWg3h0Dxszzjytsh6v2zx6XExnHrG4xYpasVSwjvbYTGjFeephc8+c6HofW
FIvgn+PVN9UyN+PAjtsFd9quA257JG594LBkyzivovqNIPi2uv5hwcX2OF4G2R1X
WyC3UesdcHZoP6Rg3rmmTjGp2t0qaU5xp7LfyEM7TsTQ/vApNGe3LKblBijk0swG
eAVZLyyJtJ+v8sxGQfMDYl61Z8pOF/Yq2fKZflvCNK22rG+YqLK9l7OwEk44Czr5
c+j2Pq3v8DypnpevrZeCsWF+5zOBjkLWJAxXQPLM61H6E+v8od7KdkMCHVBAhXvx
RUghPHn9byFYQpwixpYT0pYqU0luv0FaxErp3Mt5635hCCSOxhDGAwMfZJgW6DNN
B5sXXhNd0xLdwT9cb9bn
=BFL5
-----END PGP SIGNATURE-----

--mqRNdCMOlOOulWfi--

--===============6866564759508376287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6866564759508376287==--
