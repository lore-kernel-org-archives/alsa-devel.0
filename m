From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Support streams which can
	start/stop with DSP active
Date: Mon, 26 Feb 2018 10:49:47 +0000
Message-ID: <20180226104947.32037-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id C36F9267A47
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 11:49:51 +0100 (CET)
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Clear the buffer data structure on each trigger start such that the
buffer is in a sensible state even if the DSP itself didn't restart.
This is necessary to support voice control streams which can trigger
multiple times without reloading the firmware.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b6e7c614301f..9b27390cf4f1 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3258,6 +3258,13 @@ static int wm_adsp_buffer_populate(struct wm_adsp_compr_buf *buf)
 	return 0;
 }
 
+static void wm_adsp_buffer_clear(struct wm_adsp_compr_buf *buf)
+{
+	buf->irq_count = 0xFFFFFFFF;
+	buf->read_index = -1;
+	buf->avail = 0;
+}
+
 static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr_buf *buf;
@@ -3268,8 +3275,8 @@ static int wm_adsp_buffer_init(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	buf->dsp = dsp;
-	buf->read_index = -1;
-	buf->irq_count = 0xFFFFFFFF;
+
+	wm_adsp_buffer_clear(buf);
 
 	ret = wm_adsp_buffer_locate(buf);
 	if (ret < 0) {
@@ -3327,16 +3334,17 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		if (wm_adsp_compr_attached(compr))
-			break;
-
-		ret = wm_adsp_compr_attach(compr);
-		if (ret < 0) {
-			adsp_err(dsp, "Failed to link buffer and stream: %d\n",
-				 ret);
-			break;
+		if (!wm_adsp_compr_attached(compr)) {
+			ret = wm_adsp_compr_attach(compr);
+			if (ret < 0) {
+				adsp_err(dsp, "Failed to link buffer and stream: %d\n",
+					 ret);
+				break;
+			}
 		}
 
+		wm_adsp_buffer_clear(compr->buf);
+
 		/* Trigger the IRQ at one fragment of data */
 		ret = wm_adsp_buffer_write(compr->buf,
 					   HOST_BUFFER_FIELD(high_water_mark),
-- 
2.11.0
