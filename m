From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Allow CODECs to ask soc-cache to
	suppress physical writes
Date: Wed,  3 Feb 2010 18:05:01 +0000
Message-ID: <1265220302-26589-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55BBA103827
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 19:05:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently the soc-cache code will always write to the device, meaning
that we need the device to be powered and active at pretty much all
times the system is active.  Allowing cache only writes lays some
groundwork for future enhancements to allow devices to be put into a
full off state when the audio subsystem is idle.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/soc.h   |    1 +
 sound/soc/soc-cache.c |   26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4bbeb9f..4e8f14b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -423,6 +423,7 @@ struct snd_soc_codec {
 	short reg_cache_step;
 
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
+	unsigned int cache_only:1;  /* Suppress writes to hardware */
 
 	/* dapm */
 	u32 pop_time;
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 097e335..84b6916 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -38,6 +38,10 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	if (reg < codec->reg_cache_size)
 		cache[reg] = value;
+
+	if (codec->cache_only)
+		return 0;
+
 	ret = codec->hw_write(codec->control_data, data, 2);
 	if (ret == 2)
 		return 0;
@@ -100,6 +104,10 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	if (reg < codec->reg_cache_size)
 		cache[reg] = value;
+
+	if (codec->cache_only)
+		return 0;
+
 	ret = codec->hw_write(codec->control_data, data, 2);
 	if (ret == 2)
 		return 0;
@@ -153,6 +161,9 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (reg < codec->reg_cache_size)
 		cache[reg] = value;
 
+	if (codec->cache_only)
+		return 0;
+
 	if (codec->hw_write(codec->control_data, data, 2) == 2)
 		return 0;
 	else
@@ -181,6 +192,9 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (!snd_soc_codec_volatile_register(codec, reg))
 		reg_cache[reg] = value;
 
+	if (codec->cache_only)
+		return 0;
+
 	if (codec->hw_write(codec->control_data, data, 3) == 3)
 		return 0;
 	else
@@ -193,10 +207,14 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 	u16 *cache = codec->reg_cache;
 
 	if (reg >= codec->reg_cache_size ||
-	    snd_soc_codec_volatile_register(codec, reg))
+	    snd_soc_codec_volatile_register(codec, reg)) {
+		if (codec->cache_only)
+			return -EINVAL;
+
 		return codec->hw_read(codec, reg);
-	else
+	} else {
 		return cache[reg];
+	}
 }
 
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
@@ -294,6 +312,10 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	reg &= 0xff;
 	if (reg < codec->reg_cache_size)
 		cache[reg] = value;
+
+	if (codec->cache_only)
+		return 0;
+
 	ret = codec->hw_write(codec->control_data, data, 3);
 	if (ret == 3)
 		return 0;
-- 
1.6.6
