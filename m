From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC:intel:skl:fix a simultaneous playback &
	capture issue on hda platform" to the asoc tree
Date: Mon, 11 Mar 2019 17:23:31 +0000 (GMT)
Message-ID: <20190311172331.587D01128896@debutante.sirena.org.uk>
References: <20190308083859.50026-4-rander.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBD1FF8971E
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2019 18:23:32 +0100 (CET)
In-Reply-To: <20190308083859.50026-4-rander.wang@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC:intel:skl:fix a simultaneous playback & capture issue on hda platform

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

>From c899df3e9b0bf7b76e642aed1a214582ea7012d5 Mon Sep 17 00:00:00 2001
From: Rander Wang <rander.wang@linux.intel.com>
Date: Fri, 8 Mar 2019 16:38:59 +0800
Subject: [PATCH] ASoC:intel:skl:fix a simultaneous playback & capture issue on
 hda platform

If playback and capture are enabled concurrently, when the capture stops
the output becomes inaudile. The playback application will become stuck
and underrun after a timeout.

This is caused by mistaken use of the stream_id, which should only be
set for playback and not for capture

Tested on Apollolake and Kabylake with SST driver.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index a4284778f117..bb463ee6ff84 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -181,6 +181,7 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 	struct hdac_stream *hstream;
 	struct hdac_ext_stream *stream;
 	struct hdac_ext_link *link;
+	unsigned char stream_tag;
 
 	hstream = snd_hdac_get_stream(bus, params->stream,
 					params->link_dma_id + 1);
@@ -199,10 +200,13 @@ int skl_pcm_link_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 
 	snd_hdac_ext_link_stream_setup(stream, format_val);
 
-	list_for_each_entry(link, &bus->hlink_list, list) {
-		if (link->index == params->link_index)
-			snd_hdac_ext_link_set_stream_id(link,
-					hstream->stream_tag);
+	stream_tag = hstream->stream_tag;
+	if (stream->hstream.direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		list_for_each_entry(link, &bus->hlink_list, list) {
+			if (link->index == params->link_index)
+				snd_hdac_ext_link_set_stream_id(link,
+								stream_tag);
+		}
 	}
 
 	stream->link_prepared = 1;
@@ -645,6 +649,7 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	struct hdac_ext_stream *link_dev =
 				snd_soc_dai_get_dma_data(dai, substream);
 	struct hdac_ext_link *link;
+	unsigned char stream_tag;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
 
@@ -654,7 +659,11 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	if (!link)
 		return -EINVAL;
 
-	snd_hdac_ext_link_clear_stream_id(link, hdac_stream(link_dev)->stream_tag);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		stream_tag = hdac_stream(link_dev)->stream_tag;
+		snd_hdac_ext_link_clear_stream_id(link, stream_tag);
+	}
+
 	snd_hdac_ext_stream_release(link_dev, HDAC_EXT_STREAM_TYPE_LINK);
 	return 0;
 }
-- 
2.20.1
