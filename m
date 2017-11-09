From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Delay and retry reading rt5663
	ID register" to the asoc tree
Date: Thu, 09 Nov 2017 17:44:36 +0000
Message-ID: <E1eCqsW-0006lU-9f@debutante>
References: <1510226890-11507-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B5551267850
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 18:44:39 +0100 (CET)
In-Reply-To: <1510226890-11507-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Delay and retry reading rt5663 ID register

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ba68fa318442d25586d057c1e8c9165bdc62c1b3 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Thu, 9 Nov 2017 19:28:10 +0800
Subject: [PATCH] ASoC: rt5663: Delay and retry reading rt5663 ID register

In the probe, the codec may not be ready for I2C reading or there are some
glitches on the i2c line. So if the i2c reading value is incorrect, it will
read again after delay. This issue is similar the patch
https://patchwork.kernel.org/patch/9681421/. In current project, these 2
devices were connected to the same i2c line, and they met the same problem.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 767f219f6c42..eb3065a992ab 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3428,7 +3428,16 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 			ret);
 		return ret;
 	}
-	regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
+
+	ret = regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
+	if (ret || (val != RT5663_DEVICE_ID_2 && val != RT5663_DEVICE_ID_1)) {
+		dev_err(&i2c->dev,
+			"Device with ID register %#x is not rt5663, retry one time.\n",
+			val);
+		msleep(100);
+		regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
+	}
+
 	switch (val) {
 	case RT5663_DEVICE_ID_2:
 		rt5663->regmap = devm_regmap_init_i2c(i2c, &rt5663_v2_regmap);
-- 
2.15.0
