From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Detach compressed stream on
	free
Date: Wed, 4 May 2016 17:11:56 +0100
Message-ID: <1462378316-8615-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1462378316-8615-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DFE5267560
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 18:19:02 +0200 (CEST)
In-Reply-To: <1462378316-8615-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

If someone powers down the DSP core (through routing changes
say) whilst a compressed record is in progress we can end up
using a freed pointer to the buffer object. When a compressed
audio stream is triggered we attach it to a buffer on a physical
DSP. This patch adds a detach of the buffer from the stream when
the stream is freed or when the DSP is powered down which avoids
the situation where we use a buffer when it is no longer valid.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 42fc469..a07bd7c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -273,8 +273,11 @@ struct wm_adsp_buffer {
 	__be32 words_written[2];	/* total words written (64 bit) */
 };
 
+struct wm_adsp_compr;
+
 struct wm_adsp_compr_buf {
 	struct wm_adsp *dsp;
+	struct wm_adsp_compr *compr;
 
 	struct wm_adsp_buffer_region *regions;
 	u32 host_buf_ptr;
@@ -2467,10 +2470,26 @@ static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
 		return -EINVAL;
 
 	compr->buf = compr->dsp->buffer;
+	compr->buf->compr = compr;
 
 	return 0;
 }
 
+static void wm_adsp_compr_detach(struct wm_adsp_compr *compr)
+{
+	if (!compr)
+		return;
+
+	/* Wake the poll so it can see buffer is no longer attached */
+	if (compr->stream)
+		snd_compr_fragment_elapsed(compr->stream);
+
+	if (wm_adsp_compr_attached(compr)) {
+		compr->buf->compr = NULL;
+		compr->buf = NULL;
+	}
+}
+
 int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 {
 	struct wm_adsp_compr *compr;
@@ -2524,6 +2543,7 @@ int wm_adsp_compr_free(struct snd_compr_stream *stream)
 
 	mutex_lock(&dsp->pwr_lock);
 
+	wm_adsp_compr_detach(compr);
 	dsp->compr = NULL;
 
 	kfree(compr->raw_buf);
@@ -2820,6 +2840,8 @@ err_buffer:
 static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 {
 	if (dsp->buffer) {
+		wm_adsp_compr_detach(dsp->buffer->compr);
+
 		kfree(dsp->buffer->regions);
 		kfree(dsp->buffer);
 
-- 
2.1.4
