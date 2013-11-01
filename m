From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: wm_adsp: Interpret ADSP memory
	region lengths as 32 bit words
Date: Fri,  1 Nov 2013 15:56:54 +0000
Message-ID: <1383321417-1133-4-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2AE226584F
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 16:57:00 +0100 (CET)
In-Reply-To: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>

Pad the ADSP word (3 bytes) to 4 bytes in the kernel and calculate
lengths based on padded ADSP words instead of treating them as bytes

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4008ceb..4039d05 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1063,6 +1063,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
 				region->len -= be32_to_cpu(adsp1_alg[i].dm);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
@@ -1080,6 +1081,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
 				region->len -= be32_to_cpu(adsp1_alg[i].zm);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
@@ -1109,6 +1111,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
 				region->len -= be32_to_cpu(adsp2_alg[i].xm);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
@@ -1126,6 +1129,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
 				region->len -= be32_to_cpu(adsp2_alg[i].ym);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
@@ -1143,6 +1147,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
 				region->len -= be32_to_cpu(adsp2_alg[i].zm);
+				region->len *= 4;
 				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
-- 
1.8.4.2
