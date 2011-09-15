From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] ASoC: twl6040: Function to fetch the TRIM
	values
Date: Thu, 15 Sep 2011 15:45:16 +0300
Message-ID: <1316090718-30822-3-git-send-email-peter.ujfalusi@ti.com>
References: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog111.obsmtp.com (na3sys009aog111.obsmtp.com
	[74.125.149.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 58720103A74
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:45:49 +0200 (CEST)
Received: by mail-bw0-f49.google.com with SMTP id t2so2797586bka.36
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:45:48 -0700 (PDT)
In-Reply-To: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Provide API to fetch the TRIM values (for machine drivers)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    9 +++++++++
 sound/soc/codecs/twl6040.h |   13 +++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 638954c..8eecf4a 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1111,6 +1111,15 @@ int twl6040_get_clk_id(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(twl6040_get_clk_id);
 
+int twl6040_get_trim_value(struct snd_soc_codec *codec, enum twl6040_trim trim)
+{
+	if (unlikely(trim >= TWL6040_TRIM_INVAL))
+		return -EINVAL;
+
+	return twl6040_read_reg_cache(codec, TWL6040_REG_TRIM1 + trim);
+}
+EXPORT_SYMBOL_GPL(twl6040_get_trim_value);
+
 static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 	/* Capture gains */
 	SOC_DOUBLE_TLV("Capture Preamplifier Volume",
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index d8de678..a83277b 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -22,8 +22,21 @@
 #ifndef __TWL6040_H__
 #define __TWL6040_H__
 
+enum twl6040_trim {
+	TWL6040_TRIM_TRIM1 = 0,
+	TWL6040_TRIM_TRIM2,
+	TWL6040_TRIM_TRIM3,
+	TWL6040_TRIM_HSOTRIM,
+	TWL6040_TRIM_HFOTRIM,
+	TWL6040_TRIM_INVAL,
+};
+
+#define TWL6040_HSF_TRIM_LEFT(x)	(x & 0x0f)
+#define TWL6040_HSF_TRIM_RIGHT(x)	((x >> 4) & 0x0f)
+
 void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
 			    struct snd_soc_jack *jack, int report);
 int twl6040_get_clk_id(struct snd_soc_codec *codec);
+int twl6040_get_trim_value(struct snd_soc_codec *codec, enum twl6040_trim trim);
 
 #endif /* End of __TWL6040_H__ */
-- 
1.7.6.1
