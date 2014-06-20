From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 10/16] ASoC: wm1250-ev1: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:06 +0530
Message-ID: <1403258352-8210-10-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id AD4C0265050
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:53 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id r10so2819568pdi.4
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:52 -0700 (PDT)
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
 sound/soc/codecs/wm1250-ev1.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 6e6b93d4696e..8011f75fb6cb 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -164,7 +164,6 @@ static int wm1250_ev1_pdata(struct i2c_client *i2c)
 
 	wm1250 = devm_kzalloc(&i2c->dev, sizeof(*wm1250), GFP_KERNEL);
 	if (!wm1250) {
-		dev_err(&i2c->dev, "Unable to allocate private data\n");
 		ret = -ENOMEM;
 		goto err;
 	}
-- 
1.7.9.5
