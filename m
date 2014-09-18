From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: max98090: Fix missing free_irq (part 2)
Date: Thu, 18 Sep 2014 13:48:44 +0300
Message-ID: <1411037324-5996-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 07AC3264EFF
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 12:48:49 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

I was blind to see interrupt was requested in codec probe instead of i2c
probe when doing commit 4adeb0ccf86a ("ASoC: max98090: Fix missing free_irq")
and there is still a case where interrupt is kept requested. Although not as
fatal as original issue.

Since codec can be reprobed while driver is loaded the subsequent
max98090_probe() call will fail in interrupt request since it wasn't freed.

Fix this by explicitly freeing irq in max98090_remove().

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
for-next, I don't think this is critical enough for stable.
---
 sound/soc/codecs/max98090.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index f1543653a699..ccc1466c0440 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2413,6 +2413,7 @@ static int max98090_remove(struct snd_soc_codec *codec)
 {
 	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
 
+	devm_free_irq(codec->dev, max98090->irq, codec);
 	cancel_delayed_work_sync(&max98090->jack_work);
 	cancel_delayed_work_sync(&max98090->pll_det_enable_work);
 	cancel_work_sync(&max98090->pll_det_disable_work);
-- 
2.1.0
