From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/5] ASoC: wm_adsp: Factor out stripping
	padding from ADSP data
Date: Fri, 22 Feb 2019 10:04:17 +0000
Message-ID: <20190222100421.894-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79751F807B5
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 11:04:25 +0100 (CET)
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
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

In preparation for more refactoring add a helper function to strip the
padding from ADSP data.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 8d16a14cd2266..ae7e1f5d8d10a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3231,6 +3231,21 @@ static inline int wm_adsp_buffer_write(struct wm_adsp_compr_buf *buf,
 				       buf->host_buf_ptr + field_offset, data);
 }
 
+static void wm_adsp_remove_padding(u32 *buf, int nwords, int data_word_size)
+{
+	u8 *pack_in = (u8 *)buf;
+	u8 *pack_out = (u8 *)buf;
+	int i, j;
+
+	/* Remove the padding bytes from the data read from the DSP */
+	for (i = 0; i < nwords; i++) {
+		for (j = 0; j < data_word_size; j++)
+			*pack_out++ = *pack_in++;
+
+		pack_in += sizeof(*buf) - data_word_size;
+	}
+}
+
 static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
 {
 	struct wm_adsp_alg_region *alg_region;
@@ -3670,11 +3685,9 @@ EXPORT_SYMBOL_GPL(wm_adsp_compr_pointer);
 static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
 {
 	struct wm_adsp_compr_buf *buf = compr->buf;
-	u8 *pack_in = (u8 *)compr->raw_buf;
-	u8 *pack_out = (u8 *)compr->raw_buf;
 	unsigned int adsp_addr;
 	int mem_type, nwords, max_read;
-	int i, j, ret;
+	int i, ret;
 
 	/* Calculate read parameters */
 	for (i = 0; i < wm_adsp_fw[buf->dsp->fw].caps->num_regions; ++i)
@@ -3706,13 +3719,7 @@ static int wm_adsp_buffer_capture_block(struct wm_adsp_compr *compr, int target)
 	if (ret < 0)
 		return ret;
 
-	/* Remove the padding bytes from the data read from the DSP */
-	for (i = 0; i < nwords; i++) {
-		for (j = 0; j < WM_ADSP_DATA_WORD_SIZE; j++)
-			*pack_out++ = *pack_in++;
-
-		pack_in += sizeof(*(compr->raw_buf)) - WM_ADSP_DATA_WORD_SIZE;
-	}
+	wm_adsp_remove_padding(compr->raw_buf, nwords, WM_ADSP_DATA_WORD_SIZE);
 
 	/* update read index to account for words read */
 	buf->read_index += nwords;
-- 
2.11.0
