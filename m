From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add DMA resume position
	in Trigger resume/suspend" to the asoc tree
Date: Sun, 10 Jan 2016 12:22:29 +0000
Message-ID: <E1aIF0v-0008QP-S9@debutante>
References: <1449816267-11910-13-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 579512605FF
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:35 +0100 (CET)
In-Reply-To: <1449816267-11910-13-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add DMA resume position in Trigger resume/suspend

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 748a1d5a3fb75e1102320214a8bde347d7b228c3 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 18 Dec 2015 15:12:07 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add DMA resume position in Trigger
 resume/suspend

Use the DMA resume capability to resume the DMA position when
stream is suspended/resumed.

In suspend we save the position and when stream is resumed the stream needs
to be started from the position when the stream was suspended using the new
DMA resume capabilities

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.7.0.rc3
