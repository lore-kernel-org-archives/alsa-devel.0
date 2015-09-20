From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Handle multiple codecs with split
	playback / capture" to the asoc tree
Date: Sat, 19 Sep 2015 17:13:02 -0700
Message-ID: <E1ZdSFa-0003yQ-1f@finisterre>
References: <alpine.DEB.2.02.1508191717300.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B0012605D8
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:28 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508191717300.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricardw@axis.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Handle multiple codecs with split playback / capture

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

>From cde79035c6cf578dd33dfea3e39666efc27cbcf2 Mon Sep 17 00:00:00 2001
From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Date: Mon, 24 Aug 2015 14:16:51 +0200
Subject: [PATCH] ASoC: Handle multiple codecs with split playback / capture

Add the capability to use multiple codecs on the same DAI linke where
one codec is used for playback and another one is used for capture.

Tested on a setup using an SSM2518 for playback and an ICS43432 I2S MEMS
microphone for capture.

No verification is made that the playback and capture codec setups are
compatible in terms of number of TDM slots (where applicable).

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 70e4b9d..3173958 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -34,6 +34,24 @@
 
 #define DPCM_MAX_BE_USERS	8
 
+/*
+ * snd_soc_dai_stream_valid() - check if a DAI supports the given stream
+ *
+ * Returns true if the DAI supports the indicated stream type.
+ */
+static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
+{
+	struct snd_soc_pcm_stream *codec_stream;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		codec_stream = &dai->driver->playback;
+	else
+		codec_stream = &dai->driver->capture;
+
+	/* If the codec specifies any rate at all, it supports the stream. */
+	return codec_stream->rates;
+}
+
 /**
  * snd_soc_runtime_activate() - Increment active count for PCM runtime components
  * @rtd: ASoC PCM runtime that is activated
@@ -371,6 +389,20 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 
 	/* first calculate min/max only for CODECs in the DAI link */
 	for (i = 0; i < rtd->num_codecs; i++) {
+
+		/*
+		 * Skip CODECs which don't support the current stream type.
+		 * Otherwise, since the rate, channel, and format values will
+		 * zero in that case, we would have no usable settings left,
+		 * causing the resulting setup to fail.
+		 * At least one CODEC should match, otherwise we should have
+		 * bailed out on a higher level, since there would be no
+		 * CODEC to support the transfer direction in that case.
+		 */
+		if (!snd_soc_dai_stream_valid(rtd->codec_dais[i],
+					      substream->stream))
+			continue;
+
 		codec_dai_drv = rtd->codec_dais[i]->driver;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			codec_stream = &codec_dai_drv->playback;
@@ -827,6 +859,23 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 		struct snd_pcm_hw_params codec_params;
 
+		/*
+		 * Skip CODECs which don't support the current stream type,
+		 * the idea being that if a CODEC is not used for the currently
+		 * set up transfer direction, it should not need to be
+		 * configured, especially since the configuration used might
+		 * not even be supported by that CODEC. There may be cases
+		 * however where a CODEC needs to be set up although it is
+		 * actually not being used for the transfer, e.g. if a
+		 * capture-only CODEC is acting as an LRCLK and/or BCLK master
+		 * for the DAI link including a playback-only CODEC.
+		 * If this becomes necessary, we will have to augment the
+		 * machine driver setup with information on how to act, so
+		 * we can do the right thing here.
+		 */
+		if (!snd_soc_dai_stream_valid(codec_dai, substream->stream))
+			continue;
+
 		/* copy params for each codec */
 		codec_params = *params;
 
-- 
2.5.0
