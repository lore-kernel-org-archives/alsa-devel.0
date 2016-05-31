From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add data structure for voice trigger notifier" to the asoc tree
Date: Tue, 31 May 2016 18:46:10 +0100
Message-ID: <E1b7nk2-000669-Eq@debutante>
References: <1464695057-11723-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1464695057-11723-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-next-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>broonie@kernel.org, sfr@canb.auug.org.au, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, lgirdwood@gmail.comarnd@arndb.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add data structure for voice trigger notifier

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

>From 546ad3d024fd47e5042d80ae1dc4c7d1b00912a7 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 31 May 2016 12:44:17 +0100
Subject: [PATCH] ASoC: arizona: Add data structure for voice trigger notifier

64-bit builds would generate a warning when we passed the core number as
a pointer through the notifier data:

sound/soc/codecs/cs47l24.c:1091:13: warning: cast to pointer from
integer of different size [-Wint-to-pointer-cast]
             (void *)i);

Rather than just fix this up with more casting add a data structure that
holds information for the notifier chain. This will make it easier to
add additional information in the future as well.

Fixes: 7baa7e2490e1 ("ASoC: arizona: Add event notification on voice trigger events")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h | 4 ++++
 sound/soc/codecs/cs47l24.c | 7 +++++--
 sound/soc/codecs/wm5110.c  | 7 +++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 18d347f3bfbe..46862af7665e 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -98,6 +98,10 @@ struct arizona_priv {
 	bool dvfs_cached;
 };
 
+struct arizona_voice_trigger_info {
+	int core;
+};
+
 #define ARIZONA_NUM_MIXER_INPUTS 104
 
 extern const unsigned int arizona_mixer_tlv[];
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 7e3d138d077b..bbc8cf18ded0 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1067,6 +1067,7 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
 {
 	struct cs47l24_priv *priv = data;
 	struct arizona *arizona = priv->core.arizona;
+	struct arizona_voice_trigger_info info;
 	int serviced = 0;
 	int i, ret;
 
@@ -1074,10 +1075,12 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
 		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
 		if (ret != -ENODEV)
 			serviced++;
-		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER)
+		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER) {
+			info.core = i;
 			arizona_call_notifiers(arizona,
 					       ARIZONA_NOTIFY_VOICE_TRIGGER,
-					       (void *)i);
+					       &info);
+		}
 	}
 
 	if (!serviced) {
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index dbc9b4df38a0..83c48eca56f5 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2222,6 +2222,7 @@ static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
 {
 	struct wm5110_priv *priv = data;
 	struct arizona *arizona = priv->core.arizona;
+	struct arizona_voice_trigger_info info;
 	int serviced = 0;
 	int i, ret;
 
@@ -2229,10 +2230,12 @@ static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
 		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
 		if (ret != -ENODEV)
 			serviced++;
-		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER)
+		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER) {
+			info.core = i;
 			arizona_call_notifiers(arizona,
 					       ARIZONA_NOTIFY_VOICE_TRIGGER,
-					       (void *)i);
+					       &info);
+		}
 	}
 
 	if (!serviced) {
-- 
2.8.1
