From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Add depends on I2C
Date: Fri, 3 Oct 2014 11:19:06 +0100
Message-ID: <20141003101906.GD4273@sirena.org.uk>
References: <1412301307-16819-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8347633028184497536=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 446D9260431
 for <alsa-devel@alsa-project.org>; Fri,  3 Oct 2014 12:19:23 +0200 (CEST)
In-Reply-To: <1412301307-16819-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8347633028184497536==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sXexu/8DJfaCjn//"
Content-Disposition: inline


--sXexu/8DJfaCjn//
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 09:55:07AM +0800, Bard Liao wrote:
> rt286 use I2C as its I/O. So the driver can only available when
> I2C is selected.

>  config SND_SOC_RT286
>  	tristate
> +	depends on I2C

This won't actually do anything - since the symbol SND_SOC_RT286 is
selected rather than enabled directly Kconfig will just ignore any
dependencies it has.  I've applied anyway.

--sXexu/8DJfaCjn//
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULngZAAoJECTWi3JdVIfQZg0H/A/7k/tPdQ/DzxPONo/q3jZe
aG2wJPfsR5fREnsuhjw1k/2FxZ6BNwtaGsfUiFpCWCxiEL1FfV6UGhQbkOdvail6
RjyRMNgbUYHecAb5zz5PtYMYsNY0mnV0AdYcxyCHjKuhgdGu8WJgIJKNOVtu19xp
xfI7m611kRX/RRoKBvez2PY88vmaNhJI9yCjkEtLYuvwpRmXLwB8JJUUmYUmzLK7
TxFpeyrPe5QCM4/0DeBwnrJ2R8NOOVpSHRyy5UGLDUEFm8t6VwffY9uXtPRQwniJ
mNOdbEDU0bC3uc4+gSCyOMIGojglba08XBQC8DiDGH1dvA03+MoXtIhEjNj+ggs=
=ChjQ
-----END PGP SIGNATURE-----

--sXexu/8DJfaCjn//--

--===============8347633028184497536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8347633028184497536==--
