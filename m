From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: add HW constraint for non
	RIGHT_J" to the asoc tree
Date: Fri, 12 Oct 2018 19:00:45 +0200 (CEST)
Message-ID: <20181012170045.88385440078@finisterre.ee.mobilebroadband>
References: <87pnwfbs5b.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 612C22679AF
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 19:00:46 +0200 (CEST)
In-Reply-To: <87pnwfbs5b.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: pcm3168a: add HW constraint for non RIGHT_J

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

>From 3809688980205622f75ed5d5890759430da4e7e4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Oct 2018 06:31:00 +0000
Subject: [PATCH] ASoC: pcm3168a: add HW constraint for non RIGHT_J

RIGHT_J only can handle 16bit data bits.
Current driver just errored if user requests non RIGHT_J
+ 16bit combination. But it is not useful for user.
This patch adds HW constraint for it, and avoid
error on such situation.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 3356c91f55b0..233a8df5d7a5 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -476,7 +476,43 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int pcm3168a_startup(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int fmt;
+	unsigned int sample_min;
+
+	if (tx)
+		fmt = pcm3168a->dac_fmt;
+	else
+		fmt = pcm3168a->adc_fmt;
+
+	/*
+	 * Available Data Bits
+	 *
+	 * RIGHT_J : 24 / 16
+	 * LEFT_J  : 24
+	 * I2S     : 24
+	 */
+	switch (fmt) {
+	case PCM3168A_FMT_RIGHT_J:
+		sample_min  = 16;
+		break;
+	default:
+		sample_min  = 24;
+	}
+
+	snd_pcm_hw_constraint_minmax(substream->runtime,
+				     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				     sample_min, 32);
+
+	return 0;
+}
 static const struct snd_soc_dai_ops pcm3168a_dac_dai_ops = {
+	.startup	= pcm3168a_startup,
 	.set_fmt	= pcm3168a_set_dai_fmt_dac,
 	.set_sysclk	= pcm3168a_set_dai_sysclk,
 	.hw_params	= pcm3168a_hw_params,
-- 
2.19.0
