From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] ASoC: pcm1792a: Fix max_register setting
Date: Sat, 12 Oct 2013 17:26:49 +0800
Message-ID: <1381570009.3884.3.camel@phoenix>
References: <1381569865.3884.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 39A7E260323
 for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2013 11:26:54 +0200 (CEST)
Received: by mail-pb0-f44.google.com with SMTP id xa7so5285894pbc.3
 for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2013 02:26:53 -0700 (PDT)
In-Reply-To: <1381569865.3884.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Michael Trimarchi <michael@amarulasolutions.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet, the max_register is register 23.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/pcm1792a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 2a8eccf..7613181 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -188,7 +188,7 @@ MODULE_DEVICE_TABLE(of, pcm1792a_of_match);
 static const struct regmap_config pcm1792a_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
-	.max_register		= 24,
+	.max_register		= 23,
 	.reg_defaults		= pcm1792a_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(pcm1792a_reg_defaults),
 	.writeable_reg		= pcm1792a_writeable_reg,
-- 
1.8.1.2
