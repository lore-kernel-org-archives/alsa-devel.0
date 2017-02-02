From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: fix error handling for gpio
	detection" to the asoc tree
Date: Thu, 02 Feb 2017 11:06:42 +0000
Message-ID: <E1cZFDu-0005gB-NR@debutante>
References: <1485973625-20553-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85E00267557
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 12:06:53 +0100 (CET)
In-Reply-To: <1485973625-20553-2-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: fix error handling for gpio detection

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

>From cec55827dde1e87f6b91e34f205744d70a7225bc Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 1 Feb 2017 12:27:04 -0600
Subject: [PATCH] ASoC: rt5645: fix error handling for gpio detection

Optional gpio handling should not cause an error status and prevent
probing if it's missing.  Remove error return for -ENOENT case and
move error message to dev_info

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 37fb2b6c34a5..e09fa19f44c0 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3658,8 +3658,14 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 						       GPIOD_IN);
 
 	if (IS_ERR(rt5645->gpiod_hp_det)) {
-		dev_err(&i2c->dev, "failed to initialize gpiod\n");
-		return PTR_ERR(rt5645->gpiod_hp_det);
+		dev_info(&i2c->dev, "failed to initialize gpiod\n");
+		ret = PTR_ERR(rt5645->gpiod_hp_det);
+		/*
+		 * Continue if optional gpiod is missing, bail for all other
+		 * errors, including -EPROBE_DEFER
+		 */
+		if (ret != -ENOENT)
+			return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
-- 
2.11.0
