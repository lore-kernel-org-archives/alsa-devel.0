From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: usb-audio: Move autoresume call at
	the end of open
Date: Mon, 28 May 2018 11:58:20 +0200
Message-ID: <20180528095821.28710-3-tiwai@suse.de>
References: <20180528095821.28710-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A48B267252
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 17:32:15 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CEEAFAC0A
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 15:32:14 +0000 (UTC)
In-Reply-To: <20180528095821.28710-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

... so that we can avoid the extra goto lines.
Also beautify the code to follow the standard codex.

No functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/pcm.c | 73 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index d5b9c30d3bb1..a66bc717b952 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -76,10 +76,9 @@ snd_pcm_uframes_t snd_usb_pcm_delay(struct snd_usb_substream *subs,
  */
 static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream)
 {
-	struct snd_usb_substream *subs;
+	struct snd_usb_substream *subs = substream->runtime->private_data;
 	unsigned int hwptr_done;
 
-	subs = (struct snd_usb_substream *)substream->runtime->private_data;
 	if (atomic_read(&subs->stream->chip->shutdown))
 		return SNDRV_PCM_POS_XRUN;
 	spin_lock(&subs->lock);
@@ -1172,9 +1171,6 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 		pt = 125 * (1 << fp->datainterval);
 		ptmin = min(ptmin, pt);
 	}
-	err = snd_usb_autoresume(subs->stream->chip);
-	if (err < 0)
-		return err;
 
 	param_period_time_if_needed = SNDRV_PCM_HW_PARAM_PERIOD_TIME;
 	if (subs->speed == USB_SPEED_FULL)
@@ -1183,30 +1179,37 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 	if (ptmin == 1000)
 		/* if period time doesn't go below 1 ms, no rules needed */
 		param_period_time_if_needed = -1;
-	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-				     ptmin, UINT_MAX);
-
-	if ((err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				       hw_rule_rate, subs,
-				       SNDRV_PCM_HW_PARAM_FORMAT,
-				       SNDRV_PCM_HW_PARAM_CHANNELS,
-				       param_period_time_if_needed,
-				       -1)) < 0)
-		goto rep_err;
-	if ((err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				       hw_rule_channels, subs,
-				       SNDRV_PCM_HW_PARAM_FORMAT,
-				       SNDRV_PCM_HW_PARAM_RATE,
-				       param_period_time_if_needed,
-				       -1)) < 0)
-		goto rep_err;
-	if ((err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
-				       hw_rule_format, subs,
-				       SNDRV_PCM_HW_PARAM_RATE,
-				       SNDRV_PCM_HW_PARAM_CHANNELS,
-				       param_period_time_if_needed,
-				       -1)) < 0)
-		goto rep_err;
+
+	err = snd_pcm_hw_constraint_minmax(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+					   ptmin, UINT_MAX);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				  hw_rule_rate, subs,
+				  SNDRV_PCM_HW_PARAM_FORMAT,
+				  SNDRV_PCM_HW_PARAM_CHANNELS,
+				  param_period_time_if_needed,
+				  -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  hw_rule_channels, subs,
+				  SNDRV_PCM_HW_PARAM_FORMAT,
+				  SNDRV_PCM_HW_PARAM_RATE,
+				  param_period_time_if_needed,
+				  -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
+				  hw_rule_format, subs,
+				  SNDRV_PCM_HW_PARAM_RATE,
+				  SNDRV_PCM_HW_PARAM_CHANNELS,
+				  param_period_time_if_needed,
+				  -1);
+	if (err < 0)
+		return err;
 	if (param_period_time_if_needed >= 0) {
 		err = snd_pcm_hw_rule_add(runtime, 0,
 					  SNDRV_PCM_HW_PARAM_PERIOD_TIME,
@@ -1216,15 +1219,13 @@ static int setup_hw_info(struct snd_pcm_runtime *runtime, struct snd_usb_substre
 					  SNDRV_PCM_HW_PARAM_RATE,
 					  -1);
 		if (err < 0)
-			goto rep_err;
+			return err;
 	}
-	if ((err = snd_usb_pcm_check_knot(runtime, subs)) < 0)
-		goto rep_err;
-	return 0;
+	err = snd_usb_pcm_check_knot(runtime, subs);
+	if (err < 0)
+		return err;
 
-rep_err:
-	snd_usb_autosuspend(subs->stream->chip);
-	return err;
+	return snd_usb_autoresume(subs->stream->chip);
 }
 
 static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
-- 
2.16.3
