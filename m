From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/13] ASoC: Move IO functions to soc-io.c
Date: Tue, 18 Mar 2014 09:02:07 +0100
Message-ID: <1395129736-11938-5-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 8520A261AFF
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:42 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

soc-core.c is getting quite crowded. Move all IO related functions that are
still in soc-core.c to soc-io.c

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 144 ---------------------------------------------------
 sound/soc/soc-io.c   | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 144 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0a39031..b66ccce 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2039,38 +2039,6 @@ int snd_soc_codec_writable_register(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_writable_register);
 
-int snd_soc_platform_read(struct snd_soc_platform *platform,
-					unsigned int reg)
-{
-	unsigned int ret;
-
-	if (!platform->driver->read) {
-		dev_err(platform->dev, "ASoC: platform has no read back\n");
-		return -1;
-	}
-
-	ret = platform->driver->read(platform, reg);
-	dev_dbg(platform->dev, "read %x => %x\n", reg, ret);
-	trace_snd_soc_preg_read(platform, reg, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snd_soc_platform_read);
-
-int snd_soc_platform_write(struct snd_soc_platform *platform,
-					 unsigned int reg, unsigned int val)
-{
-	if (!platform->driver->write) {
-		dev_err(platform->dev, "ASoC: platform has no write back\n");
-		return -1;
-	}
-
-	dev_dbg(platform->dev, "write %x = %x\n", reg, val);
-	trace_snd_soc_preg_write(platform, reg, val);
-	return platform->driver->write(platform, reg, val);
-}
-EXPORT_SYMBOL_GPL(snd_soc_platform_write);
-
 /**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
@@ -2289,118 +2257,6 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_soc_free_ac97_codec);
 
-unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	unsigned int ret;
-
-	ret = codec->read(codec, reg);
-	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
-	trace_snd_soc_reg_read(codec, reg, ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snd_soc_read);
-
-unsigned int snd_soc_write(struct snd_soc_codec *codec,
-			   unsigned int reg, unsigned int val)
-{
-	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
-	trace_snd_soc_reg_write(codec, reg, val);
-	return codec->write(codec, reg, val);
-}
-EXPORT_SYMBOL_GPL(snd_soc_write);
-
-/**
- * snd_soc_update_bits - update codec register bits
- * @codec: audio codec
- * @reg: codec register
- * @mask: register mask
- * @value: new value
- *
- * Writes new register value.
- *
- * Returns 1 for change, 0 for no change, or negative error code.
- */
-int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned int mask, unsigned int value)
-{
-	bool change;
-	unsigned int old, new;
-	int ret;
-
-	if (codec->using_regmap) {
-		ret = regmap_update_bits_check(codec->control_data, reg,
-					       mask, value, &change);
-	} else {
-		ret = snd_soc_read(codec, reg);
-		if (ret < 0)
-			return ret;
-
-		old = ret;
-		new = (old & ~mask) | (value & mask);
-		change = old != new;
-		if (change)
-			ret = snd_soc_write(codec, reg, new);
-	}
-
-	if (ret < 0)
-		return ret;
-
-	return change;
-}
-EXPORT_SYMBOL_GPL(snd_soc_update_bits);
-
-/**
- * snd_soc_update_bits_locked - update codec register bits
- * @codec: audio codec
- * @reg: codec register
- * @mask: register mask
- * @value: new value
- *
- * Writes new register value, and takes the codec mutex.
- *
- * Returns 1 for change else 0.
- */
-int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
-			       unsigned short reg, unsigned int mask,
-			       unsigned int value)
-{
-	int change;
-
-	mutex_lock(&codec->mutex);
-	change = snd_soc_update_bits(codec, reg, mask, value);
-	mutex_unlock(&codec->mutex);
-
-	return change;
-}
-EXPORT_SYMBOL_GPL(snd_soc_update_bits_locked);
-
-/**
- * snd_soc_test_bits - test register for change
- * @codec: audio codec
- * @reg: codec register
- * @mask: register mask
- * @value: new value
- *
- * Tests a register with a new value and checks if the new value is
- * different from the old value.
- *
- * Returns 1 for change else 0.
- */
-int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
-				unsigned int mask, unsigned int value)
-{
-	int change;
-	unsigned int old, new;
-
-	old = snd_soc_read(codec, reg);
-	new = (old & ~mask) | value;
-	change = old != new;
-
-	return change;
-}
-EXPORT_SYMBOL_GPL(snd_soc_test_bits);
-
 /**
  * snd_soc_cnew - create new control
  * @_template: control template
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 8aa0869..de1e496 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -19,6 +19,150 @@
 
 #include <trace/events/asoc.h>
 
+unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
+{
+	unsigned int ret;
+
+	ret = codec->read(codec, reg);
+	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
+	trace_snd_soc_reg_read(codec, reg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_read);
+
+unsigned int snd_soc_write(struct snd_soc_codec *codec,
+			   unsigned int reg, unsigned int val)
+{
+	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
+	trace_snd_soc_reg_write(codec, reg, val);
+	return codec->write(codec, reg, val);
+}
+EXPORT_SYMBOL_GPL(snd_soc_write);
+
+/**
+ * snd_soc_update_bits - update codec register bits
+ * @codec: audio codec
+ * @reg: codec register
+ * @mask: register mask
+ * @value: new value
+ *
+ * Writes new register value.
+ *
+ * Returns 1 for change, 0 for no change, or negative error code.
+ */
+int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
+				unsigned int mask, unsigned int value)
+{
+	bool change;
+	unsigned int old, new;
+	int ret;
+
+	if (codec->using_regmap) {
+		ret = regmap_update_bits_check(codec->control_data, reg,
+					       mask, value, &change);
+	} else {
+		ret = snd_soc_read(codec, reg);
+		if (ret < 0)
+			return ret;
+
+		old = ret;
+		new = (old & ~mask) | (value & mask);
+		change = old != new;
+		if (change)
+			ret = snd_soc_write(codec, reg, new);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return change;
+}
+EXPORT_SYMBOL_GPL(snd_soc_update_bits);
+
+/**
+ * snd_soc_update_bits_locked - update codec register bits
+ * @codec: audio codec
+ * @reg: codec register
+ * @mask: register mask
+ * @value: new value
+ *
+ * Writes new register value, and takes the codec mutex.
+ *
+ * Returns 1 for change else 0.
+ */
+int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
+			       unsigned short reg, unsigned int mask,
+			       unsigned int value)
+{
+	int change;
+
+	mutex_lock(&codec->mutex);
+	change = snd_soc_update_bits(codec, reg, mask, value);
+	mutex_unlock(&codec->mutex);
+
+	return change;
+}
+EXPORT_SYMBOL_GPL(snd_soc_update_bits_locked);
+
+/**
+ * snd_soc_test_bits - test register for change
+ * @codec: audio codec
+ * @reg: codec register
+ * @mask: register mask
+ * @value: new value
+ *
+ * Tests a register with a new value and checks if the new value is
+ * different from the old value.
+ *
+ * Returns 1 for change else 0.
+ */
+int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
+				unsigned int mask, unsigned int value)
+{
+	int change;
+	unsigned int old, new;
+
+	old = snd_soc_read(codec, reg);
+	new = (old & ~mask) | value;
+	change = old != new;
+
+	return change;
+}
+EXPORT_SYMBOL_GPL(snd_soc_test_bits);
+
+int snd_soc_platform_read(struct snd_soc_platform *platform,
+					unsigned int reg)
+{
+	unsigned int ret;
+
+	if (!platform->driver->read) {
+		dev_err(platform->dev, "ASoC: platform has no read back\n");
+		return -1;
+	}
+
+	ret = platform->driver->read(platform, reg);
+	dev_dbg(platform->dev, "read %x => %x\n", reg, ret);
+	trace_snd_soc_preg_read(platform, reg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_platform_read);
+
+int snd_soc_platform_write(struct snd_soc_platform *platform,
+					 unsigned int reg, unsigned int val)
+{
+	if (!platform->driver->write) {
+		dev_err(platform->dev, "ASoC: platform has no write back\n");
+		return -1;
+	}
+
+	dev_dbg(platform->dev, "write %x = %x\n", reg, val);
+	trace_snd_soc_preg_write(platform, reg, val);
+	return platform->driver->write(platform, reg, val);
+}
+EXPORT_SYMBOL_GPL(snd_soc_platform_write);
+
 #ifdef CONFIG_REGMAP
 static int hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		    unsigned int value)
-- 
1.8.0
