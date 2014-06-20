From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 04/16] ASoC: sta529: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:00 +0530
Message-ID: <1403258352-8210-4-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E97F261AF9
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:33 +0200 (CEST)
Received: by mail-pd0-f176.google.com with SMTP id ft15so2816202pdb.35
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:32 -0700 (PDT)
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
 sound/soc/codecs/sta529.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sta529.c b/sound/soc/codecs/sta529.c
index a40c4b0196a3..fcdf11026aff 100644
--- a/sound/soc/codecs/sta529.c
+++ b/sound/soc/codecs/sta529.c
@@ -380,10 +380,8 @@ static int sta529_i2c_probe(struct i2c_client *i2c,
 		return -EINVAL;
 
 	sta529 = devm_kzalloc(&i2c->dev, sizeof(struct sta529), GFP_KERNEL);
-	if (sta529 == NULL) {
-		dev_err(&i2c->dev, "Can not allocate memory\n");
+	if (!sta529)
 		return -ENOMEM;
-	}
 
 	sta529->regmap = devm_regmap_init_i2c(i2c, &sta529_regmap);
 	if (IS_ERR(sta529->regmap)) {
-- 
1.7.9.5
