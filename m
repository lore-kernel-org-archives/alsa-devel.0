From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8810: fix arm-linux-gnueabi-gcc 7.2.0
	compile error
Date: Fri, 15 Mar 2019 15:17:51 +0800
Message-ID: <20190315071751.3192-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 8E528F896B2
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2019 08:17:58 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch fixes the compile error at the branch 'asoc for-5.2' as follows:
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
ERROR: "__aeabi_uldivmod" [sound/soc/codecs/snd-soc-nau8810.ko] undefined!

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8810.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 5d300b790f78..ede2030b987a 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/math64.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -497,6 +498,7 @@ static int nau8810_calc_pll(unsigned int pll_in,
 	unsigned int fs, struct nau8810_pll *pll_param)
 {
 	u64 f2, f2_max, pll_ratio;
+	u32 mclk_scaler;
 	int i, scal_sel;
 
 	if (pll_in > NAU_PLL_REF_MAX || pll_in < NAU_PLL_REF_MIN)
@@ -505,7 +507,8 @@ static int nau8810_calc_pll(unsigned int pll_in,
 	f2_max = 0;
 	scal_sel = ARRAY_SIZE(nau8810_mclk_scaler);
 	for (i = 0; i < ARRAY_SIZE(nau8810_mclk_scaler); i++) {
-		f2 = 256ULL * fs * 4 * nau8810_mclk_scaler[i] / 10;
+		mclk_scaler = 4 * nau8810_mclk_scaler[i] / 10;
+		f2 = 256ULL * fs * mclk_scaler;
 		if (f2 > NAU_PLL_FREQ_MIN && f2 < NAU_PLL_FREQ_MAX &&
 			f2_max < f2) {
 			f2_max = f2;
-- 
2.18.0
