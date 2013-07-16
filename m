From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: tlv320aic3x: Add compatible strings
	for specific devices
Date: Tue, 16 Jul 2013 13:42:09 +0100
Message-ID: <1373978530-23027-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CEC4226500A
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 14:42:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linaro-kernel@lists.linaro.org, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The driver supports a range of devices but currently doesn't allow those
device names to be used for enumeration on DT. Add the currently listed
I2C IDs as compatible strings.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 8 +++++++-
 sound/soc/codecs/tlv320aic3x.c                          | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index f47c3f5..26f65f9 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -3,7 +3,13 @@ Texas Instruments - tlv320aic3x Codec module
 The tlv320aic3x serial control bus communicates through I2C protocols
 
 Required properties:
-- compatible - "string" -  "ti,tlv320aic3x"
+
+- compatible - "string" - One of:
+    "ti,tlv320aic3x" - Generic TLV320AIC3x device
+    "ti,tlv320aic33" - TLV320AIC33
+    "ti,tlv320aic3007" - TLV320AIC3007
+
+
 - reg - <int> -  I2C slave address
 
 
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index e5b9268..c9bb760 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1582,6 +1582,8 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 #if defined(CONFIG_OF)
 static const struct of_device_id tlv320aic3x_of_match[] = {
 	{ .compatible = "ti,tlv320aic3x", },
+	{ .compatible = "ti,tlv320aic33" },
+	{ .compatible = "ti,tlv320aic3007" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tlv320aic3x_of_match);
-- 
1.8.3.2
