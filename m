From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: io: Remove SND_SOC_I2C
Date: Thu, 20 Feb 2014 09:11:10 +0900
Message-ID: <1392855070-27700-2-git-send-email-broonie@kernel.org>
References: <1392855070-27700-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DF95C26531A
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 01:11:41 +0100 (CET)
In-Reply-To: <1392855070-27700-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Now that all users have been converted to regmap we can eliminate the ASoC
level wrapper for I2C I/O reducing the amount of duplicated functionality.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 include/sound/soc.h | 1 -
 sound/soc/soc-io.c  | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 21038e0..de07934 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -355,7 +355,6 @@ typedef int (*hw_write_t)(void *,const char* ,int);
 extern struct snd_ac97_bus_ops *soc_ac97_ops;
 
 enum snd_soc_control_type {
-	SND_SOC_I2C = 1,
 	SND_SOC_REGMAP,
 };
 
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 3a0d99e..add99e2 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -99,13 +99,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	config.val_bits = data_bits;
 
 	switch (control) {
-#if IS_ENABLED(CONFIG_REGMAP_I2C)
-	case SND_SOC_I2C:
-		codec->control_data = regmap_init_i2c(to_i2c_client(codec->dev),
-						      &config);
-		break;
-#endif
-
 	case SND_SOC_REGMAP:
 		/* Device has made its own regmap arrangements */
 		codec->using_regmap = true;
-- 
1.9.0.rc3
