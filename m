From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8810: fix the issue of 64 bits
	division
Date: Fri, 22 Mar 2019 12:25:35 +0800
Message-ID: <20190322042535.30650-1-KCHSU0@nuvoton.com>
References: <20190313064718.4534-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id B9519F89670
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2019 05:25:42 +0100 (CET)
In-Reply-To: <20190313064718.4534-1-KCHSU0@nuvoton.com>
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

Do division with div_u64 for the PLL calculation.
These errors are fixed and list as follows:
1."__udivdi3" [sound/soc/codecs/snd-soc-nau8810.ko] undefined!
2."__aeabi_uldivmod" [sound/soc/codecs/snd-soc-nau8810.ko] undefined!
3. nau8810.c:(.text.nau8810_calc_pll+0xd8): undefined reference to
`__udivdi3'

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8810.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 125e205e6687..dd82c65cfa7f 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -505,7 +505,8 @@ static int nau8810_calc_pll(unsigned int pll_in,
 	f2_max = 0;
 	scal_sel = ARRAY_SIZE(nau8810_mclk_scaler);
 	for (i = 0; i < ARRAY_SIZE(nau8810_mclk_scaler); i++) {
-		f2 = 256ULL * fs * 4 * nau8810_mclk_scaler[i] / 10;
+		f2 = 256ULL * fs * 4 * nau8810_mclk_scaler[i];
+		f2 = div_u64(f2, 10);
 		if (f2 > NAU_PLL_FREQ_MIN && f2 < NAU_PLL_FREQ_MAX &&
 			f2_max < f2) {
 			f2_max = f2;
-- 
2.18.0
