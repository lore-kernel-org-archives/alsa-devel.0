From: Ian Kumlien <pomac@vapor.com>
Subject: Re: [noise] The noise problem wrt Audigy 2 ZS
Date: Mon, 24 Oct 2005 11:00:51 +0200
Message-ID: <1130144451.10270.22.camel@localhost>
References: <1130080668.10270.3.camel@localhost>
	 <1130084827.11980.12.camel@mindpipe>  <1130112868.10270.11.camel@localhost>
	 <1130127531.16563.5.camel@mindpipe>
Reply-To: pomac@vapor.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Hc2S+c03suDxP3UTuXQi"
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1130127531.16563.5.camel@mindpipe>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Lee Revell <rlrevell@joe-job.com>
Cc: ALSA user list <alsa-user@lists.sourceforge.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-Hc2S+c03suDxP3UTuXQi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-10-24 at 00:18 -0400, Lee Revell wrote:
> Please make sure to cc: the ALSA lists.

Yeah, i only hit reply last time, =3DP

> On Mon, 2005-10-24 at 02:14 +0200, Ian Kumlien wrote:
> > On Sun, 2005-10-23 at 12:27 -0400, Lee Revell wrote:
> > > On Sun, 2005-10-23 at 17:17 +0200, Ian Kumlien wrote:
> > > > Hi,=20
> > > >=20
> > > > I have found a bunch of topics on this now:
> > > > Squealing / Buzzing / Static noise with EMU10k1 and Audigy 2 ZS
> > > > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1276
> > >=20
> > > How are you able to access this site at all?  bugtrack.alsa-project.o=
rg
> > > has been giving me "Connection refused" for days.
> >=20
> > It worked before, both from here and from a friends place...=20
> >=20
> > > Can you repost the text of the bug report?
> >=20
> > Someone else did.
> >=20
> > The interesting part of this is that it almost works for a while, if yo=
u
> > really work at it, you *can* get it to work sometimes. It feels like it
> > depends on where in the memory "things" are located, and by things i
> > mean either the kernel module or the app itself, i dunno which.
> >=20
> > You can also hear more or less of the actual sound with the noise,
> > sometimes you don't hear any of it and sometimes you hear some of it.
> >=20
>=20
> Hmm.  You mentioned this bug only occurs on 64 bit machines or with more
> than 1GB of memory.  Maybe it can only DMA into the first 1GB of memory
> or something.  Try this patch.

Yes, that seems to work, and the comment above should apply to both
cards i think =3D)

(i compiled a new version of rc2 with this patch and it just started
playing fine, now contact the others =3D)

> --- include/sound/emu10k1.h~	2005-10-11 12:31:42.000000000 -0400
> +++ include/sound/emu10k1.h	2005-10-24 00:14:40.000000000 -0400
> @@ -48,7 +48,7 @@
> =20
>  /* FIXME? - according to the OSS driver the EMU10K1 needs a 29 bit DMA m=
ask */
>  #define EMU10K1_DMA_MASK	0x7fffffffUL	/* 31bit */
> -#define AUDIGY_DMA_MASK		0xffffffffUL	/* 32bit */
> +#define AUDIGY_DMA_MASK		0x7fffffffUL	/* 32bit */
> =20
>  #define TMEMSIZE        256*1024
>  #define TMEMSIZEREG     4

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-Hc2S+c03suDxP3UTuXQi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBDXKLD7F3Euyc51N8RAoUiAJwMbEC13cd+FfcN+j27Q0QC9TIfYgCfTVvt
yFlHj4cB4My8vs93UqzoCxY=
=psVG
-----END PGP SIGNATURE-----

--=-Hc2S+c03suDxP3UTuXQi--



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
