From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/5] ASoC: Intel: Skylake: Suspend PCMs when
	marked as active suspend
Date: Thu, 28 Apr 2016 18:45:28 +0530
Message-ID: <1461849329-20364-5-git-send-email-vinod.koul@intel.com>
References: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 61F742667D1
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:10:51 +0200 (CEST)
In-Reply-To: <1461849329-20364-1-git-send-email-vinod.koul@intel.com>
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

For 'ignore_suspend' cases we need to keep DSP and pipes On, but
can suspend the stream and pause the DMA as we are not rendering
data during the suspended time.

For this we can check the dai widget ignore_suspend flag in
trigger suspend/resume, and start and stop the host DMA and host
copier pipelines.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index df24d8c6b757..c726937321ef 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -402,23 +402,33 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct skl_module_cfg *mconfig;
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
+	struct snd_soc_dapm_widget *w;
 	int ret;
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
 	if (!mconfig)
 		return -EIO;
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		w = dai->playback_widget;
+	else
+		w = dai->capture_widget;
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
-		skl_pcm_prepare(substream, dai);
-		/*
-		 * enable DMA Resume enable bit for the stream, set the dpib
-		 * & lpib position to resune before starting the DMA
-		 */
-		snd_hdac_ext_stream_drsm_enable(ebus, true,
-					hdac_stream(stream)->index);
-		snd_hdac_ext_stream_set_dpibr(ebus, stream, stream->dpib);
-		snd_hdac_ext_stream_set_lpib(stream, stream->lpib);
+		if (!w->ignore_suspend) {
+			skl_pcm_prepare(substream, dai);
+			/*
+			 * enable DMA Resume enable bit for the stream, set the
+			 * dpib & lpib position to resume before starting the
+			 * DMA
+			 */
+			snd_hdac_ext_stream_drsm_enable(ebus, true,
+						hdac_stream(stream)->index);
+			snd_hdac_ext_stream_set_dpibr(ebus, stream,
+							stream->dpib);
+			snd_hdac_ext_stream_set_lpib(stream, stream->lpib);
+		}
 
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
@@ -448,7 +458,7 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 
 		ret = skl_decoupled_trigger(substream, cmd);
-		if (cmd == SNDRV_PCM_TRIGGER_SUSPEND) {
+		if ((cmd == SNDRV_PCM_TRIGGER_SUSPEND) && !w->ignore_suspend) {
 			/* save the dpib and lpib positions */
 			stream->dpib = readl(ebus->bus.remap_addr +
 					AZX_REG_VS_SDXDPIB_XBASE +
-- 
1.9.1
