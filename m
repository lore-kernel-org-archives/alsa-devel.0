From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 2/2] ASoC: cs4270: add power management
	support
Date: Wed, 6 May 2009 01:26:01 +0200
Message-ID: <20090505232601.GB28090@buzzloop.caiaq.de>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
	<1241515501-6600-2-git-send-email-daniel@caiaq.de>
	<4A005BA8.2070600@freescale.com>
	<20090505155116.GD24556@buzzloop.caiaq.de>
	<4A007D89.8020602@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 21A2124342
	for <alsa-devel@alsa-project.org>;
	Wed,  6 May 2009 01:26:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A007D89.8020602@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 05, 2009 at 12:55:21PM -0500, Timur Tabi wrote:
> You forgot to add "v2" to the subject line.  And you'll need a v3 on the
> next version of the patch, because ...

Ok, next round ...

Daniel

>From fff7cf8e74d1529060abe5207ad9b7d39c578026 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Thu, 2 Apr 2009 15:43:44 +0200
Subject: [PATCH v3] ASoC: cs4270: add power management support

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Timur Tabi <timur@freescale.com>
Cc: Mark Brown <broonie@sirena.org.uk>
---
 sound/soc/codecs/cs4270.c |   58 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index bc338df..4d4a45e 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -18,7 +18,7 @@
  * - The machine driver's 'startup' function must call
  *   cs4270_set_dai_sysclk() with the value of MCLK.
  * - Only I2S and left-justified modes are supported
- * - Power management is not supported
+ * - Power management is supported
  */
 
 #include <linux/module.h>
@@ -27,6 +27,7 @@
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <linux/i2c.h>
+#include <linux/delay.h>
 
 #include "cs4270.h"
 
@@ -65,6 +66,8 @@
 #define CS4270_PWRCTL_PDN_ADC	0x20
 #define CS4270_PWRCTL_PDN_DAC	0x02
 #define CS4270_PWRCTL_PDN	0x01
+#define CS4270_PWRCTL_PDN_ALL	\
+	(CS4270_PWRCTL_PDN_ADC | CS4270_PWRCTL_PDN_DAC | CS4270_PWRCTL_PDN)
 #define CS4270_MODE_SPEED_MASK	0x30
 #define CS4270_MODE_1X		0x00
 #define CS4270_MODE_2X		0x10
@@ -788,6 +791,57 @@ static struct i2c_device_id cs4270_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs4270_id);
 
+#ifdef CONFIG_PM
+
+/* This suspend/resume implementation can handle both - a simple standby
+ * where the codec remains powered, and a full suspend, where the voltage
+ * domain the codec is connected to is teared down and/or any other hardware
+ * reset condition is asserted.
+ *
+ * The codec's own power saving features are enabled in the suspend callback,
+ * and all registers are written back to the hardware when resuming.
+ */
+
+static int cs4270_i2c_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
+	struct snd_soc_codec *codec = &cs4270->codec;
+	int reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
+
+	return snd_soc_write(codec, CS4270_PWRCTL, reg);
+}
+
+static int cs4270_i2c_resume(struct i2c_client *client)
+{
+	struct cs4270_private *cs4270 = i2c_get_clientdata(client);
+	struct snd_soc_codec *codec = &cs4270->codec;
+	int reg;
+
+	/* In case the device was put to hard reset during sleep, we need to
+	 * wait 500ns here before any I2C communication. */
+	ndelay(500);
+
+	/* first restore the entire register cache ... */
+	for (reg = CS4270_FIRSTREG; reg <= CS4270_LASTREG; reg++) {
+		u8 val = snd_soc_read(codec, reg);
+
+		if (i2c_smbus_write_byte_data(client, reg, val)) {
+			dev_err(codec->dev, "i2c write failed\n");
+			return -EIO;
+		}
+	}
+
+	/* ... then disable the power-down bits */
+	reg = snd_soc_read(codec, CS4270_PWRCTL);
+	reg &= ~CS4270_PWRCTL_PDN_ALL;
+
+	return snd_soc_write(codec, CS4270_PWRCTL, reg);
+}
+#else
+#define cs4270_i2c_suspend	NULL
+#define cs4270_i2c_resume	NULL
+#endif /* CONFIG_PM */
+
 /*
  * cs4270_i2c_driver - I2C device identification
  *
@@ -802,6 +856,8 @@ static struct i2c_driver cs4270_i2c_driver = {
 	.id_table = cs4270_id,
 	.probe = cs4270_i2c_probe,
 	.remove = cs4270_i2c_remove,
+	.suspend = cs4270_i2c_suspend,
+	.resume = cs4270_i2c_resume,
 };
 
 /*
-- 
1.6.2.1
