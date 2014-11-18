From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: wm_adsp: Fix memory leak in
	wm_adsp_setup_algs
Date: Tue, 18 Nov 2014 16:29:12 +0000
Message-ID: <1416328152-8713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AA7DD26047F
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 17:36:46 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, aitdark.park@samsung.com
List-Id: alsa-devel@alsa-project.org

From: JS Park <aitdark.park@samsung.com>

If we fail to allocate memory for one of the memory regions whilst
parsing the DSP firmware, we will leak the buffer holding the algorithm
information. This patch ensures that this buffer is freed on all error
paths.

Signed-off-by: JS Park <aitdark.park@samsung.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 08d8ec3..e54d7b5 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1053,8 +1053,10 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 				  be32_to_cpu(adsp1_alg[i].zm));
 
 			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region)
-				return -ENOMEM;
+			if (!region) {
+				ret = -ENOMEM;
+				goto out;
+			}
 			region->type = WMFW_ADSP1_DM;
 			region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp1_alg[i].dm);
@@ -1071,8 +1073,10 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			}
 
 			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region)
-				return -ENOMEM;
+			if (!region) {
+				ret = -ENOMEM;
+				goto out;
+			}
 			region->type = WMFW_ADSP1_ZM;
 			region->alg = be32_to_cpu(adsp1_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp1_alg[i].zm);
@@ -1101,8 +1105,10 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 				  be32_to_cpu(adsp2_alg[i].zm));
 
 			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region)
-				return -ENOMEM;
+			if (!region) {
+				ret = -ENOMEM;
+				goto out;
+			}
 			region->type = WMFW_ADSP2_XM;
 			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp2_alg[i].xm);
@@ -1119,8 +1125,10 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			}
 
 			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region)
-				return -ENOMEM;
+			if (!region) {
+				ret = -ENOMEM;
+				goto out;
+			}
 			region->type = WMFW_ADSP2_YM;
 			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp2_alg[i].ym);
@@ -1137,8 +1145,10 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			}
 
 			region = kzalloc(sizeof(*region), GFP_KERNEL);
-			if (!region)
-				return -ENOMEM;
+			if (!region) {
+				ret = -ENOMEM;
+				goto out;
+			}
 			region->type = WMFW_ADSP2_ZM;
 			region->alg = be32_to_cpu(adsp2_alg[i].alg.id);
 			region->base = be32_to_cpu(adsp2_alg[i].zm);
-- 
1.7.2.5
