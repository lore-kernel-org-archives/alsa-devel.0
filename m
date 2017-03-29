From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l35: Clear reset_gpio on the error
	path in probe" to the asoc tree
Date: Wed, 29 Mar 2017 12:02:34 +0100
Message-ID: <E1ctBN4-0007Mq-IY@debutante>
References: <1490630067-23455-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C29AB266EFD
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:02:43 +0200 (CEST)
In-Reply-To: <1490630067-23455-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: brian.austin@cirrus.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Clear reset_gpio on the error path in probe

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

>From 8e71321d19c4ed02d9eed15955b8d485bab016fc Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 27 Mar 2017 16:54:27 +0100
Subject: [PATCH] ASoC: cs35l35: Clear reset_gpio on the error path in probe

The error path in probe attempts to put the device back into reset.
Should we fail to get the reset_gpio (such as a probe defer) we will
leave the error value in there, which the gpiod_set_value_cansleep on
the error path will attempt to deference.

Fix this issue by clearing reset_gpio before we head into the error
path.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 1d9f332b2eec..9688274f7c90 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1412,10 +1412,10 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(cs35l35->reset_gpio)) {
 		ret = PTR_ERR(cs35l35->reset_gpio);
+		cs35l35->reset_gpio = NULL;
 		if (ret == -EBUSY) {
 			dev_info(dev,
 				 "Reset line busy, assuming shared reset\n");
-			cs35l35->reset_gpio = NULL;
 		} else {
 			dev_err(dev, "Failed to get reset GPIO: %d\n", ret);
 			goto err;
-- 
2.11.0
