From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: Add jack reporting interface
Date: Thu,  8 Jan 2009 19:38:00 +0000
Message-ID: <1231443481-29352-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090108193718.GA29183@sirena.org.uk>
	<1231443481-29352-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1231443481-29352-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AB4A24377
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 20:38:13 +0100 (CET)
In-Reply-To: <1231443481-29352-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This patch adds a jack reporting interface to ASoC.  This wraps the ALSA
core jack detection functionality and provides integration with DAPM to
automatically update the power state of pins based on the jack state.

Since embedded platforms can have multiple detecton methods used for a
single jack (eg, separate microphone and headphone detection) the report
function allows specification of which bits are being updated on a given
report.

The expected usage is that machine drivers will create jack objects and
then configure jack detection methods to update that jack.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   32 ++++++++++++
 sound/soc/Kconfig    |    1 +
 sound/soc/Makefile   |    2 +-
 sound/soc/soc-jack.c |  138 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/soc-jack.c

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 24593ac..68d8149 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -154,6 +154,8 @@ enum snd_soc_bias_level {
 	SND_SOC_BIAS_OFF,
 };
 
+struct snd_jack;
+struct snd_soc_card;
 struct snd_soc_device;
 struct snd_soc_pcm_stream;
 struct snd_soc_ops;
@@ -164,6 +166,8 @@ struct snd_soc_platform;
 struct snd_soc_codec;
 struct soc_enum;
 struct snd_soc_ac97_ops;
+struct snd_soc_jack;
+struct snd_soc_jack_pin;
 
 typedef int (*hw_write_t)(void *,const char* ,int);
 typedef int (*hw_read_t)(void *,char* ,int);
@@ -184,6 +188,13 @@ int snd_soc_init_card(struct snd_soc_device *socdev);
 int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 	const struct snd_pcm_hardware *hw);
 
+/* Jack reporting */
+int snd_soc_jack_new(struct snd_soc_card *card, const char *id, int type,
+		     struct snd_soc_jack *jack);
+void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask);
+int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
+			  struct snd_soc_jack_pin *pins);
+
 /* codec IO */
 #define snd_soc_read(codec, reg) codec->read(codec, reg)
 #define snd_soc_write(codec, reg, value) codec->write(codec, reg, value)
@@ -237,6 +248,27 @@ int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
 int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 
+/**
+ * struct snd_soc_jack_pin - Describes a pin to update based on jack detection
+ *
+ * @pin:    name of the pin to update
+ * @mask:   bits to check for in reported jack status
+ * @invert: if non-zero then pin is enabled when status is not reported
+ */
+struct snd_soc_jack_pin {
+	struct list_head list;
+	const char *pin;
+	int mask;
+	bool invert;
+};
+
+struct snd_soc_jack {
+	struct snd_jack *jack;
+	struct snd_soc_card *card;
+	struct list_head pins;
+	int status;
+};
+
 /* SoC PCM stream information */
 struct snd_soc_pcm_stream {
 	char *stream_name;
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index ef025c6..3d2bb6f 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -6,6 +6,7 @@ menuconfig SND_SOC
 	tristate "ALSA for SoC audio support"
 	select SND_PCM
 	select AC97_BUS if SND_SOC_AC97_BUS
+	select SND_JACK if INPUT=y || INPUT=SND
 	---help---
 
 	  If you want ASoC support, you should say Y here and also to the
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 86a9b1f..0237879 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,4 +1,4 @@
-snd-soc-core-objs := soc-core.o soc-dapm.o
+snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
new file mode 100644
index 0000000..8cc00c3
--- /dev/null
+++ b/sound/soc/soc-jack.c
@@ -0,0 +1,138 @@
+/*
+ * soc-jack.c  --  ALSA SoC jack handling
+ *
+ * Copyright 2008 Wolfson Microelectronics PLC.
+ *
+ * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <sound/jack.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+/**
+ * snd_soc_jack_new - Create a new jack
+ * @card:  ASoC card
+ * @id:    an identifying string for this jack
+ * @type:  a bitmask of enum snd_jack_type values that can be detected by
+ *         this jack
+ * @jack:  structure to use for the jack
+ *
+ * Creates a new jack object.
+ *
+ * Returns zero if successful, or a negative error code on failure.
+ * On success jack will be initialised.
+ */
+int snd_soc_jack_new(struct snd_soc_card *card, const char *id, int type,
+		     struct snd_soc_jack *jack)
+{
+	jack->card = card;
+	INIT_LIST_HEAD(&jack->pins);
+
+	return snd_jack_new(card->socdev->codec->card, id, type, &jack->jack);
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_new);
+
+/**
+ * snd_soc_jack_report - Report the current status for a jack
+ *
+ * @jack:   the jack
+ * @status: a bitmask of enum snd_jack_type values that are currently detected.
+ * @mask:   a bitmask of enum snd_jack_type values that being reported.
+ *
+ * If configured using snd_soc_jack_add_pins() then the associated
+ * DAPM pins will be enabled or disabled as appropriate and DAPM
+ * synchronised.
+ *
+ * Note: This function uses mutexes and should be called from a
+ * context which can sleep (such as a workqueue).
+ */
+void snd_soc_jack_report(struct snd_soc_jack *jack, int status, int mask)
+{
+	struct snd_soc_codec *codec = jack->card->socdev->codec;
+	struct snd_soc_jack_pin *pin;
+	int enable;
+	int oldstatus;
+
+	if (!jack) {
+		WARN_ON_ONCE(!jack);
+		return;
+	}
+
+	mutex_lock(&codec->mutex);
+
+	oldstatus = jack->status;
+
+	jack->status &= ~mask;
+	jack->status |= status;
+
+	/* The DAPM sync is expensive enough to be worth skipping */
+	if (jack->status == oldstatus)
+		goto out;
+
+	list_for_each_entry(pin, &jack->pins, list) {
+		enable = pin->mask & status;
+
+		if (pin->invert)
+			enable = !enable;
+
+		if (enable)
+			snd_soc_dapm_enable_pin(codec, pin->pin);
+		else
+			snd_soc_dapm_disable_pin(codec, pin->pin);
+	}
+
+	snd_soc_dapm_sync(codec);
+
+	snd_jack_report(jack->jack, status);
+
+out:
+	mutex_unlock(&codec->mutex);
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_report);
+
+/**
+ * snd_soc_jack_add_pins - Associate DAPM pins with an ASoC jack
+ *
+ * @jack:  ASoC jack
+ * @count: Number of pins
+ * @pins:  Array of pins
+ *
+ * After this function has been called the DAPM pins specified in the
+ * pins array will have their status updated to reflect the current
+ * state of the jack whenever the jack status is updated.
+ */
+int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
+			  struct snd_soc_jack_pin *pins)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (!pins[i].pin) {
+			printk(KERN_ERR "No name for pin %d\n", i);
+			return -EINVAL;
+		}
+		if (!pins[i].mask) {
+			printk(KERN_ERR "No mask for pin %d (%s)\n", i,
+			       pins[i].pin);
+			return -EINVAL;
+		}
+
+		INIT_LIST_HEAD(&pins[i].list);
+		list_add(&(pins[i].list), &jack->pins);
+	}
+
+	/* Update to reflect the last reported status; canned jack
+	 * implementations are likely to set their state before the
+	 * card has an opportunity to associate pins.
+	 */
+	snd_soc_jack_report(jack, 0, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_jack_add_pins);
-- 
1.5.6.5
