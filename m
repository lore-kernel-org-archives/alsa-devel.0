From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l35: Add additional delay for
	reset" to the asoc tree
Date: Tue, 06 Jun 2017 20:05:44 +0100
Message-ID: <E1dIJnU-00076q-R6@debutante>
References: <1496245873-9011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93D3E267022
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 21:05:54 +0200 (CEST)
In-Reply-To: <1496245873-9011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: brian.austin@cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Add additional delay for reset

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

>From dc43f46a9b6988a40d4e11d05b8107d4546c61b9 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 31 May 2017 16:51:13 +0100
Subject: [PATCH] ASoC: cs35l35: Add additional delay for reset

Very fast systems may violate the minimum constraints for time the reset
line needs to remain low, or communicate with the device too soon after
releasing the reset. Fix this by adding some delays in to allow the chip
to properly reset, also factor out the reset into a function as it is
likely it will be re-used in later additions to the driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l35.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index f8aef5869b03..5ff12e4116e5 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -162,6 +162,14 @@ static bool cs35l35_precious_register(struct device *dev, unsigned int reg)
 	}
 }
 
+static void cs35l35_reset(struct cs35l35_private *cs35l35)
+{
+	gpiod_set_value_cansleep(cs35l35->reset_gpio, 0);
+	usleep_range(2000, 2100);
+	gpiod_set_value_cansleep(cs35l35->reset_gpio, 1);
+	usleep_range(1000, 1100);
+}
+
 static int cs35l35_wait_for_pdn(struct cs35l35_private *cs35l35)
 {
 	int ret;
@@ -1454,7 +1462,7 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 		}
 	}
 
-	gpiod_set_value_cansleep(cs35l35->reset_gpio, 1);
+	cs35l35_reset(cs35l35);
 
 	init_completion(&cs35l35->pdn_done);
 
-- 
2.11.0
