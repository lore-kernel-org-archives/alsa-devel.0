From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 1/2] ASoC: core: Reordered DAPM update power on
	widgets
Date: Thu,  2 Dec 2010 14:03:09 +0200
Message-ID: <1291291390-8669-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id E5F7A103A81
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 13:03:16 +0100 (CET)
In-Reply-To: <1291291390-8669-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Add option to request reorder update power on codecs.
Certain codecs can generate pop noise, when for example enabling the bypass
path.
The route cause in these codecs are the DAPM update power and register write
sequence:
1. User enable the bypass
2. DAPM power up sequence takes place
2.1 codec DAPM widgets got powered on, codec is enabled
2.2 External speaker enabled
3. The bit enabling the bypass got changed.

Step 3 can cause audible pop on the speaker.

By introducing new flag for the DAPM (dapm_reorder_pupdate), codecs can request
for reordered power up sequence, which will look like this:

1. User enable the bypass
2. The bit enabling the bypass got changed.
3. DAPM power up sequence takes place
3.1 codec DAPM widgets got powered on, codec is enabled
3.2 External speaker enabled

The pop noise going to be filtered out, since the speaker going to be enabled
after the bit change taken place.

The default (current) sequence is not changed, since codec drivers must request
for reordered sequence.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-dapm.c     |   27 +++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 041e98b..38f8aad 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -474,6 +474,7 @@ struct snd_soc_dapm_context {
 	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
+	unsigned int dapm_reorder_pupdate:1; /* Reordered pupdate in widgets */
 
 	struct device *dev; /* from parent - for debug */
 	struct snd_soc_codec *codec; /* parent codec */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6a29d59..432ecf5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1626,6 +1626,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val, val2, val_mask;
+	unsigned int change, dapm_pupdate_first = 1;
 	int connect;
 	int ret;
 
@@ -1646,16 +1647,21 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	mutex_lock(&widget->codec->mutex);
 	widget->value = val;
 
-	if (snd_soc_test_bits(widget->codec, reg, val_mask, val)) {
-		if (val)
-			/* new connection */
-			connect = invert ? 0:1;
-		else
-			/* old connection must be powered down */
-			connect = invert ? 1:0;
+	change = snd_soc_test_bits(widget->codec, reg, val_mask, val);
+	if (val)
+		/* new connection */
+		connect = invert ? 0 : 1;
+	else
+		/* old connection must be powered down */
+		connect = invert ? 1 : 0;
 
-		dapm_mixer_update_power(widget, kcontrol, connect);
+	if (widget->dapm->dapm_reorder_pupdate) {
+		/* reodered DAPM change requested */
+		if (connect)
+			dapm_pupdate_first = 0;
 	}
+	if (change && dapm_pupdate_first)
+		dapm_mixer_update_power(widget, kcontrol, connect);
 
 	if (widget->event) {
 		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
@@ -1673,6 +1679,11 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	} else
 		ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
 
+	if (ret < 0)
+		goto out;
+
+	if (change && !dapm_pupdate_first)
+		dapm_mixer_update_power(widget, kcontrol, connect);
 out:
 	mutex_unlock(&widget->codec->mutex);
 	return ret;
-- 
1.7.3.2
