From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 3/3] ASoC: wm_adsp: Make use of local variables
Date: Tue, 2 Apr 2019 13:49:16 +0100
Message-ID: <20190402124916.28736-3-ckeepax@opensource.cirrus.com>
References: <20190402124916.28736-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE608F89633
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 14:49:20 +0200 (CEST)
In-Reply-To: <20190402124916.28736-1-ckeepax@opensource.cirrus.com>
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

Tidy up some instances of dereferencing to obtain things that are
already stored in local variables.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4223186594b4d..c8c49d5b8ac95 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3381,7 +3381,7 @@ static int wm_adsp_compr_attach(struct wm_adsp_compr *compr)
 		return -EINVAL;
 
 	compr->buf = buf;
-	compr->buf->compr = compr;
+	buf->compr = compr;
 
 	return 0;
 }
@@ -4092,7 +4092,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 
 	buf = compr->buf;
 
-	if (!compr->buf || compr->buf->error) {
+	if (!buf || buf->error) {
 		snd_compr_stop_error(stream, SNDRV_PCM_STATE_XRUN);
 		ret = -EIO;
 		goto out;
@@ -4112,7 +4112,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 		if (buf->avail < wm_adsp_compr_frag_words(compr)) {
 			ret = wm_adsp_buffer_get_error(buf);
 			if (ret < 0) {
-				if (compr->buf->error)
+				if (buf->error)
 					snd_compr_stop_error(stream,
 							SNDRV_PCM_STATE_XRUN);
 				goto out;
-- 
2.11.0
