From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v3.19
Date: Tue, 16 Dec 2014 17:12:04 +0000
Message-ID: <20141216171204.GT11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5857382223487645451=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA6C26066A
 for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2014 18:12:09 +0100 (CET)
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


--===============5857382223487645451==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/xzC8FKR3TvyAjXE"
Content-Disposition: inline


--/xzC8FKR3TvyAjXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1810afd3e1ded09c53d4e966dddce3c7d484521f:

  Merge remote-tracking branches 'asoc/topic/wm9090', 'asoc/topic/wm9712' and 'asoc/topic/wm9713' into asoc-next (2014-12-08 13:12:36 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.19-2

for you to fetch changes up to c52e5698efef1d9999d744be001be62d9fcabf55:

  Merge remote-tracking branches 'asoc/fix/atmel', 'asoc/fix/intel', 'asoc/fix/rt5645', 'asoc/fix/rt5677' and 'asoc/fix/samsung' into asoc-linus (2014-12-16 11:52:34 +0000)

----------------------------------------------------------------
ASoC: Merge window fixes for v3.19

A smattering of driver specific fixes here, some more cleanup of the
Exynos7 and Intel ACPI support plus a fix for register cache sync on the
pcm512x driver which has been lurking for a while.

----------------------------------------------------------------
Bard Liao (1):
      ASoC: rt5645: Fix potential crash in jd function

Ben Zhang (1):
      ASoC: rt5677: add REGMAP_I2C and REGMAP_IRQ dependency

Kevin Strasser (1):
      ASoC: Intel: fix possible acpi enumeration panic

Mark Brown (1):
      Merge remote-tracking branches 'asoc/fix/atmel', 'asoc/fix/intel', 'asoc/fix/rt5645', 'asoc/fix/rt5677' and 'asoc/fix/samsung' into asoc-linus

Matthieu Crapet (1):
      ASoC: atmel_ssc_dai/trivial: typo fix

Peter Rosin (1):
      ASoC: pcm512x: Trigger auto-increment of register addresses on i2c

Sylwester Nawrocki (1):
      ASoC: samsung: i2s: Add missing assignment of variant_regs

Wei Yongjun (1):
      ASoC: Intel: fix return value check in sst_acpi_probe()

 sound/soc/atmel/atmel_ssc_dai.c |  2 +-
 sound/soc/codecs/Kconfig        |  2 ++
 sound/soc/codecs/pcm512x-i2c.c  |  7 ++++++-
 sound/soc/codecs/rt5645.c       |  4 ++++
 sound/soc/intel/sst/sst_acpi.c  | 10 +++++-----
 sound/soc/samsung/i2s.c         |  2 ++
 6 files changed, 20 insertions(+), 7 deletions(-)

--/xzC8FKR3TvyAjXE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUkGfjAAoJECTWi3JdVIfQCbkH/RFWqsHzIMfYNKZMCYT+YcC3
HcWa4jZJWfNvPCm/1DaK8L5K+qtTCqmIjUFlW8c818UefU0fQyBkktHQRFkKRz5P
zUmB+NQwcAR/FWE0DE7bm1r6QkWIY1WEXjsp/akNTs94iXG5NaS6Bpof0pTqjwC+
2IgijqrpWLSpx9uTzUtKpa2cnOUBBKPfIzSjIMzrlxwVlUJetlF1kk4Zmun/NAeY
aAOVfENPHtZDvbR//MlupvnCYm5Od0/x2+reoIQ1pZrbLeuwKWNPdhEPGfKJUK9s
ydTZw6EQ+5GE8E+kDrZMGapNIhf4qkuUCkmWlPGMdUrcz+HRv3VUBaCHp7db3ME=
=J3K4
-----END PGP SIGNATURE-----

--/xzC8FKR3TvyAjXE--

--===============5857382223487645451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5857382223487645451==--
