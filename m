From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Use set_tdm_slot to set
	the dma channel" to the asoc tree
Date: Tue, 24 Jan 2017 18:40:04 +0000
Message-ID: <E1cW60i-0006vM-Mo@debutante>
References: <1484589477-7630-4-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A26EE266CC1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 19:40:18 +0100 (CET)
In-Reply-To: <1484589477-7630-4-git-send-email-jeeja.kp@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Use set_tdm_slot to set the dma channel

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

>From 1011509dfd25f90db333f82fa85c39b0861d2b09 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 24 Jan 2017 21:49:04 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Use set_tdm_slot to set the dma channel

DMA channel(stream tag) used by the HDA link need to programmed in
codec so that codec receives packet from the link associated with the
same channel.

DMA channel is allocated in link BE dai hw_params, the same needs to be
set for the BE codec dai. Instead of using get/set dma_data(), use
dai_ops snd_soc_dai_set_tdm_slot() to set the stream tag.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index ae7997ab19b1..55dc9f27d4b2 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -532,10 +532,10 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *link_dev;
 	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
-	struct hdac_ext_dma_params *dma_params;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct skl_pipe_params p_params = {0};
 	struct hdac_ext_link *link;
+	int stream_tag;
 
 	link_dev = snd_hdac_ext_stream_assign(ebus, substream,
 					HDAC_EXT_STREAM_TYPE_LINK);
@@ -548,16 +548,16 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	if (!link)
 		return -EINVAL;
 
+	stream_tag = hdac_stream(link_dev)->stream_tag;
+
 	/* set the stream tag in the codec dai dma params  */
-	dma_params = snd_soc_dai_get_dma_data(codec_dai, substream);
-	if (dma_params)
-		dma_params->stream_tag =  hdac_stream(link_dev)->stream_tag;
+	snd_soc_dai_set_tdm_slot(codec_dai, stream_tag, 0, 0, 0);
 
 	p_params.s_fmt = snd_pcm_format_width(params_format(params));
 	p_params.ch = params_channels(params);
 	p_params.s_freq = params_rate(params);
 	p_params.stream = substream->stream;
-	p_params.link_dma_id = hdac_stream(link_dev)->stream_tag - 1;
+	p_params.link_dma_id = stream_tag - 1;
 	p_params.link_index = link->index;
 	p_params.format = params_format(params);
 
-- 
2.11.0
