From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage of
	regulator framework to control avdd_dac
Date: Thu,  8 Oct 2009 14:58:56 +0300
Message-ID: <1255003137-1034-8-git-send-email-eduardo.valentin__20583.3963737406$1255003366$gmane$org@nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds initial usage of regulator framework to control avdd_dac
inside tlv320aic3x ASoC codec driver.

The  refcount to avdd_dac is increased / decreased
only during probe and remove. Here it is still needed to implement
proper enable/disable regulator depending on chip usage. Now if driver
can get regulator for avdd_dac, then it will just let it on on probe
and then leave it off on remove.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 3395cf9..82e0a64 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/regulator/consumer.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -56,6 +57,7 @@ struct aic3x_priv {
 	struct snd_soc_codec codec;
 	unsigned int sysclk;
 	int master;
+	struct regulator *regulator;
 };
 
 /*
@@ -1286,6 +1288,11 @@ static int aic3x_unregister(struct aic3x_priv *aic3x)
 	snd_soc_unregister_dai(&aic3x_dai);
 	snd_soc_unregister_codec(&aic3x->codec);
 
+	if (aic3x->regulator) {
+		regulator_disable(aic3x->regulator);
+		regulator_put(aic3x->regulator);
+	}
+
 	kfree(aic3x);
 	aic3x_codec = NULL;
 
@@ -1320,6 +1327,25 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	codec->control_data = i2c;
 	codec->hw_write = (hw_write_t) i2c_master_send;
 
+	aic3x->regulator = regulator_get(&i2c->dev, "avdd_dac");
+	if (IS_ERR(aic3x->regulator)) {
+		dev_warn(&i2c->dev, "No regulator to supply avdd_dac."
+					" Assuming always on.\n");
+		aic3x->regulator = NULL;
+	}
+
+	/*
+	 * REVISIT: Need to add proper code to put into sleep mode
+	 * avdd_dac regulator. For now, just leave it on.
+	 */
+	if (aic3x->regulator) {
+		int err;
+
+		err = regulator_enable(aic3x->regulator);
+		if (err < 0)
+			return err;
+	}
+
 	i2c_set_clientdata(i2c, aic3x);
 
 	return aic3x_register(codec);
-- 
1.6.4.183.g04423

