From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: i2s: Add
	SNDRV_PCM_FMTBIT_S32_LE support" to the asoc tree
Date: Sun, 10 Jan 2016 12:07:47 +0000
Message-ID: <E1aIEmh-0007RE-2n@debutante>
References: <1452379678-14160-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EEF7C26063D
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:07:52 +0100 (CET)
In-Reply-To: <1452379678-14160-1-git-send-email-michael@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: i2s: Add SNDRV_PCM_FMTBIT_S32_LE support

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4ab936d1aca69978dc738592a00e34f836bda1c3 Mon Sep 17 00:00:00 2001
From: Michael Trimarchi <michael@amarulasolutions.com>
Date: Sat, 9 Jan 2016 23:47:58 +0100
Subject: [PATCH] ASoC: rockchip: i2s: Add SNDRV_PCM_FMTBIT_S32_LE support

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 8b0a588ed622..6561c4cc2edd 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -242,6 +242,9 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S24_LE:
 		val |= I2S_TXCR_VDW(24);
 		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		val |= I2S_TXCR_VDW(32);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -360,7 +363,8 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 		.formats = (SNDRV_PCM_FMTBIT_S8 |
 			    SNDRV_PCM_FMTBIT_S16_LE |
 			    SNDRV_PCM_FMTBIT_S20_3LE |
-			    SNDRV_PCM_FMTBIT_S24_LE),
+			    SNDRV_PCM_FMTBIT_S24_LE |
+			    SNDRV_PCM_FMTBIT_S32_LE),
 	},
 	.capture = {
 		.stream_name = "Capture",
@@ -370,7 +374,8 @@ static struct snd_soc_dai_driver rockchip_i2s_dai = {
 		.formats = (SNDRV_PCM_FMTBIT_S8 |
 			    SNDRV_PCM_FMTBIT_S16_LE |
 			    SNDRV_PCM_FMTBIT_S20_3LE |
-			    SNDRV_PCM_FMTBIT_S24_LE),
+			    SNDRV_PCM_FMTBIT_S24_LE |
+			    SNDRV_PCM_FMTBIT_S32_LE),
 	},
 	.ops = &rockchip_i2s_dai_ops,
 	.symmetric_rates = 1,
-- 
2.7.0.rc3
