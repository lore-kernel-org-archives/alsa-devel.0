From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH v2 1/3] ASoC: soc-cache: Add support for
	default readable()/volatile() functions
Date: Thu, 13 Jan 2011 12:20:36 +0000
Message-ID: <1294921238-11859-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C80DE10382F
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 13:20:46 +0100 (CET)
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
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

For common scenarios, device drivers can provide a table of all the
registers that are at least either readable/writable/volatile.  The idea
is that if a register lookup fails, all of its read/write/vol members
will be zero and will be treated as default.  This also reduces the
size of the register access array.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |   22 ++++++++++++++++++++++
 sound/soc/soc-cache.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d609232..b8acf99 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -276,6 +276,10 @@ int snd_soc_cache_write(struct snd_soc_codec *codec,
 			unsigned int reg, unsigned int value);
 int snd_soc_cache_read(struct snd_soc_codec *codec,
 		       unsigned int reg, unsigned int *value);
+int snd_soc_default_volatile_register(struct snd_soc_codec *codec,
+				      unsigned int reg);
+int snd_soc_default_readable_register(struct snd_soc_codec *codec,
+				      unsigned int reg);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
@@ -367,6 +371,22 @@ int snd_soc_put_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 
 /**
+ * struct snd_soc_reg_access - Describes whether a given register is
+ * readable, writable or volatile.
+ *
+ * @reg: the register number
+ * @read: whether this register is readable
+ * @write: whether this register is writable
+ * @vol: whether this register is volatile
+ */
+struct snd_soc_reg_access {
+	u16 reg;
+	u16 read;
+	u16 write;
+	u16 vol;
+};
+
+/**
  * struct snd_soc_jack_pin - Describes a pin to update based on jack detection
  *
  * @pin:    name of the pin to update
@@ -515,6 +535,8 @@ struct snd_soc_codec_driver {
 	short reg_cache_step;
 	short reg_word_size;
 	const void *reg_cache_default;
+	short reg_access_size;
+	const struct snd_soc_reg_access *reg_access_default;
 	enum snd_soc_compress_type compress_type;
 
 	/* codec bias level */
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 1a36b36..d97a59f 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1603,3 +1603,52 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_cache_sync);
+
+static int snd_soc_get_reg_access_index(struct snd_soc_codec *codec,
+					unsigned int reg)
+{
+	const struct snd_soc_codec_driver *codec_drv;
+	unsigned int min, max, index;
+
+	codec_drv = codec->driver;
+	min = 0;
+	max = codec_drv->reg_access_size - 1;
+	do {
+		index = (min + max) / 2;
+		if (codec_drv->reg_access_default[index].reg == reg)
+			return index;
+		if (codec_drv->reg_access_default[index].reg < reg)
+			min = index + 1;
+		else
+			max = index;
+	} while (min <= max);
+	return -1;
+}
+
+int snd_soc_default_volatile_register(struct snd_soc_codec *codec,
+				      unsigned int reg)
+{
+	int index;
+
+	if (reg >= codec->driver->reg_cache_size)
+		return 1;
+	index = snd_soc_get_reg_access_index(codec, reg);
+	if (index < 0)
+		return 0;
+	return codec->driver->reg_access_default[index].vol;
+}
+EXPORT_SYMBOL_GPL(snd_soc_default_volatile_register);
+
+int snd_soc_default_readable_register(struct snd_soc_codec *codec,
+				      unsigned int reg)
+{
+	int index;
+
+	if (reg >= codec->driver->reg_cache_size)
+		return 1;
+	index = snd_soc_get_reg_access_index(codec, reg);
+	if (index < 0)
+		return 0;
+	return codec->driver->reg_access_default[index].read;
+}
+EXPORT_SYMBOL_GPL(snd_soc_default_readable_register);
-- 
1.7.3.5
