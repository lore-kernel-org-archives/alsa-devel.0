From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix simultaneous Baytrail SST
	capture and playback
Date: Thu, 15 May 2014 14:41:48 +0300
Message-ID: <1400154108-14698-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AB9926171D
 for <alsa-devel@alsa-project.org>; Thu, 15 May 2014 13:41:59 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

I managed to drop a change to stream ID setting from commit 49fee1781634
("ASoC: Intel: Only export one Baytrail DAI") leading to non-working
simultaneous capture-playback since after one DAI conversion
rtd->cpu_dai->id + 1 will be the same for both playback and capture.

Use substream->stream + 1 like it was in original Liam's patch.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 23a25c0627bd..6242ccce2bb7 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -254,7 +254,7 @@ static int sst_byt_pcm_open(struct snd_pcm_substream *substream)
 
 	snd_soc_set_runtime_hwparams(substream, &sst_byt_pcm_hardware);
 
-	pcm_data->stream = sst_byt_stream_new(byt, rtd->cpu_dai->id + 1,
+	pcm_data->stream = sst_byt_stream_new(byt, substream->stream + 1,
 					      byt_notify_pointer, pcm_data);
 	if (pcm_data->stream == NULL) {
 		dev_err(rtd->dev, "failed to create stream\n");
-- 
2.0.0.rc0
