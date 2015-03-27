From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 3/4] ASoC: rt5645: Use update_bits for bit
	control
Date: Fri, 27 Mar 2015 20:19:08 +0800
Message-ID: <1427458749-821-3-git-send-email-bardliao@realtek.com>
References: <1427458749-821-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C91B265A79
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 13:19:20 +0100 (CET)
In-Reply-To: <1427458749-821-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, jason.ym.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

In codec bias level off, we need to disable gate mode with MCLK
for power saving. It is set by one bit. We don't need to write
while register for that.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index f9edf09..b6d5b95 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2396,7 +2396,8 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_OFF:
 		snd_soc_write(codec, RT5645_DEPOP_M2, 0x1100);
-		snd_soc_write(codec, RT5645_GEN_CTRL1, 0x0128);
+		snd_soc_update_bits(codec, RT5645_GEN_CTRL1,
+				RT5645_DIG_GATE_CTRL, 0);
 		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 				RT5645_PWR_VREF1 | RT5645_PWR_MB |
 				RT5645_PWR_BG | RT5645_PWR_VREF2 |
-- 
1.8.1.1.439.g50a6b54
