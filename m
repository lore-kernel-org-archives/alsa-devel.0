From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2] ASoC: Intel: Baytrail: Fix implicit
	fallthrough warning
Date: Wed, 28 Aug 2019 11:51:02 +0200
Message-ID: <20190828095102.15737-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DB46F89744
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2019 11:51:13 +0200 (CEST)
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

Append fallthrough statement to fix warning reported during compilation.

Fixes: b80d19c166c4 ("ASoC: Intel: Restore Baytrail ADSP streams only when ADSP was in reset")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

Changes from v1:
- made use of fallthrough statement as suggested by Pierre
- updated commit message

 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 9cbc982d46a9..54f2ee3010ee 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -193,6 +193,7 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		pdata->restore_stream = false;
+		/* fallthrough */
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		sst_byt_stream_pause(byt, pcm_data->stream);
 		break;
-- 
2.17.1
