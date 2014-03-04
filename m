From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: io: Remove hw_read() operation
Date: Tue,  4 Mar 2014 17:10:51 +0800
Message-ID: <1393924251-6754-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F096C26573F
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 10:11:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

We now no longer have any users of hw_read() in the kernel so remove the
code in order to prevent any new users being added. Users should be using
regmap.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/sound/soc.h |  1 -
 sound/soc/soc-io.c  | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 56c4c71..dc36331 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -706,7 +706,6 @@ struct snd_soc_codec {
 	/* codec IO */
 	void *control_data; /* codec control (i2c/3wire) data */
 	hw_write_t hw_write;
-	unsigned int (*hw_read)(struct snd_soc_codec *, unsigned int);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
 	void *reg_cache;
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index c3b6a0a..3c1de9c 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -26,18 +26,6 @@ static int hw_write(struct snd_soc_codec *codec, unsigned int reg,
 	return regmap_write(codec->control_data, reg, value);
 }
 
-static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	int ret;
-	unsigned int val;
-
-	ret = regmap_read(codec->control_data, reg, &val);
-	if (ret == 0)
-		return val;
-	else
-		return -1;
-}
-
 /**
  * snd_soc_codec_set_cache_io: Set up standard I/O functions.
  *
@@ -64,7 +52,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	int ret;
 
 	codec->write = hw_write;
-	codec->read = hw_read;
 
 	switch (control) {
 	case SND_SOC_REGMAP:
-- 
1.9.0
