From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 5/6] ASoC: wm_adsp: Remove and free algorithm
	regions for ADSP1
Date: Fri,  1 Nov 2013 15:56:56 +0000
Message-ID: <1383321417-1133-6-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B9F8265859
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 16:57:03 +0100 (CET)
In-Reply-To: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Do it in a similar fashion as we do for ADSP2.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 79dc4aa..1761f65 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1366,6 +1366,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = w->codec;
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
+	struct wm_adsp_alg_region *alg_region;
 	struct wm_coeff_ctl *ctl;
 	int ret;
 	int val;
@@ -1443,6 +1444,14 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 
 		list_for_each_entry(ctl, &dsp->ctl_list, list)
 			ctl->enabled = 0;
+
+		while (!list_empty(&dsp->alg_regions)) {
+			alg_region = list_first_entry(&dsp->alg_regions,
+						      struct wm_adsp_alg_region,
+						      list);
+			list_del(&alg_region->list);
+			kfree(alg_region);
+		}
 		break;
 
 	default:
-- 
1.8.4.2
