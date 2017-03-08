From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 5/8] ASoC: rt5665: increase button detection
	accuracy
Date: Wed, 8 Mar 2017 19:05:33 +0800
Message-ID: <1488971136-19100-5-git-send-email-bardliao@realtek.com>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 5162F266927
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:05:50 +0100 (CET)
In-Reply-To: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Use sar adc for button detection to increase accuracy.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index efacc94..ca6aa66 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1139,7 +1139,8 @@ static void rt5665_enable_push_button_irq(struct snd_soc_codec *codec,
 	bool enable)
 {
 	if (enable) {
-		snd_soc_write(codec, RT5665_4BTN_IL_CMD_1, 0x000b);
+		snd_soc_write(codec, RT5665_4BTN_IL_CMD_1, 0x0003);
+		snd_soc_update_bits(codec, RT5665_SAR_IL_CMD_9, 0x1, 0x1);
 		snd_soc_write(codec, RT5665_IL_CMD_1, 0x0048);
 		snd_soc_update_bits(codec, RT5665_4BTN_IL_CMD_2,
 				RT5665_4BTN_IL_MASK | RT5665_4BTN_IL_RST_MASK,
-- 
2.7.4
