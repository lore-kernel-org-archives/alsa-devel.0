From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: soc-cache: Introduce raw bulk write
	support
Date: Tue, 22 Mar 2011 10:37:03 +0000
Message-ID: <1300790223-13308-7-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BAD09103865
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 11:37:14 +0100 (CET)
In-Reply-To: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

As it has become more common to have to write firmware or similar
large chunks of data to the hardware, add a function to perform
raw bulk writes that bypass the cache.  This only handles volatile
registers as we should avoid getting out of sync with the actual
cache.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    3 +++
 sound/soc/soc-cache.c |   39 +++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-core.c  |    7 +++++++
 3 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index abb56ef..4a11795 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -544,6 +544,7 @@ struct snd_soc_codec {
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
+	int (*bulk_write_raw)(struct snd_soc_codec *, unsigned int, const void *, size_t);
 	void *reg_cache;
 	const void *reg_def_copy;
 	const struct snd_soc_cache_ops *cache_ops;
@@ -815,6 +816,8 @@ struct soc_enum {
 unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg);
 unsigned int snd_soc_write(struct snd_soc_codec *codec,
 			   unsigned int reg, unsigned int val);
+unsigned int snd_soc_bulk_write_raw(struct snd_soc_codec *codec,
+				    unsigned int reg, const void *data, size_t len);
 
 /* device driver data */
 
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 9ae0593..86beaad 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -394,6 +394,44 @@ static int snd_soc_16_16_spi_write(void *control_data, const char *data,
 #define snd_soc_16_16_spi_write NULL
 #endif
 
+/* Primitive bulk write support for soc-cache.  The data pointed to by `data' needs
+ * to already be in the form the hardware expects including any leading register specific
+ * data.  Any data written through this function will not go through the cache as it
+ * only handles writing to volatile or out of bounds registers.
+ */
+static int snd_soc_hw_bulk_write_raw(struct snd_soc_codec *codec, unsigned int reg,
+				     const void *data, size_t len)
+{
+	int ret;
+
+	/* Ensure that the base register is volatile.  Subsequently
+	 * any other register that is touched by this routine should be
+	 * volatile as well to ensure that we don't get out of sync with
+	 * the cache.
+	 */
+	if (!snd_soc_codec_volatile_register(codec, reg)
+	    && reg < codec->driver->reg_cache_size)
+		return -EINVAL;
+
+	switch (codec->control_type) {
+	case SND_SOC_I2C:
+		ret = i2c_master_send(codec->control_data, data, len);
+		break;
+	case SND_SOC_SPI:
+		ret = do_spi_write(codec->control_data, data, len);
+		break;
+	default:
+		BUG();
+	}
+
+	if (ret == len)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
 static struct {
 	int addr_bits;
 	int data_bits;
@@ -477,6 +515,7 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 
 	codec->write = io_types[i].write;
 	codec->read = io_types[i].read;
+	codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
 
 	switch (control) {
 	case SND_SOC_CUSTOM:
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4dda589..636328e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2228,6 +2228,13 @@ unsigned int snd_soc_write(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_write);
 
+unsigned int snd_soc_bulk_write_raw(struct snd_soc_codec *codec,
+				    unsigned int reg, const void *data, size_t len)
+{
+	return codec->bulk_write_raw(codec, reg, data, len);
+}
+EXPORT_SYMBOL_GPL(snd_soc_bulk_write_raw);
+
 /**
  * snd_soc_update_bits - update codec register bits
  * @codec: audio codec
-- 
1.7.4.1
