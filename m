From: Baptiste Jonglez <baptiste@bitsofnetworks.org>
Subject: Re: Assertion failure in alsa-lib crashing
 applications (snd_pcm_area_copy: Assertion `dst < src || dst >= src +
 bytes' failed)
Date: Tue, 14 Jun 2016 23:02:21 +0200
Message-ID: <20160614210221.GB5107@lud.polynome.dn42>
References: <20160607172935.GC25444@lud.polynome.dn42>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6877988577622589495=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mails.bitsofnetworks.org (rezine.polyno.me [193.33.56.138])
 by alsa0.perex.cz (Postfix) with ESMTP id D5D93264F22
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 23:02:24 +0200 (CEST)
Received: from rev-140-155.legacytubes.illyse.net ([89.234.140.155]
 helo=lud.polynome.dn42) by mails.bitsofnetworks.org with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.84_2)
 (envelope-from <baptiste@bitsofnetworks.org>) id 1bCvTb-0001LF-By
 for alsa-devel@alsa-project.org; Tue, 14 Jun 2016 23:02:23 +0200
In-Reply-To: <20160607172935.GC25444@lud.polynome.dn42>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6877988577622589495==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 07, 2016 at 07:29:35PM +0200, Baptiste Jonglez wrote:
> When using Ring [1], an audio-video application, it sometimes crashes
> because of an assertion in libasound.so:
>=20
>     pcm.c:2758: snd_pcm_area_copy: Assertion `dst < src || dst >=3D src +=
 bytes' failed.
>=20
> The complete upstream bug report is at [2].  The (not-so-useful) stack
> trace is the following:
>=20
> <snip>
>=20
> The next time it crashes, I will have debug symbols in dring.  I can also
> recompile alsa-lib with debug symbols, what is the best way to do that?

As promised, here is a new stack trace with debug symbols:

#0  0x00007f899af94295 in raise () from /usr/lib/libc.so.6
#1  0x00007f899af956da in abort () from /usr/lib/libc.so.6
#2  0x00007f899af8d297 in __assert_fail_base () from /usr/lib/libc.so.6
#3  0x00007f899af8d342 in __assert_fail () from /usr/lib/libc.so.6
#4  0x00007f89a003b04d in snd_pcm_area_copy (dst_area=3D0x7f89847f3360, dst=
_offset=3D<optimized out>, src_area=3D0x7f89847f3350, src_offset=3D<optimiz=
ed out>, samples=3D<optimized out>, format=3D<optimized out>) at pcm.c:2758
#5  0x00007f89a003b27c in snd_pcm_areas_copy (dst_areas=3D0x7f896c002dd0, d=
st_areas@entry=3D0x7f896c002db0, dst_offset=3D248, src_areas=3D0x7f896c002d=
d0, src_areas@entry=3D0x610, src_offset=3D0, channels=3D2, channels@entry=
=3D0, frames=3D1552, frames@entry=3D0, format=3DSND_PCM_FORMAT_S32_LE) at p=
cm.c:2904
#6  0x00007f89a007c2d9 in softvol_convert_stereo_vol (svol=3Dsvol@entry=3D0=
x7f896c0013c0, dst_areas=3Ddst_areas@entry=3D0x7f896c002db0, dst_offset=3Dd=
st_offset@entry=3D248, src_areas=3D0x610, src_areas@entry=3D0x7f896c002db0,=
 src_offset=3Dsrc_offset@entry=3D0, channels=3D0, frames=3D<optimized out>)=
 at pcm_softvol.c:291
#7  0x00007f89a007c3f6 in snd_pcm_softvol_read_areas (pcm=3D0x7f896c001b10,=
 areas=3D0x7f896c002db0, offset=3D248, size=3D1552, slave_areas=3D0x7f896c0=
02db0, slave_offset=3D0, slave_sizep=3D0x7f89847f3480) at pcm_softvol.c:630
#8  0x00007f89a004d0e1 in snd_pcm_plugin_avail_update (pcm=3D0x7f896c001b10=
) at pcm_plugin.c:490
#9  0x00007f89a004cf19 in snd_pcm_plugin_avail_update (pcm=3D0x7f896c001eb0=
) at pcm_plugin.c:460
#10 0x00000000005486d4 in ring::AlsaLayer::capture (this=3D0x1a9ef00) at al=
salayer.cpp:694
#11 0x0000000000545de4 in ring::AlsaThread::run (this=3D0x1b00500) at alsal=
ayer.cpp:137
<snip> (horrible C++ stack trace from the application itself)

Is there anything in there that could explain the assertion failure?
Perhaps a wrong API usage?

Thanks,
Baptiste

>=20
> Looking around, it seems other projects have run into the same issue:
>=20
>     https://aur.archlinux.org/packages/ultrastardx-git/?comments=3Dall#co=
mment-435458
>     https://aur.archlinux.org/packages/zoom/#comment-544696
>     http://ubuntuforums.org/showthread.php?t=3D2248373
>     https://github.com/js-platform/node-webrtc/issues/110
>     https://fedorahosted.org/fldigi/ticket/70
>=20
> The output of the alsa-info.sh script on my system is at [3].
> What else can I provide to debug this issue further?
>=20
> Thanks,
> Baptiste
>=20
> [1] https://ring.cx
> [2] https://tuleap.ring.cx/plugins/tracker/?aid=3D502
> [3] http://www.alsa-project.org/db/?f=3D0dd2ba1021b3d535f30f07c55dc18e2ef=
60db26d



> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXYHDYAAoJEL4B7CKgTi5Gnw8P/ir2QebxnHb4D96qZhgV25gN
5UMVUp2z33a8i4GnEk5gvmhldsWPiHDDSieF3ildicZZFUYsVaFSXJ12OiHtd04G
72xzJ574DLcmTrxoXuacsIQAyjVBCVvhlxPr8ewSaRwChjcp+Zspg5/o/sDJojvk
4yYuPjjRGNuXPmz0iKkbfkrh8ZE4gLWUnnDfPM2nuOvvWj+HsuG8SwXB3962dsRO
DUihmwS28/UVnDkgIy8Nb1jOAT6OAWc46XPUeya05A31OkJE37Zi6al/O5ijsGGU
DpxMIZXutQZ+LpuwZxRFLHCGWNugy68crU2R8aUKiNrA7Pgi1vxK3nqshn7QE0f4
oL2gxm0GSQIeohRQMO76vF5QkoX0ysnJBGc+6s1MkOQzI+DRGWoVtL5iGzDlvv5A
q+M1IjP5WdY7jVTbIgtnwbvYFgJuB1i5uBIFhUC9P15Q2UWoDud8TzPTBizHv8gx
IgIs/prnk2/xVGXPgqnHbZwIaTIYNw37YNiPH9WQQ98AGSjho11pjbOjj65++4G6
Vlz7g1xisYBp+Pyrk5TI3ImhBFuiAtw1SiR37RiVtD7RIKHbBInDjvWNrQ9h1rVR
ZMH+2uiszNMUELgAGrZ0N8aciUQfdwWLEwgVPLpIO5zhikvPsHI3/wMJNcVody3H
JenSSMGrKSwBYjrnlYPX
=icZ9
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

--===============6877988577622589495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6877988577622589495==--
