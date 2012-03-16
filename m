From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Samsung: Added to support mono
	recording
Date: Fri, 16 Mar 2012 19:01:38 +0000
Message-ID: <20120316190136.GC3158@opensource.wolfsonmicro.com>
References: <0c1f01cd033f$bc35fc50$34a1f4f0$@com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1484215196723111014=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 081AB2433F
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:01:41 +0100 (CET)
In-Reply-To: <0c1f01cd033f$bc35fc50$34a1f4f0$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, sbkim01@gmail.com, 'Liam Girdwood' <lrg@ti.com>, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org


--===============1484215196723111014==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 03:40:53PM +0900, Sangbeom Kim wrote:
> From: Sangsu Park <sangsu4u.park@samsung.com>
>=20
> The dma size will be changed by requested number of
> channel(mono/stereo) from platform. For mono recording,
> channels_min value should be 1.

Applied, thanks.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY44JAAoJEBus8iNuMP3dUFEP/jF7GRFscK/r2fjw53X/cuB/
q1ghqzz+WP6p+M7cNI0aREoYNd321YEOOCDfp0U3dJNrtKPGY6BVetbUczCpGP2+
/L1dz/v3dQiGti+YJF0AFQoIzm3dnXr/dp5fJ0mmIihdPnHMO6GWYDuTbqbgsZCu
CryereXzrzR3qpaIGvA5JbXbg8I8LmKmkx4jjW/c3dj3EMmPmC4NFQR7Jjvdn3TX
H23IYou0Z/E3Ir46fCqs2d2HiQ4Pb5f4zvdWZX40nljUEHU8J5r3gt53Eyc3ZPFu
bvZbVtsJNZnkHrV5J4aiYL0mdA3rN5iNgtjX3fJSel4j2AFDESOL9UTNLnIlXkXm
j6h4sK8NAbidNfFBSrFxF8+f540YH8MEp1Jz9G+N71ffOWOXDalgVpoWSbi5aQa3
If5/nF+Pn6fva1kr/3GxzfoQeYP8vB4J/TzL8EuRaQ0ELKjdj5AcyG+fBj2TFpSm
mH9+VgKVymQp3YwkM4Vr6/qu5984Js6BFFm4nGbACSMYnEliq0paJqd5WyGS/2xG
B5Wc/kRhigN5AY9RBdhGjzzey0c70t86D/F3GfyqToHJDk7wNDfQCU5pSTPsAkX5
6gbZJlDRMqmPE2Lg8Y0AMZKKDzmarI0OvZ6pOlHdDYtVLRGJ9XpWq9lkmwtJmK66
Lqg8GFJNsS7KFazaOJa3
=HIST
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--

--===============1484215196723111014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1484215196723111014==--
