From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: Add support jack detection via
 codec
Date: Fri, 22 Apr 2016 10:22:50 +0100
Message-ID: <20160422092250.GA3217@sirena.org.uk>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-3-git-send-email-zhengxing@rock-chips.com>
 <20160421141921.GA25900@rob-hp-laptop>
 <57197BBA.50304@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5894506196616713872=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <57197BBA.50304-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mengdong Lin <mengdong.lin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adam.Thomson-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============5894506196616713872==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TWLMYU3k2ba4mEMM"
Content-Disposition: inline


--TWLMYU3k2ba4mEMM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 22, 2016 at 09:17:46AM +0800, Xing Zheng wrote:

> Hi Mark, the other question here, how do we make sense to use the
> simple-card to call the "snd_soc_dai_set_pll" if the codec (like da7219)
> requires do this?

What we should do there is move the CODEC clocking to be represented
using the clock API and then there are common clock bindings that
already exist for configuring clocks.

--TWLMYU3k2ba4mEMM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXGe1pAAoJECTWi3JdVIfQ8VEH/R6U0WQdP79xYu08En2ZZeG+
KxEwOe3xjOB9qkzifp9ONKasWkmYQBiWJuTty9rNUI5zxuXyY5rrUVaeLNXhxmgV
uRzZ2Df0rZHdmrwTev1+fe6GKu21c1o1St5ZxhW2roWBtL3U78z2pWL+/M66YW/2
em0hVwD7Nuxf+8L+B1xU5JDwIkgLFBOo80A95sfpUJLKfBRIwywXBOoA2Uqpk7tM
IsRCs+Rnw8KOuDT+qplYF2ZMt+/V42JeO0RvL3hdKdnpL5YeX8uSEAMWgBI2hUAN
qVirdIV8/BCv360vcIgp033tGJzkusZgM027YTGU2NNjFDp/XdzSCwNDyGW6AiM=
=cGoo
-----END PGP SIGNATURE-----

--TWLMYU3k2ba4mEMM--


--===============5894506196616713872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============5894506196616713872==--
