From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Avoid relying on uninitialized "val" value" to the asoc tree
Date: Fri, 14 Apr 2017 18:11:58 +0100
Message-ID: <E1cz4lK-0005ZO-IB@debutante>
References: <20170414164033.11681-2-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170414164033.11681-2-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, bardliao@realtek.com, oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.combroonie@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Avoid relying on uninitialized "val" value

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

>From 0a78b248c3324fbbba49f74e2c93e0f436583788 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Fri, 14 Apr 2017 09:40:31 -0700
Subject: [PATCH] ASoC: rt5514: Avoid relying on uninitialized "val" value

In rt5514_i2c_probe() if the regmap_read(RT5514_VENDOR_ID2) fails then
"val" may be left as uninitialized.  Current code relies on "val" not
being RT5514_DEVICE_ID, but that's potentially unsafe.

Let's check for errors from regmap_read() and also explicitly init the
value do we're not passing a possibly uninitialized int to printk.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 481e77763fe4..969a05620e04 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1090,7 +1090,7 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 	struct rt5514_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5514_priv *rt5514;
 	int ret;
-	unsigned int val;
+	unsigned int val = ~0;
 
 	rt5514 = devm_kzalloc(&i2c->dev, sizeof(struct rt5514_priv),
 				GFP_KERNEL);
@@ -1120,8 +1120,8 @@ static int rt5514_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt5514->regmap, RT5514_VENDOR_ID2, &val);
-	if (val != RT5514_DEVICE_ID) {
+	ret = regmap_read(rt5514->regmap, RT5514_VENDOR_ID2, &val);
+	if (ret || val != RT5514_DEVICE_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %x is not rt5514\n", val);
 		return -ENODEV;
-- 
2.11.0
