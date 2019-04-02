From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/3] ASoC: wm_adsp: Check for buffer in trigger
	stop
Date: Tue, 2 Apr 2019 13:49:14 +0100
Message-ID: <20190402124916.28736-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BFC4FF8071D
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 14:49:20 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Trigger stop can be called in situations where trigger start failed
and as such it can't be assumed the buffer is already attached to
the compressed stream or a NULL pointer may be dereferenced.

Fixes: 639e5eb3c7d6 ("ASoC: wm_adsp: Correct handling of compressed streams that restart")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0aa62b26f61cc..2da4ba2da42a8 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3952,7 +3952,8 @@ int wm_adsp_compr_trigger(struct snd_compr_stream *stream, int cmd)
 		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		wm_adsp_buffer_clear(compr->buf);
+		if (wm_adsp_compr_attached(compr))
+			wm_adsp_buffer_clear(compr->buf);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.11.0
