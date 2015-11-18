From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ac97: add gpio chip" to the asoc tree
Date: Wed, 18 Nov 2015 18:09:31 +0000
Message-ID: <E1Zz7Ah-0000DW-Tv@debutante>
References: <1447243971-11715-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66E28265AEC
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:43 +0100 (CET)
In-Reply-To: <1447243971-11715-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ac97: add gpio chip

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

>From 9bf5c3d11f1fbaf43399d189f05fb20ceb46ee5d Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Wed, 11 Nov 2015 13:12:51 +0100
Subject: [PATCH] ASoC: ac97: add gpio chip

The AC97 specification provides a guide for 16 GPIOs in the codecs. If
the gpiolib is compiled in the kernel, declare a gpio chip.

This was tested with a pxa27x board (mioa701) and a wm9713 codec.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/ac97_codec.h |   3 ++
 sound/soc/soc-ac97.c       | 125 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 74bc85473b58..15aa5f07c955 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -417,11 +417,13 @@
 #define AC97_RATES_MIC_ADC	4
 #define AC97_RATES_SPDIF	5
 
+#define AC97_NUM_GPIOS		16
 /*
  *
  */
 
 struct snd_ac97;
+struct snd_ac97_gpio_priv;
 struct snd_pcm_chmap;
 
 struct snd_ac97_build_ops {
@@ -529,6 +531,7 @@ struct snd_ac97 {
 	struct delayed_work power_work;
 #endif
 	struct device dev;
+	struct snd_ac97_gpio_priv *gpio_priv;
 
 	struct snd_pcm_chmap *chmaps[2]; /* channel-maps (optional) */
 };
diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index d40efc9fe0a9..ae563e379a72 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/of_gpio.h>
 #include <linux/of.h>
@@ -38,6 +39,14 @@ struct snd_ac97_reset_cfg {
 	int gpio_reset;
 };
 
+struct snd_ac97_gpio_priv {
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio_chip;
+#endif
+	unsigned int gpios_set;
+	struct snd_soc_codec *codec;
+};
+
 static struct snd_ac97_bus soc_ac97_bus = {
 	.ops = NULL, /* Gets initialized in snd_soc_set_ac97_ops() */
 };
@@ -47,6 +56,117 @@ static void soc_ac97_device_release(struct device *dev)
 	kfree(to_ac97_t(dev));
 }
 
+#ifdef CONFIG_GPIOLIB
+static inline struct snd_soc_codec *gpio_to_codec(struct gpio_chip *chip)
+{
+	struct snd_ac97_gpio_priv *gpio_priv =
+		container_of(chip, struct snd_ac97_gpio_priv, gpio_chip);
+
+	return gpio_priv->codec;
+}
+
+static int snd_soc_ac97_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	if (offset >= AC97_NUM_GPIOS)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int snd_soc_ac97_gpio_direction_in(struct gpio_chip *chip,
+					  unsigned offset)
+{
+	struct snd_soc_codec *codec = gpio_to_codec(chip);
+
+	dev_dbg(codec->dev, "set gpio %d to output\n", offset);
+	return snd_soc_update_bits(codec, AC97_GPIO_CFG,
+				   1 << offset, 1 << offset);
+}
+
+static int snd_soc_ac97_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct snd_soc_codec *codec = gpio_to_codec(chip);
+	int ret;
+
+	ret = snd_soc_read(codec, AC97_GPIO_STATUS);
+	dev_dbg(codec->dev, "get gpio %d : %d\n", offset,
+		ret < 0 ? ret : ret & (1 << offset));
+
+	return ret < 0 ? ret : ret & (1 << offset);
+}
+
+static void snd_soc_ac97_gpio_set(struct gpio_chip *chip, unsigned offset,
+				  int value)
+{
+	struct snd_ac97_gpio_priv *gpio_priv =
+		container_of(chip, struct snd_ac97_gpio_priv, gpio_chip);
+	struct snd_soc_codec *codec = gpio_to_codec(chip);
+
+	gpio_priv->gpios_set &= ~(1 << offset);
+	gpio_priv->gpios_set |= (!!value) << offset;
+	snd_soc_write(codec, AC97_GPIO_STATUS, gpio_priv->gpios_set);
+	dev_dbg(codec->dev, "set gpio %d to %d\n", offset, !!value);
+}
+
+static int snd_soc_ac97_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned offset, int value)
+{
+	struct snd_soc_codec *codec = gpio_to_codec(chip);
+
+	dev_dbg(codec->dev, "set gpio %d to output\n", offset);
+	snd_soc_ac97_gpio_set(chip, offset, value);
+	return snd_soc_update_bits(codec, AC97_GPIO_CFG, 1 << offset, 0);
+}
+
+static struct gpio_chip snd_soc_ac97_gpio_chip = {
+	.label			= "snd_soc_ac97",
+	.owner			= THIS_MODULE,
+	.request		= snd_soc_ac97_gpio_request,
+	.direction_input	= snd_soc_ac97_gpio_direction_in,
+	.get			= snd_soc_ac97_gpio_get,
+	.direction_output	= snd_soc_ac97_gpio_direction_out,
+	.set			= snd_soc_ac97_gpio_set,
+	.can_sleep		= 1,
+};
+
+static int snd_soc_ac97_init_gpio(struct snd_ac97 *ac97,
+				  struct snd_soc_codec *codec)
+{
+	struct snd_ac97_gpio_priv *gpio_priv;
+	int ret;
+
+	gpio_priv = devm_kzalloc(codec->dev, sizeof(*gpio_priv), GFP_KERNEL);
+	if (!gpio_priv)
+		return -ENOMEM;
+	ac97->gpio_priv = gpio_priv;
+	gpio_priv->codec = codec;
+	gpio_priv->gpio_chip = snd_soc_ac97_gpio_chip;
+	gpio_priv->gpio_chip.ngpio = AC97_NUM_GPIOS;
+	gpio_priv->gpio_chip.dev = codec->dev;
+	gpio_priv->gpio_chip.base = -1;
+
+	ret = gpiochip_add(&gpio_priv->gpio_chip);
+	if (ret != 0)
+		dev_err(codec->dev, "Failed to add GPIOs: %d\n", ret);
+	return ret;
+}
+
+static void snd_soc_ac97_free_gpio(struct snd_ac97 *ac97)
+{
+	gpiochip_remove(&ac97->gpio_priv->gpio_chip);
+}
+#else
+static int snd_soc_ac97_init_gpio(struct snd_ac97 *ac97,
+				  struct snd_soc_codec *codec)
+{
+	return 0;
+}
+
+static void snd_soc_ac97_free_gpio(struct snd_ac97 *ac97)
+{
+}
+#endif
+
 /**
  * snd_soc_alloc_ac97_codec() - Allocate new a AC'97 device
  * @codec: The CODEC for which to create the AC'97 device
@@ -119,6 +239,10 @@ struct snd_ac97 *snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	if (ret)
 		goto err_put_device;
 
+	ret = snd_soc_ac97_init_gpio(ac97, codec);
+	if (ret)
+		goto err_put_device;
+
 	return ac97;
 
 err_put_device:
@@ -135,6 +259,7 @@ EXPORT_SYMBOL_GPL(snd_soc_new_ac97_codec);
  */
 void snd_soc_free_ac97_codec(struct snd_ac97 *ac97)
 {
+	snd_soc_ac97_free_gpio(ac97);
 	device_del(&ac97->dev);
 	ac97->bus = NULL;
 	put_device(&ac97->dev);
-- 
2.6.2
