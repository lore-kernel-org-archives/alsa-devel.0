From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: Add helper functions bias level
	management
Date: Mon, 27 Apr 2015 22:13:23 +0200
Message-ID: <1430165606-3072-2-git-send-email-lars@metafoo.de>
References: <1430165606-3072-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-223.synserver.de (smtp-out-223.synserver.de
 [212.40.185.223])
 by alsa0.perex.cz (Postfix) with ESMTP id 0586126509D
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 22:13:42 +0200 (CEST)
In-Reply-To: <1430165606-3072-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently drivers are responsible for managing the bias_level field of
their DAPM context. The DAPM state itself is managed by the DAPM core
though and the core has certain expectations on how and when the bias_level
field should be updated. If drivers don't adhere to these undefined
behavior can occur.

This patch adds a few helper functions for manipulating the DAPM context
state, each function with a description on when it should be used and what
its effects are. This will also help us to move more of the bias_level
management from drivers to the DAPM core.

For convenience also add snd_soc_codec_* wrappers around these helpers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 34 ++++++++++++++++++++++++++++++++++
 include/sound/soc.h      | 40 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c     | 35 +++++++++++++++++++++++++++++++----
 3 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 1065095..b659d9f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -444,6 +444,9 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 struct snd_soc_dapm_context *snd_soc_dapm_kcontrol_dapm(
 	struct snd_kcontrol *kcontrol);
 
+int snd_soc_dapm_force_bias_level(struct snd_soc_dapm_context *dapm,
+	enum snd_soc_bias_level level);
+
 /* dapm widget types */
 enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
@@ -623,4 +626,35 @@ struct snd_soc_dapm_stats {
 	int neighbour_checks;
 };
 
+/**
+ * snd_soc_dapm_init_bias_level() - Initialize DAPM bias level
+ * @dapm: The DAPM context to initialize
+ * @level: The DAPM level to initialize to
+ *
+ * This function only sets the driver internal state of the DAPM level and will
+ * not modify the state of the device. Hence it should not be used during normal
+ * operation, but only to synchronize the internal state to the device state.
+ * E.g. during driver probe to set the DAPM level to the one corresponding with
+ * the power-on reset state of the device.
+ *
+ * To change the DAPM state of the device use snd_soc_dapm_set_bias_level().
+ */
+static inline void snd_soc_dapm_init_bias_level(
+	struct snd_soc_dapm_context *dapm, enum snd_soc_bias_level level)
+{
+	dapm->bias_level = level;
+}
+
+/**
+ * snd_soc_dapm_get_bias_level() - Get current DAPM bias level
+ * @dapm: The context for which to get the bias level
+ *
+ * Returns: The current bias level of the passed DAPM context.
+ */
+static inline enum snd_soc_bias_level snd_soc_dapm_get_bias_level(
+	struct snd_soc_dapm_context *dapm)
+{
+	return dapm->bias_level;
+}
+
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index d57dc7c..de265a8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1294,6 +1294,46 @@ static inline struct snd_soc_dapm_context *snd_soc_codec_get_dapm(
 }
 
 /**
+ * snd_soc_dapm_init_bias_level() - Initialize CODEC DAPM bias level
+ * @dapm: The CODEC for which to initialize the DAPM bias level
+ * @level: The DAPM level to initialize to
+ *
+ * Initializes the CODEC DAPM bias level. See snd_soc_dapm_init_bias_level().
+ */
+static inline void snd_soc_codec_init_bias_level(struct snd_soc_codec *codec,
+	enum snd_soc_bias_level level)
+{
+	snd_soc_dapm_init_bias_level(snd_soc_codec_get_dapm(codec), level);
+}
+
+/**
+ * snd_soc_dapm_get_bias_level() - Get current CODEC DAPM bias level
+ * @codec: The CODEC for which to get the DAPM bias level
+ *
+ * Returns: The current DAPM bias level of the CODEC.
+ */
+static inline enum snd_soc_bias_level snd_soc_codec_get_bias_level(
+	struct snd_soc_codec *codec)
+{
+	return snd_soc_dapm_get_bias_level(snd_soc_codec_get_dapm(codec));
+}
+
+/**
+ * snd_soc_codec_force_bias_level() - Set the CODEC DAPM bias level
+ * @codec: The CODEC for which to set the level
+ * @level: The level to set to
+ *
+ * Forces the CODEC bias level to a specific state. See
+ * snd_soc_dapm_force_bias_level().
+ */
+static inline int snd_soc_codec_force_bias_level(struct snd_soc_codec *codec,
+	enum snd_soc_bias_level level)
+{
+	return snd_soc_dapm_force_bias_level(snd_soc_codec_get_dapm(codec),
+		level);
+}
+
+/**
  * snd_soc_dapm_kcontrol_codec() - Returns the codec associated to a kcontrol
  * @kcontrol: The kcontrol
  *
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index defe0f0..b24782b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -526,6 +526,35 @@ static void soc_dapm_async_complete(struct snd_soc_dapm_context *dapm)
 }
 
 /**
+ * snd_soc_dapm_force_bias_level() - Sets the DAPM bias level
+ * @dapm: The DAPM context for which to set the level
+ * @level: The level to set
+ *
+ * Forces the DAPM bias level to a specific state. It will call the bias level
+ * callback of DAPM context with the specified level. This will even happen if
+ * the context is already at the same level. Furthermore it will not go through
+ * the normal bias level sequencing, meaning any intermediate states between the
+ * current and the target state will not be entered.
+ *
+ * Note that the change in bias level is only temporary and the next time
+ * snd_soc_dapm_sync() is called the state will be set to the level as
+ * determined by the DAPM core. The function is mainly intended to be used to
+ * used during probe or resume from suspend to power up the device so
+ * initialization can be done, before the DAPM core takes over.
+ */
+int snd_soc_dapm_force_bias_level(struct snd_soc_dapm_context *dapm,
+	enum snd_soc_bias_level level)
+{
+	int ret = 0;
+
+	if (dapm->set_bias_level)
+		ret = dapm->set_bias_level(dapm, level);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_force_bias_level);
+
+/**
  * snd_soc_dapm_set_bias_level - set the bias level for the system
  * @dapm: DAPM context
  * @level: level to configure
@@ -547,10 +576,8 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 	if (ret != 0)
 		goto out;
 
-	if (dapm->set_bias_level)
-		ret = dapm->set_bias_level(dapm, level);
-	else if (!card || dapm != &card->dapm)
-		dapm->bias_level = level;
+	if (!card || dapm != &card->dapm)
+		ret = snd_soc_dapm_force_bias_level(dapm, level);
 
 	if (ret != 0)
 		goto out;
-- 
1.8.0
