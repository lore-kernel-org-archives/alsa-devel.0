From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: rt5645: Fix updating wrong register
 for T5645_AIF2 case
Date: Sat, 17 May 2014 19:17:32 +0800
Message-ID: <1400325452.22102.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f181.google.com (mail-ve0-f181.google.com
 [209.85.128.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F330261647
 for <alsa-devel@alsa-project.org>; Sat, 17 May 2014 13:17:38 +0200 (CEST)
Received: by mail-ve0-f181.google.com with SMTP id pa12so4325396veb.40
 for <alsa-devel@alsa-project.org>; Sat, 17 May 2014 04:17:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This looks like a copy-paste bug, fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi,
I don't have this h/w, so please test if this patch works.
Axel
 sound/soc/codecs/rt5645.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 68923ec..ab97d72 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1932,8 +1932,8 @@ static int rt5645_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 			RT5645_I2S_MS_MASK | RT5645_I2S_BP_MASK |
 			RT5645_I2S_DF_MASK, reg_val);
 		break;
-	case  RT5645_AIF2:
-		snd_soc_update_bits(codec, RT5645_I2S1_SDP,
+	case RT5645_AIF2:
+		snd_soc_update_bits(codec, RT5645_I2S2_SDP,
 			RT5645_I2S_MS_MASK | RT5645_I2S_BP_MASK |
 			RT5645_I2S_DF_MASK, reg_val);
 		break;
-- 
1.8.3.2
