From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/8] ASoC: pcm: Refactor
 soc_pcm_apply_msb for multicodecs
Date: Tue, 1 Jul 2014 18:20:53 +0100
Message-ID: <20140701172053.GC15028@sirena.org.uk>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-3-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7397792909461775837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 14FFE2650EE
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 19:21:12 +0200 (CEST)
In-Reply-To: <1404200881-32253-3-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: misael.lopez@ti.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7397792909461775837==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 09:47:55AM +0200, Benoit Cousson wrote:
> Refactor the function to facilitate the migration to
> multiple codecs.

Applied, thanks.

> Fix a trailing space in the header as well.

Please don't do things like this if they're not in a part of the code
being changed, it makes review a bit harder.  A separate patch would be
fine.

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsu3yAAoJELSic+t+oim9I3cQAJdgopVTzJrfTDaN4SR9ZEPq
AmomesMGsu2Zm/UuQmyLOU6VVTmOmYkA9ye5mqkyOTOtDnT5+vxJLkbGqO7dci67
VVUXaQ+PU1yJ9pb28viTcVcHgJZtj/dcjkcP2+jkBQQIltCrClwBhrWYLojATzjm
TUOmG2c5FRj1mcGDK08bED4w0KMbBRWH2dptE3tbN0veI48EDL8jnhYyfUaV2XfX
DA52jinSIKog1vFQLpX0YyRKAYqiOix4nC5S8dqoR+MckT5zoSEXd5YoC/fJuzb3
3OwzW3gMAKup+SBefbfzszaWBoJ2IBvejN2TTuB6XjvKE4bb945CbBklx38pWC8o
+k2Aq7gk26P5nmv09zDeQS+iAu7S1lAPiYayDQeK5wRBx9qO/Na23Kx6JenG2dZ7
G4PmbEm60qOq4kcQwBcBc7AhqbaRIKd35eXpCgs+KDcxpQjDKLubXnWReTPo+HF4
w31wbHOcC2Ujmhme/Y/r/zqP8JMfDL6CU3IGLVJdsIjrCl+u8NDm65k47Ul8J+Hs
XE6l9vIK9VEC1ooms6f9RHxh018XO7czJrx48PCxrlfoF7P86Qi+AWhRwT14gTiR
XiPbFsikgAHCcQ2S4bEavNE7A8egudIqc7HgUC1VRnHeIFQ1YFiPPQxCnb4k04mY
d1KcYwxThDYUhxufK+y+
=3bHz
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

--===============7397792909461775837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7397792909461775837==--
