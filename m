From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/2] ASoC: dapm: Rename dapm mutex subclass to
	better match usage.
Date: Fri,  9 Mar 2012 12:02:08 +0000
Message-ID: <1331294528-27350-2-git-send-email-lrg@ti.com>
References: <1331294528-27350-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 9885B10BB54
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 13:02:21 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so322482wib.14
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 04:02:19 -0800 (PST)
In-Reply-To: <1331294528-27350-1-git-send-email-lrg@ti.com>
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

Rename SND_SOC_DAPM_CLASS_PCM to SND_SOC_DAPM_CLASS_RUNTIME to
better match the usage and align with card mutex too.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    4 ++--
 sound/soc/soc-dapm.c     |   20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a4ae018..1beb28d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -432,8 +432,8 @@ enum snd_soc_dapm_type {
 };
 
 enum snd_soc_dapm_subclass {
-	SND_SOC_DAPM_CLASS_INIT	= 0,
-	SND_SOC_DAPM_CLASS_PCM	= 1,
+	SND_SOC_DAPM_CLASS_INIT		= 0,
+	SND_SOC_DAPM_CLASS_RUNTIME	= 1,
 };
 
 /*
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a58427b..e5aa65a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1787,7 +1787,7 @@ int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	struct snd_soc_card *card = widget->dapm->card;
 	int ret;
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	ret = soc_dapm_mux_update_power(widget, kcontrol, mux, e);
 	mutex_unlock(&card->dapm_mutex);
 	return ret;
@@ -1831,7 +1831,7 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	struct snd_soc_card *card = widget->dapm->card;
 	int ret;
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	ret = soc_dapm_mixer_update_power(widget, kcontrol, connect);
 	mutex_unlock(&card->dapm_mutex);
 	return ret;
@@ -2004,7 +2004,7 @@ int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 	if (!dapm->card || !dapm->card->instantiated)
 		return 0;
 
-	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	ret = dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
 	mutex_unlock(&dapm->card->dapm_mutex);
 	return ret;
@@ -2423,7 +2423,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		/* old connection must be powered down */
 		connect = invert ? 1 : 0;
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	change = snd_soc_test_bits(widget->codec, reg, mask, val);
 	if (change) {
@@ -2515,7 +2515,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= (bitmask - 1) << e->shift_r;
 	}
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
 	if (change) {
@@ -2584,7 +2584,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.enumerated.item[0] >= e->max)
 		return -EINVAL;
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	change = widget->value != ucontrol->value.enumerated.item[0];
 	if (change) {
@@ -2681,7 +2681,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		mask |= e->mask << e->shift_r;
 	}
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
 	if (change) {
@@ -2740,7 +2740,7 @@ int snd_soc_dapm_get_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	ucontrol->value.integer.value[0] =
 		snd_soc_dapm_get_pin_status(&card->dapm, pin);
@@ -2763,7 +2763,7 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
 	const char *pin = (const char *)kcontrol->private_value;
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
 	if (ucontrol->value.integer.value[0])
 		snd_soc_dapm_enable_pin(&card->dapm, pin);
@@ -3082,7 +3082,7 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 {
 	struct snd_soc_card *card = rtd->card;
 
-	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_PCM);
+	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	soc_dapm_stream_event(rtd, stream, event);
 	mutex_unlock(&card->dapm_mutex);
 }
-- 
1.7.5.4
