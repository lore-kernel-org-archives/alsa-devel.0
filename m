From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH 2/2 v2] ASoC: simple-card: add Device Tree support
Date: Tue, 29 Jan 2013 09:45:09 +0800
Message-ID: <20130129014507.GB4748@opensource.wolfsonmicro.com>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
 <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <5106E98A.6070103@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6208355567037230929=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5106E98A.6070103-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============6208355567037230929==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2013 at 02:11:38PM -0700, Stephen Warren wrote:
> On 01/14/2013 07:40 PM, Kuninori Morimoto wrote:

> > +simple-audio,xxx,dai,clock-gating
> > +	"continuous"
> > +	"gated"

> Don't you need to use the common clock bindings to define which clock to
> gate? Or, is the I2S/... node's binding supposed to provide that
> information?

This is for the I2S bus - it's saying if the clocks should only be
present when there is data or not.

To be honest using the common clock API for anything off-SoC still seems
fairly hopeless right now, the architecture maintainers don't care about
it and there's little interest in fixing it in the clock API itself.

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBymXAAoJELSic+t+oim9zTIP/1XlJfM5XLgfSFzKnDlXkPKk
8MSN2fScNBE/SPwHn+DFsp2uqdmtTFNxA8AMpE2b2O889lU2E98DTh2pnK7JwWgb
YVPmaL9QsXdgi44dkrPL3aj8hp2HiG/eW0yYiOIXLnxpKPttnEF15ON/dFu/BifE
WIkhLkoMxrj5Nc/yWu3Fim0s2p24S2dZlOhv94DsATd2zU5n0GGWE4E+Q9PCClB5
zonCgebN6vk2DTnYCwDl7IuqHNlQOkrOP1U3PJhrdLG7fTjlFrDvBHb19iHnbvhd
7YOLGshsccubt3lyBl+ZjRSxWDp8C9sdIiCbEn/SrlxbqxB1e0bMNhIa4/5g4yQd
kZlnls5h+XLGlaGd/DsiCQWUrZP2j+BJ2zdEkqt7U+C7xxvKnVF26Sd+MmK3lllf
jaJB53vcs8Ln3xiRo8PQHAeSEAubBs/2/zVnXjP20zg/0X1otDfrYPTM3M0/PRIw
Tm+J+N8Bn+V3modXla2vNELMoyj8gZ2gn4AdIm1natGexdsv1RJUFY/DQLAQyPlV
8tQh6oXDxZ68Pec6ueYvWT8KJpHD1dx5YymSsxKVz851/9yJI1dnN5P60rTg0iv+
VQDfmq/azdTB69XdUrtIkOdMlRdtcmm3PxyoK0C/58uDGwG8s8yPLKBe3HnbHzUK
p/joGsC5vazEJN5AdJFS
=gIJo
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--

--===============6208355567037230929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6208355567037230929==--
