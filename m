From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 07/13] ASoC: wm_adsp: Factor out finding the
	location of an algorithm region
Date: Tue, 8 Dec 2015 16:08:31 +0000
Message-ID: <1449590917-21170-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 92C932604F8
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:08 +0100 (CET)
In-Reply-To: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b083642..2b99f46 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1362,6 +1362,19 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 	return alg;
 }
 
+static struct wm_adsp_alg_region *
+	wm_adsp_find_alg_region(struct wm_adsp *dsp, int type, unsigned int id)
+{
+	struct wm_adsp_alg_region *alg_region;
+
+	list_for_each_entry(alg_region, &dsp->alg_regions, list) {
+		if (id == alg_region->alg && type == alg_region->type)
+			return alg_region;
+	}
+
+	return NULL;
+}
+
 static struct wm_adsp_alg_region *wm_adsp_create_region(struct wm_adsp *dsp,
 							int type, __be32 id,
 							__be32 base)
@@ -1734,22 +1747,16 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 				break;
 			}
 
-			reg = 0;
-			list_for_each_entry(alg_region,
-					    &dsp->alg_regions, list) {
-				if (le32_to_cpu(blk->id) == alg_region->alg &&
-				    type == alg_region->type) {
-					reg = alg_region->base;
-					reg = wm_adsp_region_to_reg(mem,
-								    reg);
-					reg += offset;
-					break;
-				}
-			}
-
-			if (reg == 0)
+			alg_region = wm_adsp_find_alg_region(dsp, type,
+						le32_to_cpu(blk->id));
+			if (alg_region) {
+				reg = alg_region->base;
+				reg = wm_adsp_region_to_reg(mem, reg);
+				reg += offset;
+			} else {
 				adsp_err(dsp, "No %x for algorithm %x\n",
 					 type, le32_to_cpu(blk->id));
+			}
 			break;
 
 		default:
-- 
2.1.4
