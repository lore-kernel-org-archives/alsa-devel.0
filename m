From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: Set use_single_rw flag for regmap
Date: Mon, 9 Feb 2015 14:41:50 +0800
Message-ID: <1423464110-20483-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 80C732604E2
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 07:42:03 +0100 (CET)
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

RT5670 doesn't support auto incrementing writes so driver should
set the use_single_rw flag for regmap.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 0632b74..6aa4ab2 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2614,6 +2614,7 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5670 = {
 static const struct regmap_config rt5670_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
+	.use_single_rw = true,
 	.max_register = RT5670_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5670_ranges) *
 					       RT5670_PR_SPACING),
 	.volatile_reg = rt5670_volatile_register,
-- 
1.8.1.1.439.g50a6b54
