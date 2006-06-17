From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Status of pinnacle/fiji driver
Date: Sat, 17 Jun 2006 23:14:51 +0400
Message-ID: <20060617191451.GC14563@procyon.home>
References: <1147966154.12531.62.camel@mindpipe> <s5h64k32v9q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0257807189=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h64k32v9q.wl%tiwai@suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0257807189==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2006 at 05:43:45PM +0200, Takashi Iwai wrote:
> At Thu, 18 May 2006 11:29:14 -0400,
> Lee Revell wrote:
> >=20
> > Someone pointed out on IRC that this driver has bitrotted and doesn't
> > compile with recent kernels.
> >=20
> > alsa/alsa-driver-1.0.11/isa/msnd/msnd_pinnacle.c:117: error: expected )
> > before string constant
> >=20
> > I think it's due to use of MODULE_PARM which seems to have been removed?
>=20
> Already fixed on HG repo.

With this fix the driver seems to compile, but won't load because of
undefined symbols - trying to compile it for 2.6.17-rc6-git7 gives
these warnings:

  CC [M]  .../isa/msnd/msnd.o
=2E../isa/msnd/msnd.c: In function `snd_msnd_init_queue':
=2E../isa/msnd/msnd.c:134: warning: implicit declaration of function `isa_w=
ritew'
  CC [M]  .../isa/msnd/msnd_pinnacle.o
=2E../isa/msnd/msnd_pinnacle.c: In function `snd_msnd_play_reset_queue':
=2E../isa/msnd/msnd_pinnacle.c:166: warning: implicit declaration of functi=
on `isa_writew'
=2E../isa/msnd/msnd_pinnacle.c: In function `snd_msnd_DARQ':
=2E../isa/msnd/msnd_pinnacle.c:313: warning: implicit declaration of functi=
on `isa_readw'
=2E../isa/msnd/msnd_pinnacle.c: In function `snd_msnd_init_sma':
=2E../isa/msnd/msnd_pinnacle.c:623: warning: implicit declaration of functi=
on `isa_memset_io'
=2E../isa/msnd/msnd_pinnacle.c:670: warning: implicit declaration of functi=
on `isa_writel'
=2E../isa/msnd/msnd_pinnacle.c: In function `upload_dsp_code':
=2E../isa/msnd/msnd_pinnacle.c:720: warning: implicit declaration of functi=
on `isa_memcpy_toio'
  CC [M]  .../isa/msnd/msnd_pinnacle_mixer.o
=2E../isa/msnd/msnd_pinnacle_mixer.c: In function `snd_msndmix_set':
=2E../isa/msnd/msnd_pinnacle_mixer.c:204: warning: implicit declaration of =
function `isa_writeb'
=2E../isa/msnd/msnd_pinnacle_mixer.c:219: warning: implicit declaration of =
function `isa_writew'
=2E../isa/msnd/msnd_pinnacle_mixer.c:241: warning: implicit declaration of =
function `isa_readw'
  CC [M]  .../isa/msnd/msnd_midi.o
=2E../isa/msnd/msnd_midi.c: In function `snd_msndmidi_input_drop':
=2E../isa/msnd/msnd_midi.c:312: warning: implicit declaration of function `=
isa_readw'
=2E../isa/msnd/msnd_midi.c:313: warning: implicit declaration of function `=
isa_writew'

WARNING: "isa_memcpy_toio" [.../isa/msnd/snd-msnd-pinnacle.ko] undefined!
WARNING: "isa_memset_io" [.../isa/msnd/snd-msnd-pinnacle.ko] undefined!
WARNING: "isa_writeb" [.../isa/msnd/snd-msnd-pinnacle.ko] undefined!
WARNING: "isa_writel" [.../isa/msnd/snd-msnd-pinnacle.ko] undefined!
WARNING: "isa_writew" [.../isa/msnd/snd-msnd-pinnacle.ko] undefined!
WARNING: "isa_readw" [.../isa/msnd/snd-msnd-pinnacle.ko] undefined!

Apparently the isa_* functions were removed from kernel:

http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3D57f3ebccaa560d1eeb40b5c719773bed5cb0df46

> > I also notice that this driver is not in the kernel.  Could it be added?
> > It would allow the OSS driver to be deprecated.
>=20
> No, the driver code is too ugly to include to kernel tree.

Does someone really maintain this driver?

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFElFSrW82GfkQfsqIRAlFrAJwLIwk5Kt6c5/IwC2xWBZvV8wK9ngCfc/pt
Qg/EHAvdTjDFDN1asjCx+QY=
=JsAp
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--


--===============0257807189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0257807189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0257807189==--
