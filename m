From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: wm_adsp: Interpret ADSP memory region
	lengths as 32 bit words
Date: Mon,  4 Nov 2013 12:03:43 +0000
Message-ID: <1383566624-9242-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 362912619F7
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 13:03:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>

Pad the ADSP word (3 bytes) to 4 bytes in the kernel and calculate
lengths based on padded ADSP words instead of treating them as bytes

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 53b6033..df95e5a 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1066,6 +1066,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
 				region->len -= be32_to_cpu(adsp1_alg[i].dm);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
@@ -1083,6 +1084,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
 				region->len -= be32_to_cpu(adsp1_alg[i].zm);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
@@ -1112,6 +1114,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
 				region->len -= be32_to_cpu(adsp2_alg[i].xm);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
@@ -1129,6 +1132,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
 				region->len -= be32_to_cpu(adsp2_alg[i].ym);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
@@ -1146,6 +1150,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
 				region->len -= be32_to_cpu(adsp2_alg[i].zm);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
-- 
1.8.4.2
