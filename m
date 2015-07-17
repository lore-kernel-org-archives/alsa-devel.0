From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] ASoC: cs4349: Fix max_register setting for
	cs4349_regmap
Date: Fri, 17 Jul 2015 23:38:34 +0800
Message-ID: <1437147514.1229.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 42BC62604D5
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 17:38:41 +0200 (CEST)
Received: by pdrg1 with SMTP id g1so63425635pdr.2
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 08:38:40 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The max_register should be the maximum valid register index rather than
number of registers. Also remove unused defines.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs4349.c | 2 +-
 sound/soc/codecs/cs4349.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index a8df8a74..9273b06 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -268,7 +268,7 @@ static struct regmap_config cs4349_regmap = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
 
-	.max_register		= CS4349_NUMREGS,
+	.max_register		= CS4349_MISC,
 	.reg_defaults		= cs4349_reg_defaults,
 	.num_reg_defaults	= ARRAY_SIZE(cs4349_reg_defaults),
 	.readable_reg		= cs4349_readable_register,
diff --git a/sound/soc/codecs/cs4349.h b/sound/soc/codecs/cs4349.h
index 3884a89..7effa0a 100644
--- a/sound/soc/codecs/cs4349.h
+++ b/sound/soc/codecs/cs4349.h
@@ -36,9 +36,6 @@ struct cs4349_platform_data {
 #define CS4349_RMPFLT		0x07	/* Ramp and Filter Control */
 #define CS4349_MISC		0x08	/* Power Down,Freeze Control,Pop Stop*/
 
-#define CS4349_FIRSTREG		0x01
-#define CS4349_LASTREG		0x08
-#define CS4349_NUMREGS		(CS4349_LASTREG - CS4349_FIRSTREG + 1)
 #define CS4349_I2C_INCR		0x80
 
 
-- 
2.1.0
