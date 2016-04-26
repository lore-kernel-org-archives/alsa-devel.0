From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: reset AD dilter is there is no
	MCLK" to the asoc tree
Date: Tue, 26 Apr 2016 11:26:35 +0100
Message-ID: <E1av0CR-00070B-Pb@debutante>
References: <1461665231-14070-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B80652608B3
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 12:26:43 +0200 (CEST)
In-Reply-To: <1461665231-14070-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, ramesh.babu@intel.com, john.lin@realtek.com, broonie@kernel.org, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: reset AD dilter is there is no MCLK

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

>From 3c9e014c442caefa14c71494ca4473121007f60f Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 26 Apr 2016 18:07:10 +0800
Subject: [PATCH] ASoC: rt298: reset AD dilter is there is no MCLK

rt298 need to reset AD filter and the ADC settings will take effort.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 20 ++++++++++++++++++++
 sound/soc/codecs/rt298.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index f0e6c06e89ac..178b1cc22e05 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -481,6 +481,26 @@ static int rt298_adc_event(struct snd_soc_dapm_widget *w,
 		snd_soc_update_bits(codec,
 			VERB_CMD(AC_VERB_SET_AMP_GAIN_MUTE, nid, 0),
 			0x7080, 0x7000);
+		 /* If MCLK doesn't exist, reset AD filter */
+		if (!(snd_soc_read(codec, RT298_VAD_CTRL) & 0x200)) {
+			pr_info("NO MCLK\n");
+			switch (nid) {
+			case RT298_ADC_IN1:
+				snd_soc_update_bits(codec,
+					RT298_D_FILTER_CTRL, 0x2, 0x2);
+				mdelay(10);
+				snd_soc_update_bits(codec,
+					RT298_D_FILTER_CTRL, 0x2, 0x0);
+				break;
+			case RT298_ADC_IN2:
+				snd_soc_update_bits(codec,
+					RT298_D_FILTER_CTRL, 0x4, 0x4);
+				mdelay(10);
+				snd_soc_update_bits(codec,
+					RT298_D_FILTER_CTRL, 0x4, 0x0);
+				break;
+			}
+		}
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		snd_soc_update_bits(codec,
diff --git a/sound/soc/codecs/rt298.h b/sound/soc/codecs/rt298.h
index d66f8847b676..3638f3d61209 100644
--- a/sound/soc/codecs/rt298.h
+++ b/sound/soc/codecs/rt298.h
@@ -137,6 +137,7 @@
 #define RT298_A_BIAS_CTRL2	0x02
 #define RT298_POWER_CTRL1	0x03
 #define RT298_A_BIAS_CTRL3	0x04
+#define RT298_D_FILTER_CTRL	0x05
 #define RT298_POWER_CTRL2	0x08
 #define RT298_I2S_CTRL1		0x09
 #define RT298_I2S_CTRL2		0x0a
@@ -148,6 +149,7 @@
 #define RT298_IRQ_CTRL		0x33
 #define RT298_WIND_FILTER_CTRL	0x46
 #define RT298_PLL_CTRL1		0x49
+#define RT298_VAD_CTRL		0x4e
 #define RT298_CBJ_CTRL1		0x4f
 #define RT298_CBJ_CTRL2		0x50
 #define RT298_PLL_CTRL		0x63
-- 
2.8.0.rc3
