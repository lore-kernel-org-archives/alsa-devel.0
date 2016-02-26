From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Add I03/I04 widgets and
	corresponding routes" to the asoc tree
Date: Fri, 26 Feb 2016 11:46:55 +0900
Message-ID: <E1aZ8Qh-0006IJ-7H@finisterre>
References: <1456384353-13041-1-git-send-email-pc.liao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C70A26526E
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 03:47:02 +0100 (CET)
In-Reply-To: <1456384353-13041-1-git-send-email-pc.liao@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, PC Liao <pc.liao@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Add I03/I04 widgets and corresponding routes

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

>From 84f3a52421a41d0b129b519da9f39fcfb336a840 Mon Sep 17 00:00:00 2001
From: Koro Chen <koro.chen@mediatek.com>
Date: Thu, 25 Feb 2016 15:12:33 +0800
Subject: [PATCH] ASoC: mediatek: Add I03/I04 widgets and corresponding routes

Add these widgets to allow another path from I2S input.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: PC Liao <pc.liao@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mtk-afe-pcm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 3456bfab4617..f1c58a2c12fb 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -40,6 +40,7 @@
 
 #define AFE_CONN1		0x0024
 #define AFE_CONN2		0x0028
+#define AFE_CONN3		0x002c
 #define AFE_CONN7		0x0460
 #define AFE_CONN8		0x0464
 #define AFE_HDMI_CONN0		0x0390
@@ -63,6 +64,7 @@
 #define AFE_HDMI_OUT_CUR	0x0378
 #define AFE_HDMI_OUT_END	0x037c
 
+#define AFE_ADDA_TOP_CON0	0x0120
 #define AFE_ADDA2_TOP_CON0	0x0600
 
 #define AFE_HDMI_OUT_CON0	0x0370
@@ -259,6 +261,7 @@ static int mtk_afe_set_i2s(struct mtk_afe *afe, unsigned int rate)
 		return -EINVAL;
 
 	/* from external ADC */
+	regmap_update_bits(afe->regmap, AFE_ADDA_TOP_CON0, 0x1, 0x1);
 	regmap_update_bits(afe->regmap, AFE_ADDA2_TOP_CON0, 0x1, 0x1);
 
 	/* set input */
@@ -901,15 +904,19 @@ static const struct snd_kcontrol_new mtk_afe_o04_mix[] = {
 };
 
 static const struct snd_kcontrol_new mtk_afe_o09_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I03 Switch", AFE_CONN3, 0, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I17 Switch", AFE_CONN7, 30, 1, 0),
 };
 
 static const struct snd_kcontrol_new mtk_afe_o10_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I04 Switch", AFE_CONN3, 3, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("I18 Switch", AFE_CONN8, 0, 1, 0),
 };
 
 static const struct snd_soc_dapm_widget mtk_afe_pcm_widgets[] = {
 	/* inter-connections */
+	SND_SOC_DAPM_MIXER("I03", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I04", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I05", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I06", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER("I17", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -932,12 +939,16 @@ static const struct snd_soc_dapm_route mtk_afe_pcm_routes[] = {
 	{"I2S Playback", NULL, "O04"},
 	{"VUL", NULL, "O09"},
 	{"VUL", NULL, "O10"},
+	{"I03", NULL, "I2S Capture"},
+	{"I04", NULL, "I2S Capture"},
 	{"I17", NULL, "I2S Capture"},
 	{"I18", NULL, "I2S Capture"},
 	{ "O03", "I05 Switch", "I05" },
 	{ "O04", "I06 Switch", "I06" },
 	{ "O09", "I17 Switch", "I17" },
+	{ "O09", "I03 Switch", "I03" },
 	{ "O10", "I18 Switch", "I18" },
+	{ "O10", "I04 Switch", "I04" },
 };
 
 static const struct snd_soc_dapm_route mtk_afe_hdmi_routes[] = {
-- 
2.7.0
