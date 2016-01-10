From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Reconfigure Link stream
	on suspend/resume" to the asoc tree
Date: Sun, 10 Jan 2016 12:22:28 +0000
Message-ID: <E1aIF0u-0008Pw-VH@debutante>
References: <1449816267-11910-14-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85AA42605EF
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:34 +0100 (CET)
In-Reply-To: <1449816267-11910-14-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Reconfigure Link stream on suspend/resume

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

>From 920982c93c26a9a94d1e90221953a2ce16e91c0b Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 18 Dec 2015 15:12:08 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Reconfigure Link stream on
 suspend/resume

On suspend the link register are lost so we need to reconfigure
them in resume. This patch adds the reconfiguration of the link
register in trigger resume.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 5a532224cb47..17a64362b283 100644
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
2.7.0.rc3
