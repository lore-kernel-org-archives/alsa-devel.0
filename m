From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: twl6040 - add method to query HS DC
	offset step size in mV
Date: Mon,  9 Jan 2012 12:10:16 +0000
Message-ID: <1326111016-6218-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 693A1103B99
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 13:10:21 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id dr1so1243035wgb.8
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 04:10:20 -0800 (PST)
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

Provide a method for mach drivers to query the HS DC offset step size in mV.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |   13 +++++++++++++
 sound/soc/codecs/twl6040.h |    1 +
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 3376e6f..4ae6b82 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1029,6 +1029,19 @@ int twl6040_get_trim_value(struct snd_soc_codec *codec, enum twl6040_trim trim)
 }
 EXPORT_SYMBOL_GPL(twl6040_get_trim_value);
 
+int twl6040_get_hs_step_size(struct snd_soc_codec *codec)
+{
+	struct twl6040 *twl6040 = codec->control_data;
+
+	if (twl6040_get_revid(twl6040) < TWL6040_REV_ES1_2)
+		/* For ES under ES_1.3 HS step is 2 mV */
+		return 2;
+	else
+		/* For ES_1.3 HS step is 1 mV */
+		return 1;
+}
+EXPORT_SYMBOL_GPL(twl6040_get_hs_step_size);
+
 static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 	/* Capture gains */
 	SOC_DOUBLE_TLV("Capture Preamplifier Volume",
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index a83277b..0028699 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -38,5 +38,6 @@ void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
 			    struct snd_soc_jack *jack, int report);
 int twl6040_get_clk_id(struct snd_soc_codec *codec);
 int twl6040_get_trim_value(struct snd_soc_codec *codec, enum twl6040_trim trim);
+int twl6040_get_hs_step_size(struct snd_soc_codec *codec);
 
 #endif /* End of __TWL6040_H__ */
-- 
1.7.5.4
