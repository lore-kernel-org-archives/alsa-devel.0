From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH 3/3] ASoC: sta32x: add workaround for ESD reset
	issue
Date: Mon, 14 Nov 2011 17:23:18 +0100
Message-ID: <1321287798-20462-4-git-send-email-js@sig21.net>
References: <1321287798-20462-1-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 1274624718
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 17:29:01 +0100 (CET)
In-Reply-To: <1321287798-20462-1-git-send-email-js@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

sta32x resets and loses all configuration during ESD test.
Work around by polling the CONFA register once a second
and restore all coeffcients and registers when CONFA
changes unexpectedly.

Cc: Sven Neumann <s.neumann@raumfeld.com>
Cc: Daniel Mack <daniel@zonque.org>
Signed-off-by: Johannes Stezenbach <js@sig21.net>
---
 include/sound/sta32x.h    |    1 +
 sound/soc/codecs/sta32x.c |   50 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/include/sound/sta32x.h b/include/sound/sta32x.h
index 45d7477..8d93b03 100644
--- a/include/sound/sta32x.h
+++ b/include/sound/sta32x.h
@@ -29,6 +29,7 @@ struct sta32x_platform_data {
 	int ch2_output_mapping;
 	int ch3_output_mapping;
 	int thermal_conf;
+	int needs_esd_watchdog;
 };
 
 #endif /* __LINUX_SND__STA32X_H */
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 97091e3..3b0deaf 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -80,6 +81,8 @@ struct sta32x_priv {
 	unsigned int format;
 
 	u32 coef_shadow[STA32X_COEF_COUNT];
+	struct delayed_work watchdog_work;
+	int shutdown;
 };
 
 static const DECLARE_TLV_DB_SCALE(mvol_tlv, -12700, 50, 1);
@@ -304,6 +307,46 @@ int sta32x_cache_sync(struct snd_soc_codec *codec)
 	return rc;
 }
 
+/* work around ESD issue where sta32x resets and loses all configuration */
+static void sta32x_watchdog(struct work_struct *work)
+{
+	struct sta32x_priv *sta32x = container_of(work, struct sta32x_priv,
+						  watchdog_work.work);
+	struct snd_soc_codec *codec = sta32x->codec;
+	unsigned int confa, confa_cached;
+
+	/* check if sta32x has reset itself */
+	confa_cached = snd_soc_read(codec, STA32X_CONFA);
+	codec->cache_bypass = 1;
+	confa = snd_soc_read(codec, STA32X_CONFA);
+	codec->cache_bypass = 0;
+	if (confa != confa_cached) {
+		codec->cache_sync = 1;
+		sta32x_cache_sync(codec);
+	}
+
+	if (!sta32x->shutdown)
+		schedule_delayed_work(&sta32x->watchdog_work,
+				      round_jiffies_relative(HZ));
+}
+
+static void sta32x_watchdog_start(struct sta32x_priv *sta32x)
+{
+	if (sta32x->pdata->needs_esd_watchdog) {
+		sta32x->shutdown = 0;
+		schedule_delayed_work(&sta32x->watchdog_work,
+				      round_jiffies_relative(HZ));
+	}
+}
+
+static void sta32x_watchdog_stop(struct sta32x_priv *sta32x)
+{
+	if (sta32x->pdata->needs_esd_watchdog) {
+		sta32x->shutdown = 1;
+		cancel_delayed_work_sync(&sta32x->watchdog_work);
+	}
+}
+
 #define SINGLE_COEF(xname, index) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = sta32x_coefficient_info, \
@@ -714,6 +757,7 @@ static int sta32x_set_bias_level(struct snd_soc_codec *codec,
 			}
 
 			sta32x_cache_sync(codec);
+			sta32x_watchdog_start(sta32x);
 		}
 
 		/* Power up to mute */
@@ -730,7 +774,7 @@ static int sta32x_set_bias_level(struct snd_soc_codec *codec,
 				    STA32X_CONFF_PWDN | STA32X_CONFF_EAPD,
 				    STA32X_CONFF_PWDN);
 		msleep(300);
-
+		sta32x_watchdog_stop(sta32x);
 		regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies),
 				       sta32x->supplies);
 		break;
@@ -863,6 +907,9 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 	sta32x->coef_shadow[60] = 0x400000;
 	sta32x->coef_shadow[61] = 0x400000;
 
+	if (sta32x->pdata->needs_esd_watchdog)
+		INIT_DELAYED_WORK(&sta32x->watchdog_work, sta32x_watchdog);
+
 	sta32x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
@@ -879,6 +926,7 @@ static int sta32x_remove(struct snd_soc_codec *codec)
 {
 	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 
+	sta32x_watchdog_stop(sta32x);
 	sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
 	regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
-- 
1.7.7.2
