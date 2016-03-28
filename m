From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: wm_adsp: Fix some subtle races on
	compressed stream
Date: Mon, 28 Mar 2016 14:29:22 +0100
Message-ID: <1459171764-29921-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1459171764-29921-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E68D12670C6
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 15:29:20 +0200 (CEST)
In-Reply-To: <1459171764-29921-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Firstly, we should be locking the pwr_lock when we initialise the
compressed buffer. Secondly, fixup a couple of places when we should be
pulling pointers only under the pwr_lock as they may be affected by
operations that take that lock.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3c5ef13..953c427 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2240,9 +2240,13 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
+		mutex_lock(&dsp->pwr_lock);
+
 		if (wm_adsp_fw[dsp->fw].num_caps != 0)
 			ret = wm_adsp_buffer_init(dsp);
 
+		mutex_unlock(&dsp->pwr_lock);
+
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
@@ -2814,12 +2818,15 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 
 int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 {
-	struct wm_adsp_compr_buf *buf = dsp->buffer;
-	struct wm_adsp_compr *compr = dsp->compr;
+	struct wm_adsp_compr_buf *buf;
+	struct wm_adsp_compr *compr;
 	int ret = 0;
 
 	mutex_lock(&dsp->pwr_lock);
 
+	buf = dsp->buffer;
+	compr = dsp->compr;
+
 	if (!buf) {
 		ret = -ENODEV;
 		goto out;
@@ -2879,14 +2886,16 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 			  struct snd_compr_tstamp *tstamp)
 {
 	struct wm_adsp_compr *compr = stream->runtime->private_data;
-	struct wm_adsp_compr_buf *buf = compr->buf;
 	struct wm_adsp *dsp = compr->dsp;
+	struct wm_adsp_compr_buf *buf;
 	int ret = 0;
 
 	adsp_dbg(dsp, "Pointer request\n");
 
 	mutex_lock(&dsp->pwr_lock);
 
+	buf = compr->buf;
+
 	if (!compr->buf) {
 		ret = -ENXIO;
 		goto out;
-- 
2.1.4
