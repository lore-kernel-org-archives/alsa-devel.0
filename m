From: Jordi Mallach <jordi@debian.org>
Subject: Bug#663090: [Pkg-alsa-devel] Bug#663090: [alsa-devel] amixer: convert percentage into db wrongly
Date: Fri, 9 Mar 2012 22:48:14 +0100
Message-ID: <20120309214814.GA11406@aigua.oskuro.net>
References: <20120308123632.GA8920@adam-laptop>
 <20120308163001.GA2991@samweis.home.lxtec.de>
 <s5h399jyrc5.wl%tiwai@suse.de>
 <20120309042247.GE2130@adam-station.nay.redhat.com>
 <s5haa3qnup0.wl%tiwai@suse.de>
 <20120309090717.GG2130@adam-station.nay.redhat.com>
 <s5hty1ym898.wl%tiwai@suse.de>
 <20120309100617.GH2130@adam-station.nay.redhat.com>
 <s5hmx7qxb40.wl%tiwai@suse.de>
Reply-To: Jordi Mallach <jordi@debian.org>, 663090@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.663090.B663090.13313297085455@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <s5hmx7qxb40.wl%tiwai@suse.de>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Takashi Iwai <tiwai@suse.de>, 663090@bugs.debian.org
Cc: Adam Lee <adam8157@gmail.com>, Vincent Cheng <Vincentc1208@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Takashi,

On Fri, Mar 09, 2012 at 12:33:19PM +0100, Takashi Iwai wrote:
> The implementation isn't too hard.  I wrote a quick patch now as below.
> It became bigger than I thought since it contains many clean-ups that
> are needed to adapt the mapped volume.
>=20
> With the patch, amixer shows and reads the percent value with -M
> option just like in alsamixer.

I see this isn't in git.a-p.org yet. If you are considering adding it for
1.0.26, I'll cherry-pick it to make Adam's life easier. :)

Indeed, quite a big patch. Thanks for that!

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9aep4ACgkQJYSUupF6Il6uqgCdFLEC/iE1HKp68pke6CaWl0Ql
YFcAnj0OBoAr8tejo97hBOOIEUqjeJy3
=qlUP
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
