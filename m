From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5 v7][RFC] ASoC: add
	snd_soc_register_cpu()
Date: Sat, 2 Mar 2013 11:25:13 +0800
Message-ID: <20130302032511.GB6610@opensource.wolfsonmicro.com>
References: <511C22E2.60701@wwwdotorg.org>
 <87obfnofsx.wl%kuninori.morimoto.gx@renesas.com>
 <511C6A1B.9000507@wwwdotorg.org>
 <874nhfv5mb.wl%kuninori.morimoto.gx@renesas.com>
 <8738wzuu9g.wl%kuninori.morimoto.gx@renesas.com>
 <87a9qsg4lp.wl%kuninori.morimoto.gx@renesas.com>
 <87mwuptgju.wl%kuninori.morimoto.gx@renesas.com>
 <512FACAC.1000808@wwwdotorg.org> <5131147F.5090901@metafoo.de>
 <1362174130.4439.61.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8129127873562433938=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2A27260799
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2013 04:25:50 +0100 (CET)
In-Reply-To: <1362174130.4439.61.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Warren <swarren@wwwdotorg.org>, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8129127873562433938==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2013 at 09:42:10PM +0000, Liam Girdwood wrote:
> On Fri, 2013-03-01 at 21:50 +0100, Lars-Peter Clausen wrote:

> > object. I mean the distinction is mostly for historic reasons from a time where
> > it was only possible to bind a the cpu_dai of a link to a CPU DAI and the
> > codec_dai to a CODEC DAI. But these dais both can for example be bound CODEC
> > DAIs. I think to have a common base here would allow us to do some cleanups to
> > the ASoC core and also avoid the duplication with snd_soc_of_get_cpu_dai_name
> > and snd_soc_of_get_codec_dai_name which was introduced in this series.

> I've been thinking about this distinction for some time too (since
> multi-component support). You are right, the division with CODEC and CPU
> DAIs is entirely historical. The same logic also applies to platform and
> codec drivers too.

The DAIs are now the same of course, it's just the containing object
that differs.  Platform drivers are a bit different to CODEC drivers for
me though in that they encapsulate the DMA equivalent of a DAI - I can
see a SoC having multiple platform drivers if it's got a couple of
different DMA controllers for example (I've seen some which have a
fancier one on faster buses for example).

> This does need some mechanical cleanup where we have a generic audio
> component driver object that contains generic DAIs. i.e. codec and
> platform drivers would become generic component drivers with generic
> DAIs.

There's also the perennial questions about code churn and if it's worth
it of course.

Should we be adding a chip driver type rather than a CPU one here and
then going through and doing the work to make sure that you can use a
chip driver wherever you use a CODEC driver so we can start converting
things over?

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMXD+AAoJELSic+t+oim9WRMQAJ5D3YRxlL6pam+ufL3Ws/D0
3drALnddtO203v9kS7VnJlW+zdv+raSC3rLLQghBq66EJb7mvN29RxRs1VpHXcBL
XjNObAdIeamoOHHvBuiDZn1/oPuBRDnsVzw62ZrF+4ZbejwZaKhoqA5POv73sCBo
LD9YtsiaiOKKjdMLZMf4DYIQwE4aUpB27pDkfZLS+7qp2HuZFa51157PiR2De7in
s94P7pYu8YtrIJsNrmwUjLLSywyIc6a2l3GfGGoCkQsyXJMBZTdfVFZPAZE40Xt5
WzWhZJwk9pTHyPX1TFdQaEDHRnFjoGx7pxixOEnbKowJiChkpLeRsCvkjj+bvx05
3u6T7bWcuqFoB6Poo6+MRj6AlNDZrVjd81q/tYdLjxdSsxX9z7QaBYVlVl90Bcrd
Z7jjuII6w86gsXt9WAOQ0lcjxfrmkFS3v6AV1ScneejJu6XGMxlfuVXTmZtUQJ03
xWalQNKlWC5OfcKPqfQ64HBA8TjtZJ+veFslIUpHP70tUTI8BTNxKffWKIV2s5cx
EnYbbQMmtL/7RLwEN4ohS9r+hPAEVKFcorQQ4gdjA58ysDMdLXli4xGS4cHzV57A
gcG155PsGkZ+3lXpK74v/X/vAVCM7XuElVDIeUhu3GH//dOFnV/xtSxLVDTVGWNb
/SPFA4frXq6HhIjzJrAv
=mr5t
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

--===============8129127873562433938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8129127873562433938==--
