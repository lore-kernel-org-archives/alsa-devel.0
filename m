From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda: fix stream id setting"
	to the asoc tree
Date: Tue, 23 Jul 2019 12:29:11 +0100 (BST)
Message-ID: <20190723112911.223AB2742BAB@ypsilon.sirena.org.uk>
References: <20190722141402.7194-20-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2A181F800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:12 +0200 (CEST)
In-Reply-To: <20190722141402.7194-20-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Rander Wang <rander.wang@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda: fix stream id setting

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 810dbea3656912d6ad8db691a9a4b2ad97d4b736 Mon Sep 17 00:00:00 2001
From: Rander Wang <rander.wang@linux.intel.com>
Date: Mon, 22 Jul 2019 09:14:00 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda: fix stream id setting

snd_hdac_ext_link_clear_stream_id maps stream id to
link output, which is for playback, not capture.

Tested on Whiskey Lake platform.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190722141402.7194-20-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-dai.c | 15 +++++++++++----
 sound/soc/sof/intel/hda-dsp.c |  8 +++++++-
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 2b5e2b8c69c2..8796f385be76 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -327,8 +327,12 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 					  DMA_CHAN_INVALID, substream->stream);
 		if (ret < 0)
 			return ret;
-		stream_tag = hdac_stream(link_dev)->stream_tag;
-		snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			stream_tag = hdac_stream(link_dev)->stream_tag;
+			snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+		}
+
 		link_dev->link_prepared = 0;
 
 		/* fallthrough */
@@ -369,8 +373,11 @@ static int hda_link_hw_free(struct snd_pcm_substream *substream,
 	if (!link)
 		return -EINVAL;
 
-	stream_tag = hdac_stream(link_dev)->stream_tag;
-	snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		stream_tag = hdac_stream(link_dev)->stream_tag;
+		snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+	}
+
 	snd_soc_dai_set_dma_data(dai, substream, NULL);
 	snd_hdac_ext_stream_release(link_dev, HDAC_EXT_STREAM_TYPE_LINK);
 	link_dev->link_prepared = 0;
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index e38008194574..fb55a3c5afd0 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -450,9 +450,15 @@ int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev)
 			link = snd_hdac_ext_bus_get_link(bus, name);
 			if (!link)
 				return -EINVAL;
+
+			stream->link_prepared = 0;
+
+			if (hdac_stream(stream)->direction ==
+				SNDRV_PCM_STREAM_CAPTURE)
+				continue;
+
 			stream_tag = hdac_stream(stream)->stream_tag;
 			snd_hdac_ext_link_clear_stream_id(link, stream_tag);
-			stream->link_prepared = 0;
 		}
 	}
 #endif
-- 
2.20.1
