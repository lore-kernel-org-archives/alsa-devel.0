From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Allow compressed buffers in
	any memory region
Date: Tue, 19 Feb 2019 17:31:56 +0000
Message-ID: <20190219173157.14611-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F6CC265537
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 18:32:00 +0100 (CET)
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

From: Andrew Ford <aford@opensource.cirrus.com>

Currently, compressed buffers can only be specified in the XM memory
region. There is no reason to have such a restriction with the newer
meta-data based way of specifying the buffers, so remove it.

Signed-off-by: Andrew Ford <aford@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1dd291cebe67..12ef85e85c29 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -344,6 +344,7 @@ struct wm_adsp_compr_buf {
 	u32 irq_count;
 	int read_index;
 	int avail;
+	int host_buf_mem_type;
 };
 
 struct wm_adsp_compr {
@@ -3219,14 +3220,14 @@ static int wm_adsp_write_data_word(struct wm_adsp *dsp, int mem_type,
 static inline int wm_adsp_buffer_read(struct wm_adsp_compr_buf *buf,
 				      unsigned int field_offset, u32 *data)
 {
-	return wm_adsp_read_data_word(buf->dsp, WMFW_ADSP2_XM,
+	return wm_adsp_read_data_word(buf->dsp, buf->host_buf_mem_type,
 				      buf->host_buf_ptr + field_offset, data);
 }
 
 static inline int wm_adsp_buffer_write(struct wm_adsp_compr_buf *buf,
 				       unsigned int field_offset, u32 data)
 {
-	return wm_adsp_write_data_word(buf->dsp, WMFW_ADSP2_XM,
+	return wm_adsp_write_data_word(buf->dsp, buf->host_buf_mem_type,
 				       buf->host_buf_ptr + field_offset, data);
 }
 
@@ -3264,6 +3265,8 @@ static int wm_adsp_legacy_host_buf_addr(struct wm_adsp_compr_buf *buf)
 	if (!buf->host_buf_ptr)
 		return -EIO;
 
+	buf->host_buf_mem_type = WMFW_ADSP2_XM;
+
 	adsp_dbg(dsp, "host_buf_ptr=%x\n", buf->host_buf_ptr);
 
 	return 0;
@@ -3282,6 +3285,7 @@ wm_adsp_find_host_buffer_ctrl(struct wm_adsp_compr_buf *buf)
 		if (!ctl->enabled)
 			continue;
 
+		buf->host_buf_mem_type = ctl->alg_region.type;
 		return ctl;
 	}
 
-- 
2.11.0
