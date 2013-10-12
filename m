From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: pcm1681: Fix max_register setting
Date: Sat, 12 Oct 2013 17:24:25 +0800
Message-ID: <1381569865.3884.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 88401260323
 for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2013 11:24:38 +0200 (CEST)
Received: by mail-pb0-f53.google.com with SMTP id up15so5293575pbc.12
 for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2013 02:24:37 -0700 (PDT)
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
Cc: Marek Belisko <marek.belisko@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet, the max_register is 13h.
ARRAY_SIZE(pcm1681_reg_defaults) + 1 is 18 which is wrong.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/pcm1681.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 651ce09..c91eba5 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -270,7 +270,7 @@ MODULE_DEVICE_TABLE(of, pcm1681_dt_ids);
 static const struct regmap_config pcm1681_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
-	.max_register		= ARRAY_SIZE(pcm1681_reg_defaults) + 1,
+	.max_register		= 0x13,
 	.reg_defaults		= pcm1681_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(pcm1681_reg_defaults),
 	.writeable_reg		= pcm1681_writeable_reg,
-- 
1.8.1.2
