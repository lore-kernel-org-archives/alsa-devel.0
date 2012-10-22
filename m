From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH resend 1/2] ASoC: davinci: replace private
 sram api with genalloc
Date: Mon, 22 Oct 2012 14:58:59 +0100
Message-ID: <20121022135859.GL4477@opensource.wolfsonmicro.com>
References: <1350482884-13119-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0409507535385482084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9C5D4265204
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 15:59:03 +0200 (CEST)
In-Reply-To: <1350482884-13119-1-git-send-email-zonque@gmail.com>
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
Cc: mporter@ti.com, alsa-devel@alsa-project.org, nsekhar@ti.com, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org


--===============0409507535385482084==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2012 at 04:08:03PM +0200, Daniel Mack wrote:
> From: Matt Porter <mporter@ti.com>
>=20
> Removes the DaVinci private SRAM API and replaces it with
> the genalloc API. The SRAM gen_pool is passed in pdata since
> DaVinci is in the early stages of DT conversion.

Applied both, thanks.

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhVEXAAoJELSic+t+oim9484P/RpPo6P2AjGpCqGPz2mw4Qrh
wYjr4a7o90L7Uc4Yirz+50ZDNmdp66/k6nVQSvMCNk3ayTztd6/09HmEN9KBJJqy
I6bmhIjDy9jUns2SmwToji0PHQ2VtBaHMd6yG9ZEj1/ZzkgtMJSvbqYoR+Sb9U4K
GkzsRll5WIMr2myKR6r3Daaehm5ahex6lsehRQ9ssFmat5Oi6VoZvNgUhp2H95hx
o11XGSKP0dYobMKzEa25tiwfIOC+DoIgoeKQuGmp2/cKAOTsIzJriGKddGWTWtCw
UZRnwFfp51Wcat6p0AX67Y9rWD43ms5Ioh8F3Pq00loF9CKsxtc1wk1RGcMz7XKN
T1fSQK+UvMxbjHQZcSnvQTr8pF/7GYTY2BUoSGVghEnvnVP/TB/VtSUH4hN9Rto7
EReCoNjnHuRPnkCLoiy/uNUZxi4bemS4nCRZLlUc5j74EwP+J3muYZsY9Z+VhM7g
YeiUPAUf9PnDvv4A5NNv1B5AkiNE4e01bXwhj/7MIJsfpvjuiDpFxNY2iyQiGqaP
ZA0Zs4Rltsw7KVrDuL+VTfpeod+EJUpiyWdcaRpZX/1TlvhoM+5BiV77spy/Buym
yyuwrnEj0tTNGUmOjjI8x1s1DekxS8I/jg+rMprdPkLjWBo01Suqv70sb5QfSxgF
Zn2dMZ47Kt6IQw9vtTrV
=BxKV
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--

--===============0409507535385482084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0409507535385482084==--
