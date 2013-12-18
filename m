From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm_adsp: Change ADSPs to be
 mixer widgets rather the PGAs
Date: Wed, 18 Dec 2013 13:23:43 +0000
Message-ID: <20131218132343.GP28455@sirena.org.uk>
References: <1387364024-15708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20131218112739.GH28455@sirena.org.uk>
 <20131218131436.GE11138@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0128291061189285661=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E7FF4261663
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 14:23:46 +0100 (CET)
In-Reply-To: <20131218131436.GE11138@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0128291061189285661==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qUZ+4mk6dr19Czgg"
Content-Disposition: inline


--qUZ+4mk6dr19Czgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 01:14:36PM +0000, Charles Keepax wrote:
> On Wed, Dec 18, 2013 at 11:27:39AM +0000, Mark Brown wrote:

> > One of the issues here was trying to ensure that the DSP started up with
> > its inputs stable so noise from them starting didn't propagage into the
> > algorithm and confuse it.  The expecation with putting it as a PGA was
> > that it would start with the outputs mute and do a digital unmute to
> > bring them up.  Since everything is digital this should all be more
> > robust than it would be for analogue.

> Muting the output is a little tricky though as a graph walk will
> be required to determine which output was connected, unless you
> have any handy ideas I have not spotted? I will start having a
> look to see what could be done on the muting front.

Not the physical output, the DSP output into the rest of the device.  It
would be very surprising if it powered up making noise.

--qUZ+4mk6dr19Czgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsaHcAAoJELSic+t+oim9RDsP/3lY+rG0EWz0rpEHBZO2QoeD
PL91nllv1w+a3kWSbNHLDG+aCflzJFI1WoiwmBZETJkCV6LGrtv0BIgsV6hUpRwi
0CCZZAjNL6NGk0DzqP4fVGpyyDejTVA6N6K3q5WWczuP7Ton0i1zVwu2JM39A59w
K/ns4e08lijqpUoHFx45fFsQ+ienVG5Mb8lDtHtzPfuUDcbKXpenNaLxwKBVBaCu
fLVOkxX7sjHn9D6HlRc3pr3hzfshoaMcdcrLWOTi+h/Ge6RfHel+FnVQLsjg42ez
9m0Ze9at40Fa283mmWuspm9nmTBZsvQ7t8Qt38Tk0A7dJ6/7Yzyazze0zTi6t86W
r+1yD4HrWIfzhAZqOP/cQcDBOGsNL/WQ1x0zV6qjsMPXuXYZdssQnsJRzwt6017e
REmFVbCIEYyMOZ99CIwSk52pF0wDJsWak8Gq00ctisRkk+DqUqpaBLd8ATbHiMUO
TRbzrC5kaapBVPKDqaJnMPbpJqnZFZlqCeQdaoXm36ZuQrP+bkHnyJzATRnfmlut
ukPnAqpc4t3MMeVWP0SmZTuckO1XYnhAzNewhya/PTJAdQoe0UBqCrnDnxZHUNZn
ySg11eTLYVXfgjYyE47SbOK7CQWpBDc2+PIaPjn3eMOWWPKJLKGiERSvY9p2B7S+
70QTE7Wvk9Rb+DTSmrAo
=mSHa
-----END PGP SIGNATURE-----

--qUZ+4mk6dr19Czgg--

--===============0128291061189285661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0128291061189285661==--
