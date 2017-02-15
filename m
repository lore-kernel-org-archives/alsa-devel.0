From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/8] ALSA: x86: Implement jack control
Date: Wed, 15 Feb 2017 22:29:29 +0100
Message-ID: <20170215212936.697-2-tiwai@suse.de>
References: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E7DC7266D1D
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 22:29:42 +0100 (CET)
In-Reply-To: <20170215212936.697-1-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch implements a jack interface for notifying HDMI/DP
connection.  PA listens to this, so it can handle the monitor
connection more gracefully.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 23 +++++++++++++++++++++++
 sound/x86/intel_hdmi_audio.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 9889cdf3ccf4..a30ca03e49ae 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -37,6 +37,7 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/control.h>
+#include <sound/jack.h>
 #include <drm/drm_edid.h>
 #include <drm/intel_lpe_audio.h>
 #include "intel_hdmi_audio.h"
@@ -1382,6 +1383,8 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 	}
 
 	had_build_channel_allocation_map(intelhaddata);
+
+	snd_jack_report(intelhaddata->jack, SND_JACK_AVOUT);
 }
 
 /* process hot unplug, called from wq with mutex locked */
@@ -1414,6 +1417,7 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 		snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 
  out:
+	snd_jack_report(intelhaddata->jack, 0);
 	if (substream)
 		had_substream_put(intelhaddata);
 	kfree(intelhaddata->chmap->chmap);
@@ -1609,6 +1613,21 @@ static void had_audio_wq(struct work_struct *work)
 }
 
 /*
+ * Jack interface
+ */
+static int had_create_jack(struct snd_intelhad *ctx)
+{
+	int err;
+
+	err = snd_jack_new(ctx->card, "HDMI/DP", SND_JACK_AVOUT, &ctx->jack,
+			   true, false);
+	if (err < 0)
+		return err;
+	ctx->jack->private_data = ctx;
+	return 0;
+}
+
+/*
  * PM callbacks
  */
 
@@ -1780,6 +1799,10 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err;
 
+	ret = had_create_jack(ctx);
+	if (ret < 0)
+		goto err;
+
 	ret = snd_card_register(card);
 	if (ret)
 		goto err;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index d6ba90fd011d..2d3e389f76b3 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -130,6 +130,7 @@ struct snd_intelhad {
 	struct work_struct hdmi_audio_wq;
 	struct mutex mutex; /* for protecting chmap and eld */
 	bool need_reset;
+	struct snd_jack *jack;
 };
 
 #endif /* _INTEL_HDMI_AUDIO_ */
-- 
2.11.1
