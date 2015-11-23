From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/7] ASoC: Intel: Skylake: Reconfigure HDA
	stream register in prepare/resume
Date: Mon, 23 Nov 2015 22:26:24 +0530
Message-ID: <1448297789-6524-3-git-send-email-vinod.koul@intel.com>
References: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BBC42654BD
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 17:52:53 +0100 (CET)
In-Reply-To: <1448297789-6524-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

PCM prepare callbacks can be called multiple times. During S3
the stream registers will be reset when Controller is reset.
When stream is resumed, these stream registers needs to reconfigured.

This patch removes the check in prepare callback() if stream already
prepared, which will allow reconfiguring of stream registers and also
decouple stream when stream is resumed to route audio via DSP.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 4378bf452582..43944aff8dcb 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -182,10 +182,6 @@ static int skl_pcm_prepare(struct snd_pcm_substream *substream,
 	int err;
 
 	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
-	if (hdac_stream(stream)->prepared) {
-		dev_dbg(dai->dev, "already stream is prepared - returning\n");
-		return 0;
-	}
 
 	format_val = skl_get_format(substream, dai);
 	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d\n",
@@ -343,6 +339,8 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct skl *skl = get_skl_ctx(dai->dev);
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_module_cfg *mconfig;
+	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	int ret;
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
@@ -350,15 +348,17 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EIO;
 
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+		skl_pcm_prepare(substream, dai);
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-	case SNDRV_PCM_TRIGGER_RESUME:
 		/*
 		 * Start HOST DMA and Start FE Pipe.This is to make sure that
 		 * there are no underrun/overrun in the case when the FE
 		 * pipeline is started but there is a delay in starting the
 		 * DMA channel on the host.
 		 */
+		snd_hdac_ext_stream_decouple(ebus, stream, true);
 		ret = skl_decoupled_trigger(substream, cmd);
 		if (ret < 0)
 			return ret;
@@ -378,6 +378,8 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 
 		ret = skl_decoupled_trigger(substream, cmd);
+		if (cmd == SNDRV_PCM_TRIGGER_SUSPEND)
+			snd_hdac_ext_stream_decouple(ebus, stream, false);
 		break;
 
 	default:
-- 
1.9.1
