From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] ASoC: RX-51: Add basic jack detection
Date: Mon, 21 Jun 2010 14:15:00 +0300
Message-ID: <1277118900-30100-2-git-send-email-jhnikula@gmail.com>
References: <1277118900-30100-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id ECCB510383E
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 13:22:14 +0200 (CEST)
Received: by wyb40 with SMTP id 40so2197817wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2010 04:22:14 -0700 (PDT)
In-Reply-To: <1277118900-30100-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch adds GPIO jack detection to Nokia N900/RX-51. At the moment only
SND_JACK_VIDEOOUT type is reported. More types could be reported after
getting more audio features supported and necessary drivers integrated for
implementing automated accessory detection.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/rx51.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 1a2de34..88052d2 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -27,6 +27,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
@@ -38,6 +39,7 @@
 #include "../codecs/tlv320aic3x.h"
 
 #define RX51_TVOUT_SEL_GPIO		40
+#define RX51_JACK_DETECT_GPIO		177
 /*
  * REVISIT: TWL4030 GPIO base in RX-51. Now statically defined to 192. This
  * gpio is reserved in arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -194,6 +196,18 @@ static int rx51_set_jack(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+static struct snd_soc_jack rx51_av_jack;
+
+static struct snd_soc_jack_gpio rx51_av_jack_gpios[] = {
+	{
+		.gpio = RX51_JACK_DETECT_GPIO,
+		.name = "avdet-gpio",
+		.report = SND_JACK_VIDEOOUT,
+		.invert = 1,
+		.debounce_time = 200,
+	},
+};
+
 static const struct snd_soc_dapm_widget aic34_dapm_widgets[] = {
 	SND_SOC_DAPM_SPK("Ext Spk", rx51_spk_event),
 	SND_SOC_DAPM_MIC("DMic", NULL),
@@ -228,6 +242,7 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
 
 static int rx51_aic34_init(struct snd_soc_codec *codec)
 {
+	struct snd_soc_card *card = codec->socdev->card;
 	int err;
 
 	/* Set up NC codec pins */
@@ -250,7 +265,16 @@ static int rx51_aic34_init(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_sync(codec);
 
-	return 0;
+	/* AV jack detection */
+	err = snd_soc_jack_new(card, "AV Jack",
+			       SND_JACK_VIDEOOUT, &rx51_av_jack);
+	if (err)
+		return err;
+	err = snd_soc_jack_add_gpios(&rx51_av_jack,
+				     ARRAY_SIZE(rx51_av_jack_gpios),
+				     rx51_av_jack_gpios);
+
+	return err;
 }
 
 /* Digital audio interface glue - connects codec <--> CPU */
@@ -326,6 +350,9 @@ err_gpio_tvout_sel:
 
 static void __exit rx51_soc_exit(void)
 {
+	snd_soc_jack_free_gpios(&rx51_av_jack, ARRAY_SIZE(rx51_av_jack_gpios),
+				rx51_av_jack_gpios);
+
 	platform_device_unregister(rx51_snd_device);
 	gpio_free(RX51_TVOUT_SEL_GPIO);
 }
-- 
1.7.1
