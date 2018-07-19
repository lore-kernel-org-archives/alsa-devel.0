From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/5] ASoC: wm_adsp: Correct algorithm list
	allocation size
Date: Thu, 19 Jul 2018 11:50:35 +0100
Message-ID: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A8C6826789E
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 12:50:43 +0200 (CEST)
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
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit 6396bb221514 ("treewide: kzalloc() -> kcalloc()") was
overlooked when doing some refactoring to the algorithm list
handling, which lead to twice as much buffer being allocated
as required for reading the algorithm list. A kcalloc is no
longer appropriate since the allocation size is now in bytes
not registers, as such change back to kzalloc.

Fixes: 7f7cca08abf4 ("ASoC: wm_adsp: Simplify handling of alg offset and length")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 07c17acc8a4f..99108d18de8d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1906,7 +1906,7 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	/* Convert length from DSP words to bytes */
 	len *= sizeof(u32);
 
-	alg = kcalloc(len, 2, GFP_KERNEL | GFP_DMA);
+	alg = kzalloc(len, GFP_KERNEL | GFP_DMA);
 	if (!alg)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.11.0
