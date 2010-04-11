From: Ben Hutchings <ben@decadent.org.uk>
Subject: Bug#536896: linux-image-2.6.26-2-amd64: audio popping with gstreamer using apps when using amd64 kernel and i386 userspace
Date: Sun, 11 Apr 2010 21:25:16 +0100
Message-ID: <1271017516.6179.126.camel@localhost>
References: <20090714135754.4684.74223.reportbug@zarvora>
	 <20100225183435.GA8488@galadriel.inutil.org>
	 <alpine.DEB.1.10.1004120102110.24942@martello.ucc.gu.uwa.edu.au>
Reply-To: Ben Hutchings <ben@decadent.org.uk>, 536896@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-XMc7r54sWvfvpRsLtem3"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.536896.B536896.127101753910072@bugs.debian.org>
In-Reply-To: <alpine.DEB.1.10.1004120102110.24942@martello.ucc.gu.uwa.edu.au>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: James Andrewartha <trs80@ucc.gu.uwa.edu.au>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: 536896@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-XMc7r54sWvfvpRsLtem3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Earlier messages can be found at http://bugs.debian.org/536896 ]

On Mon, 2010-04-12 at 01:08 +0800, James Andrewartha wrote:
> On Thu, 25 Feb 2010, Moritz Muehlenhoff wrote:
>=20
> > On Tue, Jul 14, 2009 at 09:57:54PM +0800, James Andrewartha wrote:
> > > Package: linux-image-2.6.26-2-amd64
> > > Version: 2.6.26-17
> > > Severity: normal
> > >=20
> > > All audio from gstreamer-using apps (eg Totem and Banshee) pops when =
I use a
> > > 2.6.{25,26,28,30} amd64 kernel and i386 userspace. 2.6.24-etchnhalf.1=
-amd64
> > > does not have this problem, nor does 2.6.26-2-686. It doesn't occur w=
hen using
> > > non-gstreamer apps like mplayer or mpd, nor with various gst-launch p=
ipelines
> > > suggested by #gstreamer like gst-launch playbin uri=3Dfile:///home/tr=
s80/a.mp3
> >=20
> > Hi,
> > The next release of Debian (6.0, code name Squeeze) will be based
> > on 2.6.32. Please test the current 2.6.32 from unstable/testing and tel=
l
> > us whether the problem persists. If so, we should report it upstream
> > to the kernel.org developers.
> >=20
> > The 2.6.32 kernel is available from packages.debian.org and can
> > be installed in both Debian stable, testing and unstable
> > installations.
>=20
> I've bisected it, and the bad patch is 130755108ba03461f69da990e54e02a254=
accd23:

Thanks for taking the time to do this.

> Author: Takashi Iwai <tiwai@suse.de>  2008-01-09 02:08:14
> Committer: Jaroslav Kysela <perex@perex.cz>  2008-02-01 01:29:47
> Parent: d948035a928400ae127c873fbf771389bee18949 ([ALSA] Remove PCM xfer_=
align sw params)
>=20
>     [ALSA] PCM - clean up snd_pcm_lib_read/write
>    =20
>     Introduce a common helper function for snd_pcm_lib_read and snd_pcm_l=
ib_write
>     for cleaning up the code.
>    =20
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>=20
> I don't know anything about this code, but I'm happy to deal with upstrea=
m=20
> if you'd prefer me to.

The above commit is supposed to be cleanup, but it has at least one
semantic change: snd_pcm_mmap_control::avail_min no longer applies to
non-blocking file handles.  I don't know whether this is was an
intentional or unintentional change, but it wasn't commented.  I also
don't know whether this can explain the popping, but I expect that it
has changed the timing of audio I/O.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-XMc7r54sWvfvpRsLtem3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUAS8IwF+e/yOyVhhEJAQL9QA//ZOdCgteToMvHBIzv/xl69EvBnDl48IGf
QXkd5+SV8zOSfQ5jMdP0o7V4Trv8sTGHggKHmx4wm0dnW7HamjFc001nOLyCKy82
gvUzHBCu5+HuysZRny7H844KttrM1zrNxYXYCf2Yjhd9vL3PnKabyc26+AxYHyCZ
C2o4Z88KCFUyTGQrRZvaY7CqF4SDyu5c1uTiNRKrxlMKC/g8xReLvUYwSK2CS3VO
BHeH8X6A1jS3Pulpqm1KqcCzWstdPJNASbrwRmBjhbEW26HhnPJzTek64jO/db2l
7JQk01+lP0DaqVYmRjTlIsTr1rjgXh1h3BdNEutdVowjsnzt5veQJXgeHEveB8RZ
YY/rt+IzIofG1AfnmYQK5oGjKmurrSnH4hV4K8VjD1smXfuOJ8ZLnzuWY+Cfi2MM
Gr6VNx9cP1ool9a4Y915rU/YxNBCcqcm531222Vi5oIh6z37tIAh2ji8TXooM3dv
cHMpL0k0io8/OGMoSXb4yW87FWHIXnkzDqgjgyiWTn1rV38/UECLRrR+rBguHBld
b9iKY38u8cP6NsuCN4jtvvX/ksjQndkBzbXE65MwXK94NrJMNGTRgU4WuR2xrtlD
yoab/ZJHpUdYXd85VHxkIfJcxznNcYFlYroLz274LDfPSoxxNIAOgr1t4sUe8cDc
6qfeW8F1/JU=
=82gh
-----END PGP SIGNATURE-----

--=-XMc7r54sWvfvpRsLtem3--
