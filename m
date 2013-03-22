From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 19/54 v2] ASoC: switch over to use
 snd_soc_register_component() on mpc5200 i2s
Date: Fri, 22 Mar 2013 11:22:57 +0100
Message-ID: <20130322102256.GD22890@opensource.wolfsonmicro.com>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <8738vpf3qd.wl%kuninori.morimoto.gx@renesas.com>
 <87boaddox7.wl%kuninori.morimoto.gx@renesas.com>
 <514B3B07.4030309@wwwdotorg.org>
 <87620kfcy4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7550927430529925298=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D3C026516B
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 11:22:58 +0100 (CET)
In-Reply-To: <87620kfcy4.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7550927430529925298==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 21, 2013 at 06:19:51PM -0700, Kuninori Morimoto wrote:

> arch/powerpc/boot/dts/lite5200.dts seems the user of this driver,
> but, it was comment-outed.
> And it is using DT, not name matching ?

Yes, this driver has only ever been used with DT.

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRTDDxAAoJELSic+t+oim9gPQP/ic5ws81zqaBp/Kphreg2WrF
GsXJQMn9ZpFU93UlGTKQFOJ2MgHL2vrZetpiArfegTDqp6TdS89jxEeQI10fC20/
TF6Ru63f0NfSSPW7cGFuUMOeYlNfF+hlvMiegM6RGR2mLS2X5NWSj0lfUVuDzH3p
t0pgwf+PTPA5IVMTSRer5Lay4R7lg1JHy3U0gIdvijqnSTGquQbaBlOnbTWk7W+T
TRSmIq7uBnyd+IivP/FVMUhuXlJpdrWABYn7LWS7tfPx+4EhsEal7gbQ/uP/TdY2
zJxG/An7xi1z/vU4nbSwFtZf66cjl9/sAJ6VlNBfroCQjJ+dtL8PqU3P2yaBEnw+
/Qj8WU7DmNbp2+XNYy6kClo44fl78lZkqpN0rDFTS2T5pNOC+qmgOPXZoZifKqjh
/+rtAFbJWBIwoi94y11gxN18/jNmmHjcJ9vj9coilE9QU8xf6AOrDekRF0rVQRji
95NakRPOULyC5BFfJsPLM8uXlHEqC2D/hatMMPl8UNg1QlY5ColqzQ6zfQn4YH9J
CdgayJczz1K3yN8y/1aqx/E8AELNA+4tvKuFDWk/ADyb78uRdQLp3/I3Nph12BUo
RPOzZxGD0NpUlNi4vVyQyPxEDjGLdsdJIAmdo4lg0GbrKdGMmhAD414slTCmPqdk
qy9R5+Ghy5efPl2NuO8P
=Wmmz
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--

--===============7550927430529925298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7550927430529925298==--
