From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Unconfuse the rt5514 at probe / resume time" to the asoc tree
Date: Fri, 14 Apr 2017 18:11:55 +0100
Message-ID: <E1cz4lH-0005YR-Hh@debutante>
References: <20170414164033.11681-3-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170414164033.11681-3-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, bardliao@realtek.com, oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.combroonie@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Unconfuse the rt5514 at probe / resume time

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

>From 7952b4baff402ddca1a263380bfd142f10290eb8 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Fri, 14 Apr 2017 09:40:32 -0700
Subject: [PATCH] ASoC: rt5514: Unconfuse the rt5514 at probe / resume time

The rt5514 can get confused and incorrectly detect a start bit if the
SCL/SDA lines happen to both go low and then high again.  This
situation has been seen to happen at reboot time and is also
theoretically possible during suspend/resume if the rt5514 keeps power
but we shut down the i2c connection.

When this happens the rt5514 is confused about the state of the i2c
bus and won't recognize its own address.  That will lead to the rt5514
incorrectly NAKing the first transfer.

A single i2c transfer to any address should be enough to get the
rt5514 out of this funky state.

It is currently believed that this problem should be fixed in the
rt5514 driver itself because it seems that the i2c controller in the
rt5514 is easily confused.  Most i2c devices wouldn't detect a start
bit in this case.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 969a05620e04..f91221b1ddf0 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1084,6 +1084,21 @@ static int rt5514_parse_dt(struct rt5514_priv *rt5514, struct device *dev)
 	return 0;
 }
 
+static __maybe_unused int rt5514_i2c_resume(struct device *dev)
+{
+	struct rt5514_priv *rt5514 = dev_get_drvdata(dev);
+	unsigned int val;
+
+	/*
+	 * Add a bogus read to avoid rt5514's confusion after s2r in case it
+	 * saw glitches on the i2c lines and thought the other side sent a
+	 * start bit.
+	 */
+	regmap_read(rt5514->regmap, RT5514_VENDOR_ID2, &val);
+
+	return 0;
+}
+
 static int rt5514_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -1120,7 +1135,15 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/*
+	 * The rt5514 can get confused if the i2c lines glitch together, as
+	 * can happen at bootup as regulators are turned off and on.  If it's
+	 * in this glitched state the first i2c read will fail, so we'll give
+	 * it one change to retry.
+	 */
 	ret = regmap_read(rt5514->regmap, RT5514_VENDOR_ID2, &val);
+	if (ret || val != RT5514_DEVICE_ID)
+		ret = regmap_read(rt5514->regmap, RT5514_VENDOR_ID2, &val);
 	if (ret || val != RT5514_DEVICE_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %x is not rt5514\n", val);
@@ -1149,10 +1172,15 @@ static int rt5514_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+static const struct dev_pm_ops rt5514_i2_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, rt5514_i2c_resume)
+};
+
 static struct i2c_driver rt5514_i2c_driver = {
 	.driver = {
 		.name = "rt5514",
 		.of_match_table = of_match_ptr(rt5514_of_match),
+		.pm = &rt5514_i2_pm_ops,
 	},
 	.probe = rt5514_i2c_probe,
 	.remove   = rt5514_i2c_remove,
-- 
2.11.0
