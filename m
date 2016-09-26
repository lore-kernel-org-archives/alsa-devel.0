From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/4] ASoC: wm_adsp: Put DSP into low power
	state between loading and running
Date: Mon, 26 Sep 2016 10:15:23 +0100
Message-ID: <1474881325-9466-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474881325-9466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A25A266703
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 11:15:28 +0200 (CEST)
In-Reply-To: <1474881325-9466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Between when we load the DSP and when it actually starts running put the
core into a lower power state where the memory is retained but nothing
is clocked.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
 - Reuse wm_adsp2_ena when bringing the DSP back out of the low power
   state such that we wait for RAM ready again.

 sound/soc/codecs/wm_adsp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4188c37..446f029 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2259,6 +2259,11 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 
 	mutex_lock(&dsp->pwr_lock);
 
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_MEM_ENA, ADSP2_MEM_ENA);
+	if (ret != 0)
+		goto err_mutex;
+
 	ret = wm_adsp2_ena(dsp);
 	if (ret != 0)
 		goto err_mutex;
@@ -2282,6 +2287,12 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 
 	dsp->booted = true;
 
+	/* Turn DSP back off until we are ready to run */
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_SYS_ENA, 0);
+	if (ret != 0)
+		goto err_ena;
+
 	mutex_unlock(&dsp->pwr_lock);
 
 	return;
@@ -2344,6 +2355,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (!dsp->booted)
 			return -EIO;
 
+		ret = wm_adsp2_ena(dsp);
+		if (ret != 0)
+			goto err;
+
 		/* Sync set controls */
 		ret = wm_coeff_sync_controls(dsp);
 		if (ret != 0)
@@ -2382,7 +2397,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		dsp->booted = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				   ADSP2_CORE_ENA | ADSP2_START, 0);
+				   ADSP2_MEM_ENA | ADSP2_CORE_ENA | ADSP2_START,
+				   0);
 
 		/* Make sure DMAs are quiesced */
 		regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
-- 
2.1.4
