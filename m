From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 06/16] ASoC: tpa6130a2: Remove redundant OOM
	message
Date: Fri, 20 Jun 2014 15:29:02 +0530
Message-ID: <1403258352-8210-6-git-send-email-sachin.kamat@samsung.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C8FB264F8F
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 12:02:40 +0200 (CEST)
Received: by mail-pb0-f51.google.com with SMTP id rp16so2953806pbb.38
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 03:02:39 -0700 (PDT)
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
 sound/soc/codecs/tpa6130a2.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 8fc5a647453b..6fac9e034c48 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -381,10 +381,8 @@ static int tpa6130a2_probe(struct i2c_client *client,
 	dev = &client->dev;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(dev, "Can not allocate memory\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	if (pdata) {
 		data->power_gpio = pdata->power_gpio;
-- 
1.7.9.5
