From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 02/16] ASoC: cs42l73: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:28:58 +0530
Message-ID: <1403258352-8210-2-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id C6FE8261ABF
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:27 +0200 (CEST)
Received: by mail-pb0-f53.google.com with SMTP id uo5so2925154pbc.26
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:25 -0700 (PDT)
In-Reply-To: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
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
 sound/soc/codecs/cs42l73.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index ae3717992d56..e3b601624794 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1408,10 +1408,8 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
 
 	cs42l73 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l73_private),
 			       GFP_KERNEL);
-	if (!cs42l73) {
-		dev_err(&i2c_client->dev, "could not allocate codec\n");
+	if (!cs42l73)
 		return -ENOMEM;
-	}
 
 	cs42l73->regmap = devm_regmap_init_i2c(i2c_client, &cs42l73_regmap);
 	if (IS_ERR(cs42l73->regmap)) {
-- 
1.7.9.5
