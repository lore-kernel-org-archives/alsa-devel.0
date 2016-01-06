From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Fix PGA clear when disabling DRE
Date: Wed, 6 Jan 2016 15:15:37 +0000
Message-ID: <1452093337-30396-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id E0C6A26040E
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2016 16:15:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

We don't want to use a bypassed write in wm5110_clear_pga_volume,
we might disable the DRE whilst the CODEC is powered down. A
normal regmap_write will always go to the hardware (when not on
cache_only) even if the written value matches the cache. As using
a normal write will still achieve the desired behaviour of bring
the cache and hardware in sync, this patch updates the function
to use a normal write, which avoids issues when the CODEC is
powered down.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index ee11b97..6088d30 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -360,15 +360,13 @@ static int wm5110_hp_ev(struct snd_soc_dapm_widget *w,
 
 static int wm5110_clear_pga_volume(struct arizona *arizona, int output)
 {
-	struct reg_sequence clear_pga = {
-		ARIZONA_OUTPUT_PATH_CONFIG_1L + output * 4, 0x80
-	};
+	unsigned int reg = ARIZONA_OUTPUT_PATH_CONFIG_1L + output * 4;
 	int ret;
 
-	ret = regmap_multi_reg_write_bypassed(arizona->regmap, &clear_pga, 1);
+	ret = regmap_write(arizona->regmap, reg, 0x80);
 	if (ret)
 		dev_err(arizona->dev, "Failed to clear PGA (0x%x): %d\n",
-			clear_pga.reg, ret);
+			reg, ret);
 
 	return ret;
 }
-- 
2.1.4
