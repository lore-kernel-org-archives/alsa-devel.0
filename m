From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [asoc-dev][RFC/PATCH 1/2] ASoC: Add support for
	generic DAPM register modifier widget
Date: Wed, 25 Jun 2008 14:42:07 +0300
Message-ID: <1214394128-7062-2-git-send-email-jarkko.nikula@nokia.com>
References: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 32E2C24359
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 13:42:18 +0200 (CEST)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5PBd8Op031825
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 06:42:12 -0500
In-Reply-To: <1214394128-7062-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

This generic register modifier widget is for updating multiple codec
register bits at once when the widget changes its power state.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 include/sound/soc-dapm.h |   14 ++++++++++++++
 sound/soc/soc-dapm.c     |   19 +++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index f8223fa..b284953 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -130,6 +130,13 @@
 {	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, .reg = wreg, \
 	.shift = wshift, .invert = winvert}
 
+/* generic register modifier widget */
+#define SND_SOC_DAPM_REG(wid, wname, wreg, wshift, wmask, won_val, woff_val) \
+{	.id = wid, .name = wname, .kcontrols = NULL, .num_kcontrols = 0, \
+	.reg = -((wreg) + 1), .shift = wshift, .mask = wmask, \
+	.on_val = won_val, .off_val = woff_val, .event = dapm_reg_event, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD}
+
 /* dapm kcontrol types */
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -227,6 +234,10 @@ int snd_soc_dapm_set_bias_level(struct snd_soc_device *socdev,
 /* dapm sys fs - used by the core */
 int snd_soc_dapm_sys_add(struct device *dev);
 
+/* event handler for register modifier widget - used by the soc-dapm */
+int dapm_reg_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event);
+
 /* dapm audio endpoint control */
 int snd_soc_dapm_set_endpoint(struct snd_soc_codec *codec,
 	char *pin, int status);
@@ -298,6 +309,9 @@ struct snd_soc_dapm_widget {
 	unsigned char shift;			/* bits to shift */
 	unsigned int saved_value;		/* widget saved value */
 	unsigned int value;				/* widget current value */
+	unsigned int mask;			/* non-shifted mask */
+	unsigned int on_val;			/* on state value */
+	unsigned int off_val;			/* off state value */
 	unsigned char power:1;			/* block power status */
 	unsigned char invert:1;			/* invert the power bit */
 	unsigned char active:1;			/* active stream on DAC, ADC's */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 728f3ac..2536382 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -443,6 +443,25 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 }
 
 /*
+ * Handler for generic register modifier widget.
+ */
+int dapm_reg_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	unsigned int val;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		val = w->on_val;
+	else
+		val = w->off_val;
+
+	snd_soc_update_bits(w->codec, -(w->reg + 1),
+			    w->mask << w->shift, val << w->shift);
+
+	return 0;
+}
+
+/*
  * Scan each dapm widget for complete audio path.
  * A complete path is a route that has valid endpoints i.e.:-
  *
-- 
1.5.5.4
