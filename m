From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: default value for property" to
	the asoc tree
Date: Fri, 23 Jun 2017 13:04:03 +0100
Message-ID: <E1dONJj-0006QQ-OZ@debutante>
References: <1498099311-2738-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A89822674A8
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 14:04:13 +0200 (CEST)
In-Reply-To: <1498099311-2738-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: default value for property

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

>From 403d2fef06104275dd4909d2684c86aabe25c917 Mon Sep 17 00:00:00 2001
From: John Hsu <supercraig0719@gmail.com>
Date: Thu, 22 Jun 2017 10:41:51 +0800
Subject: [PATCH] ASoC: nau8825: default value for property

Assign default value for codec private data when property not given.
If without those default value and property, the codec will work
abnormally.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 53 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 97fbeba9498f..c00b86dd80dc 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -2429,6 +2429,7 @@ static void nau8825_print_device_properties(struct nau8825 *nau8825)
 
 static int nau8825_read_device_properties(struct device *dev,
 	struct nau8825 *nau8825) {
+	int ret;
 
 	nau8825->jkdet_enable = device_property_read_bool(dev,
 		"nuvoton,jkdet-enable");
@@ -2436,30 +2437,58 @@ static int nau8825_read_device_properties(struct device *dev,
 		"nuvoton,jkdet-pull-enable");
 	nau8825->jkdet_pull_up = device_property_read_bool(dev,
 		"nuvoton,jkdet-pull-up");
-	device_property_read_u32(dev, "nuvoton,jkdet-polarity",
+	ret = device_property_read_u32(dev, "nuvoton,jkdet-polarity",
 		&nau8825->jkdet_polarity);
-	device_property_read_u32(dev, "nuvoton,micbias-voltage",
+	if (ret)
+		nau8825->jkdet_polarity = 1;
+	ret = device_property_read_u32(dev, "nuvoton,micbias-voltage",
 		&nau8825->micbias_voltage);
-	device_property_read_u32(dev, "nuvoton,vref-impedance",
+	if (ret)
+		nau8825->micbias_voltage = 6;
+	ret = device_property_read_u32(dev, "nuvoton,vref-impedance",
 		&nau8825->vref_impedance);
-	device_property_read_u32(dev, "nuvoton,sar-threshold-num",
+	if (ret)
+		nau8825->vref_impedance = 2;
+	ret = device_property_read_u32(dev, "nuvoton,sar-threshold-num",
 		&nau8825->sar_threshold_num);
-	device_property_read_u32_array(dev, "nuvoton,sar-threshold",
+	if (ret)
+		nau8825->sar_threshold_num = 4;
+	ret = device_property_read_u32_array(dev, "nuvoton,sar-threshold",
 		nau8825->sar_threshold, nau8825->sar_threshold_num);
-	device_property_read_u32(dev, "nuvoton,sar-hysteresis",
+	if (ret) {
+		nau8825->sar_threshold[0] = 0x08;
+		nau8825->sar_threshold[1] = 0x12;
+		nau8825->sar_threshold[2] = 0x26;
+		nau8825->sar_threshold[3] = 0x73;
+	}
+	ret = device_property_read_u32(dev, "nuvoton,sar-hysteresis",
 		&nau8825->sar_hysteresis);
-	device_property_read_u32(dev, "nuvoton,sar-voltage",
+	if (ret)
+		nau8825->sar_hysteresis = 0;
+	ret = device_property_read_u32(dev, "nuvoton,sar-voltage",
 		&nau8825->sar_voltage);
-	device_property_read_u32(dev, "nuvoton,sar-compare-time",
+	if (ret)
+		nau8825->sar_voltage = 6;
+	ret = device_property_read_u32(dev, "nuvoton,sar-compare-time",
 		&nau8825->sar_compare_time);
-	device_property_read_u32(dev, "nuvoton,sar-sampling-time",
+	if (ret)
+		nau8825->sar_compare_time = 1;
+	ret = device_property_read_u32(dev, "nuvoton,sar-sampling-time",
 		&nau8825->sar_sampling_time);
-	device_property_read_u32(dev, "nuvoton,short-key-debounce",
+	if (ret)
+		nau8825->sar_sampling_time = 1;
+	ret = device_property_read_u32(dev, "nuvoton,short-key-debounce",
 		&nau8825->key_debounce);
-	device_property_read_u32(dev, "nuvoton,jack-insert-debounce",
+	if (ret)
+		nau8825->key_debounce = 3;
+	ret = device_property_read_u32(dev, "nuvoton,jack-insert-debounce",
 		&nau8825->jack_insert_debounce);
-	device_property_read_u32(dev, "nuvoton,jack-eject-debounce",
+	if (ret)
+		nau8825->jack_insert_debounce = 7;
+	ret = device_property_read_u32(dev, "nuvoton,jack-eject-debounce",
 		&nau8825->jack_eject_debounce);
+	if (ret)
+		nau8825->jack_eject_debounce = 0;
 
 	nau8825->mclk = devm_clk_get(dev, "mclk");
 	if (PTR_ERR(nau8825->mclk) == -EPROBE_DEFER) {
-- 
2.13.1
