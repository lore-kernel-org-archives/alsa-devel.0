From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: rt5665: Unlock on error in rt5665_calibrate()
Date: Fri, 18 Nov 2016 14:56:11 +0300
Message-ID: <20161118115611.GA3784@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We should probably unlock before returning here.

Fixes: 33ada14a26c8 ("ASoC: add rt5665 codec driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 34254fd..25bd01b 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4587,7 +4587,7 @@ static void rt5665_calibrate(struct rt5665_priv *rt5665)
 			pr_err("HP Calibration Failure\n");
 			regmap_write(rt5665->regmap, RT5665_RESET, 0);
 			regcache_cache_bypass(rt5665->regmap, false);
-			return;
+			goto unlock;
 		}
 
 		count++;
@@ -4606,7 +4606,7 @@ static void rt5665_calibrate(struct rt5665_priv *rt5665)
 			pr_err("MONO Calibration Failure\n");
 			regmap_write(rt5665->regmap, RT5665_RESET, 0);
 			regcache_cache_bypass(rt5665->regmap, false);
-			return;
+			goto unlock;
 		}
 
 		count++;
@@ -4620,7 +4620,7 @@ static void rt5665_calibrate(struct rt5665_priv *rt5665)
 
 	regmap_write(rt5665->regmap, RT5665_BIAS_CUR_CTRL_8, 0xa602);
 	regmap_write(rt5665->regmap, RT5665_ASRC_8, 0x0120);
-
+unlock:
 	mutex_unlock(&rt5665->calibrate_mutex);
 }
 
