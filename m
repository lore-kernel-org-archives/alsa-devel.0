From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: Intel: Reset hw_ptr on resume trigger
Date: Fri, 28 Jul 2017 16:42:06 +0800
Message-ID: <20170728084206.4431-1-cychiang@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "U . Artie Eoff" <ullysses.a.eoff@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: "U. Artie Eoff" <ullysses.a.eoff@intel.com>

Reset the hw_ptr before queuing the restore_stream_context
work to eradicate a nasty white audio noise on resume.

Signed-off-by: U. Artie Eoff <ullysses.a.eoff@intel.com>
---
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 4765ad474544..e0db7070cd42 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -187,8 +187,10 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		sst_byt_stream_start(byt, pcm_data->stream, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
-		if (pdata->restore_stream == true)
+		if (pdata->restore_stream == true) {
+			pcm_data->hw_ptr = 0;
 			schedule_work(&pcm_data->work);
+		}
 		else
 			sst_byt_stream_resume(byt, pcm_data->stream);
 		break;
-- 
2.12.2
