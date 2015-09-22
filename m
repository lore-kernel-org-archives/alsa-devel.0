From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add jd_invert for Broadwell" to
	the asoc tree
Date: Tue, 22 Sep 2015 09:46:57 -0700
Message-ID: <E1ZeQiX-00010s-45@finisterre>
References: <1442543948-10486-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C34D2650F5
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 18:47:34 +0200 (CEST)
In-Reply-To: <1442543948-10486-2-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add jd_invert for Broadwell

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

>From 917536aeb88d34e06c1353b0dd144f0987bb66bd Mon Sep 17 00:00:00 2001
From: John Lin <john.lin@realtek.com>
Date: Mon, 21 Sep 2015 14:12:01 +0800
Subject: [PATCH] ASoC: rt5645: Add jd_invert for Broadwell

Broadwell can not triger the IRQ falling and rising simultaneously,
so it can not detect jack-in and jack-out simultaneously.
We add a flag "jd_invert" to platform data. If this flag is set,
codec IRQ will be set to invert that forces IRQ as pulse when jack-in
and jack-out.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/rt5645.h    | 2 ++
 sound/soc/codecs/rt5645.c | 7 +++++++
 sound/soc/codecs/rt5645.h | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index 22734bc..a5cf615 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -21,6 +21,8 @@ struct rt5645_platform_data {
 	/* 0 = IN2P; 1 = GPIO6; 2 = GPIO10; 3 = GPIO12 */
 
 	unsigned int jd_mode;
+	/* Invert JD when jack insert */
+	bool jd_invert;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e830688..b0d96b6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2829,6 +2829,9 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
+		if (rt5645->pdata.jd_invert)
+			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
+				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
@@ -2844,6 +2847,9 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			snd_soc_dapm_disable_pin(dapm, "LDO2");
 		snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 		snd_soc_dapm_sync(dapm);
+		if (rt5645->pdata.jd_invert)
+			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
+				RT5645_JD_1_1_MASK, RT5645_JD_1_1_NOR);
 	}
 
 	return rt5645->jack_type;
@@ -3213,6 +3219,7 @@ static struct rt5645_platform_data buddy_platform_data = {
 	.dmic1_data_pin = RT5645_DMIC_DATA_GPIO5,
 	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
 	.jd_mode = 3,
+	.jd_invert = true,
 };
 
 static int buddy_quirk_cb(const struct dmi_system_id *id)
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 0e4cfc6..90325d9 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -1626,6 +1626,10 @@
 #define RT5645_OT_P_NOR				(0x0 << 10)
 #define RT5645_OT_P_INV				(0x1 << 10)
 #define RT5645_IRQ_JD_1_1_EN			(0x1 << 9)
+#define RT5645_JD_1_1_MASK			(0x1 << 7)
+#define RT5645_JD_1_1_SFT			7
+#define RT5645_JD_1_1_NOR			(0x0 << 7)
+#define RT5645_JD_1_1_INV			(0x1 << 7)
 
 /* IRQ Control 2 (0xbe) */
 #define RT5645_IRQ_MB1_OC_MASK			(0x1 << 15)
-- 
2.5.0
