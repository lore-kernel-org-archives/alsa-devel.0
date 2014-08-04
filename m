From: "Peter S. Housel" <housel@acm.org>
Subject: [PATCH] ASoC: tlv320aic31xx: place codec into reset
	state initially
Date: Mon,  4 Aug 2014 15:13:21 -0700
Message-ID: <1407190401-3712-1-git-send-email-housel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmfepo202.cox.net (fed1rmfepo202.cox.net [68.230.241.147])
 by alsa0.perex.cz (Postfix) with ESMTP id C8C5826545B
 for <alsa-devel@alsa-project.org>; Tue,  5 Aug 2014 00:14:02 +0200 (CEST)
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo202.cox.net
 (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
 id <20140804221401.MLPW8128.fed1rmfepo202.cox.net@fed1rmimpo210>
 for <alsa-devel@alsa-project.org>; Mon, 4 Aug 2014 18:14:01 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Peter S. Housel" <housel@acm.org>, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Previously the driver would only place the TLV320AIC31XX into reset
using the gpio reset line when at least one of the power supply
regulators was disabled, so that if these supplies were always enabled
no reset would ever occur. This change resets the codec state at probe
time so that the initial register cache values are correct.

Signed-off-by: Peter S. Housel <housel@acm.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 0f64c78..89a4daf 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1194,7 +1194,7 @@ static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
 	if (aic31xx->pdata.gpio_reset) {
 		ret = devm_gpio_request_one(aic31xx->dev,
 					    aic31xx->pdata.gpio_reset,
-					    GPIOF_OUT_INIT_HIGH,
+					    GPIOF_OUT_INIT_LOW,
 					    "aic31xx-reset-pin");
 		if (ret < 0) {
 			dev_err(aic31xx->dev, "not able to acquire gpio\n");
-- 
1.9.1
