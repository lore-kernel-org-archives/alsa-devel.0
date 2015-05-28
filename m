From: Sergey Kiselev <skiselev@gmail.com>
Subject: ASoC: PATCH: wm8731 - reinitialize regmap cache after
	hardware reset
Date: Thu, 28 May 2015 09:34:09 -0700
Message-ID: <CA+abuVebbr9Cif_SfB+JcNhUOMV70fdWa-Q-nk+gFv9H5MRtgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 180D42604BD
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 18:34:10 +0200 (CEST)
Received: by igbsb11 with SMTP id sb11so43765578igb.0
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 09:34:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I am working on a machine driver that uses wm8731 codec and I've
noticed that it will not work after rmmod/modprobe of that machine
driver. The issue is that wm8731_probe() resets the hardware, but it
doesn't reinitialize the regmap cache to the default values.

The patch below fixes this issue.

I also skimmed through other codecs, and some of them might have
similar issue (wm8510.c, wm8711.c, wm8750.c, wm8753.c, wm8940.c,
wm8960.c, wm8971.c, wm8974.c, wm8988.c, wm8990.c)

Another way to avoid this issue might be resetting the codec in the
*_spi_probe()/*_i2c_probe(), so that it only gets reset once when
codec is loading.

Thanks in advance for any comments/suggestions on the patch.

Thanks,
Sergey

Signed-off-by: Sergey Kiselev <skiselev@gmail.com>

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 2245b6a..76af75b 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -84,7 +84,7 @@ static bool wm8731_writeable(struct device *dev,
unsigned int reg)
  return reg <= WM8731_RESET;
 }

-#define wm8731_reset(c) snd_soc_write(c, WM8731_RESET, 0)
+static int wm8731_reset(struct snd_soc_codec *codec);

 static const char *wm8731_input_select[] = {"Line In", "Mic"};

@@ -665,6 +665,21 @@ static const struct regmap_config wm8731_regmap = {
  .num_reg_defaults = ARRAY_SIZE(wm8731_reg_defaults),
 };

+static int wm8731_reset(struct snd_soc_codec *codec)
+{
+ int ret;
+ struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+
+ ret = snd_soc_write(codec, WM8731_RESET, 0);
+
+ if (ret != 0)
+ return ret;
+
+ regmap_reinit_cache(wm8731->regmap, &wm8731_regmap);
+
+ return 0;
+}
+
 #if defined(CONFIG_SPI_MASTER)
 static int wm8731_spi_probe(struct spi_device *spi)
 {
