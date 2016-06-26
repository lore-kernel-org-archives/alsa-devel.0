From: Baptiste Jonglez <baptiste@bitsofnetworks.org>
Subject: Re: Assertion failure in alsa-lib crashing
 applications (snd_pcm_area_copy: Assertion `dst < src || dst >= src +
 bytes' failed)
Date: Sun, 26 Jun 2016 20:28:32 +0200
Message-ID: <20160626182832.GA29321@lud.polynome.dn42>
References: <20160607172935.GC25444@lud.polynome.dn42>
 <20160614210221.GB5107@lud.polynome.dn42>
 <20160614223939.GB3039@lud.polynome.dn42>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4526247832273221895=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mails.bitsofnetworks.org (rezine.polyno.me [193.33.56.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 9287C2619D8
 for <alsa-devel@alsa-project.org>; Sun, 26 Jun 2016 20:28:35 +0200 (CEST)
Received: from rev-140-155.legacytubes.illyse.net ([89.234.140.155]
 helo=lud.polynome.dn42) by mails.bitsofnetworks.org with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.84_2)
 (envelope-from <baptiste@bitsofnetworks.org>) id 1bHEnK-00041E-OS
 for alsa-devel@alsa-project.org; Sun, 26 Jun 2016 20:28:34 +0200
In-Reply-To: <20160614223939.GB3039@lud.polynome.dn42>
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


--===============4526247832273221895==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Is there anything else I can provide to help getting this issue fixed?

The main issue is that snd_pcm_area_copy() gets called with overlapping
source and destination buffers, which triggers this assertion before a
memcpy:

  http://git.alsa-project.org/?p=3Dalsa-lib.git;a=3Dblob;f=3Dsrc/pcm/pcm.c;=
h=3D0d0d093deb49f2db7d207b29b728df372cce84bc;hb=3DHEAD#l2762

This happens when the system is really loaded (CPU-wise).

Do you think the problem is likely to come from an incorrect API usage
=66rom the application?  Knowing this would significantly narrow down the
search, because the problem could also come from within alsa itself.

The callling code from the application is quite complex, see here:

  https://github.com/savoirfairelinux/ring-daemon/blob/master/src/media/aud=
io/alsa/alsalayer.cpp

In particular, the assertion is triggered by the call to
snd_pcm_avail_update() at line 694 (see the stack trace below).

Thanks,
Baptiste

On Wed, Jun 15, 2016 at 12:39:39AM +0200, Baptiste Jonglez wrote:
> On Tue, Jun 14, 2016 at 11:02:21PM +0200, Baptiste Jonglez wrote:
> > Hi,
> >=20
> > On Tue, Jun 07, 2016 at 07:29:35PM +0200, Baptiste Jonglez wrote:
> > > When using Ring [1], an audio-video application, it sometimes crashes
> > > because of an assertion in libasound.so:
> > >=20
> > >     pcm.c:2758: snd_pcm_area_copy: Assertion `dst < src || dst >=3D s=
rc + bytes' failed.
> > >=20
> > > The complete upstream bug report is at [2].  The (not-so-useful) stack
> > > trace is the following:
> > >=20
> > > <snip>
> > >=20
> > > The next time it crashes, I will have debug symbols in dring.  I can =
also
> > > recompile alsa-lib with debug symbols, what is the best way to do tha=
t?
> >=20
> > As promised, here is a new stack trace with debug symbols:
> >
> > <snip>
>=20
> Sorry, this stack trace still had some arguments optimised out.  Here is
> the stack trace without optimisation:
>=20
> #0  0x00007f42a8696295 in raise () from /usr/lib/libc.so.6
> #1  0x00007f42a86976da in abort () from /usr/lib/libc.so.6
> #2  0x00007f42a868f297 in __assert_fail_base () from /usr/lib/libc.so.6
> #3  0x00007f42a868f342 in __assert_fail () from /usr/lib/libc.so.6
> #4  0x00007f42ad7463da in snd_pcm_area_copy (dst_area=3D0x7f4290ced250, d=
st_offset=3D144, src_area=3D0x7f4290ced260, src_offset=3D0, samples=3D0, fo=
rmat=3DSND_PCM_FORMAT_S32_LE)
>     at pcm.c:2758
> #5  0x00007f42ad746918 in snd_pcm_areas_copy (dst_areas=3D0x7f427c000e90,=
 dst_offset=3D72, src_areas=3D0x7f427c000e90, src_offset=3D0, channels=3D2,=
 frames=3D1904,=20
>     format=3DSND_PCM_FORMAT_S32_LE) at pcm.c:2904
> #6  0x00007f42ad79cb66 in softvol_convert_stereo_vol (svol=3D0x7f427c02f5=
00, dst_areas=3D0x7f427c000e70, dst_offset=3D72, src_areas=3D0x7f427c000e70=
, src_offset=3D0,=20
>     channels=3D2, frames=3D1904) at pcm_softvol.c:291
> #7  0x00007f42ad79e081 in snd_pcm_softvol_read_areas (pcm=3D0x7f427c03108=
0, areas=3D0x7f427c000e70, offset=3D72, size=3D1904, slave_areas=3D0x7f427c=
000e70, slave_offset=3D0,=20
>     slave_sizep=3D0x7f4290ced408) at pcm_softvol.c:630
> #8  0x00007f42ad75e367 in snd_pcm_plugin_avail_update (pcm=3D0x7f427c0310=
80) at pcm_plugin.c:490
> #9  0x00007f42ad745c3e in snd_pcm_avail_update (pcm=3D0x7f427c031080) at =
pcm.c:2508
> #10 0x00007f42ad75e214 in snd_pcm_plugin_avail_update (pcm=3D0x7f427c02fc=
70) at pcm_plugin.c:460
> #11 0x00007f42ad745c3e in snd_pcm_avail_update (pcm=3D0x7f427c02faa0) at =
pcm.c:2508
> #12 0x00000000005486d4 in ring::AlsaLayer::capture (this=3D0x1978220) at =
alsalayer.cpp:694
> #13 0x0000000000545de4 in ring::AlsaThread::run (this=3D0x19706f0) at als=
alayer.cpp:137
>=20
> Attached is a full stack trace with local variables.  I can provide the
> core dump privately.
>=20
> Also note that this happens when the application is under high CPU
> pressure (for instance other programs with higher priority are using all
> available CPU cores).
>=20
> The calling code into the lib is here, when capturing from a device:
>=20
>   https://github.com/savoirfairelinux/ring-daemon/blob/master/src/media/a=
udio/alsa/alsalayer.cpp#L694
>=20
> Baptiste
>=20
> > Is there anything in there that could explain the assertion failure?
> > Perhaps a wrong API usage?
> >=20
> > Thanks,
> > Baptiste
> >=20
> > >=20
> > > Looking around, it seems other projects have run into the same issue:
> > >=20
> > >     https://aur.archlinux.org/packages/ultrastardx-git/?comments=3Dal=
l#comment-435458
> > >     https://aur.archlinux.org/packages/zoom/#comment-544696
> > >     http://ubuntuforums.org/showthread.php?t=3D2248373
> > >     https://github.com/js-platform/node-webrtc/issues/110
> > >     https://fedorahosted.org/fldigi/ticket/70
> > >=20
> > > The output of the alsa-info.sh script on my system is at [3].
> > > What else can I provide to debug this issue further?
> > >=20
> > > Thanks,
> > > Baptiste
> > >=20
> > > [1] https://ring.cx
> > > [2] https://tuleap.ring.cx/plugins/tracker/?aid=3D502
> > > [3] http://www.alsa-project.org/db/?f=3D0dd2ba1021b3d535f30f07c55dc18=
e2ef60db26d
> >=20
> >=20
> >=20
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >=20
>=20
>=20
>=20
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20

> d7463da in snd_pcm_area_copy (dst_area=3D0x7f4290ced250, dst_offset=3D144=
, src_area=3D0x7f4290ced260, src_offset=3D0, samples=3D0, format=3DSND_PCM_=
FORMAT_S32_LE)
>     at pcm.c:2758
>         bytes =3D 15232
>         src =3D 0x7f427c0316b0 ""
>         dst =3D 0x7f427c0318f0 ""
>         width =3D 32
>         src_step =3D 32578
>         dst_step =3D -1865493936
>         __PRETTY_FUNCTION__ =3D "snd_pcm_area_copy"
>         __FUNCTION__ =3D "snd_pcm_area_copy"
> #5  0x00007f42ad746918 in snd_pcm_areas_copy (dst_areas=3D0x7f427c000e90,=
 dst_offset=3D72, src_areas=3D0x7f427c000e90, src_offset=3D0, channels=3D2,=
 frames=3D1904,=20
>     format=3DSND_PCM_FORMAT_S32_LE) at pcm.c:2904
>         s =3D {addr =3D 0x7f427c0316b0, first =3D 0, step =3D 32}
>         d =3D {addr =3D 0x7f427c0316b0, first =3D 0, step =3D 32}
>         step =3D 64
>         src_addr =3D 0x7f427c0316b0
>         src_start =3D 0x7f427c000e70
>         channels1 =3D 0
>         chns =3D 2
>         dst_addr =3D 0x7f427c0316b0
>         dst_start =3D 0x7f427c000e70
>         width =3D 32
>         __PRETTY_FUNCTION__ =3D "snd_pcm_areas_copy"
>         __FUNCTION__ =3D "snd_pcm_areas_copy"
> #6  0x00007f42ad79cb66 in softvol_convert_stereo_vol (svol=3D0x7f427c02f5=
00, dst_areas=3D0x7f427c000e70, dst_offset=3D72, src_areas=3D0x7f427c000e70=
, src_offset=3D0,=20
>     channels=3D2, frames=3D1904) at pcm_softvol.c:291
>         dst_area =3D 0x7f427c02f560
>         src_area =3D 0x7f427c031380
>         src_step =3D 32578
>         dst_step =3D 2909997239
>         vol_scale =3D 32578
>         vol =3D {2429473552, 1}
>         vol_c =3D 2080568576
> #7  0x00007f42ad79e081 in snd_pcm_softvol_read_areas (pcm=3D0x7f427c03108=
0, areas=3D0x7f427c000e70, offset=3D72, size=3D1904, slave_areas=3D0x7f427c=
000e70, slave_offset=3D0,=20
>     slave_sizep=3D0x7f4290ced408) at pcm_softvol.c:630
>         svol =3D 0x7f427c02f500
> #8  0x00007f42ad75e367 in snd_pcm_plugin_avail_update (pcm=3D0x7f427c0310=
80) at pcm_plugin.c:490
>         frames =3D 1904
>         cont =3D 1976
>         slave_frames =3D 2048
>         err =3D 0
>         slave_areas =3D 0x7f427c000e70
>         slave_offset =3D 0
>         result =3D 72
>         areas =3D 0x7f427c000e70
>         xfer =3D 144
>         hw_offset =3D 72
>         size =3D 1904
>         plugin =3D 0x7f427c02f500
>         slave =3D 0x7f427c030640
>         slave_size =3D 2472
> #9  0x00007f42ad745c3e in snd_pcm_avail_update (pcm=3D0x7f427c031080) at =
pcm.c:2508
> No locals.
> #10 0x00007f42ad75e214 in snd_pcm_plugin_avail_update (pcm=3D0x7f427c02fc=
70) at pcm_plugin.c:460
>         plugin =3D 0x7f427c031310
>         slave =3D 0x7f427c031080
>         slave_size =3D 9255600
> #11 0x00007f42ad745c3e in snd_pcm_avail_update (pcm=3D0x7f427c02faa0) at =
pcm.c:2508
> No locals.
> #12 0x00000000005486d4 in ring::AlsaLayer::capture (this=3D0x1978220) at =
alsalayer.cpp:694
>         mainBufferFormat =3D {sample_rate =3D 48000, nb_channels =3D 2, s=
tatic DEFAULT_SAMPLE_RATE =3D 48000}
>         toGetFrames =3D 32578
>         framesPerBufferAlsa =3D 5540553
> #13 0x0000000000545de4 in ring::AlsaThread::run (this=3D0x19706f0) at als=
alayer.cpp:137
> No locals.
> d7463da in snd_pcm_area_copy (dst_area=3D0x7f4290ced250, dst_offset=3D144=
, src_area=3D0x7f4290ced260, src_offset=3D0, samples=3D0, format=3DSND_PCM_=
FORMAT_S32_LE)
>     at pcm.c:2758
>         bytes =3D 15232
>         src =3D 0x7f427c0316b0 ""
>         dst =3D 0x7f427c0318f0 ""
>         width =3D 32
>         src_step =3D 32578
>         dst_step =3D -1865493936
>         __PRETTY_FUNCTION__ =3D "snd_pcm_area_copy"
>         __FUNCTION__ =3D "snd_pcm_area_copy"
> #5  0x00007f42ad746918 in snd_pcm_areas_copy (dst_areas=3D0x7f427c000e90,=
 dst_offset=3D72, src_areas=3D0x7f427c000e90, src_offset=3D0, channels=3D2,=
 frames=3D1904,=20
>     format=3DSND_PCM_FORMAT_S32_LE) at pcm.c:2904
>         s =3D {addr =3D 0x7f427c0316b0, first =3D 0, step =3D 32}
>         d =3D {addr =3D 0x7f427c0316b0, first =3D 0, step =3D 32}
>         step =3D 64
>         src_addr =3D 0x7f427c0316b0
>         src_start =3D 0x7f427c000e70
>         channels1 =3D 0
>         chns =3D 2
>         dst_addr =3D 0x7f427c0316b0
>         dst_start =3D 0x7f427c000e70
>         width =3D 32
>         __PRETTY_FUNCTION__ =3D "snd_pcm_areas_copy"
>         __FUNCTION__ =3D "snd_pcm_areas_copy"
> #6  0x00007f42ad79cb66 in softvol_convert_stereo_vol (svol=3D0x7f427c02f5=
00, dst_areas=3D0x7f427c000e70, dst_offset=3D72, src_areas=3D0x7f427c000e70=
, src_offset=3D0,=20
>     channels=3D2, frames=3D1904) at pcm_softvol.c:291
>         dst_area =3D 0x7f427c02f560
>         src_area =3D 0x7f427c031380
>         src_step =3D 32578
>         dst_step =3D 2909997239
>         vol_scale =3D 32578
>         vol =3D {2429473552, 1}
>         vol_c =3D 2080568576
> #7  0x00007f42ad79e081 in snd_pcm_softvol_read_areas (pcm=3D0x7f427c03108=
0, areas=3D0x7f427c000e70, offset=3D72, size=3D1904, slave_areas=3D0x7f427c=
000e70, slave_offset=3D0,=20
>     slave_sizep=3D0x7f4290ced408) at pcm_softvol.c:630
>         svol =3D 0x7f427c02f500
> #8  0x00007f42ad75e367 in snd_pcm_plugin_avail_update (pcm=3D0x7f427c0310=
80) at pcm_plugin.c:490
>         frames =3D 1904
>         cont =3D 1976
>         slave_frames =3D 2048
>         err =3D 0
>         slave_areas =3D 0x7f427c000e70
>         slave_offset =3D 0
>         result =3D 72
>         areas =3D 0x7f427c000e70
>         xfer =3D 144
>         hw_offset =3D 72
>         size =3D 1904
>         plugin =3D 0x7f427c02f500
>         slave =3D 0x7f427c030640
>         slave_size =3D 2472
> #9  0x00007f42ad745c3e in snd_pcm_avail_update (pcm=3D0x7f427c031080) at =
pcm.c:2508
> No locals.
> #10 0x00007f42ad75e214 in snd_pcm_plugin_avail_update (pcm=3D0x7f427c02fc=
70) at pcm_plugin.c:460
>         plugin =3D 0x7f427c031310
>         slave =3D 0x7f427c031080
>         slave_size =3D 9255600
> #11 0x00007f42ad745c3e in snd_pcm_avail_update (pcm=3D0x7f427c02faa0) at =
pcm.c:2508
> No locals.
> #12 0x00000000005486d4 in ring::AlsaLayer::capture (this=3D0x1978220) at =
alsalayer.cpp:694
>         mainBufferFormat =3D {sample_rate =3D 48000, nb_channels =3D 2, s=
tatic DEFAULT_SAMPLE_RATE =3D 48000}
>         toGetFrames =3D 32578
>         framesPerBufferAlsa =3D 5540553
> #13 0x0000000000545de4 in ring::AlsaThread::run (this=3D0x19706f0) at als=
alayer.cpp:137
> No locals.
>=20




> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXcB7LAAoJEL4B7CKgTi5GQC4P/0xEfBbepKzMc4njDmFjpmwp
vIUOfZm965u8CH0uS3l/DA3mylUiFUBti9EcP+mQa2o3Uk5DW3iGOiThBw2yxYml
4/QV/R+a2Sh2YJWgKUjmv9iEM++yL+EaFpQevT6pR7V7+p+i6aEP0kz90RvQUnyJ
Vr5cRjRLqN+3O8hZ9sFJMozWcUyaZa9sp2uaudAfAa3KLAPFDrIHehn1CmxA1OOB
nEab5i0OjamD5lHToz6N6Xkd8dgp0Hz8cSTfR57VUexF2rJk3v/0BE/Yw8k3ZsKV
aaoPdstFw/ZvutRslOxvbnieEbGPiclb40s7L2COaRZyfdwu4jNtHbEniGqGvevT
uNtYIUgCYgCfi8Ct19F/SQBYKo5pXmrn6FlNdEARMAURUyOd0+SyjcDvkq0A60eF
mSg1FW4ti+vdPYu5skQuMvRMdedf8G5Qb3ngwkf5EOEfvYNyYutBNcSaNVVzPg8d
OHIwbwNapJpNXaRKmFpdMZrETEplbdLTBScYYOs43ANQIHjZS4URDxlU7VOuYquA
8DDifqT1bXt5KUuq9uQcwVX2Vv37DxUOgbyhylK+6NT1d6TAL09oC1VzXFImp2Uw
xuerAAavbtjlu/yJBaSxRR0zWXtOZxFsF/1KQGUcBFO4vvHT0Whb/fDA7AuqrmBS
dr/KOm7I15xcSROQcl58
=YFGh
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

--===============4526247832273221895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4526247832273221895==--
