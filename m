From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 1/2] ASoC: soc-dapm: Reorder DAPM register write
	sequence
Date: Mon,  2 Aug 2010 10:08:14 +0300
Message-ID: <1280732895-29010-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E2535103823
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 09:08:33 +0200 (CEST)
In-Reply-To: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch changes the order of DAPM widget register write
and the DAPM power update walking.

Currently this is what happens:
1. User changes a control, which is associated with DAPM.
2. First the DAPM walking happens based on the coming change
3. DAPM changes the widgets in the changed paths
4. The requested change by the control will be written to the codec.

After the patch:
1. User changes a control, which is associated with DAPM.
2. We check, if there is a change (and store the result in 'change')
3. The requested change by the control will be written to the codec.
4. If there were change DAPM walking happens
5. The rest of DAPM changes happen

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/soc-dapm.c |   41 +++++++++++++++++++++++++----------------
 1 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 03cb7c0..ccdd441 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1573,7 +1573,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
-	unsigned int val, val2, val_mask;
+	unsigned int val, val2, val_mask, change;
 	int connect;
 	int ret;
 
@@ -1593,17 +1593,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
-
-	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
-		if (val)
-			/* new connection */
-			connect = invert ? 0:1;
-		else
-			/* old connection must be powered down */
-			connect = invert ? 1:0;
-
-		dapm_mixer_update_power(widget, kcontrol, connect);
-	}
+	change = snd_soc_test_bits(widget->codec, reg, val_mask, val);
 
 	if (widget->event) {
 		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
@@ -1621,6 +1611,17 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	} else
 		ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
 
+	if (change) {
+		if (val)
+			/* new connection */
+			connect = invert ? 0 : 1;
+		else
+			/* old connection must be powered down */
+			connect = invert ? 1 : 0;
+
+		dapm_mixer_update_power(widget, kcontrol, connect);
+	}
+
 out:
 	mutex_unlock(&widget->codec->mutex);
 	return ret;
@@ -1690,7 +1691,6 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
-	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
 	if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
 		ret = widget->event(widget,
@@ -1701,9 +1701,14 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 
 	ret = snd_soc_update_bits(widget->codec, e->reg, mask, val);
 
-	if (widget->event_flags & SND_SOC_DAPM_POST_REG)
+	if (widget->event_flags & SND_SOC_DAPM_POST_REG) {
 		ret = widget->event(widget,
 				    kcontrol, SND_SOC_DAPM_POST_REG);
+		if (ret < 0)
+			goto out;
+	}
+
+	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
 out:
 	mutex_unlock(&widget->codec->mutex);
@@ -1836,7 +1841,6 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
 	change = snd_soc_test_bits(widget->codec, e->reg, mask, val);
-	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
 	if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
 		ret = widget->event(widget,
@@ -1847,9 +1851,14 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 
 	ret = snd_soc_update_bits(widget->codec, e->reg, mask, val);
 
-	if (widget->event_flags & SND_SOC_DAPM_POST_REG)
+	if (widget->event_flags & SND_SOC_DAPM_POST_REG) {
 		ret = widget->event(widget,
 				    kcontrol, SND_SOC_DAPM_POST_REG);
+		if (ret < 0)
+			goto out;
+	}
+
+	dapm_mux_update_power(widget, kcontrol, change, mux, e);
 
 out:
 	mutex_unlock(&widget->codec->mutex);
-- 
1.7.2
