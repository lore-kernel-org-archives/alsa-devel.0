From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove dai->driver NULL
	check" to the asoc tree
Date: Thu, 13 Sep 2018 12:39:23 +0100 (BST)
Message-ID: <20180913113923.395B41121CA5@debutante.sirena.org.uk>
References: <87wors4jf0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D346726788E
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 13:39:24 +0200 (CEST)
In-Reply-To: <87wors4jf0.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove dai->driver NULL check

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

>From a7c439d6128de2cbc087ae7524b47f613ff8bc6c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 11 Sep 2018 15:50:27 +0900
Subject: [PATCH] ASoC: soc-core: remove dai->driver NULL check

It is strange if it has "dai" but doesn't have "dai->driver".
And more over "dai->driver->xxx" is used everywhere without
"dai->driver" pointer NULL checking.
It got Oops already if "dai->driver" was NULL.
Let's remove un-needed "dai->driver" NULL check.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 807f112fad80..325dc1964850 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2519,8 +2519,6 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_bclk_ratio);
  */
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	if (dai->driver == NULL)
-		return -EINVAL;
 	if (dai->driver->ops->set_fmt == NULL)
 		return -ENOTSUPP;
 	return dai->driver->ops->set_fmt(dai, fmt);
@@ -2667,9 +2665,6 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tristate);
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 			     int direction)
 {
-	if (!dai->driver)
-		return -ENOTSUPP;
-
 	if (dai->driver->ops->mute_stream)
 		return dai->driver->ops->mute_stream(dai, mute, direction);
 	else if (direction == SNDRV_PCM_STREAM_PLAYBACK &&
-- 
2.19.0.rc2
