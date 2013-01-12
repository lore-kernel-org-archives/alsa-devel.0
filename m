From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Provide explicit trace of
	coefficient writes
Date: Sat, 12 Jan 2013 20:31:32 +0000
Message-ID: <1358022692-31602-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F16E2615D3
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 13:37:35 +0100 (CET)
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

Helpful for debugging.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4a233b8..14af8e2 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -775,6 +775,9 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 				return -ENOMEM;
 			}
 
+			adsp_dbg(dsp, "%s.%d: Writing %d bytes at %x\n",
+				 file, blocks, le32_to_cpu(blk->len),
+				 reg);
 			ret = regmap_raw_write(regmap, reg, blk->data,
 					       le32_to_cpu(blk->len));
 			if (ret != 0) {
-- 
1.7.10.4
