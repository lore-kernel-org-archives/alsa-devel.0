From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: remove saarb and tavorevb3 machine
	drivers
Date: Wed, 15 May 2013 08:59:42 +0400
Message-ID: <20130515045942.GK24524@sirena.org.uk>
References: <1368544041.1350.111.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0236292449037300265=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BB0226109E
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:59:53 +0200 (CEST)
In-Reply-To: <1368544041.1350.111.camel@x61.thuisdomein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0236292449037300265==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 05:07:21PM +0200, Paul Bolle wrote:
> Support for PXA95x was removed in v3.8. This means that the Kconfig
> symbols MACH_SAARB and MACH_TAVOREVB3 are no longer available. This
> leaves the SoC Audio support for Marvell Saarb and Marvell Tavor EVB3
> unbuildable. Remove these drivers too.

Applied, thanks.

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxY7AAoJELSic+t+oim9i+cP/j6W0qy+mM6Km08JaKKNB/2m
z9pBkcjRcVJujr+jHJUBGkKF2IfZTKDcTAQ6+c7H3k8PYNBZbKBBz+Vrjgu7UJoe
6VhFzCgkff7R193HIPVTsfrYidnU2xjPkRUhZgrFpAt6vKiPXVLewqoVrsh//uhi
1bqzbw4Q04OP328r+jH27hQhp+6xteDYseJ9JxLkgLZDD69a4EE0ya0BtPmz/xz6
Gx+5mCPUczvebt+cioF/3j1I6dH/QtRy3aJajP7VPBVBTKna+kxdeh4iELBf85vo
TD05tEJJUKb9oAnMj5gqJl0K1yylWREofRjnIt6Mp3Cje6KXkfyZkSd0eI3bjQKF
pSxp86s8cLw2BMutikxG2imR71KIQqsfNDfO1USoFWadFYhJogepGGIg987qfDb1
dIMJo0terP8M5+eGqlcO3Snfzwy5/+oAsOLL+AfqLdm3nId4LYgV6TgVRLa67QcD
QqhOJgNH5NCaeeTFGHmMKQiIc8QiDCVh/SlHyPNr8Cb4OntDLwk0fp66rHbG2l+l
tRdn5+faAoQr+EvtC4KE4tjdFOtE+zaV8SBa7hzwJQjflZ4UQWxuFxEjm2jHgILj
qIyQl7b0pj+A/NTtCQPi/DAOgwAsh6Vt9gUSM+hwAqeaIikZQkdr2xnV+U1cF5J1
iCmvYgi6jYu/50ea5sD/
=mlVL
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--

--===============0236292449037300265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0236292449037300265==--
