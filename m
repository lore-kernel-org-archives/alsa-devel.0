From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98357a: Make 'sdmode-gpios' dts
	property optional" to the asoc tree
Date: Mon, 13 Jul 2015 19:14:22 +0100
Message-ID: <E1ZEiFC-000340-NO@debutante>
References: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C06D261B02
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 20:14:29 +0200 (CEST)
In-Reply-To: <1436714061-18618-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98357a: Make 'sdmode-gpios' dts property optional

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

>From 5119222f2e3de2e51a3b3270036d53c55ce68236 Mon Sep 17 00:00:00 2001
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Sun, 12 Jul 2015 08:14:19 -0700
Subject: [PATCH] ASoC: max98357a: Make 'sdmode-gpios' dts property optional

The option is not needed if chip is always on or managed by some other part
of system like platform card driver.

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/max98357a.txt | 6 +++++-
 sound/soc/codecs/max98357a.c                          | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max98357a.txt b/Documentation/devicetree/bindings/sound/max98357a.txt
index a7a149a236e5..28645a2ff885 100644
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
index 3a2fda08a893..fa1b79302bb3 100644
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
2.1.4
