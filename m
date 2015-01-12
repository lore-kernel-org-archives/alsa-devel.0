From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Add the slot_width "25" support
	in the TDM mode
Date: Mon, 12 Jan 2015 13:34:55 +0800
Message-ID: <1421040895-15345-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B229D2605C7
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 06:35:05 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, yang.a.fang@intel.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add the slot_width "25" support in the TDM mode for the Intel platform.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 32c368c..af34ffc 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4123,6 +4123,7 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		val |= (1 << 8);
 		break;
 	case 24:
+	case 25:
 		val |= (2 << 8);
 		break;
 	case 32:
@@ -4136,9 +4137,14 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	switch (dai->id) {
 	case RT5677_AIF1:
 		snd_soc_update_bits(codec, RT5677_TDM1_CTRL1, 0x1f00, val);
+		if (slot_width == 25)
+			snd_soc_update_bits(codec, RT5677_DIG_MISC, 0x8000,
+				0x8000);
 		break;
 	case RT5677_AIF2:
 		snd_soc_update_bits(codec, RT5677_TDM2_CTRL1, 0x1f00, val);
+		if (slot_width == 25)
+			snd_soc_update_bits(codec, RT5677_DIG_MISC, 0x80, 0x80);
 		break;
 	default:
 		break;
-- 
1.8.1.1.439.g50a6b54
