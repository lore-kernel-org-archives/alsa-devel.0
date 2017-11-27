From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use snd_soc_write/read on
	twl4030" to the asoc tree
Date: Mon, 27 Nov 2017 18:51:42 +0000
Message-ID: <E1eJOVK-0006lV-2b@debutante>
References: <87y3pzklfl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A1EF266DCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:51:47 +0100 (CET)
In-Reply-To: <87y3pzklfl.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: don't use snd_soc_write/read on twl4030

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

>From 3bb0f7c31b1aedd0f85c675297031281799145d7 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Nov 2017 01:05:17 +0000
Subject: [PATCH] ASoC: don't use snd_soc_write/read on twl4030

twl4030 doesn't use regmap nor reg_cache. Its write/read are done
through twl4030_reg_write/read. This driver directly calling these
functions, but sometimes using snd_soc_write/read.
As part of cleanup, snd_soc_codec_driver::write, read will be
removed soon. Then, write/read access through snd_soc_write/read
will doesn't work on this driver, since it doesn't use regmap nor
reg_cache.
This patch replace snd_soc_write/read to twl4030_write/read.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl4030.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 90691701b082..8798182959c1 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -850,14 +850,14 @@ static int snd_soc_get_volsw_twl4030(struct snd_kcontrol *kcontrol,
 	int mask = (1 << fls(max)) - 1;
 
 	ucontrol->value.integer.value[0] =
-		(snd_soc_read(codec, reg) >> shift) & mask;
+		(twl4030_read(codec, reg) >> shift) & mask;
 	if (ucontrol->value.integer.value[0])
 		ucontrol->value.integer.value[0] =
 			max + 1 - ucontrol->value.integer.value[0];
 
 	if (shift != rshift) {
 		ucontrol->value.integer.value[1] =
-			(snd_soc_read(codec, reg) >> rshift) & mask;
+			(twl4030_read(codec, reg) >> rshift) & mask;
 		if (ucontrol->value.integer.value[1])
 			ucontrol->value.integer.value[1] =
 				max + 1 - ucontrol->value.integer.value[1];
@@ -908,9 +908,9 @@ static int snd_soc_get_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
 	int mask = (1<<fls(max))-1;
 
 	ucontrol->value.integer.value[0] =
-		(snd_soc_read(codec, reg) >> shift) & mask;
+		(twl4030_read(codec, reg) >> shift) & mask;
 	ucontrol->value.integer.value[1] =
-		(snd_soc_read(codec, reg2) >> shift) & mask;
+		(twl4030_read(codec, reg2) >> shift) & mask;
 
 	if (ucontrol->value.integer.value[0])
 		ucontrol->value.integer.value[0] =
@@ -2195,8 +2195,6 @@ static int twl4030_soc_remove(struct snd_soc_codec *codec)
 static const struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.probe = twl4030_soc_probe,
 	.remove = twl4030_soc_remove,
-	.read = twl4030_read,
-	.write = twl4030_write,
 	.set_bias_level = twl4030_set_bias_level,
 	.idle_bias_off = true,
 
-- 
2.15.0
