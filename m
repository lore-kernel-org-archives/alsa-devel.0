From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: extend channel merging to the
	backend cpu dai" to the asoc tree
Date: Thu, 28 Jun 2018 11:20:33 +0100
Message-ID: <E1fYU2T-00047k-IT@debutante>
References: <20180627094818.5885-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C2CDD267A0A
 for <alsa-devel@alsa-project.org>; Thu, 28 Jun 2018 12:20:37 +0200 (CEST)
In-Reply-To: <20180627094818.5885-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: extend channel merging to the backend cpu dai

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

>From 4f2bd18b191a10660782f2f1ccc989b000b2be63 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 27 Jun 2018 11:48:18 +0200
Subject: [PATCH] ASoC: dpcm: extend channel merging to the backend cpu dai

Extend dpcm_merge_chan to also check backend cpu dai channels
capabilities. Apply the same policy as soc_pcm_init_runtime_hw() for
multicodec links and only check cpu dai in this case.

Cc: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 63f96cde046a..6ee4131941df 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1736,12 +1736,26 @@ static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
 
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
 		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai_driver *cpu_dai_drv =  be->cpu_dai->driver;
 		struct snd_soc_dai_driver *codec_dai_drv;
 		struct snd_soc_pcm_stream *codec_stream;
-		int i;
+		struct snd_soc_pcm_stream *cpu_stream;
+
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			cpu_stream = &cpu_dai_drv->playback;
+		else
+			cpu_stream = &cpu_dai_drv->capture;
+
+		*channels_min = max(*channels_min, cpu_stream->channels_min);
+		*channels_max = min(*channels_max, cpu_stream->channels_max);
+
+		/*
+		 * chan min/max cannot be enforced if there are multiple CODEC
+		 * DAIs connected to a single CPU DAI, use CPU DAI's directly
+		 */
+		if (be->num_codecs == 1) {
+			codec_dai_drv = be->codec_dais[0]->driver;
 
-		for (i = 0; i < be->num_codecs; i++) {
-			codec_dai_drv = be->codec_dais[i]->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
 			else
-- 
2.18.0.rc2
