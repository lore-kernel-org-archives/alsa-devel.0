From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Removed unused
	skl_get_format()" to the asoc tree
Date: Thu, 15 Dec 2016 12:20:41 +0000
Message-ID: <E1cHV1d-0000Uz-Ei@debutante>
References: <1480700509-23380-4-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30E72266A53
 for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2016 13:20:50 +0100 (CET)
In-Reply-To: <1480700509-23380-4-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Removed unused skl_get_format()

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

>From f4e4e9893964684397dec517debe77cb7e405a6c Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 8 Dec 2016 13:41:15 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Removed unused skl_get_format()

Removed the unused function skl_get_format as the format is calculated
directly using the HDA core API.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 1abff8e1a298..10fa10df4e57 100644
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
2.11.0
