From: Mike Frysinger <vapier@gentoo.org>
Subject: Re:
 =?iso-8859-1?q?1=2E0=2E13rc3=3A_relocation_error=3A_?=
 =?iso-8859-1?q?mocp=3A_symbol=09snd=5Fpcm=5Fhw=5Fparams=5Fget=5Fchannels?=
 =?iso-8859-1?q?=5Fmin_=2E=2E?=
Date: Thu, 28 Sep 2006 15:33:01 -0400
Message-ID: <200609281533.02170.vapier@gentoo.org>
References: <20060926201319.GA3067@samweis.home.lxtec.de>
	<1159469533.7086.51.camel@mindpipe>
	<20060928191513.GC2855@samweis.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0552199634=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060928191513.GC2855@samweis.home.lxtec.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org

--===============0552199634==
Content-Type: multipart/signed; boundary="nextPart2076147.YEr3hJHsPM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2076147.YEr3hJHsPM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 28 September 2006 15:15, Elimar Riesebieter wrote:
> On Thu, 28 Sep 2006 the mental interface of Lee Revell told:
> > On Thu, 2006-09-28 at 20:44 +0200, Elimar Riesebieter wrote:
> > > --enable--shared=3Dno \
> >
> > Was this typo pasted from your actual build script?
>
> Why is that a typo?

you have too many dashes in there

and the point here is to check out versioned symbols in the shared library;=
=20
symbol versioning has no value in static libraries
=2Dmike

--nextPart2076147.YEr3hJHsPM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRwjbkFjO5/oN/WBAQLlnBAAlNOc+y9/Q4P7jSBILqqGCfVmRXDZKLdJ
TrEhmjavVZIzJ6gkfvV4if4dBfIeq9Wpan/LNSLcTFu1tAKtLC4uLy+1Rylb4tY5
OpA8PXMmCo/xL3Q1bnTR+ICg1qG9PtsKvXG9ROH8/ZaU5kd4FJZvwbB2ZU0kWEW+
Dbv5ct3kzNUSG5JFN64sKx95BForzPKBEkR6/ih3L6lTHPUvEFgWbGnKQX7N6O3s
hjvtrrgW4NrrU672IdwYs/vMYA5Kj5bTORK0qB2pCe/gxQmKePzCFeAqePqPA20u
o8NNS/4JY+SrHWa+zCPeizHYftVAeb2q0S9TQcFFi5KXuYymsBqlLDjyTqV9x8Zs
aA1xUlyNcg1TyQ606QZYb2Cfnbp846UHekqdXfRjP/V9pK7NebYGd6l+ueac9wqj
cmvNkBN+3bWPFpfSg61xZj+SQ6xC1kPLPg9S9qfXqjD7BCJb8EebETrgRqnTWPx0
UivxExs+MIfVGQIPOYKjuzsXXbYAxM1TQ0bIFYYk6IJ3YcGjkr2/X9l3Hw7bZ471
Xe0qtB9/QiZVTR6szNVaLsyRpSu4tLOHBjXnA/aepLynU1D3++D74npyMLLHD/Ft
y+gM5PQdnRyLeOZiN/fj3beWC3MoPS38MZjNQVS/9u1aIpb8qRrjSbLNqlKEJlCV
lhO0idJeCls=
=bZFv
-----END PGP SIGNATURE-----

--nextPart2076147.YEr3hJHsPM--


--===============0552199634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0552199634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0552199634==--
