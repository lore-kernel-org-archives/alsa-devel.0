From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Add delay for output disable
Date: Mon, 19 Jan 2015 16:24:32 +0000
Message-ID: <20150119162432.GF2809@sirena.org.uk>
References: <1421682586-6303-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6975468615773854489=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D4B9260A56
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 17:24:45 +0100 (CET)
In-Reply-To: <1421682586-6303-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6975468615773854489==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Content-Disposition: inline


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2015 at 03:49:46PM +0000, Charles Keepax wrote:

> +	case SND_SOC_DAPM_POST_PMD:
> +		switch (w->shift) {
> +		case ARIZONA_OUT1L_ENA_SHIFT:
> +		case ARIZONA_OUT1R_ENA_SHIFT:
> +		case ARIZONA_OUT2L_ENA_SHIFT:
> +		case ARIZONA_OUT2R_ENA_SHIFT:
> +		case ARIZONA_OUT3L_ENA_SHIFT:
> +		case ARIZONA_OUT3R_ENA_SHIFT:
> +			udelay(750);
> +			break;

That's a really quite long udelay() especially given that as the code is
written it's going to be cumalative over all the outputs being torn down
so typically will be 1.5ms for headphones (not sure if that's the
intention or not).  msleep() would be more friendly than udelay() and
it'd also be good to arrange to coalesce the delays.  Perhaps set a flag
in _PRE_PMD and check if a delay is needed in the clock teardown?  Or
better yet record a timestamp and then figure out if a delay is needed
when tearing down the clock though that is probably overengineering.

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUvS+/AAoJECTWi3JdVIfQMzgH/1zN/485Bx+h9Bvbj+b7smIN
AKNWLh1yMU6FDJVY2FAty1Aw+J+jdoJvSF3AWJLpiKDZQBBDRb812bzxmgZ1sFGt
YCB1M6qpKCikUkx4V7N0vtsTwMv/y/nLegAyi50t7oCvF9ukTgY3HGKJxEjaunP6
0XS9v/52wsYUYvICjzOZELNdNJ9es4JXbBXZsvB9R09k47nm9c5nlVN5f25id82v
y11e36dH+tQ9AL3LxHAvwhklQw++u/lOzaGEEnxgvn1+Ws66Xi9COx7h8fYatkXa
A6DX6CF/cFFriFAc74njsYuh+24jN0Rx1zKRQOYCDZGGYeXwb2S7dPUokdzdt3c=
=IhVS
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--

--===============6975468615773854489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6975468615773854489==--
