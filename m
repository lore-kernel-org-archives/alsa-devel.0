From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8810: fix the typo of function name
Date: Wed, 13 Mar 2019 15:04:16 +0800
Message-ID: <20190313070416.15917-1-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 643E1F80799
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 08:04:23 +0100 (CET)
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

Correct the typo at the function name.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8810.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index e7fd0b2..39512a7 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -493,7 +493,7 @@ static int nau8810_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int nau88l0_calc_pll(unsigned int pll_in,
+static int nau8810_calc_pll(unsigned int pll_in,
 	unsigned int fs, struct nau8810_pll *pll_param)
 {
 	u64 f2, f2_max, pll_ratio;
@@ -542,7 +542,7 @@ static int nau8810_set_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	int ret, fs;
 
 	fs = freq_out / 256;
-	ret = nau88l0_calc_pll(freq_in, fs, pll_param);
+	ret = nau8810_calc_pll(freq_in, fs, pll_param);
 	if (ret < 0) {
 		dev_err(nau8810->dev, "Unsupported input clock %d\n", freq_in);
 		return ret;
-- 
2.18.0
