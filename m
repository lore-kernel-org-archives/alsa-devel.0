From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Return sample rate in
	wm_adsp_compr_pointer
Date: Tue, 2 Feb 2016 16:41:36 +0000
Message-ID: <1454431296-21622-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EE2F265104
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 17:41:35 +0100 (CET)
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

We should return a valid sample rate from the pointer callback, this
patch adds this into the driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 28d3851..ed90e12 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -292,6 +292,8 @@ struct wm_adsp_compr {
 
 	u32 *raw_buf;
 	unsigned int copied_total;
+
+	unsigned int sample_rate;
 };
 
 #define WM_ADSP_DATA_WORD_SIZE         3
@@ -2484,6 +2486,8 @@ int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 	if (!compr->raw_buf)
 		return -ENOMEM;
 
+	compr->sample_rate = params->codec.sample_rate;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp_compr_set_params);
@@ -2923,6 +2927,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 
 	tstamp->copied_total = compr->copied_total;
 	tstamp->copied_total += buf->avail * WM_ADSP_DATA_WORD_SIZE;
+	tstamp->sampling_rate = compr->sample_rate;
 
 out:
 	mutex_unlock(&dsp->pwr_lock);
-- 
2.1.4
