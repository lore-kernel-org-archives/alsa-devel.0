From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - make IO calls return a valid
	errno on failure.
Date: Mon, 25 Jul 2011 11:15:59 +0100
Message-ID: <1311588959-3512-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 3722210385F
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jul 2011 12:16:04 +0200 (CEST)
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

IO call failures should return an errno instead of -1

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |    4 ++--
 sound/soc/soc-dapm.c |    4 ++--
 sound/soc/soc-io.c   |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 159f144..fcf69f4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1661,7 +1661,7 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 
 	if (!platform->driver->read) {
 		dev_err(platform->dev, "platform has no read back\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	ret = platform->driver->read(platform, reg);
@@ -1677,7 +1677,7 @@ int snd_soc_platform_write(struct snd_soc_platform *platform,
 {
 	if (!platform->driver->write) {
 		dev_err(platform->dev, "platform has no write back\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	dev_dbg(platform->dev, "write %x = %x\n", reg, val);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3956670..45141fa 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -132,7 +132,7 @@ static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg)
 		return snd_soc_platform_read(w->platform, reg);
 
 	dev_err(w->dapm->dev, "no valid widget read method\n");
-	return -1;
+	return -EINVAL;
 }
 
 static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg, int val)
@@ -143,7 +143,7 @@ static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg, int val)
 		return snd_soc_platform_write(w->platform, reg, val);
 
 	dev_err(w->dapm->dev, "no valid widget write method\n");
-	return -1;
+	return -EINVAL;
 }
 
 static int soc_widget_update_bits(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index cca490c..166186c 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -41,7 +41,7 @@ static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
 	    !codec->cache_bypass) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret < 0)
-			return -1;
+			return ret;
 	}
 
 	if (codec->cache_only) {
@@ -67,7 +67,7 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
 	    snd_soc_codec_volatile_register(codec, reg) ||
 	    codec->cache_bypass) {
 		if (codec->cache_only)
-			return -1;
+			return -EINVAL;
 
 		BUG_ON(!codec->hw_read);
 		return codec->hw_read(codec, reg);
@@ -75,7 +75,7 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
 
 	ret = snd_soc_cache_read(codec, reg, &val);
 	if (ret < 0)
-		return -1;
+		return ret;
 	return val;
 }
 
-- 
1.7.4.1
