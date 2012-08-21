From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-compress: Remove unused variable
Date: Tue, 21 Aug 2012 15:14:11 +0100
Message-ID: <20120821141411.GN7995@opensource.wolfsonmicro.com>
References: <1345531822-2297-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2637639058926010088=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 47EAA265FCF
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:14:11 +0200 (CEST)
In-Reply-To: <1345531822-2297-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: alsa-devel@alsa-project.org, namartax.kohli@intel.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2637639058926010088==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hNG1vEeyG8BCaHbQ"
Content-Disposition: inline


--hNG1vEeyG8BCaHbQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2012 at 12:20:22PM +0530, Sachin Kamat wrote:
> codec_dai is not used in the function.
>=20
> sound/soc/soc-compress.c: In function =E2=80=98soc_compr_set_params=E2=80=
=99:
> sound/soc/soc-compress.c:156:22: warning:
> unused variable =E2=80=98codec_dai=E2=80=99 [-Wunused-variable]

Applied, thanks.

--hNG1vEeyG8BCaHbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM5duAAoJEFJkBDiqVpZ49OkP+wcXmNewZA9hxQsSQPp0ZvX8
a5LrxCcpHKwp7rqejo6+LoaDBmJqI4aCYqNDCXkZyQwaNqCXr3l4BUDZnqizff0C
3NlxMDqSUvoBYI99C5zEewJv29TYtHARyP8Bh6CR9ggFUn1URt/PHCktSgj6DpPY
ivA+XgxI5o6BlQ+JvNsTNaj/jXlq5yvsifEeDVIYVnc7nhxOmdyoTui5sNIY3Nrq
dSErA5bJlZq7oJvvhY1n4v/cBzsepL/HiqvS0mQfnyjUr8GBPXpl0aPQoHnjrM3c
4OJsDTIXx8TdWE/d8PEQVkY+drwRaWl9jyDdn4U6kR0QuqIj/iiP5jsI9WLcfjBQ
1RrR67YiNAZmz4ooZh/Fp7vFA5WB3ZA27V8/ZDP4ZQWLK7jVvoRLJCSkRaq9RYCx
vmCQrre5RjSxaNIIJzpKhBY+gz+v1StpXFpEfKXZ0TImW94KWKnLT/gpNr8EZiZy
hC6nGTRS/WNO0batmZt3gYpJTnCz3ApeDyi6SiBCD2EYs0Xj//v4JVRraBkg/Qob
VC5CObZiow6u/IUSjrwENSPKoO9vaUpbRgnWfSwc7FvIK0x24rHkeAeECFu+zlZU
S8Kfs7LsHeD9PgYTMXK+hThUkdtYB5x2AY6OZIDzb2pQXYpWunk7uPK9ekS/v27p
eTCdMuMGWHrzqGmZXdxH
=1EGy
-----END PGP SIGNATURE-----

--hNG1vEeyG8BCaHbQ--

--===============2637639058926010088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2637639058926010088==--
