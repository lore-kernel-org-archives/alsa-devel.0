From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: dapm: Bodge for lack of a widely
	available clk API
Date: Mon,  4 Jun 2012 08:19:20 +0100
Message-ID: <1338794360-28558-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1338794360-28558-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7ED9103F6C
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 09:19:22 +0200 (CEST)
In-Reply-To: <1338794360-28558-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a66379a..11a88d8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1011,12 +1011,14 @@ int dapm_clock_event(struct snd_soc_dapm_widget *w,
 	if (!w->clk)
 		return -EIO;
 
+#ifdef CONFIG_HAVE_CLK
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		return clk_enable(w->clk);
 	} else {
 		clk_disable(w->clk);
 		return 0;
 	}
+#endif
 }
 EXPORT_SYMBOL_GPL(dapm_clock_event);
 
@@ -2902,6 +2904,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		}
 		break;
 	case snd_soc_dapm_clock_supply:
+#ifdef CONFIG_HAVE_CLK
 		w->clk = devm_clk_get(dapm->dev, w->name);
 		if (IS_ERR(w->clk)) {
 			ret = PTR_ERR(w->clk);
@@ -2909,6 +2912,9 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 				w->name, ret);
 			return NULL;
 		}
+#else
+		return NULL
+#endif
 		break;
 	default:
 		break;
-- 
1.7.10
