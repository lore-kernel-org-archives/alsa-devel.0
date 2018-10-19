From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: add hw constraint for capture
	channel" to the asoc tree
Date: Fri, 19 Oct 2018 13:27:18 +0100 (BST)
Message-ID: <20181019122718.E94941122548@debutante.sirena.org.uk>
References: <87o9btz6oi.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9987E2679E4
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:27:19 +0200 (CEST)
In-Reply-To: <87o9btz6oi.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: pcm3168a: add hw constraint for capture channel

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

>From 4e9e07c5675706983ed649cfb92521a4d8aa1d6d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Oct 2018 01:54:33 +0000
Subject: [PATCH] ASoC: pcm3168a: add hw constraint for capture channel

LEFT_J / I2S only can use TDM.
commit 594680ea4a394 ("ASoC: pcm3168a: add hw constraint for channel")
commit 3809688980205 ("ASoC: pcm3168a: add HW constraint for non
RIGHT_J") added channel constraint for it, but, it was only for playback.
This patch adds constraint for capture.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 63aa02592bc0..52cc950c9fd1 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -529,11 +529,17 @@ static int pcm3168a_startup(struct snd_pcm_substream *substream,
 		break;
 	case PCM3168A_FMT_LEFT_J:
 		sample_min  = 24;
-		channel_max =  8;
+		if (tx)
+			channel_max = 8;
+		else
+			channel_max = 6;
 		break;
 	case PCM3168A_FMT_I2S:
 		sample_min  = 24;
-		channel_max =  8;
+		if (tx)
+			channel_max = 8;
+		else
+			channel_max = 6;
 		break;
 	default:
 		sample_min  = 24;
@@ -559,6 +565,7 @@ static const struct snd_soc_dai_ops pcm3168a_dac_dai_ops = {
 };
 
 static const struct snd_soc_dai_ops pcm3168a_adc_dai_ops = {
+	.startup	= pcm3168a_startup,
 	.set_fmt	= pcm3168a_set_dai_fmt_adc,
 	.set_sysclk	= pcm3168a_set_dai_sysclk,
 	.hw_params	= pcm3168a_hw_params
-- 
2.19.0.rc2
