From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cht_bsw_max98090_ti: Use card DAPM
	context to access widgets" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:35 +0100
Message-ID: <E1ZCTNP-0005RT-3U@finisterre>
References: <1436189891-15343-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BCBA2654B0
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:46 +0200 (CEST)
In-Reply-To: <1436189891-15343-4-git-send-email-lars@metafoo.de>
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

   ASoC: cht_bsw_max98090_ti: Use card DAPM context to access widgets

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

>From c68c2be5f6ae4a27d548921bf8b32413c5eab8ed Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 6 Jul 2015 15:38:09 +0200
Subject: [PATCH] ASoC: cht_bsw_max98090_ti: Use card DAPM context to access
 widgets

The dapm field of the snd_soc_codec struct will eventually be removed
(replaced with the DAPM context from the component embedded inside the
CODEC). Replace its usage with the card's DAPM context. The idea is that
DAPM is hierarchical and with the card at the root it is possible to access
widgets from other contexts through the card context.

While we are at it also remove some extra newlines.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index d604ee8..afcd6ba 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -104,21 +104,17 @@ static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
 static int cht_ti_jack_event(struct notifier_block *nb,
 		unsigned long event, void *data)
 {
-
 	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
-	struct snd_soc_dai *codec_dai = jack->card->rtd->codec_dai;
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_dapm_context *dapm = &jack->card->dapm;
 
 	if (event & SND_JACK_MICROPHONE) {
-
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "SHDN");
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "MICBIAS");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_force_enable_pin(dapm, "SHDN");
+		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS");
+		snd_soc_dapm_sync(dapm);
 	} else {
-
-		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS");
-		snd_soc_dapm_disable_pin(&codec->dapm, "SHDN");
-		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_dapm_disable_pin(dapm, "MICBIAS");
+		snd_soc_dapm_disable_pin(dapm, "SHDN");
+		snd_soc_dapm_sync(dapm);
 	}
 
 	return 0;
-- 
2.1.4
