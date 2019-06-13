From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-tdm: consistently use SND_SOC_DAIFMT defines" to the asoc tree
Date: Thu, 13 Jun 2019 20:06:09 +0100 (BST)
Message-ID: <20190613190610.10949440046@finisterre.sirena.org.uk>
References: <20190613114233.21130-5-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190613114233.21130-5-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: axg-tdm: consistently use SND_SOC_DAIFMT defines

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 05113483fd300d7a4605a726770e7255e29f1ac7 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 13 Jun 2019 13:42:33 +0200
Subject: [PATCH] ASoC: meson: axg-tdm: consistently use SND_SOC_DAIFMT defines

There a mix of SND_SOC_DAIFMT_ and SND_SOC_DAI_FORMAT_ in
axg-tdm-interface.c. Even, if this is currently the same thing, lets use
the same group consistently.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-tdm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 585ce030b79b..d51f3344be7c 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -306,8 +306,8 @@ static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
 		}
 		break;
 
-	case SND_SOC_DAI_FORMAT_DSP_A:
-	case SND_SOC_DAI_FORMAT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
 		break;
 
 	default:
-- 
2.20.1
