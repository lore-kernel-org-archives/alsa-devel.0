From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: wm2200: Fix setting dai format in
	wm2200_set_fmt
Date: Fri, 21 Dec 2012 16:28:37 +0800
Message-ID: <1356078517.8338.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 820BF265264
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2012 09:28:49 +0100 (CET)
Received: by mail-pb0-f42.google.com with SMTP id rp2so2577298pbb.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2012 00:28:48 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

According to the defines in wm2200.h:
/*
 * R1284 (0x504) - Audio IF 1_5
 */
#define WM2200_AIF1_FMT_MASK                    0x0007  /* AIF1_FMT - [2:0] */
#define WM2200_AIF1_FMT_SHIFT                        0  /* AIF1_FMT - [2:0] */
#define WM2200_AIF1_FMT_WIDTH                        3  /* AIF1_FMT - [2:0] */

We should not left shift 1 bit for fmt_val when setting dai format.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Mark,
wm2200.h defines WM2200_AIF1_FMT_SHIFT to be 0, so current code looks wrong to me.
I don't have the datasheet, so can you check if this patch is correct?

Axel
 sound/soc/codecs/wm2200.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index afcf31d..a12fc2f 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1626,7 +1626,7 @@ static int wm2200_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			    WM2200_AIF1TX_LRCLK_MSTR | WM2200_AIF1TX_LRCLK_INV,
 			    lrclk);
 	snd_soc_update_bits(codec, WM2200_AUDIO_IF_1_5,
-			    WM2200_AIF1_FMT_MASK << 1, fmt_val << 1);
+			    WM2200_AIF1_FMT_MASK, fmt_val);
 
 	return 0;
 }
-- 
1.7.9.5
