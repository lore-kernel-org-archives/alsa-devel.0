From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Use standard cache sync code in
	wm8961
Date: Sat, 17 Dec 2011 09:39:16 +0000
Message-ID: <1324114756-24254-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1324114756-24254-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 309C7244AF
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2011 10:39:20 +0100 (CET)
In-Reply-To: <1324114756-24254-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

We write the reset register with the default value so it should not be
mistakenly written.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8961.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 8bcc17a..4f20c72 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1047,18 +1047,7 @@ static int wm8961_suspend(struct snd_soc_codec *codec)
 
 static int wm8961_resume(struct snd_soc_codec *codec)
 {
-	u16 *reg_cache = codec->reg_cache;
-	int i;
-
-	for (i = 0; i < codec->driver->reg_cache_size; i++) {
-		if (reg_cache[i] == wm8961_reg_defaults[i])
-			continue;
-
-		if (i == WM8961_SOFTWARE_RESET)
-			continue;
-
-		snd_soc_write(codec, i, reg_cache[i]);
-	}
+	snd_soc_cache_sync(codec);
 
 	wm8961_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.7.7.3
