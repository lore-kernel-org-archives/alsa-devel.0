From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-pcm: DPCM cares BE channel
	constraint" to the asoc tree
Date: Fri, 22 Jun 2018 15:57:17 +0100
Message-ID: <E1fWNUz-0003N1-F3@debutante>
References: <20180620092520.14101-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 19B192676DD
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 16:57:27 +0200 (CEST)
In-Reply-To: <20180620092520.14101-1-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, jiada_wang@mentor.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-pcm: DPCM cares BE channel constraint

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

>From f4c277b817cc9489fffabffb4e15d2f3b686056c Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Wed, 20 Jun 2018 18:25:20 +0900
Subject: [PATCH] ASoC: soc-pcm: DPCM cares BE channel constraint

Current DPCM is caring only FE channel configuration. Sometimes
it will be trouble if user selects channel which isn't supported
by BE.

This patch adds new .dpcm_merged_chan on struct snd_soc_dai_link.
DPCM will use FE / BE merged channel if struct snd_soc_dai_link
has it.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h |  2 ++
 sound/soc/soc-pcm.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1378dcd2128a..f7579f82cc00 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -957,6 +957,8 @@ struct snd_soc_dai_link {
 
 	/* DPCM used FE & BE merged format */
 	unsigned int dpcm_merged_format:1;
+	/* DPCM used FE & BE merged channel */
+	unsigned int dpcm_merged_chan:1;
 
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 45b52f7b9690..19ebfc958b9d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1715,6 +1715,46 @@ static u64 dpcm_runtime_base_format(struct snd_pcm_substream *substream)
 	return formats;
 }
 
+static void dpcm_runtime_base_chan(struct snd_pcm_substream *substream,
+				   unsigned int *channels_min,
+				   unsigned int *channels_max)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	struct snd_soc_dpcm *dpcm;
+	int stream = substream->stream;
+
+	if (!fe->dai_link->dpcm_merged_chan)
+		return;
+
+	*channels_min = 0;
+	*channels_max = UINT_MAX;
+
+	/*
+	 * It returns merged BE codec channel;
+	 * if FE want to use it (= dpcm_merged_chan)
+	 */
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai_driver *codec_dai_drv;
+		struct snd_soc_pcm_stream *codec_stream;
+		int i;
+
+		for (i = 0; i < be->num_codecs; i++) {
+			codec_dai_drv = be->codec_dais[i]->driver;
+			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+				codec_stream = &codec_dai_drv->playback;
+			else
+				codec_stream = &codec_dai_drv->capture;
+
+			*channels_min = max(*channels_min,
+					    codec_stream->channels_min);
+			*channels_max = min(*channels_max,
+					    codec_stream->channels_max);
+		}
+	}
+}
+
 static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1722,11 +1762,17 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
 	u64 format = dpcm_runtime_base_format(substream);
+	unsigned int channels_min = 0, channels_max = UINT_MAX;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback, format);
 	else
 		dpcm_init_runtime_hw(runtime, &cpu_dai_drv->capture, format);
+
+	dpcm_runtime_base_chan(substream, &channels_min, &channels_max);
+
+	runtime->hw.channels_min = max(channels_min, runtime->hw.channels_min);
+	runtime->hw.channels_max = min(channels_max, runtime->hw.channels_max);
 }
 
 static int dpcm_fe_dai_do_trigger(struct snd_pcm_substream *substream, int cmd);
-- 
2.18.0.rc2
