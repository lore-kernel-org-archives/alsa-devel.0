From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Move compr_attach/attached
	functions
Date: Wed, 4 May 2016 17:11:55 +0100
Message-ID: <1462378316-8615-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 6113E267561
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 18:19:04 +0200 (CEST)
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

Move wm_adsp_compr_attach and wm_adsp_compr_attached functions so they
will stay logically grouped with similar functions after some additional
changes.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 630ebcd..42fc469 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2452,6 +2452,25 @@ void wm_adsp2_remove(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_remove);
 
+static inline int wm_adsp_compr_attached(struct wm_adsp_compr *compr)
+{
+	return compr->buf != NULL;
+}
+
+static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
+{
+	/*
+	 * Note this will be more complex once each DSP can support multiple
+	 * streams
+	 */
+	if (!compr->dsp->buffer)
+		return -EINVAL;
+
+	compr->buf = compr->dsp->buffer;
+
+	return 0;
+}
+
 int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream)
 {
 	struct wm_adsp_compr *compr;
@@ -2810,25 +2829,6 @@ static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 	return 0;
 }
 
-static inline int wm_adsp_compr_attached(struct wm_adsp_compr *compr)
-{
-	return compr->buf != NULL;
-}
-
-static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
-{
-	/*
-	 * Note this will be more complex once each DSP can support multiple
-	 * streams
-	 */
-	if (!compr->dsp->buffer)
-		return -EINVAL;
-
-	compr->buf = compr->dsp->buffer;
-
-	return 0;
-}
-
 int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 {
 	struct wm_adsp_compr *compr = stream->runtime->private_data;
-- 
2.1.4
