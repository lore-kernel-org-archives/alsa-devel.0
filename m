From: Bogdan Togorean <bogdan.togorean@gmail.com>
Subject: [PATCH 2/2] ASoC: adau1977: Add support for setting MICBIAS via DT
Date: Tue, 19 Feb 2019 16:11:39 +0200
Message-ID: <20190219141139.24216-3-bogdan.togorean@gmail.com>
References: <20190219141139.24216-1-bogdan.togorean@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219141139.24216-1-bogdan.togorean@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, tiwai@suse.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bogdan Togorean <bogdan.togorean@gmail.com>
List-Id: alsa-devel@alsa-project.org

If platform_data is NULL add reading of optional adi,micbias
property from DT. If adi,micbias is not set keep the default
value for micbias.

Signed-off-by: Bogdan Togorean <bogdan.togorean@gmail.com>
---
 sound/soc/codecs/adau1977.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 116af6a9ce3b..11c53bcb71dd 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -885,13 +885,15 @@ static int adau1977_setup_micbias(struct adau1977 *adau1977)
 	struct adau1977_platform_data *pdata = adau1977->dev->platform_data;
 	unsigned int micbias;
 
-	if (pdata) {
+	if (pdata)
 		micbias = pdata->micbias;
-		if (micbias > ADAU1977_MICBIAS_9V0)
-			return -EINVAL;
-
-	} else {
+	else if (device_property_read_u32(adau1977->dev, "adi,micbias",
+					  &micbias))
 		micbias = ADAU1977_MICBIAS_8V5;
+
+	if (micbias > ADAU1977_MICBIAS_9V0) {
+		dev_err(adau1977->dev, "Invalid value for 'adi,micbias'\n");
+		return -EINVAL;
 	}
 
 	return regmap_update_bits(adau1977->regmap, ADAU1977_REG_MICBIAS,
-- 
2.20.1
