From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 04/12] ASoC: wm_adsp: Shutdown any compressed
	streams on DSP watchdog timeout
Date: Tue, 19 Mar 2019 11:52:07 +0000
Message-ID: <20190319115215.22960-5-ckeepax@opensource.cirrus.com>
References: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BCF5F8968A
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 12:52:18 +0100 (CET)
In-Reply-To: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

If a watchdog timeout is received from the DSP it is safe to assume the
DSP is not functioning anymore and as such any active compressed streams
should be put into an error state.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 21 +++++++++++++++++++++
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c19a8a041d4dd..5608ed5deccac 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2905,6 +2905,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (wm_adsp_fw[dsp->fw].num_caps != 0)
 			wm_adsp_buffer_free(dsp);
 
+		dsp->fatal_error = false;
+
 		mutex_unlock(&dsp->pwr_lock);
 
 		adsp_dbg(dsp, "Execution stopped\n");
@@ -3000,6 +3002,9 @@ static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
 {
 	struct wm_adsp_compr_buf *buf = NULL, *tmp;
 
+	if (compr->dsp->fatal_error)
+		return -EINVAL;
+
 	list_for_each_entry(tmp, &compr->dsp->buffer_list, list) {
 		if (!tmp->name || !strcmp(compr->name, tmp->name)) {
 			buf = tmp;
@@ -3916,6 +3921,21 @@ int wm_adsp2_lock(struct wm_adsp *dsp, unsigned int lock_regions)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_lock);
 
+static void wm_adsp_fatal_error(struct wm_adsp *dsp)
+{
+	struct wm_adsp_compr *compr;
+
+	dsp->fatal_error = true;
+
+	list_for_each_entry(compr, &dsp->compr_list, list) {
+		if (compr->stream) {
+			snd_compr_stop_error(compr->stream,
+					     SNDRV_PCM_STATE_XRUN);
+			snd_compr_fragment_elapsed(compr->stream);
+		}
+	}
+}
+
 irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 {
 	unsigned int val;
@@ -3934,6 +3954,7 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 	if (val & ADSP2_WDT_TIMEOUT_STS_MASK) {
 		adsp_err(dsp, "watchdog timeout error\n");
 		wm_adsp_stop_watchdog(dsp);
+		wm_adsp_fatal_error(dsp);
 	}
 
 	if (val & (ADSP2_SLAVE_ERR_MASK | ADSP2_REGION_LOCK_ERR_MASK)) {
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 59e07ad163296..8f09b4419a914 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -85,6 +85,7 @@ struct wm_adsp {
 	bool preloaded;
 	bool booted;
 	bool running;
+	bool fatal_error;
 
 	struct list_head ctl_list;
 
-- 
2.11.0
