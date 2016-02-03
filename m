From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: arizona: Add support for
 SNDRV_PCM_RATE_KNOT
Date: Wed, 3 Feb 2016 09:24:25 +0100
Message-ID: <56B1B939.5030503@metafoo.de>
References: <1454431084-21411-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20160202193002.GV4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0591828925132334784=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-189.synserver.de (smtp-out-189.synserver.de
 [212.40.185.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EBCA260544
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 09:38:20 +0100 (CET)
In-Reply-To: <20160202193002.GV4455@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0591828925132334784==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vO091L55AJ7kv7kr1f8l4sIBfswAWMf29"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vO091L55AJ7kv7kr1f8l4sIBfswAWMf29
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 02/02/2016 08:30 PM, Mark Brown wrote:
> On Tue, Feb 02, 2016 at 04:38:04PM +0000, Charles Keepax wrote:
>=20
>> +#define ARIZONA_48K_RATES 12000, 24000, 48000, 96000, 192000, 4000, 8=
000, \
>> +			  16000, 32000
>=20
> This just looks wrong.  It's valid code but with the combination of the=

> split line and the list without any sort of parenthesis it sets off
> alarm bells.  Duplicating might not be the worst thing ever...

For list constraints it is possible to specify a mask for which of the
entries in the rates array should be considered. So you could use the sam=
e
rate array, but use different masks. The adau1977 drive for example does =
this.



--vO091L55AJ7kv7kr1f8l4sIBfswAWMf29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsbk5AAoJEOj3aLScRbOZzBUP/3otPww89P58AvfiOA4YpWxI
VyxJDJDSzPPtca3uNiWQmZWpbIteYEFlKS3Mh/17NIioLNh5A16F/c4IWGKUOn4u
OUb/YSOJKAmnX5vWJGWqEXOJMn8Gy2S6MoBTqRDfg5QBM0hNaxoaT1IT9FqCBIn1
6jtPu0ed31LgfaPymfz5cTSEggDxVch+4FbTJEMkf7ZatWOkSbCm2TZTOPcHMoFy
ozg3tRQl7lmp5543vwuswZADWjkvaRedOLapVu3Mdb8hMuydM+F1AFkzwVU2T7NY
LEL1c2RXic/B63LSEjsw4WqkrOqsie5lHOvuAITfBsFliZo5BJXf96FfvcoXIyT+
ZEo0IrTeAmVZfbg5ST7R+eeng84AoAyayRwt0KtokHTJe6gbP5scQVgbNEMV2mMo
/SKDO3v8jArLvtlj8xD8lyZ5uOsX3McuxT/sDiDYOExycB2Vb1vWg+qT4gk1+Rau
gEgefU9rxi0LU1xjGOcoVgQx8qGz219z+ZuFk1RPDvgeU2BZuV06e/dVYoL3JL2Z
NgitFWjstfjxeGR1H3oeJDAlmINM6Pe1TSZ1lLXy9rYT8Lz/Hg+FyGJd51hJrCsm
Y1ywsrCiVg1K2q77lY5/80KCZCXD36IRKGFNHEbol+21GjBsyT6NafeqI6ejFYyO
uYfaoSO4Vbd7ViVMXWnx
=u3WB
-----END PGP SIGNATURE-----

--vO091L55AJ7kv7kr1f8l4sIBfswAWMf29--

--===============0591828925132334784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0591828925132334784==--
