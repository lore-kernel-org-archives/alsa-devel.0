From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: wm_adsp: Factor out checking of
	stream errors from the DSP
Date: Thu, 10 Mar 2016 10:44:53 +0000
Message-ID: <1457606694-10985-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 26F93260686
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 11:45:03 +0100 (CET)
In-Reply-To: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Factor out the reading of the DSP error flag into its own function to
support further improvements to the code.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index e2e0d81..f28c244 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2812,6 +2812,23 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
 	return 0;
 }
 
+static int wm_adsp_buffer_check_error(struct wm_adsp_compr_buf *buf)
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
 int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr_buf *buf = dsp->buffer;
@@ -2827,16 +2844,9 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 
 	adsp_dbg(dsp, "Handling buffer IRQ\n");
 
-	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
-	if (ret < 0) {
-		adsp_err(dsp, "Failed to check buffer error: %d\n", ret);
-		goto out;
-	}
-	if (buf->error != 0) {
-		adsp_err(dsp, "Buffer error occurred: %d\n", buf->error);
-		ret = -EIO;
+	ret = wm_adsp_buffer_check_error(buf);
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
 				  &buf->irq_count);
-- 
2.1.4
