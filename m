From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] sound: soc: codecs: wcd9335: fix "conversion
 to bool not needed here"
Date: Thu, 11 Jul 2019 23:19:06 +0530
Message-ID: <20190711174906.GA10867@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96674F800D8
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2019 19:49:16 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id m4so3303201pgk.0
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2019 10:49:15 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Vinod Koul <vkoul@kernel.org>, Wen Yang <wen.yang99@zte.com.cn>, Gen Zhang <blackgod016574@gmail.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fix below issue reported by coccicheck
sound/soc/codecs/wcd9335.c:3991:25-30: WARNING: conversion to bool not
needed here

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1bbbe42..85a8d10 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3988,12 +3988,7 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
 		regmap_read(wcd->if_regmap,
 				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
 		if (val) {
-			if (!tx)
-				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
-					(port_id / 8);
-			else
-				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
-					(port_id / 8);
+			reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 + (port_id / 8);
 			regmap_read(
 				wcd->if_regmap, reg, &int_val);
 			/*
-- 
2.7.4
