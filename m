From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: Fix suspend/resume" to the asoc
	tree
Date: Mon, 20 Jul 2015 18:52:11 +0100
Message-ID: <E1ZHFEZ-0002sE-9m@debutante>
References: <1437300918-4612-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D2D72614FB
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:18 +0200 (CEST)
In-Reply-To: <1437300918-4612-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4349: Fix suspend/resume

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cb2510dac7e1c5ac77652bb31e8c39ce2eef8bbe Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sun, 19 Jul 2015 12:15:17 +0200
Subject: [PATCH] ASoC: cs4349: Fix suspend/resume

dev_get_drvdata() will not return the snd_soc_runtime to which this CODEC
is attached, so the current code will result in undefined behavior.
To fix this just use regmap_update_bits(cs4349->regmap, ...) directly
instead of snd_soc_update_bits(rtd->codec, ...).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index f4fccc621ceb..13ccbf75207e 100644
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
