From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.11
Date: Mon, 15 Jul 2013 12:36:35 +0100
Message-ID: <20130715113635.GC11538@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1593904135272436053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FAB4260866
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 13:36:39 +0200 (CEST)
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


--===============1593904135272436053==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.11-rc1

for you to fetch changes up to 4824b69a928b6609cfb1cf232ef32d4a8125a371:

  Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus (2013-07-15 11:13:58 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.11

The biggest change here is the OMAP change, these are larger than I'd
have liked but make the driver actually usable - during the merge window
OMAP removed support for non-DT OMAP4 boards but in doing so removed the
method of accessing DMA channels used by the ASoC drivers rendering them
unusuable.

Otherwise nothing exciting, the symmetric rates change for WM8978 is a
fix for the information we expose to userspace.

----------------------------------------------------------------
Fabio Estevam (2):
      ASoC: sglt5000: Fix the default value of CHIP_SSS_CTRL
      ASoC: sglt5000: Fix SGTL5000_PLL_FRAC_DIV_MASK

Kuninori Morimoto (1):
      ASoC: wm8978: enable symmetric rates

Mark Brown (6):
      ASoC: wm8994: Remove overly noisy debug logging
      Merge remote-tracking branch 'asoc/fix/omap' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/samsung' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/sgtl5000' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8978' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus

Padmavathi Venna (1):
      ASoC: Samsung: Set RFS and BFS in slave mode

Peter Ujfalusi (4):
      ASoC: omap-pcm: Request the DMA channel differently when DT is involved
      ASoC: omap-mcpdm: Do not use platform_get_resource_byname() for DMA
      ASoC: omap-dmic: Do not use platform_get_resource_byname() for DMA
      ASoC: omap-mcbsp: Use different method for DMA request when booted with DT

 sound/soc/codecs/sgtl5000.c |  2 +-
 sound/soc/codecs/sgtl5000.h |  2 +-
 sound/soc/codecs/wm8978.c   |  1 +
 sound/soc/codecs/wm8994.c   |  4 ----
 sound/soc/omap/mcbsp.c      | 39 ++++++++++++++++++++++-----------------
 sound/soc/omap/omap-dmic.c  | 11 +----------
 sound/soc/omap/omap-mcpdm.c | 16 ++--------------
 sound/soc/omap/omap-pcm.c   | 17 ++++++++++++++---
 sound/soc/samsung/i2s.c     |  8 ++++----
 9 files changed, 46 insertions(+), 54 deletions(-)

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR497AAAoJELSic+t+oim9N5cQAJTxPjOfDwkFr7sjd/vqK1xX
o4OuN9LWeiMMh02Hbs8jGdZd7yDB+BRT4FM4vn9dZZfeF1f+jbC0T0BhyKMlzYnt
lUYBu/6wb79YlmjMMmzpnN4ij5PbPD6PT49W10PWQuf9yM7uYnJQ3F0p0ag5pmwO
rI4scBjBUO/nUEOO1c0XgmkBjBwMrbogRVuy631dom2Cynrhlmn7R6SZCrK/2uKL
qLqHh6ed6c9yxAptI4DvVq2NdrcrDWAnrOfGYMfXS/ZWn0H79bUunj9PNd96CzLL
f1Y+R6k5TnwIDblOwzQYL+FCZVfQfPVN6ajL/y2Hqg+ew+AyyRq6FJnQiG23wd12
McRshDvKTNz+fuqM8U3vjw7flueyEG2LKXRwxmxN6npKoP2j/MG2A2BBTjEhbxRr
DMGz7oHC5amQ7vONiN5K1Zao1Y2HIoS3ygwxj2xS1n7yc3/zqpn2RuvPU1GOEPdT
odk3bng5dNDbitzZaSdEaTEAIS58JfOwSslR48WAW/B/OFISlb20Gndo7RDmGudp
hMRNMbRxlewUpiEnCW+rtTB3WlxfIYP+NKfcqQH1fY9WzqUvmJfgosOwZZzAwNA9
hQg5aXdFtU84gFb+xFtA0DZr/buD3Eeif1+8s2C9um+mEHXHoy3LcnoRPlmAdupu
3OerpnelkLh/MdcRUBNr
=vT8M
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--

--===============1593904135272436053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1593904135272436053==--
