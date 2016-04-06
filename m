From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 4/6] ASoC: wm_adsp: Factor out fetching of
	stream errors from the DSP
Date: Wed, 6 Apr 2016 11:21:53 +0100
Message-ID: <1459938115-25456-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 585202606F8
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 12:21:52 +0200 (CEST)
In-Reply-To: <1459938115-25456-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Factor out the reading of the DSP error flag into its own function to
support further improvements to the code.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 953c427..f70c609 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2816,6 +2816,23 @@ static int wm_adsp_buffer_update_avail(struct wm_adsp_compr_buf *buf)
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
 int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr_buf *buf;
@@ -2834,16 +2851,9 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 
 	adsp_dbg(dsp, "Handling buffer IRQ\n");
 
-	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
-	if (ret < 0) {
-		adsp_err(dsp, "Failed to check buffer error: %d\n", ret);
-		goto out;
-	}
-	if (buf->error != 0) {
-		adsp_err(dsp, "Buffer error occurred: %d\n", buf->error);
-		ret = -EIO;
+	ret = wm_adsp_buffer_get_error(buf);
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(irq_count),
 				  &buf->irq_count);
-- 
2.1.4
