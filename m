From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 1/3] ASoC: soc_jack - add function to determine
	jack type
Date: Fri, 28 Jan 2011 22:39:39 +0530
Message-ID: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B386E24392
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 17:54:47 +0100 (CET)
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
Cc: Harsha Priya <priya.harsha@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch adds a helper function that determines the jack type
given the mic bias value. For any codec that would give
the mic bias value on a jack insertion, this function would
return the type of jack based on mic bias range

Signed-off-by: Harsha Priya <priya.harsha@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc.h  |   15 +++++++++++++++
 sound/soc/soc-jack.c |   18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7ecdaef..afe98eb 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -246,6 +246,19 @@ typedef int (*hw_write_t)(void *,const char* ,int);
 
 extern struct snd_ac97_bus_ops soc_ac97_ops;
 
+enum soc_mic_bias_zones {
+	/* mic bias volutage range for Headphones*/
+	SND_SOC_JACK_HP_START = 0,
+	SND_SOC_JACK_HP_END = 400,
+	/* mic bias volutage range for American Headset*/
+	SND_SOC_JACK_AM_HS_START = 400,
+	SND_SOC_JACK_AM_HS_END = 650,
+	/* mic bias volutage range for Headset*/
+	SND_SOC_JACK_HS_START = 650,
+	SND_SOC_JACK_HS_END = 2000,
+	SND_SOC_UNDEFINED,
+};
+
 enum snd_soc_control_type {
 	SND_SOC_CUSTOM,
 	SND_SOC_I2C,
@@ -307,6 +320,8 @@ void snd_soc_jack_notifier_register(struct snd_soc_jack *jack,
 				    struct notifier_block *nb);
 void snd_soc_jack_notifier_unregister(struct snd_soc_jack *jack,
 				      struct notifier_block *nb);
+int snd_soc_jack_get_type(int mic_bias);
+
 #ifdef CONFIG_GPIOLIB
 int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			struct snd_soc_jack_gpio *gpios);
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index ac5a5bc..462965a 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -186,6 +186,24 @@ void snd_soc_jack_notifier_unregister(struct snd_soc_jack *jack,
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_notifier_unregister);
 
+/**
+ * snd_soc_jack_get_type - Based on the mic bias value, this function returns
+ *  the type of jack
+ *
+ * @mic_bias:  mic bias value detected
+ *
+ * Based on the mic bias value passed, this function helps identify
+ * the type of jack as either SND_JACK_HEADSET or SND_JACK_HEADPHONE.
+ */
+int snd_soc_jack_get_type(int mic_bias)
+{
+	if (mic_bias >= SND_SOC_JACK_HP_START && mic_bias < SND_SOC_JACK_HS_END)
+		return SND_JACK_HEADSET;
+	else
+		return SND_JACK_HEADPHONE;
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_get_type);
+
 #ifdef CONFIG_GPIOLIB
 /* gpio detect */
 static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
-- 
1.7.3.4
