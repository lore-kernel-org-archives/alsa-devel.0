From: Joe Perches <joe@perches.com>
Subject: [PATCH 62/62] sound: Remove unnecessary semicolons
Date: Sun, 28 Jun 2009 09:27:07 -0700
Message-ID: <abb8165c1dd4442d61748f23a8033d8bc8fc8be0.1246173683.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755969AbZF1Qny@vger.kernel.org>
In-Reply-To: <cover.1246173664.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/oss/sys_timer.c               |    3 ---
 sound/soc/codecs/wm9081.c           |    2 +-
 sound/soc/pxa/pxa-ssp.c             |    2 +-
 sound/soc/s3c24xx/s3c24xx_uda134x.c |    2 +-
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/oss/sys_timer.c b/sound/oss/sys_timer.c
index 1075344..8db6aef 100644
--- a/sound/oss/sys_timer.c
+++ b/sound/oss/sys_timer.c
@@ -100,9 +100,6 @@ def_tmr_open(int dev, int mode)
 	curr_tempo = 60;
 	curr_timebase = 100;
 	opened = 1;
-
-	;
-
 	{
 		def_tmr.expires = (1) + jiffies;
 		add_timer(&def_tmr);
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 86fc57e..220eebc 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1079,7 +1079,7 @@ static int wm9081_hw_params(struct snd_pcm_substream *substream,
 		       - wm9081->fs);
 	for (i = 1; i < ARRAY_SIZE(clk_sys_rates); i++) {
 		cur_val = abs((wm9081->sysclk_rate /
-			       clk_sys_rates[i].ratio) - wm9081->fs);;
+			       clk_sys_rates[i].ratio) - wm9081->fs);
 		if (cur_val < best_val) {
 			best = i;
 			best_val = cur_val;
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 19c4540..af87986 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -351,7 +351,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
 			do_div(tmp, freq_out);
 			val = tmp;
 
-			val = (val << 16) | 64;;
+			val = (val << 16) | 64;
 			ssp_write_reg(ssp, SSACDD, val);
 
 			ssacd |= (0x6 << 4);
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 8e79a41..c215d32 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -67,7 +67,7 @@ static int s3c24xx_uda134x_startup(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 #ifdef ENFORCE_RATES
-	struct snd_pcm_runtime *runtime = substream->runtime;;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 #endif
 
 	mutex_lock(&clk_lock);
-- 
1.6.3.1.10.g659a0.dirty
