From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: dapm: Add support for virtual mixer
	controls
Date: Sun,  6 Oct 2013 13:43:49 +0200
Message-ID: <1381059831-16074-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-184.synserver.de (smtp-out-187.synserver.de
 [212.40.185.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 681032619FA
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2013 13:42:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch adds support for virtual DAPM mixer controls. They are similar to
virtual DAPM enums. There is no hardware register backing the control, so
changing the control's value wont have any direct effect on the hardware. But it
still influences the DAPM graph by causing the path it sits on to be connected
or disconnected. This in turn can cause power changes for some of the widgets on
the DAPM graph, which will then modify the hardware state.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  4 ++++
 include/sound/soc.h      |  3 ++-
 sound/soc/soc-dapm.c     | 45 +++++++++++++++++++++++++++------------------
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 27a72d5..2037c45 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -286,6 +286,8 @@ struct device;
 	.info = snd_soc_info_volsw, \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
 	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 1) }
+#define SOC_DAPM_SINGLE_VIRT(xname, max) \
+	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0)
 #define SOC_DAPM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, \
@@ -300,6 +302,8 @@ struct device;
 	.tlv.p = (tlv_array), \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
 	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
+#define SOC_DAPM_SINGLE_TLV_VIRT(xname, max, tlv_array) \
+	SOC_DAPM_SINGLE(xname, SND_SOC_NOPM, 0, max, 0, tlv_array)
 #define SOC_DAPM_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6dd329a..af1678c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1049,7 +1049,8 @@ struct snd_soc_pcm_runtime {
 /* mixer control */
 struct soc_mixer_control {
 	int min, max, platform_max;
-	unsigned int reg, rreg, shift, rshift;
+	int reg, rreg;
+	unsigned int shift, rshift;
 	unsigned int invert:1;
 	unsigned int autodisable:1;
 };
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c17c14c..25b9554 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -499,18 +499,22 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 		int val;
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)
 			w->kcontrol_news[i].private_value;
-		unsigned int reg = mc->reg;
+		int reg = mc->reg;
 		unsigned int shift = mc->shift;
 		int max = mc->max;
 		unsigned int mask = (1 << fls(max)) - 1;
 		unsigned int invert = mc->invert;
 
-		val = soc_widget_read(w, reg);
-		val = (val >> shift) & mask;
-		if (invert)
-			val = max - val;
+		if (reg != SND_SOC_NOPM) {
+			val = soc_widget_read(w, reg);
+			val = (val >> shift) & mask;
+			if (invert)
+				val = max - val;
+			p->connect = !!val;
+		} else {
+			p->connect = 0;
+		}
 
-		p->connect = !!val;
 	}
 	break;
 	case snd_soc_dapm_mux: {
@@ -2791,7 +2795,7 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = codec->card;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
+	int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
@@ -2804,7 +2808,7 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 			 kcontrol->id.name);
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	if (dapm_kcontrol_is_powered(kcontrol))
+	if (dapm_kcontrol_is_powered(kcontrol) && reg != SND_SOC_NOPM)
 		val = (snd_soc_read(codec, reg) >> shift) & mask;
 	else
 		val = dapm_kcontrol_get_value(kcontrol);
@@ -2835,7 +2839,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = codec->card;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
+	int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
@@ -2857,19 +2861,24 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	dapm_kcontrol_set_value(kcontrol, val);
+	change = dapm_kcontrol_set_value(kcontrol, val);
 
-	mask = mask << shift;
-	val = val << shift;
+	if (reg != SND_SOC_NOPM) {
+		mask = mask << shift;
+		val = val << shift;
+
+		change = snd_soc_test_bits(codec, reg, mask, val);
+	}
 
-	change = snd_soc_test_bits(codec, reg, mask, val);
 	if (change) {
-		update.kcontrol = kcontrol;
-		update.reg = reg;
-		update.mask = mask;
-		update.val = val;
+		if (reg != SND_SOC_NOPM) {
+			update.kcontrol = kcontrol;
+			update.reg = reg;
+			update.mask = mask;
+			update.val = val;
 
-		card->update = &update;
+			card->update = &update;
+		}
 
 		soc_dapm_mixer_update_power(card, kcontrol, connect);
 
-- 
1.8.0
