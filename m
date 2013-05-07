From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm0010: fix error return code in
	wm0010_boot()
Date: Tue, 7 May 2013 14:54:31 +0100
Message-ID: <20130507135431.GT7478@sirena.org.uk>
References: <CAPgLHd-5rAbUnijs_dfeXuk9LhsSKihOBYeicLWDvZECfP0LmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2241446948279091192=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1004E265065
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 15:54:43 +0200 (CEST)
In-Reply-To: <CAPgLHd-5rAbUnijs_dfeXuk9LhsSKihOBYeicLWDvZECfP0LmA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, yongjun_wei@trendmicro.com.cn
List-Id: alsa-devel@alsa-project.org


--===============2241446948279091192==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0WGqsT62A4RTsSXf"
Content-Disposition: inline


--0WGqsT62A4RTsSXf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 07:38:52PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fix to return -ENOMEM in the memory malloc of 'out' and 'img_swap' error
> handling case instead of 0, as done elsewhere in this function.

Applied, thanks.  Please note my new e-mail address.

--0WGqsT62A4RTsSXf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRiQeUAAoJELSic+t+oim9M3AP/RgCrVYDfwHqOvHUQ0qn/E5r
AwA8nIaCnpuIoPUMzTi/KHhuw20XI5exuNKMmr4D2AsJVoo/ayVGaOq+Urs7ytmR
bS6fDmX8xi01ZB6vCvrSYr3aKDL6sqR+avqi5JEj070C7+ZolDkq8lKVKggj4YMp
Ty7u0/moLgWI64t+YeRIBivUHyxqESfpBAXEKMMhw3t1ENnu28IZOwL9Sbh+R4Kv
OUc7RU8q27+4uR3G6KpZNRxXfycVWzym1d1rnEEFLeUBRBtQEiNnmOCoNWDs4JQ3
Sj36Ssvt0yjjzk3+uVCKUtIsn8kwg6IQ5DwvIbkhL3aIKGXC/QqQvJnD5VOVMj7I
fgEzuFbevohrRa1GBw3+N2cXFItSBig3RjXS2rjp+7fa2mD6OkW8/woHD+CuoJDz
AiYTWcADRSGat3uH/zXzDYJNgluEilk9TaPJSdWDyuNO1iP1QB1HLLSOa2suNqZt
D+YyH9OV35ejQsVxykdzhHD0K6LRDz7DNQYJzKQXMdD13W62QnpYh9UQ+li/HDmY
xi6QQT3q+xava6K5U6gcVNqU7281+32kAeRWoZHqPzeovSKZMI67I2vcAXFfNAy6
6Okc0KdrqaEW+yP+CzB8JnqubyHs3fU8iy4KvXaXFpntLHuMFV4cb7Dg2c4Zzjlq
lRBVRdkMT9s4GcCtLN2S
=/TCp
-----END PGP SIGNATURE-----

--0WGqsT62A4RTsSXf--

--===============2241446948279091192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2241446948279091192==--
