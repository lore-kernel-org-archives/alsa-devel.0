From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Update cached error state
	on trigger
Date: Tue, 19 Feb 2019 17:31:57 +0000
Message-ID: <20190219173157.14611-2-ckeepax@opensource.cirrus.com>
References: <20190219173157.14611-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D6C9265535
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 18:32:00 +0100 (CET)
In-Reply-To: <20190219173157.14611-1-ckeepax@opensource.cirrus.com>
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
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, aford@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

From: Stuart Henderson <stuarth@opensource.cirrus.com>

If a compressed stream is restarted after getting an error, the cached
error value will still be used on the next pointer request, preventing
the stream from starting.  Resolve this by ensuring the error status is
updated on trigger start.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 12ef85e85c29..8d16a14cd226 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3426,6 +3426,23 @@ static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 	return 0;
 }
 
+static int wm_adsp_buffer_get_error(struct wm_adsp_compr_buf *buf)
+{
+	int ret;
+
+	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
+	if (ret < 0) {
+		adsp_err(buf->dsp, "Failed to check buffer error: %d\n", ret);
+		return ret;
+	}
+	if (buf->error != 0) {
+		adsp_err(buf->dsp, "Buffer error occurred: %d\n", buf->error);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 {
 	struct wm_adsp_compr *compr = stream->runtime->private_data;
@@ -3447,6 +3464,10 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 			}
 		}
 
+		ret = wm_adsp_buffer_get_error(compr->buf);
+		if (ret < 0)
+			break;
+
 		wm_adsp_buffer_clear(compr->buf);
 
 		/* Trigger the IRQ at one fragment of data */
@@ -3522,23 +3543,6 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 	return 0;
 }
 
-static int wm_adsp_buffer_get_error(struct wm_adsp_compr_buf *buf)
-{
-	int ret;
-
-	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
-	if (ret < 0) {
-		adsp_err(buf->dsp, "Failed to check buffer error: %d\n", ret);
-		return ret;
-	}
-	if (buf->error != 0) {
-		adsp_err(buf->dsp, "Buffer error occurred: %d\n", buf->error);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr_buf *buf;
-- 
2.11.0
