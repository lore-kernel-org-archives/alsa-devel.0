From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: max98090: Fix build warning when
 CONFIG_PM_RUNTIME is not set
Date: Thu, 02 May 2013 16:00:58 +0800
Message-ID: <1367481658.13357.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f45.google.com (mail-da0-f45.google.com
 [209.85.210.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A92B82610C9
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 10:01:05 +0200 (CEST)
Received: by mail-da0-f45.google.com with SMTP id w3so196359dad.32
 for <alsa-devel@alsa-project.org>; Thu, 02 May 2013 01:01:04 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Fix below build warning when CONFIG_PM_RUNTIME is not set.

  CC [M]  sound/soc/codecs/max98090.o
sound/soc/codecs/max98090.c:2339:12: warning: 'max98090_runtime_resume' defined but not used [-Wunused-function]
sound/soc/codecs/max98090.c:2350:12: warning: 'max98090_runtime_suspend' defined but not used [-Wunused-function]

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max98090.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index ce0d364..4f39a50 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2336,6 +2336,7 @@ static int max98090_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
 static int max98090_runtime_resume(struct device *dev)
 {
 	struct max98090_priv *max98090 = dev_get_drvdata(dev);
@@ -2355,6 +2356,7 @@ static int max98090_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops max98090_pm = {
 	SET_RUNTIME_PM_OPS(max98090_runtime_suspend,
-- 
1.8.1.2
