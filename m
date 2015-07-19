From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: cs4349: Fix suspend/resume
Date: Sun, 19 Jul 2015 12:15:17 +0200
Message-ID: <1437300918-4612-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-068.synserver.de (smtp-out-068.synserver.de
 [212.40.185.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D1F92260566
 for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2015 12:15:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Tim Howe <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

dev_get_drvdata() will not return the snd_soc_runtime to which this CODEC
is attached, so the current code will result in undefined behavior.
To fix this just use regmap_update_bits(cs4349->regmap, ...) directly
instead of snd_soc_update_bits(rtd->codec, ...).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/cs4349.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index a8df8a74..db18799 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -328,10 +328,9 @@ static int cs4349_i2c_remove(struct i2c_client *client)
 static int cs4349_runtime_suspend(struct device *dev)
 {
 	struct cs4349_private *cs4349 = dev_get_drvdata(dev);
-	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
 	int ret;
 
-	ret = snd_soc_update_bits(rtd->codec, CS4349_MISC, PWR_DWN, 1);
+	ret = regmap_update_bits(cs4349->regmap, CS4349_MISC, PWR_DWN, 1);
 	if (ret < 0)
 		return ret;
 
@@ -347,10 +346,9 @@ static int cs4349_runtime_suspend(struct device *dev)
 static int cs4349_runtime_resume(struct device *dev)
 {
 	struct cs4349_private *cs4349 = dev_get_drvdata(dev);
-	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
 	int ret;
 
-	ret = snd_soc_update_bits(rtd->codec, CS4349_MISC, PWR_DWN, 0);
+	ret = regmap_update_bits(cs4349->regmap, CS4349_MISC, PWR_DWN, 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.1.4
