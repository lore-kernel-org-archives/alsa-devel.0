From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC v2 1/3] ASoC: core: DAPM widget flag for reversed
	power up sequence
Date: Fri,  3 Dec 2010 15:31:11 +0200
Message-ID: <1291383073-16048-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id C78B4244CD
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 14:31:19 +0100 (CET)
In-Reply-To: <1291383073-16048-1-git-send-email-peter.ujfalusi@nokia.com>
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

New flag indicating, that the DAPM widget needs different
power up sequence.
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

By introducing new flag for the widget (route_change_before_powerup),
reordered power up sequence can be requesetd, which will look like this:

1. User enable the bypass
2. The bit enabling the bypass got changed.
3. DAPM power up sequence takes place
3.1 codec DAPM widgets got powered on, codec is enabled
3.2 External speaker enabled

The pop noise going to be filtered out, since the speaker going to be enabled
after the bit change taken place.

With the flag only the power up sequence can be changed, the power down
sequence remains the same.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 include/sound/soc-dapm.h |    1 +
 sound/soc/soc-dapm.c     |   17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 041e98b..e5a3c74 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -447,6 +447,7 @@ struct snd_soc_dapm_widget {
 	unsigned char ext:1;			/* has external widgets */
 	unsigned char force:1;			/* force state */
 	unsigned char ignore_suspend:1;         /* kept enabled over suspend */
+	unsigned char route_change_before_powerup:1;	/* reveresed power up */
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6a29d59..7fae969 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1626,8 +1626,9 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val, val2, val_mask;
+	unsigned int update_power_first = 1;
 	int connect;
-	int ret;
+	int ret = 0;
 
 	val = (ucontrol->value.integer.value[0] & mask);
 
@@ -1653,9 +1654,16 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 		else
 			/* old connection must be powered down */
 			connect = invert ? 1:0;
+	} else {
+		goto out;
+	}
+
+	if (widget->route_change_before_powerup && connect)
+		/* Reordering the power up sequence  */
+		update_power_first = 0;
 
+	if (update_power_first)
 		dapm_mixer_update_power(widget, kcontrol, connect);
-	}
 
 	if (widget->event) {
 		if (widget->event_flags & SND_SOC_DAPM_PRE_REG) {
@@ -1673,6 +1681,11 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	} else
 		ret = snd_soc_update_bits(widget->codec, reg, val_mask, val);
 
+	if (ret < 0)
+		goto out;
+
+	if (!update_power_first)
+		dapm_mixer_update_power(widget, kcontrol, connect);
 out:
 	mutex_unlock(&widget->codec->mutex);
 	return ret;
-- 
1.7.3.2
