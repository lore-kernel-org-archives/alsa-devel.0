From: Mark Brown <broonie@kernel.org>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 20:06:22 +0100
Message-ID: <20130601190622.GM16790@sirena.org.uk>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <51A736C6.2060500@ladisch.de>
 <CAOMZO5C3eDi_wicdJLab5Dg1yqexkJ6Ffhwwft_2XnO5KHPD+Q@mail.gmail.com>
 <CAOMZO5CfQUnRN8h5gSFV8qAu2YYw4B3hZRBfgkW5DzEmAb3-2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4208803332783226974=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BE0EB261ACF
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 21:06:31 +0200 (CEST)
In-Reply-To: <CAOMZO5CfQUnRN8h5gSFV8qAu2YYw4B3hZRBfgkW5DzEmAb3-2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============4208803332783226974==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j3zO+32zXj6UcJCE"
Content-Disposition: inline


--j3zO+32zXj6UcJCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 01, 2013 at 03:09:38PM -0300, Fabio Estevam wrote:

> root@freescale /$ cat /proc/asound/pcm
> 00-00: HiFi Playback sgtl5000-0 :  : playback 1 : capture 1
> 00-01: HiFi Capture sgtl5000-1 :  : playback 1 : capture 1

Hrm, in that case the kernel does seem to be lying about capabilites...
are all the DAIs correctly listing that they're unidirectional?

--j3zO+32zXj6UcJCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRqkYrAAoJELSic+t+oim9aDEP/A1sKqadUnR5gsoS0D34DI8Z
OAnr11f4jjsf2zKj/gzrZfUtW1zrZzHRMICWX3rc9uYAQIbK0RutSpgHMMkeBu9M
y6lBuBAR/cO1UXS318LWr2uuw1YkQxE3emO7HhY/UN6/a423BDxdm6M6iKdb15XG
rRDOTsX4YTJIU3QND7WgIJFtjOyVnQtWwqjPo9gpBRK8rz3mT9N2mrEkLqu6WURo
f41wOJBOlKJU0D180IrNxrJAuGuNbWmByGcj6yRmjUCfn5DF/ulnQKl+q6/lRujF
RBJu9UmgiqCiFE8EcI6TayZ6OHU5FvbfBAygGvKXo0GUC9V6bGokTdkE5hncAFPB
tNM5uH0CbiH9pRN6slHAYCzHNL5SCZTrdWcTiPXYvtv0oiNnRormmwnkdBKuJb+j
htSDv2ejfwPTYsVJL0JQJgbMYfNdkTHywM5KrrzoOASucn/2vbuVckVNIoBmbdDX
cR31brYHbjqIA4OyHDyWn0pUMA+KZ9136TXJyw6aMJJ7RQ0aGq7SFgyB8kjzEPen
QMr3PGK1PaPmuB0NbzrDrdBH8XG0fYyrFXxK6o1FryF7hk5eAH2fK2DwXZuAefx3
PlFaK5N90y4TLjFWMkwyD/lCBSah6gXmIPbxLHjpzoJgqIKS2yaZ1IaSmyioBneN
Cu7ZW0DHSGtg+6bl+znD
=aTCE
-----END PGP SIGNATURE-----

--j3zO+32zXj6UcJCE--

--===============4208803332783226974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4208803332783226974==--
