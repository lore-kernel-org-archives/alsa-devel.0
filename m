From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: twl6040 - Add method to query optimum
	PDM_DL1 gain
Date: Mon,  9 Jan 2012 12:11:22 +0000
Message-ID: <1326111082-11678-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F6BC103B8E
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 13:11:27 +0100 (CET)
Received: by mail-wi0-f181.google.com with SMTP id hq2so3025213wib.12
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 04:11:26 -0800 (PST)
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

The DL1 PDM interface adds a little gain depending on the output device.
Add a method to retrieve the gain value for machine driver usage.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |   23 +++++++++++++++++++++++
 sound/soc/codecs/twl6040.h |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 4ae6b82..3b00ee7 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -33,6 +33,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-dapm.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
@@ -1042,6 +1043,28 @@ int twl6040_get_hs_step_size(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(twl6040_get_hs_step_size);
 
+int twl6040_get_dl1_gain(struct snd_soc_codec *codec)
+{
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	if (snd_soc_dapm_get_pin_status(dapm, "EP"))
+		return -1; /* -1dB */
+
+	if (snd_soc_dapm_get_pin_status(dapm, "HSOR") ||
+		snd_soc_dapm_get_pin_status(dapm, "HSOL")) {
+
+		u8 val = snd_soc_read(codec, TWL6040_REG_HSLCTL);
+		if (val & TWL6040_HSDACMODE)
+			/* HSDACL in LP mode */
+			return -8; /* -8dB */
+		else
+			/* HSDACL in HP mode */
+			return -1; /* -1dB */
+	}
+	return 0; /* 0dB */
+}
+EXPORT_SYMBOL_GPL(twl6040_get_dl1_gain);
+
 static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 	/* Capture gains */
 	SOC_DOUBLE_TLV("Capture Preamplifier Volume",
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index 0028699..b580c9d 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -39,5 +39,6 @@ void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
 int twl6040_get_clk_id(struct snd_soc_codec *codec);
 int twl6040_get_trim_value(struct snd_soc_codec *codec, enum twl6040_trim trim);
 int twl6040_get_hs_step_size(struct snd_soc_codec *codec);
+int twl6040_get_dl1_gain(struct snd_soc_codec *codec);
 
 #endif /* End of __TWL6040_H__ */
-- 
1.7.5.4
