From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 01/16] ASoC: cs4270: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:28:57 +0530
Message-ID: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 82D20261A68
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:25 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id r10so2810473pdi.18
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:23 -0700 (PDT)
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
Cc: broonie@kernel.org, spk.linux@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Let memory subsystem handle the error logging.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 sound/soc/codecs/cs4270.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 9947a9583679..e6d4ff9fd992 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -664,10 +664,8 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 
 	cs4270 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs4270_private),
 			      GFP_KERNEL);
-	if (!cs4270) {
-		dev_err(&i2c_client->dev, "could not allocate codec\n");
+	if (!cs4270)
 		return -ENOMEM;
-	}
 
 	/* get the power supply regulators */
 	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
-- 
1.7.9.5
