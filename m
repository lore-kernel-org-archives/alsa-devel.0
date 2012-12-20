From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: arizona: Do proper shift for setting
	aif1 rate
Date: Thu, 20 Dec 2012 23:29:42 +0800
Message-ID: <1356017382.12143.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f47.google.com (mail-da0-f47.google.com
 [209.85.210.47])
 by alsa0.perex.cz (Postfix) with ESMTP id AA04626077D
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 16:30:03 +0100 (CET)
Received: by mail-da0-f47.google.com with SMTP id s35so1566832dak.20
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 07:30:02 -0800 (PST)
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

ARIZONA_AIF1_RATE_MASK is 0x7800 /* AIF1_RATE - [14:11] */
Thus we need left shift ARIZONA_AIF1_RATE_SHIFT when setting aif1 rate.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/arizona.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index adf397b..38248a7 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -714,7 +714,8 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 		snd_soc_update_bits(codec, ARIZONA_ASYNC_SAMPLE_RATE_1,
 				    ARIZONA_ASYNC_SAMPLE_RATE_MASK, sr_val);
 		snd_soc_update_bits(codec, base + ARIZONA_AIF_RATE_CTRL,
-				    ARIZONA_AIF1_RATE_MASK, 8);
+				    ARIZONA_AIF1_RATE_MASK,
+				    8 << ARIZONA_AIF1_RATE_SHIFT);
 		break;
 	default:
 		arizona_aif_err(dai, "Invalid clock %d\n", dai_priv->clk);
-- 
1.7.9.5
