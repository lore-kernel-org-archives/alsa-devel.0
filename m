From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: codecs: fix wm8524 build error
Date: Mon, 31 Jul 2017 18:05:46 +0200
Message-ID: <20170731160713.3732735-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 91CD5266FD2
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 18:07:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mihai Serban <mihai.serban@nxp.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, patches@opensource.cirrus.com, Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When CONFIG_OF is disabled, we run into a build error:

sound/soc/codecs/wm8524.c:257:21: error: 'wm8524_of_match' undeclared here (not in a function); did you mean 'wm8524_dai'?

This removes the unnecessary #ifdef around the match table.

Fixes: 007b6a54c305 ("ASoC: codecs: add wm8524 codec driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/wm8524.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
index f42ec664877c..e22b76d64e32 100644
--- a/sound/soc/codecs/wm8524.c
+++ b/sound/soc/codecs/wm8524.c
@@ -206,13 +206,11 @@ static const struct snd_soc_codec_driver soc_codec_dev_wm8524 = {
 	},
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id wm8524_of_match[] = {
 	{ .compatible = "wlf,wm8524" },
 	{ /* sentinel*/ }
 };
 MODULE_DEVICE_TABLE(of, wm8524_of_match);
-#endif
 
 static int wm8524_codec_probe(struct platform_device *pdev)
 {
-- 
2.9.0
