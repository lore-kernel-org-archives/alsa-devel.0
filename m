From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: rt5665: Fix missing mutex_unlock in
	rt5665_calibrate
Date: Wed, 16 Nov 2016 21:08:41 +0800
Message-ID: <20161116130842.28182-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 024A22606F8
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 14:10:23 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id p66so14724525pga.2
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 05:10:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, Julia Lawall <julia.lawall@lip6.fr>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rt5665.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 34254fd..7dfaaf1 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4587,7 +4587,7 @@ static void rt5665_calibrate(struct rt5665_priv *rt5665)
 			pr_err("HP Calibration Failure\n");
 			regmap_write(rt5665->regmap, RT5665_RESET, 0);
 			regcache_cache_bypass(rt5665->regmap, false);
-			return;
+			goto out_unlock;
 		}
 
 		count++;
@@ -4606,7 +4606,7 @@ static void rt5665_calibrate(struct rt5665_priv *rt5665)
 			pr_err("MONO Calibration Failure\n");
 			regmap_write(rt5665->regmap, RT5665_RESET, 0);
 			regcache_cache_bypass(rt5665->regmap, false);
-			return;
+			goto out_unlock;
 		}
 
 		count++;
@@ -4621,6 +4621,7 @@ static void rt5665_calibrate(struct rt5665_priv *rt5665)
 	regmap_write(rt5665->regmap, RT5665_BIAS_CUR_CTRL_8, 0xa602);
 	regmap_write(rt5665->regmap, RT5665_ASRC_8, 0x0120);
 
+out_unlock:
 	mutex_unlock(&rt5665->calibrate_mutex);
 }
 
-- 
2.9.3
