From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/16] ASoC: core: Add 8bit multi reg
	control accessors
Date: Thu, 22 Mar 2012 17:02:42 +0000
Message-ID: <20120322170242.GM3091@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-3-git-send-email-ola.o.lilja@stericsson.com>
	<20120313212512.GD3177@opensource.wolfsonmicro.com>
	<4F6B5A41.9020107@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0239435419122292746=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F44E10442C
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 18:02:44 +0100 (CET)
In-Reply-To: <4F6B5A41.9020107@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0239435419122292746==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L/bWm/e7/ricERqM"
Content-Disposition: inline


--L/bWm/e7/ricERqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2012 at 05:58:41PM +0100, Kristoffer KARLSSON wrote:

> We do have several controls composed by chunks of 8-bit registers that both are
> contiguous and supports reading back in our hardware and I guess that this
> might not be such an unusual setup for other hardwares either, which would make
> for a useful generic control I believe.

> Do you agree that such a control type could be an useful generic one in the
> framework?

It should support registers of any size, not just 8 bit registers, but
otherwise yes.

--L/bWm/e7/ricERqM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPa1r8AAoJEBus8iNuMP3d1gYP/RHpl9bJG4Z9q1hr4oV4c47l
ANUMKQbptNH7hOz10Raqug4Pu/Ehf3T3Quycqr+Do0TOHkrNNyZxpL7VRMRmYMml
xIXh6s6NM5sSFePBQVZ9S69g44oowh6nejnDXUlIBmviSMtAh3ClN3a8Sapyu6P/
tDch0oV9OpL3wBMNtC3MoqPOOsEs1LYC9OPSKoC4OuiGyxZkRDUhKQcsyY+/juLR
72sxN9eXJptquUd6TZnM5ReQO3u6XwvDwZemQlpIsqTfqv5HlbdgOhnO5okL0nVO
7+gI7DEwGsO2rqj0QX0ODSLeaYtjcLagksMEzxh5Cs91+soFxpbkm5UNLZ9WvTL8
x4/LapqpfhHWuKDaQ8PK2df4VHblu+1Di40R56AG1y8UYLKJYGhpek5BBzJEppAc
Rbd/0o0oSQIWPktQpmobv/PoT9M751Hcuint2O9kOb6aVF2gqYGJ8J3GYClBXEtw
y0uBs++Qy5ziekG/z9GzMM34juuIC6IQE1aYLwQjqoZW3Mnu1BzGTfnLvY8lMapx
tjF+mR3k0oVVJ06FxlKld46OnvfCQ+hSyGhcmtlLecpFKrvsIrLoeETSuBCf56q6
kmh45SI1XjVcBh3mOlQzQoK03l3txFOd1f9x7s/5sypAi1ymfxHps7OC17UngPyA
kEdbZWDd3LA1OOYohYlQ
=kXPS
-----END PGP SIGNATURE-----

--L/bWm/e7/ricERqM--

--===============0239435419122292746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0239435419122292746==--
