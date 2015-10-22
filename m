From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: Show device properties" to the
	asoc tree
Date: Fri, 23 Oct 2015 08:09:03 +0900
Message-ID: <E1ZpOyl-0008Ke-CV@finisterre>
References: <1444427341-7135-2-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4979A266AB7
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:14 +0200 (CEST)
In-Reply-To: <1444427341-7135-2-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: Show device properties

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

>From 218d2ce2036f50d259dbcdd37a4db72cad6fc0d1 Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Mon, 19 Oct 2015 16:49:06 -0700
Subject: [PATCH] ASoC: nau8825: Show device properties

The codec device properties are printed for debugging.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index bd58b96..7fc7b4e 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1100,6 +1100,34 @@ static void nau8825_reset_chip(struct regmap *regmap)
 	regmap_write(regmap, NAU8825_REG_RESET, 0x00);
 }
 
+static void nau8825_print_device_properties(struct nau8825 *nau8825)
+{
+	int i;
+	struct device *dev = nau8825->dev;
+
+	dev_dbg(dev, "jkdet-enable:         %d\n", nau8825->jkdet_enable);
+	dev_dbg(dev, "jkdet-pull-enable:    %d\n", nau8825->jkdet_pull_enable);
+	dev_dbg(dev, "jkdet-pull-up:        %d\n", nau8825->jkdet_pull_up);
+	dev_dbg(dev, "jkdet-polarity:       %d\n", nau8825->jkdet_polarity);
+	dev_dbg(dev, "micbias-voltage:      %d\n", nau8825->micbias_voltage);
+	dev_dbg(dev, "vref-impedance:       %d\n", nau8825->vref_impedance);
+
+	dev_dbg(dev, "sar-threshold-num:    %d\n", nau8825->sar_threshold_num);
+	for (i = 0; i < nau8825->sar_threshold_num; i++)
+		dev_dbg(dev, "sar-threshold[%d]=%d\n", i,
+				nau8825->sar_threshold[i]);
+
+	dev_dbg(dev, "sar-hysteresis:       %d\n", nau8825->sar_hysteresis);
+	dev_dbg(dev, "sar-voltage:          %d\n", nau8825->sar_voltage);
+	dev_dbg(dev, "sar-compare-time:     %d\n", nau8825->sar_compare_time);
+	dev_dbg(dev, "sar-sampling-time:    %d\n", nau8825->sar_sampling_time);
+	dev_dbg(dev, "short-key-debounce:   %d\n", nau8825->key_debounce);
+	dev_dbg(dev, "jack-insert-debounce: %d\n",
+			nau8825->jack_insert_debounce);
+	dev_dbg(dev, "jack-eject-debounce:  %d\n",
+			nau8825->jack_eject_debounce);
+}
+
 static int nau8825_read_device_properties(struct device *dev,
 	struct nau8825 *nau8825) {
 
@@ -1213,6 +1241,8 @@ static int nau8825_i2c_probe(struct i2c_client *i2c,
 	nau8825->dev = dev;
 	nau8825->irq = i2c->irq;
 
+	nau8825_print_device_properties(nau8825);
+
 	nau8825_reset_chip(nau8825->regmap);
 	ret = regmap_read(nau8825->regmap, NAU8825_REG_I2C_DEVICE_ID, &value);
 	if (ret < 0) {
-- 
2.6.1
