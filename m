From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH] ASoC: Intel: Baytrail: Fix implicit
	fallthrough warning
Date: Thu, 22 Aug 2019 14:01:35 +0200
Message-ID: <20190822120135.13515-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8F7AF800BF
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 14:01:42 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org, tiwai@suse.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Separate _SUSPEND from _PAUSE_PUSH to ensure code is handled correctly
while fixing warning reported during compilation.

Fixes: b80d19c166c4 ("ASoC: Intel: Restore Baytrail ADSP streams only when ADSP was in reset")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 9cbc982d46a9..eddb24ab8072 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -193,6 +193,8 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		pdata->restore_stream = false;
+		sst_byt_stream_pause(byt, pcm_data->stream);
+		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		sst_byt_stream_pause(byt, pcm_data->stream);
 		break;
-- 
2.17.1
