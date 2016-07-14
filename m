From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Fix conflicting pcm dev drvdata
	on haswell" to the asoc tree
Date: Thu, 14 Jul 2016 17:32:10 +0100
Message-ID: <E1bNjYY-0001TX-7a@debutante>
References: <1467942896-40785-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05B7426582F
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 18:32:16 +0200 (CEST)
In-Reply-To: <1467942896-40785-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Fix conflicting pcm dev drvdata on haswell

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

>From c999675b04c146aa57f6e853a3746de979427fad Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Thu, 7 Jul 2016 18:54:56 -0700
Subject: [PATCH] ASoC: Intel: Fix conflicting pcm dev drvdata on haswell

soc-core sets the snd_soc_pcm_runtime->dev drvdata to
snd_soc_pcm_runtime in soc_post_component_init, and access
it in places like codec_reg_show.

hsw_pcm_open overwrites the drvdata to point to hsw_pcm_data,
confusing soc-core, and causing crashes when cat
/sys/devices/pci0000:00/INT3438:00/.../System PCM/codec_reg

This patch removes the set in hsw_pcm_open since it's no longer
used. commit 7ff9d6714a5c ("ASoC: Intel: Split hsw_pcm_data for
playback and capture") already removed all calls to
snd_soc_pcm_get_drvdata(rtd).

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 994256b39b9c..3154525c2b83 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -819,7 +819,6 @@ static int hsw_pcm_open(struct snd_pcm_substream *substream)
 	mutex_lock(&pcm_data->mutex);
 	pm_runtime_get_sync(pdata->dev);
 
-	snd_soc_pcm_set_drvdata(rtd, pcm_data);
 	pcm_data->substream = substream;
 
 	snd_soc_set_runtime_hwparams(substream, &hsw_pcm_hardware);
-- 
2.8.1
