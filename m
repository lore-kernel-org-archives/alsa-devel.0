From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 02/12] ASoC: wm_adsp: Correct error messages in
	wm_adsp_buffer_get_error
Date: Tue, 19 Mar 2019 11:52:05 +0000
Message-ID: <20190319115215.22960-3-ckeepax@opensource.cirrus.com>
References: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03C03F80792
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 12:52:18 +0100 (CET)
In-Reply-To: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

During recent logging improvements it seems two error messages lost
their updates during patch application/rebasing. Add these back in.

Fixes: 0d3fba3e7a56 ("ASoC: wm_adsp: Improve logging messages")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0de36b7eeeb22..b3348a213c185 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3535,11 +3535,11 @@ static int wm_adsp_buffer_get_error(struct wm_adsp_compr_buf *buf)
 
 	ret = wm_adsp_buffer_read(buf, HOST_BUFFER_FIELD(error), &buf->error);
 	if (ret < 0) {
-		adsp_err(buf->dsp, "Failed to check buffer error: %d\n", ret);
+		compr_err(buf, "Failed to check buffer error: %d\n", ret);
 		return ret;
 	}
 	if (buf->error != 0) {
-		adsp_err(buf->dsp, "Buffer error occurred: %d\n", buf->error);
+		compr_err(buf, "Buffer error occurred: %d\n", buf->error);
 		return -EIO;
 	}
 
-- 
2.11.0
