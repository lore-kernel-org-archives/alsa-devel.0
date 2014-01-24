From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Samsung: Fix build error due to
 missing dependency
Date: Fri, 24 Jan 2014 13:17:24 +0000
Message-ID: <20140124131724.GZ11727@sirena.org.uk>
References: <1390552765-32210-1-git-send-email-sachin.kamat@linaro.org>
 <1390552765-32210-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3772307924972322827=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3CDB2616F4
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 14:17:30 +0100 (CET)
In-Reply-To: <1390552765-32210-2-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3772307924972322827==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FhvelBhrd33NvMcY"
Content-Disposition: inline


--FhvelBhrd33NvMcY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 02:09:25PM +0530, Sachin Kamat wrote:
> Depend on MFD_ARIZONA to avoid the following build errors:
>=20
> sound/soc/codecs/arizona.c:218: undefined reference to `arizona_request_i=
rq'
> sound/soc/codecs/arizona.c:226: undefined reference to `arizona_request_i=
rq'
> sound/soc/codecs/arizona.c:1719: undefined reference to `arizona_request_=
irq'

Applied, thanks.

--FhvelBhrd33NvMcY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4mfhAAoJELSic+t+oim9+EQP+wd5+QN/I0YDyvnD/eUBXEnC
35aRd6+75oDFEDyBdOtdl8I78DDyE52yIxN4uFXiqiMhlF0WDAqjSv1ckbtT2Z9o
/Wx0k9JFzLEaD3FAL8FrDjyIYTA0iZdJ5H5saRpsvXQN5GcrYMCThgekXz5PqqKE
vb3CGAKBghEzw/VPoQHiuHDjz0SG1xKf04DNXpmWWuwvsMwmlTdt0FeL9zLqG5+0
ducDyx1Quom32IDCGLJo9DK9PWO2eLBRFTLTZNAmefrMn4JeNkHY8u4ehyBxo2Hk
AlIQ8JqblNRML/kFCtcd28NqqyOsq6h9k9VSeOPx/VjSbEXGLMuAgSUHUFC1YV6Q
rETVQa3EJB9xOMx1tvMqml4oIfWvTW9PptX4e2XntZZ0ftu95CMRAlo1lrVkRaUf
kKQC6gum9x5izDz2w8Qaz+l3r4cjrmmKRyZXtE2e7osPM/6y+KhMptX/sggc7o5I
1irWO8OyMLOqF6nFHGCtkVG7qk535pEHyZiNI1KaF/Zr50BSOW9NklCpZSz0QWu9
sAMJmMFOdjWYUfVipTwvjwDLIrNzZGKXU3h4MCbOy6alMlbsg0otJVY5l7AyqI49
5phsAMZY7Jc1MPumL+0K1nABdViBUahYHNOOeQB8inzTFpHcITPkQetItCUClxwY
5LZKhRZmXo5ymVknj9jl
=brGu
-----END PGP SIGNATURE-----

--FhvelBhrd33NvMcY--

--===============3772307924972322827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3772307924972322827==--
