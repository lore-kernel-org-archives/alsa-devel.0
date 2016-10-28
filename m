From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rl6347a: Use dev_err for I2C
	communication error prints" to the asoc tree
Date: Fri, 28 Oct 2016 18:03:06 +0100
Message-ID: <E1c0AYc-0003XS-2v@finisterre>
References: <20161007075951.20386-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F3212676B2
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 19:03:27 +0200 (CEST)
In-Reply-To: <20161007075951.20386-1-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rl6347a: Use dev_err for I2C communication error prints

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

>From b058b176dd26546bcef8f8b774f1542b2907af5f Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Fri, 7 Oct 2016 10:59:51 +0300
Subject: [PATCH] ASoC: rl6347a: Use dev_err for I2C communication error prints

It's difficult to guess from bunch of "ret=-121" errors what driver and
device actually caused them. Since struct i2c_client has the dev pointer
use that for dev_err() with meaningful error message.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rl6347a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rl6347a.c b/sound/soc/codecs/rl6347a.c
index a4b910efbd45..8f571cf8edd4 100644
--- a/sound/soc/codecs/rl6347a.c
+++ b/sound/soc/codecs/rl6347a.c
@@ -51,7 +51,7 @@ int rl6347a_hw_write(void *context, unsigned int reg, unsigned int value)
 	if (ret == 4)
 		return 0;
 	else
-		pr_err("ret=%d\n", ret);
+		dev_err(&client->dev, "I2C error %d\n", ret);
 	if (ret < 0)
 		return ret;
 	else
-- 
2.10.1
