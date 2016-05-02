From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Suspend PCMs when
	marked as active suspend" to the asoc tree
Date: Mon, 02 May 2016 12:03:33 +0100
Message-ID: <E1axBdV-0001Vw-Q6@debutante>
References: <1461849329-20364-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 378EA260438
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 13:03:38 +0200 (CEST)
In-Reply-To: <1461849329-20364-5-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Suspend PCMs when marked as active suspend

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

>From 9a655db0201ef523683d700cb3f4508c08bc9d8c Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 28 Apr 2016 18:45:28 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Suspend PCMs when marked as active
 suspend

For 'ignore_suspend' cases we need to keep DSP and pipes On, but
can suspend the stream and pause the DMA as we are not rendering
data during the suspended time.

For this we can check the dai widget ignore_suspend flag in
trigger suspend/resume, and start and stop the host DMA and host
copier pipelines.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 4fcf5f830a8c..b0e7797f2259 100644
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
2.8.1
