From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l51: split i2c from codec driver
Date: Wed, 16 Apr 2014 00:58:17 +0100
Message-ID: <20140415235817.GO12304@sirena.org.uk>
References: <1397594973-6947-1-git-send-email-brian.austin@cirrus.com>
 <20140415225829.GM12304@sirena.org.uk>
 <C1EB06C9-0C0D-4443-9715-61F10C95FA8A@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4192203326284628989=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 565DD260859
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 01:58:30 +0200 (CEST)
In-Reply-To: <C1EB06C9-0C0D-4443-9715-61F10C95FA8A@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============4192203326284628989==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0Wg1ddIY7KV0vpwL"
Content-Disposition: inline


--0Wg1ddIY7KV0vpwL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 15, 2014 at 11:25:41PM +0000, Austin, Brian wrote:
> > On Apr 15, 2014, at 17:58, "Mark Brown" <broonie@kernel.org> wrote:

> > Applied, thanks but there was some fuzz applying - please check it came
> > out OK and that you were submitting against current code.

> Thanks, it was based off of topic/cs42l51. I'll check it now

Oh, that explains it.  Until I applied that patch there was no
topic/cs42l51 - when Linus merges a branch I delete it and then start a
new branch for any new work based off one of his -rcs (or another topic
branch if there's a dependency).  Your copy of the branch will have been
pre-merge window.  Since the merge window closed I'd deleted the old
topic branch, the fuzz will have been due to some subsystem wide patches
getting merged in.

--0Wg1ddIY7KV0vpwL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTceWAAoJELSic+t+oim98rEP/RxlkOm1NOvubgDNsw7Gfe7a
swN3eQbYDYVRLhQi2XcoQPM3PEhYnCy1XQtfOBlNowgbeyqLa7Yuip3g2RlS7JN6
1vygTfuNJd36o/YBXxzvDViE2eXABFt6fWFYUGOFFexr5VQv1d0iSNf1ctIJpwzz
kBU7RVDy7ZeNgcLkPkLasVTOf1uHkGYIqodQhqmcza+e7SkRXyFlIvLvqv7uPfFb
w3hw0JEOTUYKHbeBxk4CBnsCGhIgyi4LkyqdGEO79woKFS1IQRESCff+ywRmBWnD
MedfwvccI0v++9/aSQTybr+4DcI6Gh9RaZX8IGMTbDW/zUNISKuyNIEA1NjRAy4K
kNgLKM3M44I6ahlmsRZrBkzO8/LDfFWbiHbkAEmtCsYu4J1SnYm1QdA9Rd5abVsm
UUoZteR9mGguUI7Wcv9WyeuHLWiNKftaGUSiwVRDavRVnJwl0iO/ZKZF5xdtXYMJ
lx23qoQYASAfQ5x3g7hP4BkIzzHzGps5/uqZmjOMFBydtGQYUjbkSeCQirt2MuMG
q016+4YYOTYuxL1XLwShDIcAmFHHahKu/x+s/UWG+u/OZiwr7rsskYu5RmVDxBNF
xUQuw9BflD/iRza9TUMBPgVysw/zP5Vl2ctUYLEuF7+PqP0AHV2EVm4/93teBbRD
m5Px6eu2VDvVNPNBvqvQ
=6lpd
-----END PGP SIGNATURE-----

--0Wg1ddIY7KV0vpwL--

--===============4192203326284628989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4192203326284628989==--
