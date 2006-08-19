From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: 1.0.12rc3 (was: ALSA 1.0.12rc2)
Date: Sat, 19 Aug 2006 16:56:33 +0200
Message-ID: <20060819145633.GA3288@neu.nirvana>
References: <Pine.LNX.4.61.0608041600090.9118@tm8103-a.perex-int.cz>
	<20060809111319.GD31959@neu.nirvana> <s5hd5baducm.wl%tiwai@suse.de>
	<20060810152918.GA3148@neu.nirvana> <s5hac6cmtlb.wl%tiwai@suse.de>
Reply-To: ALSA development <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1205225392=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from junior.physik.fu-berlin.de (at1-old.physik.fu-berlin.de
	[160.45.32.86])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D5B1122D
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Aug 2006 16:56:36 +0200 (MEST)
In-Reply-To: <s5hac6cmtlb.wl%tiwai@suse.de>
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


--===============1205225392==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2006 at 06:41:20PM +0200, Takashi Iwai wrote:
> At Thu, 10 Aug 2006 17:29:18 +0200,
> Axel Thimm wrote:
> >=20
> > On Wed, Aug 09, 2006 at 01:25:13PM +0200, Takashi Iwai wrote:
> > > At Wed, 9 Aug 2006 13:13:19 +0200,
> > > Axel Thimm wrote:
> > > > On Fri, Aug 04, 2006 at 04:01:26PM +0200, Jaroslav Kysela wrote:
> > > > > 	1.0.12rc2 ALSA packages (except tools and oss - no changes) were=
=20
> > > > > released. The list of changes can be obtained here:
> > > >=20
> > > > I tried to build on several FC/RHEL platforms, there are some new
> > > > failures wrt rc1:
> > > >=20
> > > > a) all 2.4. kernel platforms (but probably more binutils related):
> > > >    Starting with pcm_oss.o it fails on assembly
> > > >=20
> > > > {standard input}:5744: Warning: rest of line ignored; first ignored=
 character is `"'
> > > > {standard input}:5745: Error: unknown pseudo-op: `.text.lock.'
> > >=20
> > > Does it happen with HG version?
> >=20
> > It now fails on
> >=20
> > In file included from ca0106_mixer.c:2:
> > ../../alsa-kernel/pci/ca0106/ca0106_mixer.c:499: unknown field `p' spec=
ified in initializer
>=20
> Is this with the same compiler?
> It's an initialization of union field.
>=20
> Possibly, initializing like
> 	.tlv =3D { .p =3D xxx }
> might work?

I tried it now said

In file included from ca0106_mixer.c:2:
=2E./../alsa-kernel/pci/ca0106/ca0106_mixer.c:499: unknown field `p' specif=
ied in initializer
=2E./../alsa-kernel/pci/ca0106/ca0106_mixer.c:499: warning: missing braces =
around initializer
=2E./../alsa-kernel/pci/ca0106/ca0106_mixer.c:499: warning: (near initializ=
ation for `snd_ca0106_volume_ctls[0].tlv')

Looks like I would need some extra {}, but I decided to drop binary
support for this release (RH7.3), so I can't test any further. Other,
newer, 2.4 platforms build fine.

Other than that a lot more builds, I only have the old (and minor)
issue with xenU/x86_64 "implicit declaration of function
'VMALLOC_VMADDR' problem". Even 2.6.18 close stuff (FC6) build
properly, thanks!
--=20
Axel.Thimm at ATrpms.net

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE5yahQBVS1GOamfERAp3uAKCA7gwwd9elXn3KqLIDI1WMrNMOcgCfS/+n
XgI9z9F2z4/3P3CW4Odk43A=
=q+ym
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--


--===============1205225392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1205225392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1205225392==--
