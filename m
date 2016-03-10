From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Use correct local length in
	error message
Date: Thu, 10 Mar 2016 10:46:07 +0000
Message-ID: <1457606767-11090-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 53135266198
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 11:46:02 +0100 (CET)
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

Fixes: 44029e9e1290 ("ASoC: wm_adsp: wm_coeff_{read|write}_control should use passed length")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3ee1c72..3c15481 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -807,7 +807,7 @@ static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 	ret = regmap_raw_read(dsp->regmap, reg, scratch, len);
 	if (ret) {
 		adsp_err(dsp, "Failed to read %zu bytes from %x: %d\n",
-			 ctl->len, reg, ret);
+			 len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
-- 
2.1.4
