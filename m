From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 04/10] ASoC: fsl-ssi: Add support for imx-pcm-fiq
Date: Mon, 8 Jul 2013 09:04:37 +0100
Message-ID: <20130708080437.GM27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-5-git-send-email-mpa@pengutronix.de>
 <20130703160637.GQ27646@sirena.org.uk>
 <20130706171323.GG16871@s25.your-server.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4478307312075533739=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130706171323.GG16871-uTtddPNT4wdcDCsr1GFxkoQuADTiUCJX@public.gmane.org>
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


--===============4478307312075533739==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OkGsJQGtcVL5ZVbY"
Content-Disposition: inline


--OkGsJQGtcVL5ZVbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 06, 2013 at 07:13:23PM +0200, Markus Pargmann wrote:
> On Wed, Jul 03, 2013 at 05:06:37PM +0100, Mark Brown wrote:
> > On Thu, Jun 20, 2013 at 03:20:23PM +0200, Markus Pargmann wrote:

> > > +	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");

> > This binding should be documented.  I'm not sure it really needs to be
> > a binding, though - is it not possible for the driver to just figure out
> > that DMA won't work automatically (for example by looking at the CODEC
> > in use)?  I'm not sure this is a good name either, it should be saying
> > why the FIQ is needed rather than saying that we should use the FIQ.

> I think fsl_ssi_startup is the first function in which we know which
> codec is connected to fsl-ssi. There we have access to the pcm runtime,
> which stores the codec used. But that is too late for the ssi setup.

> I could use of_find_compatible_node to search for the wm9712 codec, but
> that would assume that there is only one codec attached to the system.

If the SSI is doing anything it will be connected to a CODEC.  If it's
not connected to a CODEC then it doesn't need to be configured at all so
it doesn't really matter.

> Perhaps "fsl,fiq-filter-codec-stream" is a better name for the binding?

Possibly.

--OkGsJQGtcVL5ZVbY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2nKNAAoJELSic+t+oim9jHMP/jENXwdMQ/xDplGE5yFk1Srf
XayRrNjFx5bqenhwKKUwA6AHYfAyOWaMv3vV7p8oTZeLfOh5aL+ptKn7KDdJd8B9
/dpTuaiDKHjuj5pp2oaAUW+iQiqu+dJnfYBdTEquwfmEPR9GPp9I9c4GJgQnjr+h
sQk4Dq+SAJYy1kNKdm1qLj/rRdkbriyDnNnGfVnng1FGKtH+wHfpbwAzeH18k6B4
qIX6jVnNeHXqXhIBRVZJf5Zu+QVQpIbgCHsGUHdNBLuC6cZeRUOmLMEeJFfd96W1
9eoIF75cNgr5IrGwMin5I7IjOdxqYqeG0WSzYRv21IdQ5Nr6sleSKpkym53cIUp8
GHurx25p01nJ0hQ6KOnaMfKyCrP5ioY+c9Pmf8T7Eb8D8UqX2ssCOEWnegN3CKDh
d41unF0SsYED/wN1ExbSy6cF6sN2phl74LElZFnkh9mqLwpzBZ5MKppnnRpLuMo5
d3m1XKmqw+6wNwle1SZOboP5yYVysG//NPVit7wbOQKyAsn98770xIRdu5RM+6T3
U0AAZ11U8yvN4qNPf/Cejoq+n79370dn5zXhcOfvs9Onh/6/EEHVyGTKjXjQZ1tL
B86OgxmAa8lnRNS+nhC9d19z5tj/1NjH8vp4yulbii1wXpiQsVHRqYFYFqfG9ncF
FlzqkLMVgmfvwvnOn61D
=R3SF
-----END PGP SIGNATURE-----

--OkGsJQGtcVL5ZVbY--

--===============4478307312075533739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4478307312075533739==--
