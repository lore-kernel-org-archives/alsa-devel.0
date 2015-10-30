From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/17] ASoC: Intel: Skylake: Fix DSP pipe
	underrun/overrun issue
Date: Fri, 30 Oct 2015 11:08:36 +0900
Message-ID: <E1Zrz7M-0001C6-8n@finisterre>
References: <1445905380-18167-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B42A265D81
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:08:39 +0100 (CET)
In-Reply-To: <1445905380-18167-11-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Fix DSP pipe underrun/overrun issue

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

>From 224829484534062dedd4218f45631a198c4bd55e Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 27 Oct 2015 09:22:53 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix DSP pipe underrun/overrun issue

While rigourous testing of SKL drivers, we noticed underuns and
overuns and on debug realized that we need to change driver
handling of FE pipe startup and shutdown

We need to start DMA and then run pipe together and not split
these up. Similarly while stopping we should stop pipe and then
DMA in a sequence.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c      | 133 +++++++++++++++++++--------------
 sound/soc/intel/skylake/skl-topology.c |  13 ++--
 2 files changed, 85 insertions(+), 61 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 1a9cd00..2517ec5 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -295,29 +295,101 @@ static int skl_be_hw_params(struct snd_pcm_substream *substream,
 	return skl_tplg_be_update_params(dai, &p_params);
 }
 
+static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
+		int cmd)
+{
+	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+	struct hdac_ext_stream *stream;
+	int start;
+	unsigned long cookie;
+	struct hdac_stream *hstr;
+
+	stream = get_hdac_ext_stream(substream);
+	hstr = hdac_stream(stream);
+
+	if (!hstr->prepared)
+		return -EPIPE;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		start = 1;
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_STOP:
+		start = 0;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&bus->reg_lock, cookie);
+
+	if (start) {
+		snd_hdac_stream_start(hdac_stream(stream), true);
+		snd_hdac_stream_timecounter_init(hstr, 0);
+	} else {
+		snd_hdac_stream_stop(hdac_stream(stream));
+	}
+
+	spin_unlock_irqrestore(&bus->reg_lock, cookie);
+
+	return 0;
+}
+
 static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *dai)
 {
 	struct skl *skl = get_skl_ctx(dai->dev);
 	struct skl_sst *ctx = skl->skl_sst;
 	struct skl_module_cfg *mconfig;
+	int ret;
 
 	mconfig = skl_tplg_fe_get_cpr_module(dai, substream->stream);
 	if (!mconfig)
 		return -EIO;
 
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
+		/*
+		 * Start HOST DMA and Start FE Pipe.This is to make sure that
+		 * there are no underrun/overrun in the case when the FE
+		 * pipeline is started but there is a delay in starting the
+		 * DMA channel on the host.
+		 */
+		ret = skl_decoupled_trigger(substream, cmd);
+		if (ret < 0)
+			return ret;
 		return skl_run_pipe(ctx, mconfig->pipe);
+		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		return skl_stop_pipe(ctx, mconfig->pipe);
+	case SNDRV_PCM_TRIGGER_STOP:
+		/*
+		 * Stop FE Pipe first and stop DMA. This is to make sure that
+		 * there are no underrun/overrun in the case if there is a delay
+		 * between the two operations.
+		 */
+		ret = skl_stop_pipe(ctx, mconfig->pipe);
+		if (ret < 0)
+			return ret;
+
+		ret = skl_decoupled_trigger(substream, cmd);
+		break;
 
 	default:
-		return 0;
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static int skl_link_hw_params(struct snd_pcm_substream *substream,
@@ -685,66 +757,15 @@ static int skl_coupled_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int skl_decoupled_trigger(struct snd_pcm_substream *substream,
-		int cmd)
-{
-	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct hdac_ext_stream *stream;
-	int start;
-	unsigned long cookie;
-	struct hdac_stream *hstr;
-
-	dev_dbg(bus->dev, "In %s cmd=%d streamname=%s\n", __func__, cmd, cpu_dai->name);
-
-	stream = get_hdac_ext_stream(substream);
-	hstr = hdac_stream(stream);
-
-	if (!hstr->prepared)
-		return -EPIPE;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-	case SNDRV_PCM_TRIGGER_RESUME:
-		start = 1;
-		break;
-
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_STOP:
-		start = 0;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&bus->reg_lock, cookie);
-
-	if (start)
-		snd_hdac_stream_start(hdac_stream(stream), true);
-	else
-		snd_hdac_stream_stop(hdac_stream(stream));
-
-	if (start)
-		snd_hdac_stream_timecounter_init(hstr, 0);
-
-	spin_unlock_irqrestore(&bus->reg_lock, cookie);
-
-	return 0;
-}
 static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
 					int cmd)
 {
 	struct hdac_ext_bus *ebus = get_bus_ctx(substream);
 
-	if (ebus->ppcap)
-		return skl_decoupled_trigger(substream, cmd);
-	else
+	if (!ebus->ppcap)
 		return skl_coupled_trigger(substream, cmd);
+
+	return 0;
 }
 
 /* calculate runtime delay from LPIB */
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 0c6e783..2f263dd 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -433,7 +433,10 @@ static int skl_tplg_bind_sinks(struct snd_soc_dapm_widget *w,
 
 			/* Start sinks pipe first */
 			if (sink_mconfig->pipe->state != SKL_PIPE_STARTED) {
-				ret = skl_run_pipe(ctx, sink_mconfig->pipe);
+				if (sink_mconfig->pipe->conn_type !=
+							SKL_PIPE_CONN_TYPE_FE)
+					ret = skl_run_pipe(ctx,
+							sink_mconfig->pipe);
 				if (ret)
 					return ret;
 			}
@@ -475,9 +478,8 @@ static int skl_tplg_pga_dapm_pre_pmu_event(struct snd_soc_dapm_widget *w,
 		return ret;
 
 	/* Start source pipe last after starting all sinks */
-	ret = skl_run_pipe(ctx, src_mconfig->pipe);
-	if (ret)
-		return ret;
+	if (src_mconfig->pipe->conn_type != SKL_PIPE_CONN_TYPE_FE)
+		return skl_run_pipe(ctx, src_mconfig->pipe);
 
 	return 0;
 }
@@ -559,7 +561,8 @@ static int skl_tplg_mixer_dapm_post_pmu_event(struct snd_soc_dapm_widget *w,
 		if (ret)
 			return ret;
 
-		ret = skl_run_pipe(ctx, sink_mconfig->pipe);
+		if (sink_mconfig->pipe->conn_type != SKL_PIPE_CONN_TYPE_FE)
+			ret = skl_run_pipe(ctx, sink_mconfig->pipe);
 	}
 
 	return ret;
-- 
2.6.1
