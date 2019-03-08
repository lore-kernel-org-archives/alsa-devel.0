From: Rander Wang <rander.wang@linux.intel.com>
Subject: [PATCH 3/3] ASoC:intel:skl:fix a simultaneous playback
	& capture issue on hda platform
Date: Fri,  8 Mar 2019 16:38:59 +0800
Message-ID: <20190308083859.50026-4-rander.wang@linux.intel.com>
References: <20190308083859.50026-1-rander.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E66A1F896EF
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 09:37:45 +0100 (CET)
In-Reply-To: <20190308083859.50026-1-rander.wang@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

If playback and capture are enabled concurrently, when the capture stops
the output becomes inaudile. The playback application will become stuck
and underrun after a timeout.

This is caused by mistaken use of the stream_id, which should only be
set for playback and not for capture

Tested on Apollolake and Kabylake with SST driver.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
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
2.14.1
