From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: ssm4567: Keep TDM_BCLKS in
	ssm4567_set_dai_fmt
Date: Tue, 21 Jul 2015 14:46:26 -0700
Message-ID: <1437515186-1961-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id C3B4F2605D3
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 23:46:50 +0200 (CEST)
Received: by pdrg1 with SMTP id g1so126836203pdr.2
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 14:46:49 -0700 (PDT)
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
Cc: Harsha Priya <harshapriya.n@intel.com>, Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol@google.com>
List-Id: alsa-devel@alsa-project.org

The regmap_write in ssm4567_set_dai_fmt accidentally clears the
TDM_BCLKS field which was set earlier by ssm4567_set_tdm_slot.

This patch fixes it by using regmap_update_bits with proper mask.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/ssm4567.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 4662587..a757ab8 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -315,7 +315,13 @@ static int ssm4567_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (invert_fclk)
 		ctrl1 |= SSM4567_SAI_CTRL_1_FSYNC;
 
-	return regmap_write(ssm4567->regmap, SSM4567_REG_SAI_CTRL_1, ctrl1);
+	return regmap_update_bits(ssm4567->regmap, SSM4567_REG_SAI_CTRL_1,
+			SSM4567_SAI_CTRL_1_BCLK |
+			SSM4567_SAI_CTRL_1_FSYNC |
+			SSM4567_SAI_CTRL_1_LJ |
+			SSM4567_SAI_CTRL_1_TDM |
+			SSM4567_SAI_CTRL_1_PDM,
+			ctrl1);
 }
 
 static int ssm4567_set_power(struct ssm4567 *ssm4567, bool enable)
-- 
2.4.3.573.g4eafbef
