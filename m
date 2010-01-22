From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: fix a memory-leak in wm8903
Date: Fri, 22 Jan 2010 18:00:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001221756240.4652@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 1A555103800
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 17:59:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Remember to free the temporary register-cache.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

should go in -rc, maybe also for stable

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index ce5515e..3595bd5 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1504,7 +1504,7 @@ static int wm8903_resume(struct platform_device *pdev)
 	struct i2c_client *i2c = codec->control_data;
 	int i;
 	u16 *reg_cache = codec->reg_cache;
-	u16 *tmp_cache = kmemdup(codec->reg_cache, sizeof(wm8903_reg_defaults),
+	u16 *tmp_cache = kmemdup(reg_cache, sizeof(wm8903_reg_defaults),
 				 GFP_KERNEL);
 
 	/* Bring the codec back up to standby first to minimise pop/clicks */
@@ -1516,6 +1516,7 @@ static int wm8903_resume(struct platform_device *pdev)
 		for (i = 2; i < ARRAY_SIZE(wm8903_reg_defaults); i++)
 			if (tmp_cache[i] != reg_cache[i])
 				snd_soc_write(codec, i, tmp_cache[i]);
+		kfree(tmp_cache);
 	} else {
 		dev_err(&i2c->dev, "Failed to allocate temporary cache\n");
 	}
