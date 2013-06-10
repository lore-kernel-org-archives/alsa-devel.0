From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: ssm2518: Fix trivial typo in checking
 tx_mask and rx_mask values
Date: Mon, 10 Jun 2013 22:23:53 +0800
Message-ID: <1370874233.25883.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CE9C261664
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 16:23:59 +0200 (CEST)
Received: by mail-pb0-f50.google.com with SMTP id wz7so1730296pbc.37
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 07:23:59 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Otherwise, ssm2518_set_tdm_slot() always returns error if slots != 0.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ssm2518.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index a76b341..f4883d9 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -538,7 +538,7 @@ static int ssm2518_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			SSM2518_REG_SAI_CTRL1, SSM2518_SAI_CTRL1_SAI_MASK,
 			SSM2518_SAI_CTRL1_SAI_I2S);
 
-	if (tx_mask == 0 || tx_mask != 0)
+	if (tx_mask == 0 || rx_mask != 0)
 		return -EINVAL;
 
 	if (slots == 1) {
-- 
1.8.1.2
