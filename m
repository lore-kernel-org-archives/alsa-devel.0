From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: ALSA 1.0.12rc2
Date: Thu, 10 Aug 2006 17:33:22 +0200
Message-ID: <20060810153322.GC3148@neu.nirvana>
References: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
	<20060809111319.GD31959@neu.nirvana> <s5hd5baducm.wl%tiwai@suse.de>
	<20060810152918.GA3148@neu.nirvana>
Reply-To: ALSA development <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2011676453=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 94063184
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Aug 2006 17:33:25 +0200 (MEST)
In-Reply-To: <20060810152918.GA3148@neu.nirvana>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============2011676453==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2006 at 05:29:18PM +0200, Axel Thimm wrote:
> On Wed, Aug 09, 2006 at 01:25:13PM +0200, Takashi Iwai wrote:
> > At Wed, 9 Aug 2006 13:13:19 +0200,
> > Axel Thimm wrote:
> > > On Fri, Aug 04, 2006 at 04:01:26PM +0200, Jaroslav Kysela wrote:
> > > > 	1.0.12rc2 ALSA packages (except tools and oss - no changes) were=
=20
> > > > released. The list of changes can be obtained here:
> > >=20
> > > I tried to build on several FC/RHEL platforms, there are some new
> > > failures wrt rc1:
> > >=20
> > > a) all 2.4. kernel platforms (but probably more binutils related):
> > >    Starting with pcm_oss.o it fails on assembly
> > >=20
> > > {standard input}:5744: Warning: rest of line ignored; first ignored c=
haracter is `"'
> > > {standard input}:5745: Error: unknown pseudo-op: `.text.lock.'
> >=20
> > Does it happen with HG version?
>=20
> It now fails on
>=20
> In file included from ca0106_mixer.c:2:
> ../../alsa-kernel/pci/ca0106/ca0106_mixer.c:499: unknown field `p' specif=
ied in initializer
>=20
> or
>=20
> In file included from pcm32.c:5:
> pcm32_old.c: In function `snd_pcm_info_ioctl32':
> pcm32_old.c:521: structure has no member named `no_compat_mmap'

BTW this also makes 2.6.9/x86_64 fail which did build for 1.0.12rc2.

> or
>=20
> adriver.h:142:35: macro "might_sleep" passed 1 arguments, but takes just 0
>=20
>=20
> > > b) on 2.6.10/x86_64:
> > >=20
> > >   CC [M]  /builddir/alsa-driver-1.0.12rc2/acore/ioctl32/ioctl32.o
> > >   CC [M]  /builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32.o
> > > In file included from /builddir/alsa-driver-1.0.12rc2/acore/ioctl32/p=
cm32.c:16:
> > > /builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32_new.c: In functio=
n `snd_pcm_info_ioctl32':
> > > /builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32_new.c:409: error:=
 structure has no member named `no_mmap_ctrl'
> > > make[4]: *** [/builddir/alsa-driver-1.0.12rc2/acore/ioctl32/pcm32.o] =
Error 1
> >=20
> > OK, that's my failure.  The patch below should fix.
> > (applied to HG now.)
>=20
> Now it dies on
>=20
>   CC [M]  /builddir/alsa-driver-1.0.12-hg20060810/acore/ioctl32/pcm32.o
> In file included from /builddir/alsa-driver-1.0.12-hg20060810/acore/ioctl=
32/pcm32.c:16:
> /builddir/alsa-driver-1.0.12-hg20060810/acore/ioctl32/pcm32_new.c: In fun=
ction `snd_pcm_info_ioctl32':
> /builddir/alsa-driver-1.0.12-hg20060810/acore/ioctl32/pcm32_new.c:409: er=
ror: structure has no member named `no_compat_mmap'
>=20



> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


--=20
Axel.Thimm at ATrpms.net

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE21HCQBVS1GOamfERAgxCAJ4udSzPRkVR9TZWW5EsohZ+F9DOEACfXOK1
8JHYU7OvlPK1pQ0T1JxdIJ4=
=q5Zj
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--


--===============2011676453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2011676453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2011676453==--
