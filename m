From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8825: fix bug in FLL parameter
Date: Tue, 13 Sep 2016 11:56:03 +0800
Message-ID: <1473738963-17406-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2A1266966
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2016 05:56:14 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

In the FLL parameter calculation, the FVCO should choose the maximum one.
The patch is to fix the bug about the wrong FVCO chosen.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 057785b..e643be9 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1907,7 +1907,7 @@ static int nau8825_calc_fll_param(unsigned int fll_in, unsigned int fs,
 	/* Calculate the FLL 10-bit integer input and the FLL 16-bit fractional
 	 * input based on FDCO, FREF and FLL ratio.
 	 */
-	fvco = div_u64(fvco << 16, fref * fll_param->ratio);
+	fvco = div_u64(fvco_max << 16, fref * fll_param->ratio);
 	fll_param->fll_int = (fvco >> 16) & 0x3FF;
 	fll_param->fll_frac = fvco & 0xFFFF;
 	return 0;
-- 
2.6.4
