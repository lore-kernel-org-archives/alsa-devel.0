From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Add platform read and write.
Date: Mon, 4 Jul 2011 11:10:15 +0100
Message-ID: <1309774215-4083-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 896F5103807
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 12:10:20 +0200 (CEST)
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

In preparation for ASoC Dynamic PCM (AKA DSP) support.

Allow platform driver to perform IO. Intended for platform DAPM.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc.h  |    8 ++++++++
 sound/soc/soc-core.c |   30 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6424b10..f30f3fe 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -312,6 +312,10 @@ int snd_soc_default_readable_register(struct snd_soc_codec *codec,
 				      unsigned int reg);
 int snd_soc_default_writable_register(struct snd_soc_codec *codec,
 				      unsigned int reg);
+int snd_soc_platform_read(struct snd_soc_platform *platform,
+					unsigned int reg);
+int snd_soc_platform_write(struct snd_soc_platform *platform,
+					unsigned int reg, unsigned int val);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
@@ -658,6 +662,10 @@ struct snd_soc_platform_driver {
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
 	int remove_order;
+
+	/* platform IO - used for platform DAPM */
+	unsigned int (*read)(struct snd_soc_platform *, unsigned int);
+	int (*write)(struct snd_soc_platform *, unsigned int, unsigned int);
 };
 
 struct snd_soc_platform {
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d49f0ed..d08abf4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1640,6 +1640,36 @@ int snd_soc_codec_writable_register(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_writable_register);
 
+int snd_soc_platform_read(struct snd_soc_platform *platform,
+					unsigned int reg)
+{
+	unsigned int ret;
+
+	if (!platform->driver->read) {
+		dev_err(platform->dev, "platform has no read back\n");
+		return -1;
+	}
+
+	ret = platform->driver->read(platform, reg);
+	dev_dbg(platform->dev, "read %x => %x\n", reg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_platform_read);
+
+int snd_soc_platform_write(struct snd_soc_platform *platform,
+					 unsigned int reg, unsigned int val)
+{
+	if (!platform->driver->write) {
+		dev_err(platform->dev, "platform has no write back\n");
+		return -1;
+	}
+
+	dev_dbg(platform->dev, "write %x = %x\n", reg, val);
+	return platform->driver->write(platform, reg, val);
+}
+EXPORT_SYMBOL_GPL(snd_soc_platform_write);
+
 /**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
-- 
1.7.4.1
