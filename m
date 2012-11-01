From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: tlv320aic32x4: Fix problem
 with first capture.
Date: Thu, 1 Nov 2012 14:36:23 +0000
Message-ID: <20121101143623.GK4413@opensource.wolfsonmicro.com>
References: <1351680814-13714-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9190829968484750910=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B08052625D8
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 15:36:24 +0100 (CET)
In-Reply-To: <1351680814-13714-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, w.sang@pengutronix.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============9190829968484750910==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KaGhPsiNaI6/sRd6"
Content-Disposition: inline


--KaGhPsiNaI6/sRd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 11:53:33AM +0100, Javier Martin wrote:
> In its previous status, the first capture didn't work properly;
> nothing was actually recorded from the microphone. This
> behaviour was observed using a Visstrim M10 board.

Applied both, thanks.

--KaGhPsiNaI6/sRd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkojYAAoJELSic+t+oim9BgUP/ROqxVYreAVMCIxcedar9+Vg
hBFxhAEk1Bz3OQYqDyuZJajtJbDHsKXV4896NL5XSvGS1HmbW1rVRHna3S7SoRm4
k5zS65h8sqLulok8pONPwXqfeNizY1bjMVGtLH/wqSlet4lCokl98388zcAH+VZo
dA4T0k/ZUfw8EgIphrxrw/1tiT8KiNXclOV6CO+ekMgdBMFnJ6dvDwGaizHgjwK+
muyYXIWR44rIBQZGGFIYMw0J4ncyEz8DXk9CJ16hDCqNoj0PLh4mS/lZxgqjkgMO
evKNwhtdVTwUOGRm3QA+RbhjwbDXwAaeWu/E30tD7ILcZ3vc4u/Tg5AY8e3RhTzH
QIjQ5ht75vA7dxT1wfeSKV3gkWTEK3mQKPnuasSON0FzGsn9h/7IQS84Nu3bmDgy
oMGk+gjHyjw1Ec9fzYdzcJlbpYfuLgk7vqr7uvM9EiIhVP2O4UkPLafClvmjcl4I
IVYQ+Qbix5kYzOWjQ9ZZGoSNVjQnfUIp/5rqFaoyx/i/nHsOuhekTZu0yI+Xgyth
6RaBScxqTXRts2Y2VG5o2FdzptKimZGICwntu6FP5HsW+lVNeetI0SFnLyZo3j/e
/6XhLEUdM2c3/HSZKff7DkrLJGkRQz0yiaQh6knHcmlAQg5le2OExEwQ9tO45Ksd
0N52jjRLAIjG77l7pJFE
=tanG
-----END PGP SIGNATURE-----

--KaGhPsiNaI6/sRd6--

--===============9190829968484750910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9190829968484750910==--
