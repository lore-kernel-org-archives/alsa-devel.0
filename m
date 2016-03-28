From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Correct typo,
	when setting DSPCLK rate
Date: Mon, 28 Mar 2016 10:47:34 +0100
Message-ID: <1459158454-5635-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B727A26590E
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 11:47:32 +0200 (CEST)
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
Cc: fabio.estevam@nxp.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, zidan.wang@freescale.com
List-Id: alsa-devel@alsa-project.org

The variable dspclk holds the rate of the DSPCLK, but the variable
sysclk holds an identifier for the clock. Currently if read a
non-sensical value from the DSPCLK_DIV register we assign sysclk to
dspclk, clearly this was intended to be sysclk_rate.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 8822360..720a14e 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2471,7 +2471,7 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 		break;
 	default:
 		dev_warn(codec->dev, "Unknown DSPCLK divisor read back\n");
-		dspclk = wm8962->sysclk;
+		dspclk = wm8962->sysclk_rate;
 	}
 
 	dev_dbg(codec->dev, "DSPCLK is %dHz, BCLK %d\n", dspclk, wm8962->bclk);
-- 
2.1.4
