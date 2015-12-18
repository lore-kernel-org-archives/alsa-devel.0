From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 11/13] ASoC: Intel: Skylake: Add DMA resume
	position in Trigger resume/suspend
Date: Fri, 18 Dec 2015 15:12:07 +0530
Message-ID: <1450431729-27259-12-git-send-email-vinod.koul@intel.com>
References: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C2E032665A9
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 10:39:29 +0100 (CET)
In-Reply-To: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
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

Use the DMA resume capability to resume the DMA position when
stream is suspended/resumed.

In suspend we save the position and when stream is resumed the stream needs
to be started from the position when the stream was suspended using the new
DMA resume capabilities

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 8039a0479053..5a532224cb47 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -393,6 +393,15 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 		skl_pcm_prepare(substream, dai);
+		/*
+		 * enable DMA Resume enable bit for the stream, set the dpib
+		 * & lpib position to resune before starting the DMA
+		 */
+		snd_hdac_ext_stream_drsm_enable(ebus, true,
+					hdac_stream(stream)->index);
+		snd_hdac_ext_stream_set_dpibr(ebus, stream, stream->dpib);
+		snd_hdac_ext_stream_set_lpib(stream, stream->lpib);
+
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		/*
@@ -421,8 +430,17 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			return ret;
 
 		ret = skl_decoupled_trigger(substream, cmd);
-		if (cmd == SNDRV_PCM_TRIGGER_SUSPEND)
+		if (cmd == SNDRV_PCM_TRIGGER_SUSPEND) {
+			/* save the dpib and lpib positions */
+			stream->dpib = readl(ebus->bus.remap_addr +
+					AZX_REG_VS_SDXDPIB_XBASE +
+					(AZX_REG_VS_SDXDPIB_XINTERVAL *
+					hdac_stream(stream)->index));
+
+			stream->lpib = snd_hdac_stream_get_pos_lpib(
+							hdac_stream(stream));
 			snd_hdac_ext_stream_decouple(ebus, stream, false);
+		}
 		break;
 
 	default:
-- 
1.9.1
