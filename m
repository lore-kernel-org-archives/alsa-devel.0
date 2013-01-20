From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Use GFP_DMA for things that may
	be DMAed
Date: Sun, 20 Jan 2013 19:01:53 +0900
Message-ID: <1358676113-6976-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6EA412615B6
 for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2013 11:02:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <Liam.R.Girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Normally kmalloc() returns things that are DMA safe so not visible on all
platforms but we do need to explicitly request DMA safe memory.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f263bfd..f956c35 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -410,7 +410,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 
 		if (reg) {
 			buf = kmemdup(region->data, le32_to_cpu(region->len),
-				      GFP_KERNEL);
+				      GFP_KERNEL | GFP_DMA);
 			if (!buf) {
 				adsp_err(dsp, "Out of memory\n");
 				return -ENOMEM;
@@ -557,7 +557,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 		adsp_warn(dsp, "Algorithm list end %x 0x%x != 0xbeadead\n",
 			  term, be32_to_cpu(val));
 
-	alg = kzalloc((term - pos) * 2, GFP_KERNEL);
+	alg = kzalloc((term - pos) * 2, GFP_KERNEL | GFP_DMA);
 	if (!alg)
 		return -ENOMEM;
 
@@ -779,7 +779,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 
 		if (reg) {
 			buf = kmemdup(blk->data, le32_to_cpu(blk->len),
-				      GFP_KERNEL);
+				      GFP_KERNEL | GFP_DMA);
 			if (!buf) {
 				adsp_err(dsp, "Out of memory\n");
 				return -ENOMEM;
-- 
1.7.10.4
