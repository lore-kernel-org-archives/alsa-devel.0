From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 11/16] ASoC: wm2000: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:07 +0530
Message-ID: <1403258352-8210-11-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C880264FFF
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:57 +0200 (CEST)
Received: by mail-pa0-f51.google.com with SMTP id hz1so2933136pad.24
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:56 -0700 (PDT)
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
 sound/soc/codecs/wm2000.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index a4c352cc3464..34ef65c52a7d 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -826,10 +826,8 @@ static int wm2000_i2c_probe(struct i2c_client *i2c,
 
 	wm2000 = devm_kzalloc(&i2c->dev, sizeof(struct wm2000_priv),
 			      GFP_KERNEL);
-	if (wm2000 == NULL) {
-		dev_err(&i2c->dev, "Unable to allocate private data\n");
+	if (!wm2000)
 		return -ENOMEM;
-	}
 
 	mutex_init(&wm2000->lock);
 
-- 
1.7.9.5
