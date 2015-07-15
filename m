From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sirf-audio-codec: Staticise local
	symbols" to the asoc tree
Date: Wed, 15 Jul 2015 12:55:40 +0100
Message-ID: <E1ZFLHo-0006ci-2D@debutante>
References: <1436939449.24267.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 117BB2658A6
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:55:49 +0200 (CEST)
In-Reply-To: <1436939449.24267.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sirf-audio-codec: Staticise local symbols

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

>From 8e2175d42e435b7957bfaa921fc27cb40e923372 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 15 Jul 2015 13:50:49 +0800
Subject: [PATCH] ASoC: sirf-audio-codec: Staticise local symbols

Also make sirf_audio_codec_dai_ops const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sirf-audio-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 29cb44256044..6bfd25c289d1 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -370,11 +370,11 @@ static int sirf_audio_codec_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-struct snd_soc_dai_ops sirf_audio_codec_dai_ops = {
+static const struct snd_soc_dai_ops sirf_audio_codec_dai_ops = {
 	.trigger = sirf_audio_codec_trigger,
 };
 
-struct snd_soc_dai_driver sirf_audio_codec_dai = {
+static struct snd_soc_dai_driver sirf_audio_codec_dai = {
 	.name = "sirf-audio-codec",
 	.playback = {
 		.stream_name = "Playback",
-- 
2.1.4
