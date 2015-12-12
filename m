From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 12/13] ASoC: Intel: Skylake: Reconfigure
	Link stream on suspend/resume
Date: Sat, 12 Dec 2015 17:36:32 +0530
Message-ID: <1449921993-21101-13-git-send-email-vinod.koul@intel.com>
References: <1449921993-21101-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E10526586D
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 13:04:09 +0100 (CET)
In-Reply-To: <1449921993-21101-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

On suspend the link register are lost so we need to reconfigure
them in resume. This patch adds the reconfiguration of the link
register in trigger resume.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index f30ace6de035..6199a8c8f6df 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -496,11 +496,6 @@ static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct hdac_ext_link *link;
 
-	if (link_dev->link_prepared) {
-		dev_dbg(dai->dev, "already stream is prepared - returning\n");
-		return 0;
-	}
-
 	dma_params  = (struct skl_dma_params *)
 			snd_soc_dai_get_dma_data(codec_dai, substream);
 	if (dma_params)
@@ -508,14 +503,15 @@ static int skl_link_pcm_prepare(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d codec_dai_name=%s\n",
 			hdac_stream(link_dev)->stream_tag, format_val, codec_dai->name);
 
-	snd_hdac_ext_link_stream_reset(link_dev);
-
-	snd_hdac_ext_link_stream_setup(link_dev, format_val);
-
 	link = snd_hdac_ext_bus_get_link(ebus, rtd->codec->component.name);
 	if (!link)
 		return -EINVAL;
 
+	snd_hdac_ext_bus_link_power_up(link);
+	snd_hdac_ext_link_stream_reset(link_dev);
+
+	snd_hdac_ext_link_stream_setup(link_dev, format_val);
+
 	snd_hdac_ext_link_set_stream_id(link, hdac_stream(link_dev)->stream_tag);
 	link_dev->link_prepared = 1;
 
@@ -527,12 +523,16 @@ static int skl_link_pcm_trigger(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_stream *link_dev =
 				snd_soc_dai_get_dma_data(dai, substream);
+	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 
 	dev_dbg(dai->dev, "In %s cmd=%d\n", __func__, cmd);
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+		skl_link_pcm_prepare(substream, dai);
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-	case SNDRV_PCM_TRIGGER_RESUME:
+		snd_hdac_ext_stream_decouple(ebus, stream, true);
 		snd_hdac_ext_link_stream_start(link_dev);
 		break;
 
@@ -540,6 +540,8 @@ static int skl_link_pcm_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		snd_hdac_ext_link_stream_clear(link_dev);
+		if (cmd == SNDRV_PCM_TRIGGER_SUSPEND)
+			snd_hdac_ext_stream_decouple(ebus, stream, false);
 		break;
 
 	default:
-- 
1.9.1
