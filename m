From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: add micbias power control
	select." to the asoc tree
Date: Thu, 04 Jan 2018 12:37:20 +0000
Message-ID: <E1eX4ls-000607-Kp@debutante>
References: <20180102185314.17189-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E77526782A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 13:37:30 +0100 (CET)
In-Reply-To: <20180102185314.17189-3-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: add micbias power control select.

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

>From e61f3f31e5830f027d8eedb742bc48a9b3173699 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 3 Jan 2018 13:39:02 +0100
Subject: [PATCH] ASoC: rt5645: add micbias power control select.

We need to set a corresponding control bit before powering micbias up.

Signed-off-by: Bard Liao <bardliao@realtek.com>
[hdegoede@redhat.com: Remove 2 unused variable declarations]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5645.h |  6 +++++
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 6f6da0abe220..fbaf36aeb587 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1943,6 +1943,56 @@ static int rt5650_hp_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5645_set_micbias1_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL2,
+			RT5645_MICBIAS1_POW_CTRL_SEL_MASK,
+			RT5645_MICBIAS1_POW_CTRL_SEL_M);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL2,
+			RT5645_MICBIAS1_POW_CTRL_SEL_MASK,
+			RT5645_MICBIAS1_POW_CTRL_SEL_A);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int rt5645_set_micbias2_event(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL2,
+			RT5645_MICBIAS2_POW_CTRL_SEL_MASK,
+			RT5645_MICBIAS2_POW_CTRL_SEL_M);
+		break;
+
+	case SND_SOC_DAPM_POST_PMD:
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL2,
+			RT5645_MICBIAS2_POW_CTRL_SEL_MASK,
+			RT5645_MICBIAS2_POW_CTRL_SEL_A);
+		break;
+
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("LDO2", RT5645_PWR_MIXER,
 		RT5645_PWR_LDO2_BIT, 0, NULL, 0),
@@ -1981,9 +2031,11 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 	/* Input Side */
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("micbias1", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB1_BIT, 0, NULL, 0),
+			RT5645_PWR_MB1_BIT, 0, rt5645_set_micbias1_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_SUPPLY("micbias2", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB2_BIT, 0, NULL, 0),
+			RT5645_PWR_MB2_BIT, 0, rt5645_set_micbias2_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC L1"),
 	SND_SOC_DAPM_INPUT("DMIC R1"),
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index cfc5f97549eb..940325b28c29 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2117,6 +2117,12 @@ enum {
 #define RT5645_RXDC_SRC_STO			(0x0 << 7)
 #define RT5645_RXDC_SRC_MONO			(0x1 << 7)
 #define RT5645_RXDC_SRC_SFT			(7)
+#define RT5645_MICBIAS1_POW_CTRL_SEL_MASK	(0x1 << 5)
+#define RT5645_MICBIAS1_POW_CTRL_SEL_A		(0x0 << 5)
+#define RT5645_MICBIAS1_POW_CTRL_SEL_M		(0x1 << 5)
+#define RT5645_MICBIAS2_POW_CTRL_SEL_MASK	(0x1 << 4)
+#define RT5645_MICBIAS2_POW_CTRL_SEL_A		(0x0 << 4)
+#define RT5645_MICBIAS2_POW_CTRL_SEL_M		(0x1 << 4)
 #define RT5645_RXDP2_SEL_MASK			(0x1 << 3)
 #define RT5645_RXDP2_SEL_IF2			(0x0 << 3)
 #define RT5645_RXDP2_SEL_ADC			(0x1 << 3)
-- 
2.15.1
