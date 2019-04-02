From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: wm_adsp: Remove redundant NULL check
	in wm_adsp_buffer_free
Date: Tue, 2 Apr 2019 13:49:15 +0100
Message-ID: <20190402124916.28736-2-ckeepax@opensource.cirrus.com>
References: <20190402124916.28736-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7AE2F89631
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

wm_adsp_compr_detach is NULL aware so there is no need to check for NULL
before calling it, remove the redundant check.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 2da4ba2da42a8..4223186594b4d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3887,8 +3887,7 @@ static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 	struct wm_adsp_compr_buf *buf, *tmp;
 
 	list_for_each_entry_safe(buf, tmp, &dsp->buffer_list, list) {
-		if (buf->compr)
-			wm_adsp_compr_detach(buf->compr);
+		wm_adsp_compr_detach(buf->compr);
 
 		kfree(buf->name);
 		kfree(buf->regions);
-- 
2.11.0
