From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/4] ASoC: rt5645: Set use_single_rw flag for
	regmap
Date: Fri, 27 Mar 2015 20:19:07 +0800
Message-ID: <1427458749-821-2-git-send-email-bardliao@realtek.com>
References: <1427458749-821-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 59567265A73
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

RT5645 doesn't support auto incrementing writes so driver should set
the use_single_rw flag for regmap.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 0133c8c..f9edf09 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2633,7 +2633,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5645 = {
 static const struct regmap_config rt5645_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
-
+	.use_single_rw = true,
 	.max_register = RT5645_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5645_ranges) *
 					       RT5645_PR_SPACING),
 	.volatile_reg = rt5645_volatile_register,
-- 
1.8.1.1.439.g50a6b54
