From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Allow runtime reconfiguration
	of the output mode
Date: Fri,  4 Jan 2013 19:37:04 +0000
Message-ID: <1357328224-3859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF58F264F07
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 20:37:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some systems use external analogue switches to connect more analogue
devices to the CODEC than are supported by the device.  In some systems
this requires changing the switched output from single ended to
differential mode dynamically at runtime. Add a new function
arizona_set_output_mode() to support this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   34 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/arizona.h |    3 +++
 2 files changed, 37 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 7724b4b..6d98cf4 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1176,6 +1176,40 @@ int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
 }
 EXPORT_SYMBOL_GPL(arizona_init_fll);
 
+/**
+ * arizona_set_output_mode - Set the mode of the specified output
+ *
+ * @codec: Device to configure
+ * @output: Output number
+ * @diff: True to set the output to differential mode
+ *
+ * Some systems use external analogue switches to connect more
+ * analogue devices to the CODEC than are supported by the device.  In
+ * some systems this requires changing the switched output from single
+ * ended to differential mode dynamically at runtime, an operation
+ * supported using this function.
+ *
+ * Most systems have a single static configuration and should use
+ * platform data instead.
+ */
+int arizona_set_output_mode(struct snd_soc_codec *codec, int output, bool diff)
+{
+	unsigned int reg, val;
+
+	if (output < 1 || output > 6)
+		return -EINVAL;
+
+	reg = ARIZONA_OUTPUT_PATH_CONFIG_1L + (output - 1) * 8;
+
+	if (diff)
+		val = ARIZONA_OUT1_MONO;
+	else
+		val = 0;
+
+	return snd_soc_update_bits(codec, reg, ARIZONA_OUT1_MONO, val);
+}
+EXPORT_SYMBOL_GPL(arizona_set_output_mode);
+
 MODULE_DESCRIPTION("ASoC Wolfson Arizona class device support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 68dfae5..697ff6f 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -213,4 +213,7 @@ extern int arizona_set_fll(struct arizona_fll *fll, int source,
 
 extern int arizona_init_dai(struct arizona_priv *priv, int dai);
 
+int arizona_set_output_mode(struct snd_soc_codec *codec, int output,
+			    bool diff);
+
 #endif
-- 
1.7.10.4
