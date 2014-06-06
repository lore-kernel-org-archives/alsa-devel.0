From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: sigmadsp: Split regmap and I2C support
	into separate modules
Date: Fri,  6 Jun 2014 14:09:17 +0200
Message-ID: <1402056557-31348-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-252.synserver.de (smtp-out-252.synserver.de
 [212.40.185.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 98610265272
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 14:09:23 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

When the SigmaDSP module is built-in, but the I2C core is build as a module
we'll get a undefined reference:

	sound/built-in.o: In function `sigma_action_write_i2c':
		:(.text+0x5d8d4): undefined reference to `i2c_master_send'

This can happen if a audio driver that is using the regmap SigmaDSP interface is
built into the kernel, but core I2C support is build as a module. To fix this
split the SigmaDSP module into three modules, one module providing the core
infrastructure and two small modules implementing the regmap and I2C interfaces.
This allows e.g. the core infrastructure and regmap support to be built into the
kernel while I2C support can still be build as a module.

Fixes: dab464b60 ("ASoC: Add ADAU1361/ADAU1761 audio CODEC support")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/Kconfig           | 12 +++++--
 sound/soc/codecs/Makefile          |  4 +++
 sound/soc/codecs/sigmadsp-i2c.c    | 35 ++++++++++++++++++++
 sound/soc/codecs/sigmadsp-regmap.c | 36 +++++++++++++++++++++
 sound/soc/codecs/sigmadsp.c        | 65 ++------------------------------------
 sound/soc/codecs/sigmadsp.h        | 20 ++++++++++++
 6 files changed, 107 insertions(+), 65 deletions(-)
 create mode 100644 sound/soc/codecs/sigmadsp-i2c.c
 create mode 100644 sound/soc/codecs/sigmadsp-regmap.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cbfa1e1..0b9571c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -225,11 +225,11 @@ config SND_SOC_ADAU1373
 config SND_SOC_ADAU1701
 	tristate "Analog Devices ADAU1701 CODEC"
 	depends on I2C
-	select SND_SOC_SIGMADSP
+	select SND_SOC_SIGMADSP_I2C
 
 config SND_SOC_ADAU17X1
 	tristate
-	select SND_SOC_SIGMADSP
+	select SND_SOC_SIGMADSP_REGMAP
 
 config SND_SOC_ADAU1761
 	tristate
@@ -476,6 +476,14 @@ config SND_SOC_SIGMADSP
 	tristate
 	select CRC32
 
+config SND_SOC_SIGMADSP_I2C
+	tristate
+	select SND_SOC_SIGMADSP
+
+config SND_SOC_SIGMADSP_REGMAP
+	tristate
+	select SND_SOC_SIGMADSP
+
 config SND_SOC_SIRF_AUDIO_CODEC
 	tristate "SiRF SoC internal audio codec"
 	select REGMAP_MMIO
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index be3377b..1bd6e1c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -77,6 +77,8 @@ snd-soc-sgtl5000-objs := sgtl5000.o
 snd-soc-alc5623-objs := alc5623.o
 snd-soc-alc5632-objs := alc5632.o
 snd-soc-sigmadsp-objs := sigmadsp.o
+snd-soc-sigmadsp-i2c-objs := sigmadsp-i2c.o
+snd-soc-sigmadsp-regmap-objs := sigmadsp-regmap.o
 snd-soc-si476x-objs := si476x.o
 snd-soc-sirf-audio-codec-objs := sirf-audio-codec.o
 snd-soc-sn95031-objs := sn95031.o
@@ -240,6 +242,8 @@ obj-$(CONFIG_SND_SOC_RT5651)	+= snd-soc-rt5651.o
 obj-$(CONFIG_SND_SOC_RT5677)	+= snd-soc-rt5677.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
+obj-$(CONFIG_SND_SOC_SIGMADSP_I2C)	+= snd-soc-sigmadsp-i2c.o
+obj-$(CONFIG_SND_SOC_SIGMADSP_REGMAP)	+= snd-soc-sigmadsp-regmap.o
 obj-$(CONFIG_SND_SOC_SI476X)	+= snd-soc-si476x.o
 obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif-rx.o snd-soc-spdif-tx.o
diff --git a/sound/soc/codecs/sigmadsp-i2c.c b/sound/soc/codecs/sigmadsp-i2c.c
new file mode 100644
index 0000000..246081a
--- /dev/null
+++ b/sound/soc/codecs/sigmadsp-i2c.c
@@ -0,0 +1,35 @@
+/*
+ * Load Analog Devices SigmaStudio firmware files
+ *
+ * Copyright 2009-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/i2c.h>
+#include <linux/export.h>
+#include <linux/module.h>
+
+#include "sigmadsp.h"
+
+static int sigma_action_write_i2c(void *control_data,
+	const struct sigma_action *sa, size_t len)
+{
+	return i2c_master_send(control_data, (const unsigned char *)&sa->addr,
+		len);
+}
+
+int process_sigma_firmware(struct i2c_client *client, const char *name)
+{
+	struct sigma_firmware ssfw;
+
+	ssfw.control_data = client;
+	ssfw.write = sigma_action_write_i2c;
+
+	return _process_sigma_firmware(&client->dev, &ssfw, name);
+}
+EXPORT_SYMBOL(process_sigma_firmware);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("SigmaDSP I2C firmware loader");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/sigmadsp-regmap.c b/sound/soc/codecs/sigmadsp-regmap.c
new file mode 100644
index 0000000..f78ed8d
--- /dev/null
+++ b/sound/soc/codecs/sigmadsp-regmap.c
@@ -0,0 +1,36 @@
+/*
+ * Load Analog Devices SigmaStudio firmware files
+ *
+ * Copyright 2009-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/regmap.h>
+#include <linux/export.h>
+#include <linux/module.h>
+
+#include "sigmadsp.h"
+
+static int sigma_action_write_regmap(void *control_data,
+	const struct sigma_action *sa, size_t len)
+{
+	return regmap_raw_write(control_data, be16_to_cpu(sa->addr),
+		sa->payload, len - 2);
+}
+
+int process_sigma_firmware_regmap(struct device *dev, struct regmap *regmap,
+	const char *name)
+{
+	struct sigma_firmware ssfw;
+
+	ssfw.control_data = regmap;
+	ssfw.write = sigma_action_write_regmap;
+
+	return _process_sigma_firmware(dev, &ssfw, name);
+}
+EXPORT_SYMBOL(process_sigma_firmware_regmap);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("SigmaDSP regmap firmware loader");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index 4068f24..f2de7e0 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -34,23 +34,6 @@ enum {
 	SIGMA_ACTION_END,
 };
 
-struct sigma_action {
-	u8 instr;
-	u8 len_hi;
-	__le16 len;
-	__be16 addr;
-	unsigned char payload[];
-} __packed;
-
-struct sigma_firmware {
-	const struct firmware *fw;
-	size_t pos;
-
-	void *control_data;
-	int (*write)(void *control_data, const struct sigma_action *sa,
-			size_t len);
-};
-
 static inline u32 sigma_action_len(struct sigma_action *sa)
 {
 	return (sa->len_hi << 16) | le16_to_cpu(sa->len);
@@ -138,7 +121,7 @@ process_sigma_actions(struct sigma_firmware *ssfw)
 	return 0;
 }
 
-static int _process_sigma_firmware(struct device *dev,
+int _process_sigma_firmware(struct device *dev,
 	struct sigma_firmware *ssfw, const char *name)
 {
 	int ret;
@@ -197,50 +180,6 @@ static int _process_sigma_firmware(struct device *dev,
 
 	return ret;
 }
-
-#if IS_ENABLED(CONFIG_I2C)
-
-static int sigma_action_write_i2c(void *control_data,
-	const struct sigma_action *sa, size_t len)
-{
-	return i2c_master_send(control_data, (const unsigned char *)&sa->addr,
-		len);
-}
-
-int process_sigma_firmware(struct i2c_client *client, const char *name)
-{
-	struct sigma_firmware ssfw;
-
-	ssfw.control_data = client;
-	ssfw.write = sigma_action_write_i2c;
-
-	return _process_sigma_firmware(&client->dev, &ssfw, name);
-}
-EXPORT_SYMBOL(process_sigma_firmware);
-
-#endif
-
-#if IS_ENABLED(CONFIG_REGMAP)
-
-static int sigma_action_write_regmap(void *control_data,
-	const struct sigma_action *sa, size_t len)
-{
-	return regmap_raw_write(control_data, be16_to_cpu(sa->addr),
-		sa->payload, len - 2);
-}
-
-int process_sigma_firmware_regmap(struct device *dev, struct regmap *regmap,
-	const char *name)
-{
-	struct sigma_firmware ssfw;
-
-	ssfw.control_data = regmap;
-	ssfw.write = sigma_action_write_regmap;
-
-	return _process_sigma_firmware(dev, &ssfw, name);
-}
-EXPORT_SYMBOL(process_sigma_firmware_regmap);
-
-#endif
+EXPORT_SYMBOL_GPL(_process_sigma_firmware);
 
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/sigmadsp.h b/sound/soc/codecs/sigmadsp.h
index e439cbd..c47cd23 100644
--- a/sound/soc/codecs/sigmadsp.h
+++ b/sound/soc/codecs/sigmadsp.h
@@ -12,6 +12,26 @@
 #include <linux/device.h>
 #include <linux/regmap.h>
 
+struct sigma_action {
+	u8 instr;
+	u8 len_hi;
+	__le16 len;
+	__be16 addr;
+	unsigned char payload[];
+} __packed;
+
+struct sigma_firmware {
+	const struct firmware *fw;
+	size_t pos;
+
+	void *control_data;
+	int (*write)(void *control_data, const struct sigma_action *sa,
+			size_t len);
+};
+
+int _process_sigma_firmware(struct device *dev,
+	struct sigma_firmware *ssfw, const char *name);
+
 struct i2c_client;
 
 extern int process_sigma_firmware(struct i2c_client *client, const char *name);
-- 
1.8.0
