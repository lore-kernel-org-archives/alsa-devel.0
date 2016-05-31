From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Add data structure for voice trigger notifier
Date: Tue, 31 May 2016 12:44:17 +0100
Message-ID: <1464695057-11723-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, arnd@arndb.de, sfr@canb.auug.org.au
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/codecs/arizona.h | 4 ++++
 sound/soc/codecs/cs47l24.c | 7 +++++--
 sound/soc/codecs/wm5110.c  | 7 +++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index ef38413..2caf4d0 100644
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
index b4d05cf..954a4f5 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1078,6 +1078,7 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
 {
 	struct cs47l24_priv *priv = data;
 	struct arizona *arizona = priv->core.arizona;
+	struct arizona_voice_trigger_info info;
 	int serviced = 0;
 	int i, ret;
 
@@ -1085,10 +1086,12 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
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
index f1b3294..3b8db83 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2233,6 +2233,7 @@ static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
 {
 	struct wm5110_priv *priv = data;
 	struct arizona *arizona = priv->core.arizona;
+	struct arizona_voice_trigger_info info;
 	int serviced = 0;
 	int i, ret;
 
@@ -2240,10 +2241,12 @@ static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
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
2.1.4
