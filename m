From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: fix the shift bit of IN1 boost
Date: Thu, 21 Jan 2016 13:13:40 +0800
Message-ID: <1453353220-16155-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B65E42604EF
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 06:14:12 +0100 (CET)
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

The shift bit of IN1 boost gain control is 12.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index c61d38b..93e8c90 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -776,7 +776,7 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
 
 	/* IN1/IN2 Control */
 	SOC_SINGLE_TLV("IN1 Boost", RT5645_IN1_CTRL1,
-		RT5645_BST_SFT1, 8, 0, bst_tlv),
+		RT5645_BST_SFT1, 12, 0, bst_tlv),
 	SOC_SINGLE_TLV("IN2 Boost", RT5645_IN2_CTRL,
 		RT5645_BST_SFT2, 8, 0, bst_tlv),
 
-- 
1.8.1.1.439.g50a6b54
