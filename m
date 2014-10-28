From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: es8328-i2c: Fix i2c_device_id name field
	in es8328_id
Date: Tue, 28 Oct 2014 08:59:37 +0800
Message-ID: <1414457977.5091.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id EEF6B261582
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 01:59:42 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id lf10so4905699pab.19
 for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 17:59:41 -0700 (PDT)
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
Cc: Sean Cross <xobs@kosagi.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The convention for i2c_device_id name does not need to have company prefix.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/es8328-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8328-i2c.c b/sound/soc/codecs/es8328-i2c.c
index aae410d..2d05b5d 100644
--- a/sound/soc/codecs/es8328-i2c.c
+++ b/sound/soc/codecs/es8328-i2c.c
@@ -19,7 +19,7 @@
 #include "es8328.h"
 
 static const struct i2c_device_id es8328_id[] = {
-	{ "everest,es8328", 0 },
+	{ "es8328", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, es8328_id);
-- 
1.9.1
