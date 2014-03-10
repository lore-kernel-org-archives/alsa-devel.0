From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v3.14
Date: Mon, 10 Mar 2014 18:23:09 +0000
Message-ID: <20140310182309.GC28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7573869740176773759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DFBFA2657CF
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 19:23:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7573869740176773759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fnNg3ex06DkJ0Ygf"
Content-Disposition: inline


--fnNg3ex06DkJ0Ygf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fa389e220254c69ffae0d403eac4146171062d08:

  Linux 3.14-rc6 (2014-03-09 19:41:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.14-rc6

for you to fetch changes up to 7f35afd44b14a39307757629ebc0a199aade52d9:

  Merge remote-tracking branches 'asoc/fix/88pm860', 'asoc/fix/omap' and 'asoc/fix/si476x' into asoc-linus (2014-03-10 11:30:56 +0000)

----------------------------------------------------------------

ASoC: Fixes for v3.14

A few things here:
 - Avoid memory leaks in error cases with DPCM, this code has never been
   that well tested in mainline due to the lack of mainline drivers but
   we now have one queued for the merge window!
 - Fix the N810 audio driver to load when booted with DT since the
   platform was converted to DT during the merge window.
 - Fixes for initialisation of some MFD drivers that are probably unused
   in mainline

----------------------------------------------------------------
Aaro Koskinen (1):
      ASoC: n810: fix init with DT boot

Lars-Peter Clausen (2):
      ASoC: si476x: Fix IO setup
      ASoC: 88pm860: Fix IO setup

Mark Brown (2):
      Merge remote-tracking branch 'asoc/fix/pcm' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/88pm860', 'asoc/fix/omap' and 'asoc/fix/si476x' into asoc-linus

Patrick Lai (1):
      ASoC: pcm: free path list before exiting from error conditions

 sound/soc/codecs/88pm860x-codec.c | 3 +++
 sound/soc/codecs/si476x.c         | 2 +-
 sound/soc/omap/n810.c             | 4 +++-
 sound/soc/soc-pcm.c               | 3 +++
 4 files changed, 10 insertions(+), 2 deletions(-)

--fnNg3ex06DkJ0Ygf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHgMKAAoJELSic+t+oim9XqcP/1RxMdnCOR76fIAevIY8Lw71
O4Jbn88dN525tdJ2zcmwjYaDvygocxFvUzeyHO9shoHb1kIuy9LGr4N3u4FUYeUM
+YqCUFggCTK3uEItVOYAw7s1bGEa/2HwKEFzhUEutg5vs/mh0aQssJJi5H1u4w1S
t8IzIRP8n6QLm9bgXD4FRH3+AyGPfUhe2pshn6tNK6JSHHPdzZsGfA0hehUZxISp
dtIiDyZgLJy+Nj7m/x0XSkxdf0EgQt8h2nxxa9zS3m+85eF2LUIvaRpM6+8v/IJg
h/sA3X3fCi0KNbkCmVFcFrlfBQzCGEbYC8dfd5SLH/ovS3IHvEeobcAv0hTPEiGl
ztryg0V8QpiK6jHPkrprubcoqqS0cwSlngifV4WWZYbRFLOsKXdCm0DbqcYmC/sB
6PvlcXAedpfD4oX2n+BF0bNQ7xGTTvt7fTPvbr05KKDvoOybPbg/fYRTyceR7OU0
rinQrxPjpTf0IURDov33zGQw0s2GYPl8RzOMVJaec+nhLwr8hvcG57aJVTZSe8wh
BwZPgsFpMxh+Vr5F93flIRRy3HGZrlqOYTrM5r+Qd5AiFpqHVFZZ8y8xcmd3yPSL
dxli6Ea/lXHQtpqCFJiD+kVmLsEa+vVwX5Cu+VqcCOuhIx/mlfJJzT8Uw9zFkpI+
jjyIDGVeOsE6VsmI4I8o
=rKlh
-----END PGP SIGNATURE-----

--fnNg3ex06DkJ0Ygf--

--===============7573869740176773759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7573869740176773759==--
