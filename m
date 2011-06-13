From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove unused and about to be broken
	SND_SOC_CUSTOM I/O bus
Date: Mon, 13 Jun 2011 19:03:44 +0100
Message-ID: <1307988224-3899-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67D6D243C8
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 20:03:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This will be removed in -next so let's drop it from mainline as soon as
we can in order to minimise surprises.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This posting is against -next, sorry, but the update for 3.0 is
trivially obvious.

 include/sound/soc.h |    3 +--
 sound/soc/soc-io.c  |    3 ---
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4334ab2..6424b10 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -258,8 +258,7 @@ typedef int (*hw_write_t)(void *,const char* ,int);
 extern struct snd_ac97_bus_ops soc_ac97_ops;
 
 enum snd_soc_control_type {
-	SND_SOC_CUSTOM = 1,
-	SND_SOC_I2C,
+	SND_SOC_I2C = 1,
 	SND_SOC_SPI,
 };
 
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index df9338a..cca490c 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -367,9 +367,6 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	codec->bulk_write_raw = snd_soc_hw_bulk_write_raw;
 
 	switch (control) {
-	case SND_SOC_CUSTOM:
-		break;
-
 	case SND_SOC_I2C:
 #if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
 		codec->hw_write = (hw_write_t)i2c_master_send;
-- 
1.7.5.4
