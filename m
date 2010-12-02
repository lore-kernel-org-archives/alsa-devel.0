From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Move active copy of CODEC read and
	write into runtime structure
Date: Thu,  2 Dec 2010 17:05:16 +0000
Message-ID: <1291309516-10322-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1291309516-10322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87B45103AEB
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 18:05:19 +0100 (CET)
In-Reply-To: <1291309516-10322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We shouldn't be assigning to the driver structure (which really ought
to be const, further patch to follow) though there's unlikely to be any
actual problem except in the unlikely case that two devices with the
same driver but different bus types appear in the same system.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    2 ++
 sound/soc/soc-cache.c |    4 ++--
 sound/soc/soc-core.c  |    6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4a9195c..714a704 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -476,6 +476,8 @@ struct snd_soc_codec {
 	void *control_data; /* codec control (i2c/3wire) data */
 	hw_write_t hw_write;
 	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
+	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
+	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
 	void *reg_cache;
 	const struct snd_soc_cache_ops *cache_ops;
 	struct mutex cache_rw_mutex;
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 5143984..78b25e8 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -728,8 +728,8 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 		return -EINVAL;
 	}
 
-	codec->driver->write = io_types[i].write;
-	codec->driver->read = io_types[i].read;
+	codec->write = io_types[i].write;
+	codec->read = io_types[i].read;
 
 	switch (control) {
 	case SND_SOC_CUSTOM:
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 20dcc97..5720dbc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2077,7 +2077,7 @@ unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
 {
 	unsigned int ret;
 
-	ret = codec->driver->read(codec, reg);
+	ret = codec->read(codec, reg);
 	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
 	trace_snd_soc_reg_read(codec, reg, ret);
 
@@ -2090,7 +2090,7 @@ unsigned int snd_soc_write(struct snd_soc_codec *codec,
 {
 	dev_dbg(codec->dev, "write %x = %x\n", reg, val);
 	trace_snd_soc_reg_write(codec, reg, val);
-	return codec->driver->write(codec, reg, val);
+	return codec->write(codec, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_write);
 
@@ -3448,6 +3448,8 @@ int snd_soc_register_codec(struct device *dev,
 
 	INIT_LIST_HEAD(&codec->dapm.widgets);
 	INIT_LIST_HEAD(&codec->dapm.paths);
+	codec->write = codec_drv->write;
+	codec->read = codec_drv->read;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
-- 
1.7.1
