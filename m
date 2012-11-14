From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: ak4104: add reset line
 property to DT bindings
Date: Wed, 14 Nov 2012 19:43:45 +0900
Message-ID: <20121114104344.GJ7407@opensource.wolfsonmicro.com>
References: <1352888919-25270-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1526158118190489571=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 661662652CF
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 11:43:56 +0100 (CET)
In-Reply-To: <1352888919-25270-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1526158118190489571==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2012 at 06:28:39PM +0800, Daniel Mack wrote:
> This device doesn't have a pdata definition for legacy boards, and
> unless anyone need to control the reset GPIO, it's not worth adding one.
> So this feature is only available to DT users for now.
>=20
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/ak4104.txt |  5 +++++

This doesn't apply, the bindings file doesn't exist in mainline or -next
- probably an earlier patch you forgot to submit.

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQo3XTAAoJELSic+t+oim9W7QP/jKuAkxZcrQjGwtbplsIF3Bo
TnAYEEzNSeKq2EdMBvSuNwKoS/9M7HnYT9+qDyWAkxa5PovTJRJ+vKZHpNLqBpf8
jF3dxiuj7A3ZVyP88f5ukR+awdN7QPXU1mTF6DjedI9xgVvIAWGEZmAokVIr3nD+
cDOtjRIncI9vSFV3VPXUHX+ZBQmY/qri5FNez88MNOf6nqmf/VfKBxPte1Hp087I
c00/NcFI7i7/h7yIl0JCTG+h7PncPBQDx9QUzx6mQi+sxo0vuJacXRVd25Qn5RT6
Tdl9c11jV7MHMTrnAbSgVp9Y3qEUWSGjpqH3OTqza5LwMXtgV2JL4cNF6oXSQ/wd
LwAjjugJFM84sqM51rVTcgA7B/BkLQ8hCucyvC+VP/aZm+NTjgk6+9U7B2+DCQiy
RAsW15k4QH25vEfn7M+1VFPmV4AzTQzJcdIQ9mMo7ogRiJ+Lwzg9mdZ2nMaU6b5t
+iM9krboGQTk8jFrIFVtJ+UmV+qSgdgKXbLJFTQIz8ToQFfP7ehIa5Gq62rYY6KB
inLEMKF4s5a68Pm3hsoDWxLmTQNmAa/6LCj+ilR2AmRDpofOeRASC4SzUPyR2Lzh
mcepXeW1yqzV9RzWOtva/I+DWZ4E+2x3qdxh9YUTFo+Le5VvKETokbeugfLOX/ZW
Jv9vp1uErALVgCDCpWpH
=BMvb
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--

--===============1526158118190489571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1526158118190489571==--
