From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: da732x: Print correct major id
Date: Thu, 03 Apr 2014 19:56:32 +0800
Message-ID: <1396526192.12814.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 by alsa0.perex.cz (Postfix) with ESMTP id DB5F2265593
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 13:56:38 +0200 (CEST)
Received: by mail-pb0-f49.google.com with SMTP id jt11so1731223pbb.22
 for <alsa-devel@alsa-project.org>; Thu, 03 Apr 2014 04:56:37 -0700 (PDT)
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Michal Hajduk <michal.hajduk@diasemi.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

DA732X_ID_MAJOR_MASK is 0xF0, so the major id is
(reg & DA732X_ID_MAJOR_MASK) >> 4.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/da732x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 7d168ec..48f3fef 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1571,7 +1571,8 @@ static int da732x_i2c_probe(struct i2c_client *i2c,
 	}
 
 	dev_info(&i2c->dev, "Revision: %d.%d\n",
-		 (reg & DA732X_ID_MAJOR_MASK), (reg & DA732X_ID_MINOR_MASK));
+		 (reg & DA732X_ID_MAJOR_MASK) >> 4,
+		 (reg & DA732X_ID_MINOR_MASK));
 
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_da732x,
 				     da732x_dai, ARRAY_SIZE(da732x_dai));
-- 
1.8.3.2
