From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.13
Date: Fri, 13 Dec 2013 13:38:34 +0000
Message-ID: <20131213133834.GA11044@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5384712649454563097=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9753A260376
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 14:38:37 +0100 (CET)
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


--===============5384712649454563097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4NxgPrvSrIDR5b4"
Content-Disposition: inline


--T4NxgPrvSrIDR5b4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.13-rc3

for you to fetch changes up to e20ab019e28dcf09c2727aa69e2a073ed66718b3:

  Merge remote-tracking branches 'asoc/fix/atmel', 'asoc/fix/fsl', 'asoc/fix/tegra' and 'asoc/fix/wm8962' into asoc-linus (2013-12-12 00:30:04 +0000)

----------------------------------------------------------------

ASoC: Fixes for v3.13

A few driver and error handling fixes plus a fix to ensure that we
mute streams when we should.  The Atmel trigger addition is a fix to
ensure that we do the correct sequence of interactions with the
hardware.

----------------------------------------------------------------
Bo Shen (2):
      ASoC: atmel_ssc_dai: add dai trigger ops
      ASoC: sam9x5_wm8731: change to work in DSP A mode

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dma' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/atmel', 'asoc/fix/fsl', 'asoc/fix/tegra' and 'asoc/fix/wm8962' into asoc-linus

Nicolin Chen (3):
      ASoC: soc-pcm: Use valid condition for snd_soc_dai_digital_mute() in hw_free()
      ASoC: wm8962: Enable SYSCLK provisonally before fetching generated DSPCLK_DIV
      ASoC: fsl: imx-wm8962: Don't update bias_level in machine driver

Stephen Warren (2):
      ASoC: tegra: fix uninitialized variables in set_fmt
      ASoC: don't leak on error in snd_dmaengine_pcm_register

 sound/soc/atmel/atmel_ssc_dai.c       | 30 ++++++++++++++++++++++++++-
 sound/soc/atmel/sam9x5_wm8731.c       |  2 +-
 sound/soc/codecs/wm8962.c             | 13 ++++++++++++
 sound/soc/fsl/imx-wm8962.c            |  2 --
 sound/soc/soc-generic-dmaengine-pcm.c | 38 +++++++++++++++++++++++++----------
 sound/soc/soc-pcm.c                   |  5 +++--
 sound/soc/tegra/tegra20_i2s.c         |  6 +++---
 sound/soc/tegra/tegra20_spdif.c       | 10 ++++-----
 sound/soc/tegra/tegra30_i2s.c         |  6 +++---
 9 files changed, 84 insertions(+), 28 deletions(-)

--T4NxgPrvSrIDR5b4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqw3XAAoJELSic+t+oim9ifUP/jG0jRgD55kntPCQU91JUSpq
a79QkvvViOL12PXszuFO3I6ZIjCkVkEoKZNs0UZS5P3jgT2Iq0wOnzroMQ2mPR5P
zqF3UZ9EQPwoiT9sVf67V6u5qF7DC76Xq6pr7H4I154s58DZ0GpRbA71SvaXQTes
7c4t/dJE+uE/dXLomCvK9CT0Si/vs+JLHanYDa0x+KWiZuEYxZzQi7uZ/IPXFvws
b4af4VtN7XnE6mCO+U55mfhDMJmu+CLYHLK5D9X/t3QHzm8VijgioQuglS5dU1qx
+5cXkeE0N8l4DLMY7jx+V7bDl29DrXs1LNStrWxEoZnaPI3IPTl/8t1OqMrZXZYt
1JMH1zQv/WZOMOLP2iD1cbVZsnvGoppvm9D+ZVA6vWJhL46+HQ1vks08ylx4qMmM
p1LzjqtxXy5UmLmQLGVDW98x4RqT4nlSpNbz1y18MdUn06u1bF+4n9DMrsg0KNBp
ZcaAaz6J7BrbTsy3LtPoS2bj9gG8uk9ztNcJ3CeZTIQAJpj2gUgqrKApPEJfLdAV
l1ROFJIW++tj34iGVnNPwtq+nbBskSASxW7sC+kbNN0NcXN7Mz8HT212splSIfJY
Ljzw0WUlk21I/tcW7zc2n+doUPGhRdu7yLyQ7mx1m5JZ2/F7WFp4oUc+daNgsPjc
kQAOEN/1s/8+DpSrHg0v
=xVjA
-----END PGP SIGNATURE-----

--T4NxgPrvSrIDR5b4--

--===============5384712649454563097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5384712649454563097==--
