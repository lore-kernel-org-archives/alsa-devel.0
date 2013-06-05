From: Mark Brown <broonie@linaro.org>
Subject: [PATCH] ASoC: max98090: Guard runtime PM callbacks
Date: Wed,  5 Jun 2013 19:33:54 +0100
Message-ID: <1370457234-27747-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A06D32619E4
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 20:34:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Otherwise the functions will be defined but unreferenced when runtime PM
is disabled, generating warnings.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/max98090.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 1bf96bd..ad5313f 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2350,6 +2350,7 @@ static int max98090_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
 static int max98090_runtime_resume(struct device *dev)
 {
 	struct max98090_priv *max98090 = dev_get_drvdata(dev);
@@ -2369,6 +2370,7 @@ static int max98090_runtime_suspend(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops max98090_pm = {
 	SET_RUNTIME_PM_OPS(max98090_runtime_suspend,
-- 
1.7.10.4
