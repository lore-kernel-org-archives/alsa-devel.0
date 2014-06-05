From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 2/5] ASoC: wm8904: switch to CCF
Date: Thu, 5 Jun 2014 18:19:29 +0800
Message-ID: <1401963572-10953-3-git-send-email-voice.shen@atmel.com>
References: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@kernel.org
Cc: boris.brezillon@free-electrons.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Enable WM8904 to support common clock framework.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 sound/soc/codecs/wm8904.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index f7c5499..af28cc6 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -49,6 +50,7 @@ static const char *wm8904_supply_names[WM8904_NUM_SUPPLIES] = {
 /* codec private data */
 struct wm8904_priv {
 	struct regmap *regmap;
+	struct clk *mclk;
 
 	enum wm8904_type devtype;
 
@@ -1828,6 +1830,8 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
+		if (wm8904->mclk)
+			clk_prepare_enable(wm8904->mclk);
 		break;
 
 	case SND_SOC_BIAS_PREPARE:
@@ -1894,6 +1898,8 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 
 		regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies),
 				       wm8904->supplies);
+		if (wm8904->mclk)
+			clk_disable_unprepare(wm8904->mclk);
 		break;
 	}
 	codec->dapm.bias_level = level;
@@ -2110,6 +2116,13 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 	if (wm8904 == NULL)
 		return -ENOMEM;
 
+	wm8904->mclk = devm_clk_get(&i2c->dev, "mclk");
+	if (IS_ERR(wm8904->mclk)) {
+		ret = PTR_ERR(wm8904->mclk);
+		dev_err(&i2c->dev, "Failed to get MCLK\n");
+		return ret;
+	}
+
 	wm8904->regmap = devm_regmap_init_i2c(i2c, &wm8904_regmap);
 	if (IS_ERR(wm8904->regmap)) {
 		ret = PTR_ERR(wm8904->regmap);
-- 
1.8.5.2
