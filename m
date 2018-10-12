From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: add hw constraint for
	channel" to the asoc tree
Date: Fri, 12 Oct 2018 19:00:35 +0200 (CEST)
Message-ID: <20181012170035.184CD440078@finisterre.ee.mobilebroadband>
References: <87o9bzbs4t.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CDDA2267845
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 19:00:35 +0200 (CEST)
In-Reply-To: <87o9bzbs4t.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: pcm3168a: add hw constraint for channel

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

>From 594680ea4a394f19d38a39a7d7c673fbad02a3d6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Oct 2018 06:31:18 +0000
Subject: [PATCH] ASoC: pcm3168a: add hw constraint for channel

LEFT_J / I2S only can use TDM.
This patch adds channel constraint for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 233a8df5d7a5..f0e2b886323e 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -484,6 +484,7 @@ static int pcm3168a_startup(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int fmt;
 	unsigned int sample_min;
+	unsigned int channel_max;
 
 	if (tx)
 		fmt = pcm3168a->dac_fmt;
@@ -496,19 +497,38 @@ static int pcm3168a_startup(struct snd_pcm_substream *substream,
 	 * RIGHT_J : 24 / 16
 	 * LEFT_J  : 24
 	 * I2S     : 24
+	 *
+	 * TDM available
+	 *
+	 * I2S
+	 * LEFT_J
 	 */
 	switch (fmt) {
 	case PCM3168A_FMT_RIGHT_J:
 		sample_min  = 16;
+		channel_max =  2;
+		break;
+	case PCM3168A_FMT_LEFT_J:
+		sample_min  = 24;
+		channel_max =  8;
+		break;
+	case PCM3168A_FMT_I2S:
+		sample_min  = 24;
+		channel_max =  8;
 		break;
 	default:
 		sample_min  = 24;
+		channel_max =  2;
 	}
 
 	snd_pcm_hw_constraint_minmax(substream->runtime,
 				     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				     sample_min, 32);
 
+	snd_pcm_hw_constraint_minmax(substream->runtime,
+				     SNDRV_PCM_HW_PARAM_CHANNELS,
+				     2, channel_max);
+
 	return 0;
 }
 static const struct snd_soc_dai_ops pcm3168a_dac_dai_ops = {
-- 
2.19.0
