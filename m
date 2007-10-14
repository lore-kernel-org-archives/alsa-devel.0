From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#429326: Bug#437827:
	libasound2: Sound	creaks badly when playing DVDs or OGG files
Date: Sun, 14 Oct 2007 23:37:58 +0200
Message-ID: <20071014213758.GC29867@frodo.home.lxtec.de>
References: <20070814122655.5216.91743.reportbug@faramir.fjphome.nl>
	<20071014170258.GA6954@fox.dooz.org>
	<20071014174706.GA29867@frodo.home.lxtec.de>
	<20071014205729.GA31793@fox.dooz.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1181069399646927453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id A27F1248BB
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Oct 2007 23:38:03 +0200 (CEST)
In-Reply-To: <20071014205729.GA31793@fox.dooz.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Lo=EFc?= Minier <lool@dooz.org>
Cc: Frans Pop <elendil@planet.nl>, matt.nottingham@zen.co.uk, alsa-devel@alsa-project.org, 429326@bugs.debian.org, 437827@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--===============1181069399646927453==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

forwarded 429326 alsa-devel@alsa-project.org

thanks

On Sun, 14 Oct 2007 the mental interface of
Lo=EFc Minier told:

> On Sun, Oct 14, 2007, Elimar Riesebieter wrote:
> > From my point of view it is not reasonable to patch Debian packages,
> > which of course will break 32bit only sound cards. So we've to find
> > a way to force a solution directly on alsa-devel. Who will forward
> > the _Debian_bug to alsa-devel@alsa-project.org ?
>=20
>  I don't understand your remark about patching the Debian package?  Why
>  would reverting the bit shift macros break anything?
>=20
>  The attached patch for alsa-lib should be enough to fix this, upstream
>  should revert the broken change in the bit shifts.

Yeah, we can provide it. But shouldn't it be a solution for all ALSA
users?

This is Debian #429326. As well reported as
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D3360.

We have to look for a general solution as the distributors don't
need to patch sources.

> Alsa #3360; GNOME #436192; LP #116990; Mandriva #33908; Revert HG r2264
> (changeset 23c4c0f5de40) as the bit shifts overflow when the volume is hi=
gh
> for 32 bits to 16 bits resampling
>=20
> diff -r 23c4c0f5de40 -r 883ae69471d2 src/pcm/plugin_ops.h
> --- a/src/pcm/plugin_ops.h	Fri Mar 09 17:06:23 2007 +0100
> +++ b/src/pcm/plugin_ops.h	Fri Mar 09 15:30:38 2007 +0100
> @@ -85,8 +85,6 @@ static inline u_int32_t sx24s(u_int32_t=20
>  #define _put_triple(ptr,val) _put_triple_be(ptr,val)
>  #define _put_triple_s(ptr,val) _put_triple_le(ptr,val)
>  #endif
> -
> -#define shift_down(val, bits) (((val) + (1 << ((bits) - 1))) >> (bits))
> =20
>  #ifdef COPY_LABELS
>  static void *copy_labels[5] =3D {
> @@ -258,14 +256,14 @@ conv_xxx1_009x: as_u32(dst) =3D sx24s((u_i
>  conv_xxx1_009x: as_u32(dst) =3D sx24s((u_int32_t)(as_u8c(src) ^ 0x80) <<=
 8); goto CONV_END;
>  conv_xxx1_9000: as_u32(dst) =3D (u_int32_t)(as_u8c(src) ^ 0x80) << 24; g=
oto CONV_END;
>  conv_xxx1_0009: as_u32(dst) =3D (u_int32_t)(as_u8c(src) ^ 0x80); goto CO=
NV_END;
> -conv_xx12_xxx1: as_u8(dst) =3D shift_down(as_u16c(src), 8); goto CONV_EN=
D;
> +conv_xx12_xxx1: as_u8(dst) =3D as_u16c(src) >> 8; goto CONV_END;
>  conv_xx12_xx12: as_u16(dst) =3D as_u16c(src); goto CONV_END;
>  conv_xx12_xx21: as_u16(dst) =3D bswap_16(as_u16c(src)); goto CONV_END;
>  conv_xx12_x120: as_u32(dst) =3D sx24((u_int32_t)as_u16c(src) << 8); goto=
 CONV_END;
>  conv_xx12_021x: as_u32(dst) =3D sx24s((u_int32_t)bswap_16(as_u16c(src)) =
<< 8); goto CONV_END;
>  conv_xx12_1200: as_u32(dst) =3D (u_int32_t)as_u16c(src) << 16; goto CONV=
_END;
>  conv_xx12_0021: as_u32(dst) =3D (u_int32_t)bswap_16(as_u16c(src)); goto =
CONV_END;
> -conv_xx12_xxx9: as_u8(dst) =3D shift_down(as_u16c(src), 8) ^ 0x80; goto =
CONV_END;
> +conv_xx12_xxx9: as_u8(dst) =3D (as_u16c(src) >> 8) ^ 0x80; goto CONV_END;
>  conv_xx12_xx92: as_u16(dst) =3D as_u16c(src) ^ 0x8000; goto CONV_END;
>  conv_xx12_xx29: as_u16(dst) =3D bswap_16(as_u16c(src)) ^ 0x80; goto CONV=
_END;
>  conv_xx12_x920: as_u32(dst) =3D sx24((u_int32_t)(as_u16c(src) ^ 0x8000) =
<< 8); goto CONV_END;
> @@ -284,57 +282,57 @@ conv_xx12_01Ax: as_u32(dst) =3D sx24s((u_i
>  conv_xx12_01Ax: as_u32(dst) =3D sx24s((u_int32_t)(as_u16c(src) ^ 0x80) <=
< 8); goto CONV_END;
>  conv_xx12_A100: as_u32(dst) =3D (u_int32_t)bswap_16(as_u16c(src) ^ 0x80)=
 << 16; goto CONV_END;
>  conv_xx12_001A: as_u32(dst) =3D (u_int32_t)(as_u16c(src) ^ 0x80); goto C=
ONV_END;
> -conv_x123_xxx1: as_u8(dst) =3D shift_down(as_u32c(src), 16); goto CONV_E=
ND;
> -conv_x123_xx12: as_u16(dst) =3D shift_down(as_u32c(src), 8); goto CONV_E=
ND;
> -conv_x123_xx21: as_u16(dst) =3D bswap_16(shift_down(as_u32c(src), 8)); g=
oto CONV_END;
> +conv_x123_xxx1: as_u8(dst) =3D as_u32c(src) >> 16; goto CONV_END;
> +conv_x123_xx12: as_u16(dst) =3D as_u32c(src) >> 8; goto CONV_END;
> +conv_x123_xx21: as_u16(dst) =3D bswap_16(as_u32c(src) >> 8); goto CONV_E=
ND;
>  conv_x123_x123: as_u32(dst) =3D sx24(as_u32c(src)); goto CONV_END;
>  conv_x123_321x: as_u32(dst) =3D sx24s(bswap_32(as_u32c(src))); goto CONV=
_END;
>  conv_x123_1230: as_u32(dst) =3D as_u32c(src) << 8; goto CONV_END;
> -conv_x123_0321: as_u32(dst) =3D shift_down(bswap_32(as_u32c(src)), 8); g=
oto CONV_END;
> - conv_x123_xxx9: as_u8(dst) =3D shift_down(as_u32c(src), 16) ^ 0x80; got=
o CONV_END;
> -conv_x123_xx92: as_u16(dst) =3D shift_down(as_u32c(src), 8) ^ 0x8000; go=
to CONV_END;
> -conv_x123_xx29: as_u16(dst) =3D bswap_16(shift_down(as_u32c(src), 8)) ^ =
0x80; goto CONV_END;
> +conv_x123_0321: as_u32(dst) =3D bswap_32(as_u32c(src)) >> 8; goto CONV_E=
ND;
> +conv_x123_xxx9: as_u8(dst) =3D (as_u32c(src) >> 16) ^ 0x80; goto CONV_EN=
D;
> +conv_x123_xx92: as_u16(dst) =3D (as_u32c(src) >> 8) ^ 0x8000; goto CONV_=
END;
> +conv_x123_xx29: as_u16(dst) =3D bswap_16(as_u32c(src) >> 8) ^ 0x80; goto=
 CONV_END;
>  conv_x123_x923: as_u32(dst) =3D sx24(as_u32c(src) ^ 0x800000); goto CONV=
_END;
>  conv_x123_329x: as_u32(dst) =3D sx24s(bswap_32(as_u32c(src)) ^ 0x8000); =
goto CONV_END;
>  conv_x123_9230: as_u32(dst) =3D (as_u32c(src) ^ 0x800000) << 8; goto CON=
V_END;
> -conv_x123_0329: as_u32(dst) =3D shift_down(bswap_32(as_u32c(src)), 8) ^ =
0x80; goto CONV_END;
> -conv_123x_xxx3: as_u8(dst) =3D shift_down(as_u32c(src), 8) & 0xff; goto =
CONV_END;
> -conv_123x_xx32: as_u16(dst) =3D bswap_16(shift_down(as_u32c(src), 8)); g=
oto CONV_END;
> -conv_123x_xx23: as_u16(dst) =3D shift_down(as_u32c(src), 8) & 0xffff; go=
to CONV_END;
> +conv_x123_0329: as_u32(dst) =3D (bswap_32(as_u32c(src)) >> 8) ^ 0x80; go=
to CONV_END;
> +conv_123x_xxx3: as_u8(dst) =3D (as_u32c(src) >> 8) & 0xff; goto CONV_END;
> +conv_123x_xx32: as_u16(dst) =3D bswap_16(as_u32c(src) >> 8); goto CONV_E=
ND;
> +conv_123x_xx23: as_u16(dst) =3D (as_u32c(src) >> 8) & 0xffff; goto CONV_=
END;
>  conv_123x_x321: as_u32(dst) =3D sx24(bswap_32(as_u32c(src))); goto CONV_=
END;
>  conv_123x_123x: as_u32(dst) =3D sx24s(as_u32c(src)); goto CONV_END;
>  conv_123x_3210: as_u32(dst) =3D bswap_32(as_u32c(src)) << 8; goto CONV_E=
ND;
> -conv_123x_0123: as_u32(dst) =3D shift_down(as_u32c(src), 8); goto CONV_E=
ND;
> -conv_123x_xxxB: as_u8(dst) =3D (shift_down(as_u32c(src), 8) & 0xff) ^ 0x=
80; goto CONV_END;
> -conv_123x_xxB2: as_u16(dst) =3D bswap_16(shift_down(as_u32c(src), 8) ^ 0=
x80); goto CONV_END;
> -conv_123x_xx2B: as_u16(dst) =3D (shift_down(as_u32c(src), 8) & 0xffff) ^=
 0x80; goto CONV_END;
> +conv_123x_0123: as_u32(dst) =3D as_u32c(src) >> 8; goto CONV_END;
> +conv_123x_xxxB: as_u8(dst) =3D ((as_u32c(src) >> 8) & 0xff) ^ 0x80; goto=
 CONV_END;
> +conv_123x_xxB2: as_u16(dst) =3D bswap_16((as_u32c(src) >> 8) ^ 0x80); go=
to CONV_END;
> +conv_123x_xx2B: as_u16(dst) =3D ((as_u32c(src) >> 8) & 0xffff) ^ 0x80; g=
oto CONV_END;
>  conv_123x_xB21: as_u32(dst) =3D sx24(bswap_32(as_u32c(src)) ^ 0x800000);=
 goto CONV_END;
>  conv_123x_12Bx: as_u32(dst) =3D sx24s(as_u32c(src) ^ 0x8000); goto CONV_=
END;
>  conv_123x_B210: as_u32(dst) =3D bswap_32(as_u32c(src) ^ 0x8000) << 8; go=
to CONV_END;
> -conv_123x_012B: as_u32(dst) =3D shift_down(as_u32c(src), 8) ^ 0x80; goto=
 CONV_END;
> -conv_1234_xxx1: as_u8(dst) =3D shift_down(as_u32c(src), 24); goto CONV_E=
ND;
> -conv_1234_xx12: as_u16(dst) =3D shift_down(as_u32c(src), 16); goto CONV_=
END;
> -conv_1234_xx21: as_u16(dst) =3D bswap_16(shift_down(as_u32c(src), 16)); =
goto CONV_END;
> -conv_1234_x123: as_u32(dst) =3D sx24(shift_down(as_u32c(src), 8)); goto =
CONV_END;
> +conv_123x_012B: as_u32(dst) =3D (as_u32c(src) >> 8) ^ 0x80; goto CONV_EN=
D;
> +conv_1234_xxx1: as_u8(dst) =3D as_u32c(src) >> 24; goto CONV_END;
> +conv_1234_xx12: as_u16(dst) =3D as_u32c(src) >> 16; goto CONV_END;
> +conv_1234_xx21: as_u16(dst) =3D bswap_16(as_u32c(src) >> 16); goto CONV_=
END;
> +conv_1234_x123: as_u32(dst) =3D sx24(as_u32c(src) >> 8); goto CONV_END;
>  conv_1234_321x: as_u32(dst) =3D sx24s(bswap_32(as_u32c(src)) << 8); goto=
 CONV_END;
>  conv_1234_1234: as_u32(dst) =3D as_u32c(src); goto CONV_END;
>  conv_1234_4321: as_u32(dst) =3D bswap_32(as_u32c(src)); goto CONV_END;
> -conv_1234_xxx9: as_u8(dst) =3D shift_down(as_u32c(src), 24) ^ 0x80; goto=
 CONV_END;
> -conv_1234_xx92: as_u16(dst) =3D shift_down(as_u32c(src), 16) ^ 0x8000; g=
oto CONV_END;
> -conv_1234_xx29: as_u16(dst) =3D bswap_16(shift_down(as_u32c(src), 16)) ^=
 0x80; goto CONV_END;
> -conv_1234_x923: as_u32(dst) =3D sx24(shift_down(as_u32c(src), 8) ^ 0x800=
000); goto CONV_END;
> +conv_1234_xxx9: as_u8(dst) =3D (as_u32c(src) >> 24) ^ 0x80; goto CONV_EN=
D;
> +conv_1234_xx92: as_u16(dst) =3D (as_u32c(src) >> 16) ^ 0x8000; goto CONV=
_END;
> +conv_1234_xx29: as_u16(dst) =3D bswap_16(as_u32c(src) >> 16) ^ 0x80; got=
o CONV_END;
> +conv_1234_x923: as_u32(dst) =3D sx24((as_u32c(src) >> 8) ^ 0x800000); go=
to CONV_END;
>  conv_1234_329x: as_u32(dst) =3D sx24s((bswap_32(as_u32c(src)) ^ 0x80) <<=
 8); goto CONV_END;
>  conv_1234_9234: as_u32(dst) =3D as_u32c(src) ^ 0x80000000; goto CONV_END;
>  conv_1234_4329: as_u32(dst) =3D bswap_32(as_u32c(src)) ^ 0x80; goto CONV=
_END;
>  conv_1234_xxx4: as_u8(dst) =3D as_u32c(src) & 0xff; goto CONV_END;
>  conv_1234_xx43: as_u16(dst) =3D bswap_16(as_u32c(src)); goto CONV_END;
>  conv_1234_xx34: as_u16(dst) =3D as_u32c(src) & 0xffff; goto CONV_END;
> -conv_1234_x432: as_u32(dst) =3D sx24(shift_down(bswap_32(as_u32c(src)), =
8)); goto CONV_END;
> +conv_1234_x432: as_u32(dst) =3D sx24(bswap_32(as_u32c(src)) >> 8); goto =
CONV_END;
>  conv_1234_234x: as_u32(dst) =3D sx24s(as_u32c(src) << 8); goto CONV_END;
>  conv_1234_xxxC: as_u8(dst) =3D (as_u32c(src) & 0xff) ^ 0x80; goto CONV_E=
ND;
>  conv_1234_xxC3: as_u16(dst) =3D bswap_16(as_u32c(src) ^ 0x80); goto CONV=
_END;
>  conv_1234_xx3C: as_u16(dst) =3D (as_u32c(src) & 0xffff) ^ 0x80; goto CON=
V_END;
> -conv_1234_xC32: as_u32(dst) =3D sx24(shift_down(bswap_32(as_u32c(src)), =
8) ^ 0x800000); goto CONV_END;
> +conv_1234_xC32: as_u32(dst) =3D sx24((bswap_32(as_u32c(src)) >> 8) ^ 0x8=
00000); goto CONV_END;
>  conv_1234_23Cx: as_u32(dst) =3D sx24s((as_u32c(src) ^ 0x80) << 8); goto =
CONV_END;
>  conv_1234_C321: as_u32(dst) =3D bswap_32(as_u32c(src) ^ 0x80); goto CONV=
_END;
>  conv_1234_123C: as_u32(dst) =3D as_u32c(src) ^ 0x80; goto CONV_END;
> @@ -384,26 +382,26 @@ get16_12_92: sample =3D as_u16c(src) ^ 0x8
>  get16_12_92: sample =3D as_u16c(src) ^ 0x8000; goto GET16_END;
>  get16_12_21: sample =3D bswap_16(as_u16c(src)); goto GET16_END;
>  get16_12_A1: sample =3D bswap_16(as_u16c(src) ^ 0x80); goto GET16_END;
> -get16_0123_12: sample =3D shift_down(as_u32c(src), 8); goto GET16_END;
> -get16_0123_92: sample =3D shift_down(as_u32c(src), 8) ^ 0x8000; goto GET=
16_END;
> -get16_1230_32: sample =3D bswap_16(shift_down(as_u32c(src), 8)); goto GE=
T16_END;
> -get16_1230_B2: sample =3D bswap_16(shift_down(as_u32c(src), 8) ^ 0x80); =
goto GET16_END;
> -get16_1234_12: sample =3D shift_down(as_u32c(src), 16); goto GET16_END;
> -get16_1234_92: sample =3D shift_down(as_u32c(src), 16) ^ 0x8000; goto GE=
T16_END;
> +get16_0123_12: sample =3D as_u32c(src) >> 8; goto GET16_END;
> +get16_0123_92: sample =3D (as_u32c(src) >> 8) ^ 0x8000; goto GET16_END;
> +get16_1230_32: sample =3D bswap_16(as_u32c(src) >> 8); goto GET16_END;
> +get16_1230_B2: sample =3D bswap_16((as_u32c(src) >> 8) ^ 0x80); goto GET=
16_END;
> +get16_1234_12: sample =3D as_u32c(src) >> 16; goto GET16_END;
> +get16_1234_92: sample =3D (as_u32c(src) >> 16) ^ 0x8000; goto GET16_END;
>  get16_1234_43: sample =3D bswap_16(as_u32c(src)); goto GET16_END;
>  get16_1234_C3: sample =3D bswap_16(as_u32c(src) ^ 0x80); goto GET16_END;
> -get16_123_12: sample =3D shift_down(_get_triple(src), 8); goto GET16_END;
> -get16_123_92: sample =3D shift_down(_get_triple(src), 8) ^ 0x8000; goto =
GET16_END;
> -get16_123_32: sample =3D shift_down(_get_triple_s(src), 8); goto GET16_E=
ND;
> -get16_123_B2: sample =3D shift_down(_get_triple_s(src), 8) ^ 0x8000; got=
o GET16_END;
> -get16_123_12_20: sample =3D shift_down(_get_triple(src), 4); goto GET16_=
END;
> -get16_123_92_20: sample =3D shift_down(_get_triple(src), 4) ^ 0x8000; go=
to GET16_END;
> -get16_123_32_20: sample =3D shift_down(_get_triple_s(src), 4); goto GET1=
6_END;
> -get16_123_B2_20: sample =3D shift_down(_get_triple_s(src), 4) ^ 0x8000; =
goto GET16_END;
> -get16_123_12_18: sample =3D shift_down(_get_triple(src), 2); goto GET16_=
END;
> -get16_123_92_18: sample =3D shift_down(_get_triple(src), 2) ^ 0x8000; go=
to GET16_END;
> -get16_123_32_18: sample =3D shift_down(_get_triple_s(src), 2); goto GET1=
6_END;
> -get16_123_B2_18: sample =3D shift_down(_get_triple_s(src), 2) ^ 0x8000; =
goto GET16_END;
> +get16_123_12: sample =3D _get_triple(src) >> 8; goto GET16_END;
> +get16_123_92: sample =3D (_get_triple(src) >> 8) ^ 0x8000; goto GET16_EN=
D;
> +get16_123_32: sample =3D _get_triple_s(src) >> 8; goto GET16_END;
> +get16_123_B2: sample =3D (_get_triple_s(src) >> 8) ^ 0x8000; goto GET16_=
END;
> +get16_123_12_20: sample =3D _get_triple(src) >> 4; goto GET16_END;
> +get16_123_92_20: sample =3D (_get_triple(src) >> 4) ^ 0x8000; goto GET16=
_END;
> +get16_123_32_20: sample =3D _get_triple_s(src) >> 4; goto GET16_END;
> +get16_123_B2_20: sample =3D (_get_triple_s(src) >> 4) ^ 0x8000; goto GET=
16_END;
> +get16_123_12_18: sample =3D _get_triple(src) >> 2; goto GET16_END;
> +get16_123_92_18: sample =3D (_get_triple(src) >> 2) ^ 0x8000; goto GET16=
_END;
> +get16_123_32_18: sample =3D _get_triple_s(src) >> 2; goto GET16_END;
> +get16_123_B2_18: sample =3D (_get_triple_s(src) >> 2) ^ 0x8000; goto GET=
16_END;
>  }
>  #endif
> =20
> @@ -431,8 +429,8 @@ static void *put16_labels[4 * 2 * 2] =3D {
> =20
>  #ifdef PUT16_END
>  while (0) {
> -put16_12_1: as_u8(dst) =3D shift_down(sample, 8); goto PUT16_END;
> -put16_12_9: as_u8(dst) =3D shift_down(sample, 8) ^ 0x80; goto PUT16_END;
> +put16_12_1: as_u8(dst) =3D sample >> 8; goto PUT16_END;
> +put16_12_9: as_u8(dst) =3D (sample >> 8) ^ 0x80; goto PUT16_END;
>  put16_12_12: as_u16(dst) =3D sample; goto PUT16_END;
>  put16_12_92: as_u16(dst) =3D sample ^ 0x8000; goto PUT16_END;
>  put16_12_21: as_u16(dst) =3D bswap_16(sample); goto PUT16_END;
> @@ -502,8 +500,8 @@ get32_12_A100: sample =3D (u_int32_t)bswap
>  get32_12_A100: sample =3D (u_int32_t)bswap_16(as_u16c(src) ^ 0x80) << 16=
; goto GET32_END;
>  get32_0123_1230: sample =3D as_u32c(src) << 8; goto GET32_END;
>  get32_0123_9230: sample =3D (as_u32c(src) << 8) ^ 0x80000000; goto GET32=
_END;
> -get32_1230_3210: sample =3D bswap_32(shift_down(as_u32c(src), 8)); goto =
GET32_END;
> -get32_1230_B210: sample =3D bswap_32(shift_down(as_u32c(src), 8) ^ 0x80)=
; goto GET32_END;
> +get32_1230_3210: sample =3D bswap_32(as_u32c(src) >> 8); goto GET32_END;
> +get32_1230_B210: sample =3D bswap_32((as_u32c(src) >> 8) ^ 0x80); goto G=
ET32_END;
>  get32_1234_1234: sample =3D as_u32c(src); goto GET32_END;
>  get32_1234_9234: sample =3D as_u32c(src) ^ 0x80000000; goto GET32_END;
>  get32_1234_4321: sample =3D bswap_32(as_u32c(src)); goto GET32_END;
> @@ -570,32 +568,32 @@ static void *put32_labels[4 * 2 * 2 + 4=20
> =20
>  #ifdef PUT32_END
>  while (0) {
> -put32_1234_1: as_u8(dst) =3D shift_down(sample, 24); goto PUT32_END;
> -put32_1234_9: as_u8(dst) =3D shift_down(sample, 24) ^ 0x80; goto PUT32_E=
ND;
> -put32_1234_12: as_u16(dst) =3D shift_down(sample, 16); goto PUT32_END;
> -put32_1234_92: as_u16(dst) =3D shift_down(sample, 16) ^ 0x8000; goto PUT=
32_END;
> -put32_1234_21: as_u16(dst) =3D bswap_16(shift_down(sample, 16)); goto PU=
T32_END;
> -put32_1234_29: as_u16(dst) =3D bswap_16(shift_down(sample, 16)) ^ 0x80; =
goto PUT32_END;
> -put32_1234_0123: as_u32(dst) =3D sx24(shift_down(sample, 8)); goto PUT32=
_END;
> -put32_1234_0923: as_u32(dst) =3D sx24(shift_down(sample, 8) ^ 0x800000);=
 goto PUT32_END;
> +put32_1234_1: as_u8(dst) =3D sample >> 24; goto PUT32_END;
> +put32_1234_9: as_u8(dst) =3D (sample >> 24) ^ 0x80; goto PUT32_END;
> +put32_1234_12: as_u16(dst) =3D sample >> 16; goto PUT32_END;
> +put32_1234_92: as_u16(dst) =3D (sample >> 16) ^ 0x8000; goto PUT32_END;
> +put32_1234_21: as_u16(dst) =3D bswap_16(sample >> 16); goto PUT32_END;
> +put32_1234_29: as_u16(dst) =3D bswap_16(sample >> 16) ^ 0x80; goto PUT32=
_END;
> +put32_1234_0123: as_u32(dst) =3D sx24(sample >> 8); goto PUT32_END;
> +put32_1234_0923: as_u32(dst) =3D sx24((sample >> 8) ^ 0x800000); goto PU=
T32_END;
>  put32_1234_3210: as_u32(dst) =3D sx24s(bswap_32(sample) << 8); goto PUT3=
2_END;
>  put32_1234_3290: as_u32(dst) =3D sx24s((bswap_32(sample) ^ 0x80) << 8); =
goto PUT32_END;
>  put32_1234_1234: as_u32(dst) =3D sample; goto PUT32_END;
>  put32_1234_9234: as_u32(dst) =3D sample ^ 0x80000000; goto PUT32_END;
>  put32_1234_4321: as_u32(dst) =3D bswap_32(sample); goto PUT32_END;
>  put32_1234_4329: as_u32(dst) =3D bswap_32(sample) ^ 0x80; goto PUT32_END;
> -put32_1234_123: _put_triple(dst, shift_down(sample, 8)); goto PUT32_END;
> -put32_1234_923: _put_triple(dst, shift_down(sample ^ 0x80000000, 8)); go=
to PUT32_END;
> -put32_1234_321: _put_triple_s(dst, shift_down(sample, 8)); goto PUT32_EN=
D;
> -put32_1234_329: _put_triple_s(dst, shift_down(sample ^ 0x80000000, 8)); =
goto PUT32_END;
> -put32_1234_123_20: _put_triple(dst, shift_down(sample, 12)); goto PUT32_=
END;
> -put32_1234_923_20: _put_triple(dst, shift_down(sample ^ 0x80000000, 12))=
; goto PUT32_END;
> -put32_1234_321_20: _put_triple_s(dst, shift_down(sample, 12)); goto PUT3=
2_END;
> -put32_1234_329_20: _put_triple_s(dst, shift_down(sample ^ 0x80000000, 12=
)); goto PUT32_END;
> -put32_1234_123_18: _put_triple(dst, shift_down(sample, 14)); goto PUT32_=
END;
> -put32_1234_923_18: _put_triple(dst, shift_down(sample ^ 0x80000000, 14))=
; goto PUT32_END;
> -put32_1234_321_18: _put_triple_s(dst, shift_down(sample, 14)); goto PUT3=
2_END;
> -put32_1234_329_18: _put_triple_s(dst, shift_down(sample ^ 0x80000000, 14=
)); goto PUT32_END;
> +put32_1234_123: _put_triple(dst, sample >> 8); goto PUT32_END;
> +put32_1234_923: _put_triple(dst, (sample ^ 0x80000000) >> 8); goto PUT32=
_END;
> +put32_1234_321: _put_triple_s(dst, sample >> 8); goto PUT32_END;
> +put32_1234_329: _put_triple_s(dst, (sample ^ 0x80000000) >> 8); goto PUT=
32_END;
> +put32_1234_123_20: _put_triple(dst, sample >> 12); goto PUT32_END;
> +put32_1234_923_20: _put_triple(dst, (sample ^ 0x80000000) >> 12); goto P=
UT32_END;
> +put32_1234_321_20: _put_triple_s(dst, sample >> 12); goto PUT32_END;
> +put32_1234_329_20: _put_triple_s(dst, (sample ^ 0x80000000) >> 12); goto=
 PUT32_END;
> +put32_1234_123_18: _put_triple(dst, sample >> 14); goto PUT32_END;
> +put32_1234_923_18: _put_triple(dst, (sample ^ 0x80000000) >> 14); goto P=
UT32_END;
> +put32_1234_321_18: _put_triple_s(dst, sample >> 14); goto PUT32_END;
> +put32_1234_329_18: _put_triple_s(dst, (sample ^ 0x80000000) >> 14); goto=
 PUT32_END;
>  }
>  #endif
> =20
> @@ -1081,4 +1079,3 @@ norms_32_s32s:	_norms(src, dst, 32, 1, =20
>  #undef _put_triple_le
>  #undef _put_triple_be
> =20
> -#undef shift_down


--=20
  Excellent day for drinking heavily.=20
  Spike the office water cooler;-)

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHEow23Ig8bsVPf7ARAqdyAJsHjGpyzbGGVV6P1OWCEvvsiNBmrgCffKWi
zmiPt4FqcmrSjtrZ4+1uW44=
=ohJs
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

--===============1181069399646927453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1181069399646927453==--
