From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/3] ASoC: dapm - Use card mutex for DAPM ops
	instead of codec mutex.
Date: Fri,  2 Mar 2012 18:11:11 +0000
Message-ID: <1330711872-27436-2-git-send-email-lrg@ti.com>
References: <1330711872-27436-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 4067410411E
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 19:11:43 +0100 (CET)
Received: by mail-we0-f173.google.com with SMTP id p12so1807352wer.18
	for <alsa-devel@alsa-project.org>; Fri, 02 Mar 2012 10:11:24 -0800 (PST)
In-Reply-To: <1330711872-27436-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

It has now become necessary to use the card mutex instead of the codec
mutex to lock the DAPM operations. This is due to the recent multi
component support and forth coming Dynamic PCM updates.

Currently we lock DAPM operations with the codec mutex of the calling
RTD context. However, DAPM operations can span the whole card context 
and all components.

This patch updates the DAPM operations that use the codec mutex to
now use the card mutex PCM subclass for all DAPM ops.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c9b088d..faeb28d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2335,6 +2335,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_card *card = codec->card;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int reg = mc->reg;
@@ -2361,7 +2362,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		/* old connection must be powered down */
 		connect = invert ? 1 : 0;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
 
 	change = snd_soc_test_bits(widget->codec, reg, mask, val);
 	if (change) {
@@ -2383,7 +2384,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
@@ -2432,6 +2433,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
 	unsigned int mask, bitmask;
@@ -2452,7 +2454,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= (bitmask - 1) << e->shift_r;
 	}
 
-	mutex_lock(&codec->mutex);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
 
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
 	if (change) {
@@ -2474,7 +2476,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->mutex);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
@@ -2511,6 +2513,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e =
 		(struct soc_enum *)kcontrol->private_value;
 	int change;
@@ -2520,7 +2523,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.enumerated.item[0] >= e->max)
 		return -EINVAL;
 
-	mutex_lock(&codec->mutex);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
 
 	change = widget->value != ucontrol->value.enumerated.item[0];
 	if (change) {
@@ -2533,7 +2536,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->mutex);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
@@ -2598,6 +2601,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct snd_soc_codec *codec = widget->codec;
+	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
 	unsigned int mask;
@@ -2616,7 +2620,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= e->mask << e->shift_r;
 	}
 
-	mutex_lock(&codec->mutex);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
 
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
 	if (change) {
@@ -2638,7 +2642,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		}
 	}
 
-	mutex_unlock(&codec->mutex);
+	mutex_unlock(&card->mutex);
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
@@ -2675,7 +2679,7 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
 
-	mutex_lock(&card->mutex);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
 
 	ucontrol->value.integer.value[0] =
 		snd_soc_dapm_get_pin_status(&card->dapm, pin);
@@ -2698,7 +2702,7 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
 
-	mutex_lock(&card->mutex);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
 
 	if (ucontrol->value.integer.value[0])
 		snd_soc_dapm_enable_pin(&card->dapm, pin);
@@ -2990,11 +2994,11 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 			      struct snd_soc_dai *dai, int event)
 {
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = rtd->card;
 
-	mutex_lock(&codec->mutex);
-	soc_dapm_stream_event(&codec->dapm, stream, dai, event);
-	mutex_unlock(&codec->mutex);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_PCM);
+	soc_dapm_stream_event(&card->dapm, stream, dai, event);
+	mutex_unlock(&card->mutex);
 	return 0;
 }
 
-- 
1.7.5.4
