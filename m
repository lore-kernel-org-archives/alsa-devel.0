From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Baytrail: simplify boolean test"
	to the asoc tree
Date: Fri, 21 Dec 2018 18:15:43 +0000 (GMT)
Message-ID: <20181221181543.3017E1121B93@debutante.sirena.org.uk>
References: <20181216224910.16198-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C819267B63
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 19:15:46 +0100 (CET)
In-Reply-To: <20181216224910.16198-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Baytrail: simplify boolean test

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3647b4ca3a98fa5cf7a9f38b67c99d00bb41e8e3 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sun, 16 Dec 2018 16:49:07 -0600
Subject: [PATCH] ASoC: Intel: Baytrail: simplify boolean test

Detected with Coccinelle

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index aabb35bf6b96..498fb5346f1a 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -188,7 +188,7 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		sst_byt_stream_start(byt, pcm_data->stream, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
-		if (pdata->restore_stream == true)
+		if (pdata->restore_stream)
 			schedule_work(&pcm_data->work);
 		else
 			sst_byt_stream_resume(byt, pcm_data->stream);
-- 
2.20.1
