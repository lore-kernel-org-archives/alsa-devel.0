From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2 3/3] ASoC: twl6040: Add jack support for
 headset and handset
Date: Mon, 6 Dec 2010 18:02:26 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCB6@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E4AE8103971
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:02:28 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

This patch adds support for reporting twl6040 headset and
handset jack events.

The machine driver retrieves and report the status  through
twl6040_hs_jack_detect in case of the early interrupt.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   26 ++++++++++++++++++++++++++
 sound/soc/codecs/twl6040.h |   12 ++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index b92f2b7..5dd5336 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -42,10 +42,16 @@
 #define TWL6040_RATES	 (SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 #define TWL6040_FORMATS	 (SNDRV_PCM_FMTBIT_S32_LE)
 
+struct twl6040_jack_data {
+	struct snd_soc_jack *jack;
+	int report;
+};
+
 /* codec private data */
 struct twl6040_data {
 	int audpwron;
 	int naudint;
+	struct twl6040_jack_data hs_jack;
 	int codec_powered;
 	int pll;
 	int non_lp;
@@ -386,6 +392,8 @@ static irqreturn_t twl6040_naudint_handler(int irq, void *data)
 {
 	struct snd_soc_codec *codec = data;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_jack_data *jack = &priv->hs_jack;
+	int report = 0;
 	u8 intid;
 
 	twl_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &intid, TWL6040_REG_INTID);
@@ -1011,6 +1019,24 @@ static int twl6040_resume(struct snd_soc_codec *codec)
 #define twl6040_resume NULL
 #endif
 
+void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
+			    struct snd_soc_jack *jack, int report)
+{
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	int status;
+
+	priv->hs_jack.jack = jack;
+	priv->hs_jack.report = report;
+
+	/* Sync status */
+	status = twl6040_read_reg_volatile(codec, TWL6040_REG_STATUS);
+	if (status & TWL6040_PLUGCOMP)
+		snd_soc_jack_report(jack, report, report);
+	else
+		snd_soc_jack_report(jack, 0, report);
+}
+EXPORT_SYMBOL_GPL(twl6040_hs_jack_detect);
+
 static int twl6040_probe(struct snd_soc_codec *codec)
 {
 	struct twl4030_codec_data *twl_codec = codec->dev->platform_data;
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index f7c77fa..5456c18 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -135,4 +135,16 @@
 #define TWL6040_HPPLL_ID		1
 #define TWL6040_LPPLL_ID		2
 
+/* STATUS (0x2E) fields */
+
+#define TWL6040_PLUGCOMP		0x02
+
+struct twl6040_setup_data {
+	void (*codec_enable)(int enable);
+	void *jack;
+};
+
+void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
+			    struct snd_soc_jack *jack, int report);
+
 #endif /* End of __TWL6040_H__ */
-- 
1.7.0.4
