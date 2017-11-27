From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cx20442: don't use reg_cache" to the
	asoc tree
Date: Mon, 27 Nov 2017 18:51:48 +0000
Message-ID: <E1eJOVQ-0006nH-Mj@debutante>
References: <871snrm01j.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 317B8266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:51:52 +0100 (CET)
In-Reply-To: <871snrm01j.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cx20442: don't use reg_cache

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

>From 39b5a0f80c07f41440f38761e4b8d36bf2072007 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Nov 2017 01:04:42 +0000
Subject: [PATCH] ASoC: cx20442: don't use reg_cache

Codec reg_cache is legacy feature and very few driver only are using
it. But, ALSA SoC framework needs to support it.
Codec will be merged into Component in the future, so, let's remove
legacy and unused feature from framework.

cx20442 is using reg_cache but it is only 1byte, and it doesn't use
snd_soc_write/read/update_bits function which uses reg_cache.
reg_cache user is only debugfs. Let's clean reg_cache for now.
But let's keep .write function since it can be used for new additional
feature. .read will not be used, let's remove.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx20442.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 2083f7eb9de2..6b6f8e44369b 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -88,17 +88,6 @@ static const struct snd_soc_dapm_route cx20442_audio_map[] = {
 	{"ADC", NULL, "Input Mixer"},
 };
 
-static unsigned int cx20442_read_reg_cache(struct snd_soc_codec *codec,
-							unsigned int reg)
-{
-	u8 *reg_cache = codec->reg_cache;
-
-	if (reg >= codec->driver->reg_cache_size)
-		return -EINVAL;
-
-	return reg_cache[reg];
-}
-
 enum v253_vls {
 	V253_VLS_NONE = 0,
 	V253_VLS_T,
@@ -123,6 +112,8 @@ enum v253_vls {
 	V253_VLS_TEST,
 };
 
+#if 0
+/* FIXME : these function will be re-used */
 static int cx20442_pm_to_v253_vls(u8 value)
 {
 	switch (value & ~(1 << CX20442_AGC)) {
@@ -199,7 +190,7 @@ static int cx20442_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	return 0;
 }
-
+#endif
 
 /*
  * Line discpline related code
@@ -399,11 +390,7 @@ static const struct snd_soc_codec_driver cx20442_codec_dev = {
 	.probe = 	cx20442_codec_probe,
 	.remove = 	cx20442_codec_remove,
 	.set_bias_level = cx20442_set_bias_level,
-	.reg_cache_default = &cx20442_reg,
-	.reg_cache_size = 1,
-	.reg_word_size = sizeof(u8),
-	.read = cx20442_read_reg_cache,
-	.write = cx20442_write,
+
 	.component_driver = {
 		.dapm_widgets		= cx20442_dapm_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(cx20442_dapm_widgets),
-- 
2.15.0
