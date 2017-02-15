From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/8] ALSA: x86: Don't bail out from PCM ops
	when disconnected
Date: Wed, 15 Feb 2017 22:29:36 +0100
Message-ID: <20170215212936.697-9-tiwai@suse.de>
References: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 379A3266E56
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 22:29:44 +0100 (CET)
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

Currently the driver returns -ENODEV when the monitor is disconnected.
But PA alsa module doesn't like this and it starts playing Juliet,
kills itself as if it were a fatal tragedy.

Since we protect the whole read/write at disconnection, just allow the
PCM accesses even during disconnection.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 8b6e1c728798..f8fa3197f6ef 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1044,13 +1044,6 @@ static int had_pcm_open(struct snd_pcm_substream *substream)
 
 	pm_runtime_get_sync(intelhaddata->dev);
 
-	if (!intelhaddata->connected) {
-		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
-			__func__);
-		retval = -ENODEV;
-		goto error;
-	}
-
 	/* set the runtime hw parameter with local snd_pcm_hardware struct */
 	runtime->hw = had_pcm_hardware;
 
@@ -1176,14 +1169,6 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		/* Disable local INTRs till register prgmng is done */
-		if (!intelhaddata->connected) {
-			dev_dbg(intelhaddata->dev,
-				"_START: HDMI cable plugged-out\n");
-			retval = -ENODEV;
-			break;
-		}
-
 		/* Enable Audio */
 		had_ack_irqs(intelhaddata); /* FIXME: do we need this? */
 		had_enable_audio(intelhaddata, true);
@@ -1217,13 +1202,6 @@ static int had_pcm_prepare(struct snd_pcm_substream *substream)
 	intelhaddata = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
 
-	if (!intelhaddata->connected) {
-		dev_dbg(intelhaddata->dev, "%s: HDMI cable plugged-out\n",
-			__func__);
-		retval = -ENODEV;
-		goto prep_end;
-	}
-
 	dev_dbg(intelhaddata->dev, "period_size=%d\n",
 		(int)frames_to_bytes(runtime, runtime->period_size));
 	dev_dbg(intelhaddata->dev, "periods=%d\n", runtime->periods);
-- 
2.11.1
