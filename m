From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.7
Date: Wed, 21 Nov 2012 12:12:14 +0900
Message-ID: <20121121031212.GL4673@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0479437912490809397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB67C265195
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 04:12:20 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0479437912490809397==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B92bTrfKjyax39gr"
Content-Disposition: inline


--B92bTrfKjyax39gr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.7

for you to fetch changes up to a6366c519cead55ce537babce2271e3b2a1ccec9:

  Merge branches 'fix/arizona', 'fix/cs4271', 'fix/kirkwood' and 'fix/samsung' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into tmp (2012-11-21 11:41:15 +0900)

----------------------------------------------------------------

ASoC: Fixes for v3.7

The biggest batch of fixes here is the Kirkwood DMA fixes, plus a couple
of other small fixes.

----------------------------------------------------------------
Daniel Mack (1):
      ASoC: cs4271: free allocated GPIO

Dimitris Papastamos (1):
      ASoC: arizona: Fix typo - Swap value in 48k_rates[] and 44k1_rates[]

Mark Brown (2):
      ASoC: bells: Fix up git patch application failure
      Merge branches 'fix/arizona', 'fix/cs4271', 'fix/kirkwood' and 'fix/samsung' of git://git.kernel.org/.../broonie/sound into tmp

Russell King (5):
      ASoC: kirkwood-dma: fix use of virt_to_phys()
      ASoC: kirkwood-dma: don't ignore other irq causes on error
      ASoC: kirkwood-i2s: fix DCO lock detection
      ASoC: kirkwood-i2s: fix DMA underruns
      ASoC: kirkwood-i2s: more pause-mode fixes

 sound/soc/codecs/arizona.c        |    4 +-
 sound/soc/codecs/cs4271.c         |   11 ++----
 sound/soc/kirkwood/kirkwood-dma.c |    3 +-
 sound/soc/kirkwood/kirkwood-i2s.c |   74 ++++++++++++++++++-------------------
 sound/soc/samsung/bells.c         |    4 +-
 5 files changed, 45 insertions(+), 51 deletions(-)

--B92bTrfKjyax39gr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrEUmAAoJELSic+t+oim9PykP/0Wk/l6lvnkLVHt2XwHUKlXw
qqkA7ZC/+KFAXWkJs8EdSNpjlPdcxWIUdt6OzodJLxIe4QHq5JvWY1BbXcvSjhVU
DYo7PMeuJJicvAWdiBqn/rqM6zivlYE2Y4OIo9uD5dv60wgRaL8ozHOhOk4qCUqs
zF5QWDSuUpEXinD3VIL5gJW7f5q9OnPpurjO1Jv1trzlC+mrLdbyHYZ3me7/Cuig
IqEoDm8tGjmesjEXYaLt3fQve9HncbRPLmR42JC7JP6mHiQHKOXAyMiLgBf46mkB
XkRMajaTJpyoDfMCMAfibho2JTc72R6aoLfFv3EfO7mQY4yNV59+miPr9WXtycxM
ouxGuI58esmxtskfantgN8iCPfaN4uxQHHvsiWV0ag8CRLyhN8ncDildQFoLuDWD
TmFYDFjhq7c1dYkknmKZHi6QMZEULkAvWH4VLwWwPTSa7z8w6H0oCMKW6JiHqv/I
pXHu1NgL76+NNd/lwgGfMvPMmYIqENH0RAR2H1VwNcrLpABPEgOXtdE2Rgwg2Soq
a773g9Kg/zX+Mj+1VPkIQCFRUMbnJAHhcqEMyAapIO0usQksKLXEpIMsmzvArsEi
QFhEzagUi9RPuKjAWzHEo4mhpx3Hg0R77DfXFWFDzu7b1KfSpZ9P84OHoB84ehMo
lhcxfUoCFl8kqZLoB/DT
=s5ry
-----END PGP SIGNATURE-----

--B92bTrfKjyax39gr--

--===============0479437912490809397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0479437912490809397==--
