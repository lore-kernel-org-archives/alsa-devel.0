From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 08/10] ASoC: Add phycore-ac97-dt driver
Date: Mon, 8 Jul 2013 09:06:22 +0100
Message-ID: <20130708080622.GN27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
 <20130703161727.GS27646@sirena.org.uk>
 <20130707071949.GH16871@s25.your-server.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6451175648783506912=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130707071949.GH16871-uTtddPNT4wdcDCsr1GFxkoQuADTiUCJX@public.gmane.org>
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


--===============6451175648783506912==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRTrqq5C0A9KK7Rj"
Content-Disposition: inline


--TRTrqq5C0A9KK7Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 07, 2013 at 09:19:49AM +0200, Markus Pargmann wrote:
> On Wed, Jul 03, 2013 at 05:17:27PM +0100, Mark Brown wrote:

> > > +extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
> > > +extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
> > > +#else
> > > +static void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
> > > +static void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }

> > These functions have no reason to be anywhere except in the driver and
> > really you should just be specifying which pins to use there - ideally
> > via pinctrl but I don't think i.MX has adopted that yet.

> There are no pinctrl driver for imx27(pca100) or imx35(pcm043). The
> iomux/pad configure functions are defined inside mach-imx/ including
> their headers. Both reset functions have to configure iomux/pad before
> and after using gpio. So I think it's not possible to make the reset
> based on the gpio pins without the necessary iomux/pad configuration.

That all sounds fixable - either make pinctrl available or make the
headers usefully visible.  You can see the arch headers in the build
of the entire kernel...

--TRTrqq5C0A9KK7Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2nL7AAoJELSic+t+oim94RQP/3ld7L1+PHAgDmaPM5A0mJXx
cK0c9p9VqKpKlLC+lzYZhPj3Eav9NWGdbu9Hh4lzgd0MW3bM/6sJ5f6HKQC44yk8
2VU1+pUCRse7rB5m2coUfEsTkLF35fnh0bMYpG5O3XEnAoYGWfkCmUVXUQlqDKK+
cfdQ/x++XYtA4cVduqq8TyfnzLggjKhLh6kMhRm+DdxQqCef9gs1X8kTyLBpzZS3
DVnJpb6oWgFh533FEJ5oBcJlJXLKLvFfaiLtsSjM9FIMBANrTEK1bdC/aQb78m8N
a0XNrEGU9rYD1Mud2tx5MQX6nu0lHC5phIe3ZS9NDb0+9Z4QDKcR+WK3uLXF7KoX
QPnCQvaa+s8s58RIuqi402KGvwtVqgiNWluip0ka6vrADtPYd+obhzbdoFdm45ba
p0OGhuljGB8yHKN7u4JWXVoCxNILV+OIxWLvgtBG+6L/p3JWWdXR9YYl8F37tjZE
dnWwCQq74PcLOks3DCaqb1eaKgl9ldAWrXvX0I6BA6DxQ2JJBLPceJa0ZU+XMne6
Y8eSGbXAne1oUFhVe6RFdfLe/N6vWBqC7dw1slb25d2+oOdCqnTQBtoia0Lcz+bN
KnUq+y8QuKGw3nf/TExh/rhHHUhbLmTGpO0KS80GKCIRCehYC5vDltLs4Vo80i83
MwNofEqkTB9aELdnrWV+
=7F/I
-----END PGP SIGNATURE-----

--TRTrqq5C0A9KK7Rj--

--===============6451175648783506912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6451175648783506912==--
