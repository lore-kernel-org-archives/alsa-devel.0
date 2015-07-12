From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH 1/3] ASoC: max98357a: Make 'sdmode-gpios' dts
	property optional
Date: Sun, 12 Jul 2015 08:14:19 -0700
Message-ID: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id D91162605C7
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 17:14:35 +0200 (CEST)
Received: by pactm7 with SMTP id tm7so193143644pac.2
 for <alsa-devel@alsa-project.org>; Sun, 12 Jul 2015 08:14:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, lars@metafoo.de, kwestfie@codeaurora.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

The option is not needed if chip is always on or managed by some other part
of system like platform card driver.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/devicetree/bindings/sound/max98357a.txt | 6 +++++-
 sound/soc/codecs/max98357a.c                          | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max98357a.txt b/Documentation/devicetree/bindings/sound/max98357a.txt
index a7a149a..28645a2 100644
--- a/Documentation/devicetree/bindings/sound/max98357a.txt
+++ b/Documentation/devicetree/bindings/sound/max98357a.txt
@@ -4,7 +4,11 @@ This node models the Maxim MAX98357A DAC.
 
 Required properties:
 - compatible   : "maxim,max98357a"
-- sdmode-gpios : GPIO specifier for the GPIO -> DAC SDMODE pin
+
+Optional properties:
+- sdmode-gpios : GPIO specifier for the chip's SD_MODE pin.
+        If this option is not specified then driver does not manage
+        the pin state (e.g. chip is always on).
 
 Example:
 
diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 3a2fda0..fa1b793 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -31,6 +31,9 @@ static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
 {
 	struct gpio_desc *sdmode = snd_soc_dai_get_drvdata(dai);
 
+	if (!sdmode)
+		return 0;
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -60,7 +63,7 @@ static int max98357a_codec_probe(struct snd_soc_codec *codec)
 {
 	struct gpio_desc *sdmode;
 
-	sdmode = devm_gpiod_get(codec->dev, "sdmode", GPIOD_OUT_LOW);
+	sdmode = devm_gpiod_get_optional(codec->dev, "sdmode", GPIOD_OUT_LOW);
 	if (IS_ERR(sdmode)) {
 		dev_err(codec->dev, "%s() unable to get sdmode GPIO: %ld\n",
 				__func__, PTR_ERR(sdmode));
-- 
2.4.5
