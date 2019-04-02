From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Add button press
	detection" to the asoc tree
Date: Tue,  2 Apr 2019 06:46:33 +0100 (BST)
Message-ID: <20190402054633.40C37442465@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29EB6F89610
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2019 07:46:41 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Add button press detection

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

>From 90f0202bf2e15e8933a550b7dfd439b500a76e1c Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Mon, 1 Apr 2019 10:13:29 -0500
Subject: [PATCH] ASoC: tlv320aic31xx: Add button press detection

This device can optionally detect headset or microphone button presses.
Add support for this by passing this event to the jack layer.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 17 +++++++++++++++--
 sound/soc/codecs/tlv320aic31xx.h |  3 ++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index a60cd8c08a14..fa47bfcb93e9 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1423,10 +1423,21 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 		dev_err(dev, "Short circuit on Left output is detected\n");
 	if (value & AIC31XX_HPRSCDETECT)
 		dev_err(dev, "Short circuit on Right output is detected\n");
-	if (value & AIC31XX_HSPLUG) {
+	if (value & (AIC31XX_HSPLUG | AIC31XX_BUTTONPRESS)) {
 		unsigned int val;
 		int status = 0;
 
+		ret = regmap_read(aic31xx->regmap, AIC31XX_INTRDACFLAG2,
+				  &val);
+		if (ret) {
+			dev_err(dev, "Failed to read interrupt mask: %d\n",
+				ret);
+			goto exit;
+		}
+
+		if (val & AIC31XX_BUTTONPRESS)
+			status |= SND_JACK_BTN_0;
+
 		ret = regmap_read(aic31xx->regmap, AIC31XX_HSDETECT, &val);
 		if (ret) {
 			dev_err(dev, "Failed to read headset type: %d\n", ret);
@@ -1451,7 +1462,8 @@ static irqreturn_t aic31xx_irq(int irq, void *data)
 	}
 	if (value & ~(AIC31XX_HPLSCDETECT |
 		      AIC31XX_HPRSCDETECT |
-		      AIC31XX_HSPLUG))
+		      AIC31XX_HSPLUG |
+		      AIC31XX_BUTTONPRESS))
 		dev_err(dev, "Unknown DAC interrupt flags: 0x%08x\n", value);
 
 read_overflow:
@@ -1564,6 +1576,7 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 
 		regmap_write(aic31xx->regmap, AIC31XX_INT1CTRL,
 			     AIC31XX_HSPLUGDET |
+			     AIC31XX_BUTTONPRESSDET |
 			     AIC31XX_SC |
 			     AIC31XX_ENGINE);
 
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 9985ceed97ae..cb024955c978 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -21,7 +21,8 @@
 #define DAC31XX_BIT			BIT(3)
 
 #define AIC31XX_JACK_MASK (SND_JACK_HEADPHONE | \
-			   SND_JACK_HEADSET)
+			   SND_JACK_HEADSET | \
+			   SND_JACK_BTN_0)
 
 enum aic31xx_type {
 	AIC3100	= 0,
-- 
2.20.1
