From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Provide early event callbacks for
	power up and down
Date: Mon, 25 Feb 2013 15:14:19 +0000
Message-ID: <1361805259-21420-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3CEA5265270
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 16:14:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some devices may benefit from being able to start some parts of the widget
power up/down sequence earlier on in the sequence than the point at which
the final power state is committed. Support these by providing events which
are called before any power state changes are done.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 38fd652..7e4efa5 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -311,6 +311,8 @@ struct device;
 #define SND_SOC_DAPM_POST_PMD	0x8		/* after widget power down */
 #define SND_SOC_DAPM_PRE_REG	0x10	/* before audio path setup */
 #define SND_SOC_DAPM_POST_REG	0x20	/* after audio path setup */
+#define SND_SOC_DAPM_WILL_PMU   0x40    /* called at start of sequence */
+#define SND_SOC_DAPM_WILL_PMD   0x80    /* called at start of sequence */
 #define SND_SOC_DAPM_PRE_POST_PMD \
 				(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 11047ba..b69e9de 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1255,6 +1255,14 @@ static void dapm_seq_check_event(struct snd_soc_dapm_context *dapm,
 		ev_name = "POST_PMD";
 		power = 0;
 		break;
+	case SND_SOC_DAPM_WILL_PMU:
+		ev_name = "WILL_PMU";
+		power = 1;
+		break;
+	case SND_SOC_DAPM_WILL_PMD:
+		ev_name = "WILL_PMD";
+		power = 0;
+		break;
 	default:
 		BUG();
 		return;
@@ -1715,6 +1723,14 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 					&async_domain);
 	async_synchronize_full_domain(&async_domain);
 
+	list_for_each_entry(w, &down_list, list) {
+		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_WILL_PMD);
+	}
+
+	list_for_each_entry(w, &up_list, list) {
+		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_WILL_PMU);
+	}
+
 	/* Power down widgets first; try to avoid amplifying pops. */
 	dapm_seq_run(dapm, &down_list, event, false);
 
-- 
1.7.10.4
