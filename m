From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cx20442: fix regression by adding back
	.read/.write" to the asoc tree
Date: Tue, 16 Jan 2018 13:56:08 +0000
Message-ID: <E1ebRii-00058Q-T4@debutante>
References: <87wp0i8syg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 008BF266E7C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 14:56:27 +0100 (CET)
In-Reply-To: <87wp0i8syg.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cx20442: fix regression by adding back .read/.write

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3c89724e994f4aee6ae2637ccd4e12aa4f92666c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Jan 2018 02:00:18 +0000
Subject: [PATCH] ASoC: cx20442: fix regression by adding back .read/.write

commit 39b5a0f80c07f ("ASoC: cx20442: don't use reg_cache")
removed .read/.write from driver, but it might breaks non-regmap
driver, because ALSA SoC framework might call it.

To fix this regression, this patch back .read/.write.
and also this patch uses cx20442 internal reg_cache
which is needed for .read/.write.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx20442.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 6b6f8e44369b..95bb10ba80dc 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -28,6 +28,7 @@
 struct cx20442_priv {
 	struct tty_struct *tty;
 	struct regulator *por;
+	u8 reg_cache;
 };
 
 #define CX20442_PM		0x0
@@ -88,6 +89,17 @@ static const struct snd_soc_dapm_route cx20442_audio_map[] = {
 	{"ADC", NULL, "Input Mixer"},
 };
 
+static unsigned int cx20442_read_reg_cache(struct snd_soc_codec *codec,
+					   unsigned int reg)
+{
+	struct cx20442_priv *cx20442 = snd_soc_codec_get_drvdata(codec);
+
+	if (reg >= 1)
+		return -EINVAL;
+
+	return cx20442->reg_cache;
+}
+
 enum v253_vls {
 	V253_VLS_NONE = 0,
 	V253_VLS_T,
@@ -112,8 +124,6 @@ enum v253_vls {
 	V253_VLS_TEST,
 };
 
-#if 0
-/* FIXME : these function will be re-used */
 static int cx20442_pm_to_v253_vls(u8 value)
 {
 	switch (value & ~(1 << CX20442_AGC)) {
@@ -147,11 +157,10 @@ static int cx20442_write(struct snd_soc_codec *codec, unsigned int reg,
 							unsigned int value)
 {
 	struct cx20442_priv *cx20442 = snd_soc_codec_get_drvdata(codec);
-	u8 *reg_cache = codec->reg_cache;
 	int vls, vsp, old, len;
 	char buf[18];
 
-	if (reg >= codec->driver->reg_cache_size)
+	if (reg >= 1)
 		return -EINVAL;
 
 	/* tty and write pointers required for talking to the modem
@@ -159,8 +168,8 @@ static int cx20442_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (!cx20442->tty || !cx20442->tty->ops->write)
 		return -EIO;
 
-	old = reg_cache[reg];
-	reg_cache[reg] = value;
+	old = cx20442->reg_cache;
+	cx20442->reg_cache = value;
 
 	vls = cx20442_pm_to_v253_vls(value);
 	if (vls < 0)
@@ -190,7 +199,6 @@ static int cx20442_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	return 0;
 }
-#endif
 
 /*
  * Line discpline related code
@@ -384,12 +392,12 @@ static int cx20442_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static const u8 cx20442_reg;
-
 static const struct snd_soc_codec_driver cx20442_codec_dev = {
 	.probe = 	cx20442_codec_probe,
 	.remove = 	cx20442_codec_remove,
 	.set_bias_level = cx20442_set_bias_level,
+	.read = cx20442_read_reg_cache,
+	.write = cx20442_write,
 
 	.component_driver = {
 		.dapm_widgets		= cx20442_dapm_widgets,
-- 
2.15.1
