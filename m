From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-ssi: Support for
	SND_SOC_DAIFMT_CBM_CFS
Date: Thu, 7 Aug 2014 18:45:47 +0100
Message-ID: <20140807174547.GQ17528@sirena.org.uk>
References: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1917195372184170860=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3AAE2652D0
 for <alsa-devel@alsa-project.org>; Thu,  7 Aug 2014 19:46:00 +0200 (CEST)
In-Reply-To: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Falzoi <fabio.falzoi84@gmail.com>
Cc: alsa-devel@alsa-project.org, adamo.a60@gmail.com, timur@tabi.org, lgirdwood@gmail.com, mpa@pengutronix.de, michael@amarulasolutions.com
List-Id: alsa-devel@alsa-project.org


--===============1917195372184170860==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pga57YAdUfKQcdIT"
Content-Disposition: inline


--Pga57YAdUfKQcdIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 04, 2014 at 05:08:07PM +0200, Fabio Falzoi wrote:
> Add SND_SOC_DAIFMT_CBM_CFS support for Freescale architecture.
> Successfully tested on i.MX 6Quad Wandboard and UDOO boards connected to
> the pcm1792a codec.
> In CBM_CFS mode, when using a sample size of 16 bits, we cannot use
> CCSR_SSI_SCR_I2S_MODE_MASTER since we get a frame sync every 16 bits.

Applied, thanks.

--Pga57YAdUfKQcdIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT47tIAAoJELSic+t+oim99hkP/R3b1JfMQURCx1oEoz72OGK8
lg6mz5vsO0kbtFMOR5XpunD3/oQIJq7SSJZXybXAD4BK8mVqVqxYL5wVrS4SPyJk
XStTkYILoS7zebvRqMI+sX+nAGn0s38mQvisLEa30kFquN2y1Mjd0KmVRgr+mDc8
k1lh1oiJ9vNtnItMHXRPxHUS466CUQ2x0Ubj/Np+gvGYUlJYDMof7GGnvEqImleM
xkp/V7asWGoZBtRonCvye5a9EYV5G+THytTHTG2m9DVObjce+IsNKl0BPVVhBVkp
rPsQR/XMVCz5zQAPzH2pBMw+4N+gTmzzdhlxmXz9tJl+n5eIj85336cZl+ILM7bA
F7UUUg27fYIKjcfXrwx6KZ0u4y4940XYQ5O3FpljRlJt7oHMTx34WRWF/mduSd1I
mesZ/y4x7IDN8Q3U8IBq02IvMCMcswZ+pD2vu6L0PGW/UICZym7HFkISt2Sv5vrV
7IT9yBI8V1Qxb0kIA+eAQF583YilOaIY7huVVsYjV7EfjopNzGaoZ0qPZqugwnLA
lNLIGxIdRuwxEEoYU9KoYGF+TBqaFEGOLZV/eacbTL4f8MoBoBZOjx6HlrNWihQM
dyE9iuR7EfI7B1qpsWatgNKpypGMuldrGFHowj/8aJF6zyok5TatVOdMySNdbDCl
V+84DqIWZL5Xv8JwVMl3
=1+lf
-----END PGP SIGNATURE-----

--Pga57YAdUfKQcdIT--

--===============1917195372184170860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1917195372184170860==--
