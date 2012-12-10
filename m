From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: adsp: Correct version number masks
Date: Mon, 10 Dec 2012 14:04:05 +0900
Message-ID: <1355115845-15551-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DAB1265079
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2012 06:04:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3f0e69b..00caaa5 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -394,7 +394,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 		algs = be32_to_cpu(adsp1_id.algs);
 		adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
 			  be32_to_cpu(adsp1_id.fw.id),
-			  (be32_to_cpu(adsp1_id.fw.ver) & 0xff000) >> 16,
+			  (be32_to_cpu(adsp1_id.fw.ver) & 0xff0000) >> 16,
 			  (be32_to_cpu(adsp1_id.fw.ver) & 0xff00) >> 8,
 			  be32_to_cpu(adsp1_id.fw.ver) & 0xff,
 			  algs);
@@ -415,7 +415,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 		algs = be32_to_cpu(adsp2_id.algs);
 		adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
 			  be32_to_cpu(adsp2_id.fw.id),
-			  (be32_to_cpu(adsp2_id.fw.ver) & 0xff000) >> 16,
+			  (be32_to_cpu(adsp2_id.fw.ver) & 0xff0000) >> 16,
 			  (be32_to_cpu(adsp2_id.fw.ver) & 0xff00) >> 8,
 			  be32_to_cpu(adsp2_id.fw.ver) & 0xff,
 			  algs);
@@ -465,7 +465,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 		case WMFW_ADSP1:
 			adsp_info(dsp, "%d: ID %x v%d.%d.%d\n",
 				  i, be32_to_cpu(adsp1_alg[i].alg.id),
-				  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff000) >> 16,
+				  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff0000) >> 16,
 				  (be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff00) >> 8,
 				  be32_to_cpu(adsp1_alg[i].alg.ver) & 0xff);
 			break;
@@ -473,7 +473,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 		case WMFW_ADSP2:
 			adsp_info(dsp, "%d: ID %x v%d.%d.%d\n",
 				  i, be32_to_cpu(adsp2_alg[i].alg.id),
-				  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff000) >> 16,
+				  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff0000) >> 16,
 				  (be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff00) >> 8,
 				  be32_to_cpu(adsp2_alg[i].alg.ver) & 0xff);
 			break;
-- 
1.7.10.4
