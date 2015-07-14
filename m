From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98925: Remove control_data
	initialization" to the asoc tree
Date: Tue, 14 Jul 2015 11:11:37 +0100
Message-ID: <E1ZExBZ-0004Qh-0D@debutante>
References: <1436809252-10112-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 63DF326060F
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 12:11:48 +0200 (CEST)
In-Reply-To: <1436809252-10112-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98925: Remove control_data initialization

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

>From f6d1a814844efc4b326538bd35a8daecd37921ed Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 13 Jul 2015 19:40:52 +0200
Subject: [PATCH] ASoC: max98925: Remove control_data initialization

The control_data field of the snd_soc_codec struct is no longer used by
ASoC drivers using standard regmap IO.

There is no need to initialize the field to point to the drivers regmap
struct, so drop that.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98925.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index aad664225dc3..eddf8bc07314 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -523,7 +523,6 @@ static int max98925_probe(struct snd_soc_codec *codec)
 	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
 
 	max98925->codec = codec;
-	codec->control_data = max98925->regmap;
 	regmap_write(max98925->regmap, MAX98925_GLOBAL_ENABLE, 0x00);
 	/* It's not the default but we need to set DAI_DLY */
 	regmap_write(max98925->regmap,
-- 
2.1.4
