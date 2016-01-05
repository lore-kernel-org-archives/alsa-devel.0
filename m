From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: improve IRQ reaction time for HS
	button
Date: Tue, 5 Jan 2016 14:22:11 +0800
Message-ID: <1451974931-23864-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9189C26067A
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 07:22:27 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

IRQ reaction time is not immediate when headset putton is pressed.
This patch shortens the reaction time.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 72d3ca5..c61d38b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3066,6 +3066,7 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 		snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
 		snd_soc_dapm_sync(dapm);
 
+		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD1, 0x3, 0x3);
 		snd_soc_update_bits(codec,
 					RT5645_INT_IRQ_ST, 0x8, 0x8);
 		snd_soc_update_bits(codec,
-- 
1.8.1.1.439.g50a6b54
