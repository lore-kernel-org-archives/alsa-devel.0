From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: Add driver for CLPS711X DAI
	interface
Date: Thu, 1 May 2014 12:01:02 -0700
Message-ID: <20140501190102.GW3245@sirena.org.uk>
References: <1397283328-633-1-git-send-email-shc_work@mail.ru>
 <20140501182935.GT3245@sirena.org.uk>
 <1398970472.345896645@f415.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0002984125041286693=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0224C265351
 for <alsa-devel@alsa-project.org>; Thu,  1 May 2014 21:02:23 +0200 (CEST)
In-Reply-To: <1398970472.345896645@f415.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Olof Johansson <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org


--===============0002984125041286693==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yOm7aJZpkJT4p9Qu"
Content-Disposition: inline


--yOm7aJZpkJT4p9Qu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 10:54:32PM +0400, Alexander Shiyan wrote:
> Thu, 1 May 2014 11:29:35 -0700 =D0=BE=D1=82 Mark Brown <broonie@kernel.or=
g>:

> > This machinery seems pretty much identical to the FIQ code for i.MX -
> > I know you don't think anything can be shared but can you please be more
> > explicit about why?  The contents of the FIQ are different but the
> > start and stop mechanics don't look so different (and given that the
> > general idea of what they do is very similar this isn't surprising to
> > me).

> That is, you really want to make some common code for this?

Well, I'd like to understand why we're not doing common code in more
detail - it's pretty fiddly and detailed stuff to be cut'n'pasting.  On
the other hand if it looks horrible to do that then perhaps that's
actually the best way to go.  Either factor it out or give a bit more
detail on why that's not the way forwards.

> OK, I will review this again, but where do you think it should be located?

A file in sound/soc (soc-pcm-fiq.c or something) perhaps?

--yOm7aJZpkJT4p9Qu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYpnrAAoJELSic+t+oim96CEP/1gUwpC5Mt8c92yJsweLhD8C
MA9b2uMBmY1jxvyfAkb4kzwWcXIJMJ5LnC/Mu5UXOI0o5D5OX+ivtOlL2rnDs3/V
zHizsCnFIlPp4OT/ADIph4puiLl2xsQdUkzBW92/x8VUsn2+urKYfbSlFObffCuY
pSEW+09L9aYlWPoCGtCMYtHXG5O9clnXfIavTjPSWYoQ8ArHZWF8h/bH2vd6dJdP
YZzE4Pa0aw1B/DZmdrLeLvJIMtLk0FHJyWYYgrXFWamcQwo8AOkU4GdDQSU6qURl
xBrA/3OW1JrLv1XoZZXlArMvYAWb4S300cqVGrw+qtAPZDDiDdMR8tf10ig8eY4F
RFoTp+DMkblAk70PSGzqli80BzD9ZInc1jNLFS6Ymdk2fHP0j9InT4WQupoczpLZ
FfqytJunLupoD7I278TxE2nk/z1EM6mZAOQ9rWfO1KwQ45ojA/8mCWNZsInj7bdU
tsP66InESv4uL7V9Nv9RivuyMC5FitIZYe4XBUjt9XB3YecsH1gVitKPkk6wS/mF
nhYp5yEqdXS7y9NSQ1nvWvBox0lmJO6HFOLxszml3hGfHMZA9NJINYTteXYpmBeJ
YG/+CJ4bkaehDypgRlaebBolgCfoEG18cN0rwj3Dr8DcmfsQO851+Q7q4kj9DC2p
LV3RyG5xJ2+V26t6VbT6
=vS5A
-----END PGP SIGNATURE-----

--yOm7aJZpkJT4p9Qu--

--===============0002984125041286693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0002984125041286693==--
