From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm_adsp: Set booted/running flags at
	the end of bring up
Date: Tue, 24 Jan 2017 11:44:00 +0000
Message-ID: <1485258241-10575-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1485258241-10575-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 62A73266CB8
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 12:43:03 +0100 (CET)
In-Reply-To: <1485258241-10575-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

The booted and running flags should really only be set once all the
steps at that power level have been complete. Currently operations can
fail after the flags have been set, which would leave us in an
inconsistent state where the flags are set but the things expected to
reach that level have not happened. Whilst there isn't really any major
impact from this it is best to clean it up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 08a4a61..822dfef 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2492,14 +2492,14 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	if (ret != 0)
 		goto err_ena;
 
-	dsp->booted = true;
-
 	/* Turn DSP back off until we are ready to run */
 	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 				 ADSP2_SYS_ENA, 0);
 	if (ret != 0)
 		goto err_ena;
 
+	dsp->booted = true;
+
 	mutex_unlock(&dsp->pwr_lock);
 
 	return;
@@ -2639,14 +2639,14 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
-		dsp->running = true;
-
 		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
 			ret = wm_adsp_buffer_init(dsp);
 			if (ret < 0)
 				goto err;
 		}
 
+		dsp->running = true;
+
 		mutex_unlock(&dsp->pwr_lock);
 
 		break;
-- 
2.1.4
