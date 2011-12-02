From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: Use a normal cache sync for WM8903
Date: Fri,  2 Dec 2011 19:28:12 +0000
Message-ID: <1322854095-14437-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111202192330.GA4333@opensource.wolfsonmicro.com>
	<1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 309DA2461A
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 20:28:20 +0100 (CET)
In-Reply-To: <1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The driver used to use a complicated method to sync the register cache
after having brought the bias level up to standby in resume due to the
use of the write sequencer to manage the initial power up. Now that we
don't use the write sequencer there is no need for this and we can just
use snd_soc_cache_sync() directly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 2cfa2fc..5113e64 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1767,23 +1767,11 @@ static int wm8903_suspend(struct snd_soc_codec *codec, pm_message_t state)
 
 static int wm8903_resume(struct snd_soc_codec *codec)
 {
-	int i;
-	u16 *reg_cache = codec->reg_cache;
-	u16 *tmp_cache = kmemdup(reg_cache, sizeof(wm8903_reg_defaults),
-				 GFP_KERNEL);
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 
-	/* Bring the codec back up to standby first to minimise pop/clicks */
-	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	snd_soc_cache_sync(codec);
 
-	/* Sync back everything else */
-	if (tmp_cache) {
-		for (i = 2; i < ARRAY_SIZE(wm8903_reg_defaults); i++)
-			if (tmp_cache[i] != reg_cache[i])
-				snd_soc_write(codec, i, tmp_cache[i]);
-		kfree(tmp_cache);
-	} else {
-		dev_err(codec->dev, "Failed to allocate temporary cache\n");
-	}
+	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
-- 
1.7.7.3
