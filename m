From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/8] ALSA: x86: Minor code rearrangement
Date: Wed, 15 Feb 2017 22:29:35 +0100
Message-ID: <20170215212936.697-8-tiwai@suse.de>
References: <20170215212936.697-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 36C04266E53
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

Put the stuff in the right order; notification should be at the end of
the action.

Also dropped a superfluous debug print and incorrect comments.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 2ed0a34bc19e..8b6e1c728798 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1374,18 +1374,15 @@ static void had_process_hot_plug(struct snd_intelhad *intelhaddata)
 			__func__, __LINE__);
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 
-	/* Safety check */
+	had_build_channel_allocation_map(intelhaddata);
+
+	/* Report to above ALSA layer */
 	substream = had_substream_get(intelhaddata);
 	if (substream) {
-		dev_dbg(intelhaddata->dev,
-			"Force to stop the active stream by disconnection\n");
-		/* Set runtime->state to hw_params done */
 		snd_pcm_stop_xrun(substream);
 		had_substream_put(intelhaddata);
 	}
 
-	had_build_channel_allocation_map(intelhaddata);
-
 	snd_jack_report(intelhaddata->jack, SND_JACK_AVOUT);
 }
 
@@ -1394,14 +1391,11 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 {
 	struct snd_pcm_substream *substream;
 
-	substream = had_substream_get(intelhaddata);
-
 	spin_lock_irq(&intelhaddata->had_spinlock);
-
 	if (!intelhaddata->connected) {
 		dev_dbg(intelhaddata->dev, "Device already disconnected\n");
 		spin_unlock_irq(&intelhaddata->had_spinlock);
-		goto out;
+		return;
 
 	}
 
@@ -1414,16 +1408,17 @@ static void had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 			__func__, __LINE__);
 	spin_unlock_irq(&intelhaddata->had_spinlock);
 
+	kfree(intelhaddata->chmap->chmap);
+	intelhaddata->chmap->chmap = NULL;
+
 	/* Report to above ALSA layer */
-	if (substream)
+	substream = had_substream_get(intelhaddata);
+	if (substream) {
 		snd_pcm_stop_xrun(substream);
+		had_substream_put(intelhaddata);
+	}
 
- out:
 	snd_jack_report(intelhaddata->jack, 0);
-	if (substream)
-		had_substream_put(intelhaddata);
-	kfree(intelhaddata->chmap->chmap);
-	intelhaddata->chmap->chmap = NULL;
 }
 
 /*
-- 
2.11.1
