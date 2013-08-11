From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak5386: Add DAPM support
Date: Sun, 11 Aug 2013 12:41:26 +0100
Message-ID: <20130811114126.GA13666@sirena.org.uk>
References: <1376220924-13246-1-git-send-email-broonie@kernel.org>
 <520777AF.5000900@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6586523346155303115=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 79D4E260309
 for <alsa-devel@alsa-project.org>; Sun, 11 Aug 2013 13:41:28 +0200 (CEST)
In-Reply-To: <520777AF.5000900@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6586523346155303115==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 11, 2013 at 01:38:23PM +0200, Daniel Mack wrote:
> On 11.08.2013 13:35, Mark Brown wrote:
> > +static struct snd_soc_codec_driver soc_codec_ak5386 = {
> > +	.dapm_widgets = ak4554_dapm_widgets,
> > +	.num_dapm_widgets = ARRAY_SIZE(ak4554_dapm_widgets),
> > +	.dapm_routes = ak4554_dapm_routes,
> > +	.num_dapm_routes = ARRAY_SIZE(ak4554_dapm_routes),

> Any particular reason for the name mismatches (ak4554 vs ak5386)?

I forgot to do the sed after I did the cut'n'paste.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSB3hiAAoJELSic+t+oim95c4P/3yuOT469hNWobK8BYmyz91D
6W3D3TIfdSg6GpQCg8SJ98TY3aEC9fPgMr9HRJSPqxHySZ0KgCIDwZ9OrSD3NAtB
btM9MZntbMdTOPQILBdPKOFIyGRW7qVJjVKFPlGpr4EutonaewAxMkSY9K3gvu9g
xCY0KOgvV5iPMCzdg98ZQlYu74FRt27f0i3x1tRqQXaI3ZsjkwJ6p9q17FSYNqe+
Y3sTJmkE7YL2jxhRFN23VvK7PS4EtBu9WCuP7/4Sd34gzt7ezbacuu72IOAkxu2D
0m8Zn0Gt0XBCT6VlPwD0cKMKarUqePiAUsp6s+aN8iHvVjcb8w7CeNDdElfRtvXx
sFBxj9zcyo6Zqq8XEW0ifimXSWdWk+AO4O3prPa+serk9eElNA/VG9M+QaYOd4dk
SrMZNelXxcAjtUKynQWu+1iMKOVE5MChmPFx6Y1noXdropWcaMMrRUC64LK1gpu4
ckv30zTaAkcWVPUnx8kU5fXhiITqjZ58ZV9GmMtrWot9fkhDpL/09KIqWSMBg+RA
UxusEZ5bUwLbZfwg9ilcI2mZiG7O8VNGtWfWqjluHu67lzI5i+DNMReVtcI1Bw32
Qf0PAmXV1m1yH4AgLEWywgFrPXbt0TEvHNnazxV+WEvCHyq40Ub4RkOyhN9H+DBs
ZNZz1VKjmnr4B/soDd5z
=8HJM
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============6586523346155303115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6586523346155303115==--
