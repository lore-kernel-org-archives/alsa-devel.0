From: jeeja.kp@intel.com
Subject: [PATCH v3 04/13] ASoC: Intel: Skylake: Removed unused
	skl_get_format()
Date: Thu,  8 Dec 2016 13:41:15 +0530
Message-ID: <1481184684-9620-5-git-send-email-jeeja.kp@intel.com>
References: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E71ED2667B2
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 09:01:25 +0100 (CET)
In-Reply-To: <1481184684-9620-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Removed the unused function skl_get_format as the format is calculated
directly using the HDA core API.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 1abff8e..10fa10d 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -259,32 +259,6 @@ static int skl_pcm_open(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int skl_get_format(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	struct skl_dma_params *dma_params;
-	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
-	int format_val = 0;
-
-	if ((ebus_to_hbus(ebus))->ppcap) {
-		struct snd_pcm_runtime *runtime = substream->runtime;
-
-		format_val = snd_hdac_calc_stream_format(runtime->rate,
-						runtime->channels,
-						runtime->format,
-						32, 0);
-	} else {
-		struct snd_soc_dai *codec_dai = rtd->codec_dai;
-
-		dma_params = snd_soc_dai_get_dma_data(codec_dai, substream);
-		if (dma_params)
-			format_val = dma_params->format;
-	}
-
-	return format_val;
-}
-
 static int skl_be_prepare(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-- 
2.5.0
