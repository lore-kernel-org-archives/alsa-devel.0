From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH] ASoC: Intel: Fix conflicting pcm dev drvdata
	on haswell
Date: Thu,  7 Jul 2016 18:54:56 -0700
Message-ID: <1467942896-40785-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 602FA261561
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 03:55:20 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id b13so10861163pat.0
 for <alsa-devel@alsa-project.org>; Thu, 07 Jul 2016 18:55:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Ben Zhang <benzh@chromium.org>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/intel/haswell/sst-haswell-pcm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index 994256b..3154525 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -819,7 +819,6 @@ static int hsw_pcm_open(struct snd_pcm_substream *substream)
 	mutex_lock(&pcm_data->mutex);
 	pm_runtime_get_sync(pdata->dev);
 
-	snd_soc_pcm_set_drvdata(rtd, pcm_data);
 	pcm_data->substream = substream;
 
 	snd_soc_set_runtime_hwparams(substream, &hsw_pcm_hardware);
-- 
2.8.0.rc3.226.g39d4020
