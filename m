From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v7 7/9] ASoC: Intel: Skylake: Fix possible
	memory corruption in codec dai dma params
Date: Wed, 17 Feb 2016 21:34:05 +0530
Message-ID: <1455725047-7303-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E22226067A
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 17:03:50 +0100 (CET)
In-Reply-To: <1455725047-7303-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Set required parameters for hdac_ext_dma_params object instead of
skl_dma_params.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 092450a..bbb6c28 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -475,7 +475,7 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *link_dev;
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	struct skl_dma_params *dma_params;
+	struct hdac_ext_dma_params *dma_params;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct skl_pipe_params p_params = {0};
 
@@ -487,11 +487,9 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_dai_set_dma_data(dai, substream, (void *)link_dev);
 
 	/* set the stream tag in the codec dai dma params  */
-	dma_params = (struct skl_dma_params *)
-			snd_soc_dai_get_dma_data(codec_dai, substream);
+	dma_params = snd_soc_dai_get_dma_data(codec_dai, substream);
 	if (dma_params)
 		dma_params->stream_tag =  hdac_stream(link_dev)->stream_tag;
-	snd_soc_dai_set_dma_data(codec_dai, substream, (void *)dma_params);
 
 	p_params.s_fmt = snd_pcm_format_width(params_format(params));
 	p_params.ch = params_channels(params);
-- 
1.9.1
