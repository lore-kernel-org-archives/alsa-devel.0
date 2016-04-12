From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v4 3/4] ASoC: wm_adsp: Use new
	snd_compr_stop_error to signal stream failure
Date: Tue, 12 Apr 2016 11:32:08 +0100
Message-ID: <1460457129-23281-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1460457129-23281-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D1E4D26518B
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 12:32:10 +0200 (CEST)
In-Reply-To: <1460457129-23281-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

If we encounter a fatal error on the compressed stream call the new
snd_compr_stop_error to shutdown the stream and allow the core to
inform user-space that the stream is no longer valid.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3ac2e1f..d221ac9 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2913,6 +2913,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 	}
 
 	if (compr->buf->error) {
+		snd_compr_stop_error(stream, SNDRV_PCM_STATE_XRUN);
 		ret = -EIO;
 		goto out;
 	}
@@ -2930,8 +2931,12 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 		 */
 		if (buf->avail < wm_adsp_compr_frag_words(compr)) {
 			ret = wm_adsp_buffer_get_error(buf);
-			if (ret < 0)
+			if (ret < 0) {
+				if (compr->buf->error)
+					snd_compr_stop_error(stream,
+							SNDRV_PCM_STATE_XRUN);
 				goto out;
+			}
 
 			ret = wm_adsp_buffer_reenable_irq(buf);
 			if (ret < 0) {
@@ -3029,8 +3034,10 @@ static int wm_adsp_compr_read(struct wm_adsp_compr *compr,
 	if (!compr->buf)
 		return -ENXIO;
 
-	if (compr->buf->error)
+	if (compr->buf->error) {
+		snd_compr_stop_error(compr->stream, SNDRV_PCM_STATE_XRUN);
 		return -EIO;
+	}
 
 	count /= WM_ADSP_DATA_WORD_SIZE;
 
-- 
2.1.4
