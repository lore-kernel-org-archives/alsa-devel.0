From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH 2/2] ASoC: nau8825: Show device properties
Date: Fri,  9 Oct 2015 14:49:01 -0700
Message-ID: <1444427341-7135-2-git-send-email-benzh@chromium.org>
References: <1444427341-7135-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id A1BA026529F
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 23:49:14 +0200 (CEST)
Received: by pacex6 with SMTP id ex6so97538592pac.0
 for <alsa-devel@alsa-project.org>; Fri, 09 Oct 2015 14:49:13 -0700 (PDT)
In-Reply-To: <1444427341-7135-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Chih-Chiang Chang <ccchang12@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

The codec device properties are printed for debugging.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/nau8825.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 010f50b..8a9e547 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1099,6 +1099,34 @@ static void nau8825_reset_chip(struct regmap *regmap)
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
 
@@ -1212,6 +1240,8 @@ static int nau8825_i2c_probe(struct i2c_client *i2c,
 	nau8825->dev = dev;
 	nau8825->irq = i2c->irq;
 
+	nau8825_print_device_properties(nau8825);
+
 	nau8825_reset_chip(nau8825->regmap);
 	ret = regmap_read(nau8825->regmap, NAU8825_REG_I2C_DEVICE_ID, &value);
 	if (ret < 0) {
-- 
2.6.0.rc2.230.g3dd15c0
