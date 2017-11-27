From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use snd_soc_write/read on
	twl6040" to the asoc tree
Date: Mon, 27 Nov 2017 18:51:45 +0000
Message-ID: <E1eJOVN-0006mS-MY@debutante>
References: <87ziafklgc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BC12267544
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:51:48 +0100 (CET)
In-Reply-To: <87ziafklgc.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: don't use snd_soc_write/read on twl6040

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

>From 93a00c467fe998bf5716cbc9cabc127046054782 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Nov 2017 01:04:58 +0000
Subject: [PATCH] ASoC: don't use snd_soc_write/read on twl6040

twl6040 doesn't use regmap nor reg_cache. Its write/read are done
through twl6040_reg_write/read. This driver directly calling these
functions, but sometimes using snd_soc_write/read.
As part of cleanup, snd_soc_codec_driver::write, read will be
removed soon. Then, write/read access through snd_soc_write/read
will doesn't work on this driver, since it doesn't use regmap nor
reg_cache.
This patch replace snd_soc_write/read to twl6040_write/read.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl6040.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index a8e6941a1868..3b895b4b451c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -543,7 +543,7 @@ int twl6040_get_dl1_gain(struct snd_soc_codec *codec)
 	if (snd_soc_dapm_get_pin_status(dapm, "HSOR") ||
 		snd_soc_dapm_get_pin_status(dapm, "HSOL")) {
 
-		u8 val = snd_soc_read(codec, TWL6040_REG_HSLCTL);
+		u8 val = twl6040_read(codec, TWL6040_REG_HSLCTL);
 		if (val & TWL6040_HSDACMODE)
 			/* HSDACL in LP mode */
 			return -8; /* -8dB */
@@ -1158,8 +1158,6 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 static const struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 	.probe = twl6040_probe,
 	.remove = twl6040_remove,
-	.read = twl6040_read,
-	.write = twl6040_write,
 	.set_bias_level = twl6040_set_bias_level,
 	.suspend_bias_off = true,
 	.ignore_pmdown_time = true,
-- 
2.15.0
