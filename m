From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: wm_adsp: Put DSP into low power
	state between loading and running
Date: Tue, 20 Sep 2016 13:52:34 +0100
Message-ID: <1474375956-10443-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 71D4326155E
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 14:52:45 +0200 (CEST)
In-Reply-To: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm_adsp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 24485ec..e0cd4fe 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2223,6 +2223,11 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 	unsigned int val;
 	int ret, count;
 
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_MEM_ENA, ADSP2_MEM_ENA);
+	if (ret != 0)
+		return ret;
+
 	ret = regmap_update_bits_async(dsp->regmap, dsp->base + ADSP2_CONTROL,
 				       ADSP2_SYS_ENA, ADSP2_SYS_ENA);
 	if (ret != 0)
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
@@ -2344,6 +2355,11 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (!dsp->booted)
 			return -EIO;
 
+		ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+					 ADSP2_SYS_ENA, ADSP2_SYS_ENA);
+		if (ret != 0)
+			goto err;
+
 		/* Sync set controls */
 		ret = wm_coeff_sync_controls(dsp);
 		if (ret != 0)
@@ -2382,7 +2398,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		dsp->booted = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				   ADSP2_CORE_ENA | ADSP2_START, 0);
+				   ADSP2_MEM_ENA | ADSP2_CORE_ENA | ADSP2_START,
+				   0);
 
 		/* Make sure DMAs are quiesced */
 		regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
-- 
2.1.4
