From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Use correct shift
	definition for DATATYPE bits" to the asoc tree
Date: Wed, 13 Dec 2017 15:45:50 +0000
Message-ID: <E1eP9EE-0002M8-ST@debutante>
References: <20171212224311.24045-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 76DE4267956
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 16:45:55 +0100 (CET)
In-Reply-To: <20171212224311.24045-4-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "Andrew F ., Davis" <afd@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Use correct shift definition for DATATYPE bits

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4483521d81684764cb7f2569bf3e4b10d38ef9f7 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Tue, 12 Dec 2017 16:43:05 -0600
Subject: [PATCH] ASoC: tlv320aic32x4: Use correct shift definition for
 DATATYPE bits

Setting the DATATYPE bit field requires shifting our value by 6. Setting
the J value of the PLL also requires a shift by 6. Currently the code
abuses this fact and uses the shift for the PLL register to set the
data-type register. Fix this here by using the definition meant for
this register.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index d7a67bfcc6d8..8f9719e6cdfd 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -641,21 +641,23 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_I2S:
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		iface_reg_1 |= (AIC32X4_DSP_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_1 |= (AIC32X4_DSP_MODE <<
+				AIC32X4_IFACE1_DATATYPE_SHIFT);
 		iface_reg_3 |= (1 << 3); /* invert bit clock */
 		iface_reg_2 = 0x01; /* add offset 1 */
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		iface_reg_1 |= (AIC32X4_DSP_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_1 |= (AIC32X4_DSP_MODE <<
+				AIC32X4_IFACE1_DATATYPE_SHIFT);
 		iface_reg_3 |= (1 << 3); /* invert bit clock */
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		iface_reg_1 |=
-			(AIC32X4_RIGHT_JUSTIFIED_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_1 |= (AIC32X4_RIGHT_JUSTIFIED_MODE <<
+				AIC32X4_IFACE1_DATATYPE_SHIFT);
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		iface_reg_1 |=
-			(AIC32X4_LEFT_JUSTIFIED_MODE << AIC32X4_PLLJ_SHIFT);
+		iface_reg_1 |= (AIC32X4_LEFT_JUSTIFIED_MODE <<
+				AIC32X4_IFACE1_DATATYPE_SHIFT);
 		break;
 	default:
 		printk(KERN_ERR "aic32x4: invalid DAI interface format\n");
-- 
2.15.1
