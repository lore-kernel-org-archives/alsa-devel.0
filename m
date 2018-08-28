From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/7] ASoC: dapm: Remove clock framework ifdefs
Date: Tue, 28 Aug 2018 14:35:02 +0100
Message-ID: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D2492678C2
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 15:35:13 +0200 (CEST)
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The clock code now has stub functions defined in its header files so
the ifdefs around clocking code should no longer be necessary.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 461d951917c0..78ab6965af55 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1320,14 +1320,13 @@ int dapm_clock_event(struct snd_soc_dapm_widget *w,
 
 	soc_dapm_async_complete(w->dapm);
 
-#ifdef CONFIG_HAVE_CLK
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		return clk_prepare_enable(w->clk);
 	} else {
 		clk_disable_unprepare(w->clk);
 		return 0;
 	}
-#endif
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dapm_clock_event);
@@ -3498,7 +3497,6 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		}
 		break;
 	case snd_soc_dapm_clock_supply:
-#ifdef CONFIG_CLKDEV_LOOKUP
 		w->clk = devm_clk_get(dapm->dev, w->name);
 		if (IS_ERR(w->clk)) {
 			ret = PTR_ERR(w->clk);
@@ -3508,9 +3506,6 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 				w->name, ret);
 			return NULL;
 		}
-#else
-		return NULL;
-#endif
 		break;
 	default:
 		break;
-- 
2.11.0
