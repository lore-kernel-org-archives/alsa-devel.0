From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8741: Add digital mute callback" to
	the asoc tree
Date: Tue, 12 Feb 2019 14:21:55 +0000 (GMT)
Message-ID: <20190212142156.023B71128113@debutante.sirena.org.uk>
References: <1549812484-17449-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 04F0A2677EB
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 15:22:02 +0100 (CET)
In-Reply-To: <1549812484-17449-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, ce3a@gmx.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8741: Add digital mute callback

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

>From 36b1599340b5bbaf4d4f015cbfe89b7bc8cd7873 Mon Sep 17 00:00:00 2001
From: Sergej Sawazki <sergej@taudac.com>
Date: Sun, 10 Feb 2019 16:28:04 +0100
Subject: [PATCH] ASoC: wm8741: Add digital mute callback

Signed-off-by: Sergej Sawazki <sergej@taudac.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8741.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 1fedf74da705..fdda83b7ca82 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -358,6 +358,15 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+int wm8741_mute(struct snd_soc_dai *codec_dai, int mute)
+{
+	struct snd_soc_component *component = codec_dai->component;
+
+	snd_soc_component_update_bits(component, WM8741_VOLUME_CONTROL,
+			WM8741_SOFT_MASK, !!mute << WM8741_SOFT_SHIFT);
+	return 0;
+}
+
 #define WM8741_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
 			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
 			SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_176400 | \
@@ -371,6 +380,7 @@ static const struct snd_soc_dai_ops wm8741_dai_ops = {
 	.hw_params	= wm8741_hw_params,
 	.set_sysclk	= wm8741_set_dai_sysclk,
 	.set_fmt	= wm8741_set_dai_fmt,
+	.digital_mute   = wm8741_mute,
 };
 
 static struct snd_soc_dai_driver wm8741_dai = {
-- 
2.20.1
