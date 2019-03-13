From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8810: use 64-bit arithmetic instead
	of 32-bit
Date: Wed, 13 Mar 2019 14:47:18 +0800
Message-ID: <20190313064718.4534-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 6A855F896F3
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 07:47:25 +0100 (CET)
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

Add suffix ULL to constant 256 in order to give the compiler complete
information about the proper arithmetic to use.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8810.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index bfd74b86c9d2..e7fd0b2645ea 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -505,7 +505,7 @@ static int nau88l0_calc_pll(unsigned int pll_in,
 	f2_max = 0;
 	scal_sel = ARRAY_SIZE(nau8810_mclk_scaler);
 	for (i = 0; i < ARRAY_SIZE(nau8810_mclk_scaler); i++) {
-		f2 = 256 * fs * 4 * nau8810_mclk_scaler[i] / 10;
+		f2 = 256ULL * fs * 4 * nau8810_mclk_scaler[i] / 10;
 		if (f2 > NAU_PLL_FREQ_MIN && f2 < NAU_PLL_FREQ_MAX &&
 			f2_max < f2) {
 			f2_max = f2;
-- 
2.18.0
