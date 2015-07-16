From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: max9877: Make driver global regmap
	struct local
Date: Thu, 16 Jul 2015 21:22:49 +0200
Message-ID: <1437074572-3831-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id A9A9D2605B0
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 21:22:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use a stack local variable to handle function local state rather than a
global static variable. The later has a potential for race conditions if
the probe function runs for two devices concurrently.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max9877.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index e1df06f..b469e1c 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -20,8 +20,6 @@
 
 #include "max9877.h"
 
-static struct regmap *regmap;
-
 static const struct reg_default max9877_regs[] = {
 	{ 0, 0x40 },
 	{ 1, 0x00 },
@@ -145,6 +143,7 @@ static const struct regmap_config max9877_regmap = {
 static int max9877_i2c_probe(struct i2c_client *client,
 			     const struct i2c_device_id *id)
 {
+	struct regmap *regmap;
 	int i;
 
 	regmap = devm_regmap_init_i2c(client, &max9877_regmap);
-- 
2.1.4
