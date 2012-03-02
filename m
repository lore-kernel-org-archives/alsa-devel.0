From: pavel.hofman@ivitera.com
Subject: [PATCH - ice1724 1/1] ALSA: ice1724 - constrain
	runtime rates for locked internal rate
Date: Fri,  2 Mar 2012 22:09:39 +0100
Message-ID: <1330722579-6923-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

The driver already defines control "Multi Track Rate Locking" which
locks the card at current rate if switched to internal clock. This patch
limits the runtime rates to this rate only, allowing proper reporting
of the card capabilities, and e.g. automatic rate conversion by the plug
plugin to the currently locked rate.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 9236297..812d10e 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1013,6 +1013,25 @@ static int set_rate_constraints(struct snd_ice1712 *ice,
 					  ice->hw_rates);
 }
 
+/* if the card has the internal rate locked (is_pro_locked), limit runtime
+   hw rates to the current internal rate only.
+*/
+static void constrain_rate_if_locked(struct snd_pcm_substream *substream)
+{
+	struct snd_ice1712 *ice = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int rate;
+	if (is_pro_rate_locked(ice)) {
+		rate = ice->get_rate(ice);
+		if (rate >= runtime->hw.rate_min
+		    && rate <= runtime->hw.rate_max) {
+			runtime->hw.rate_min = rate;
+			runtime->hw.rate_max = rate;
+		}
+	}
+}
+
+
 /* multi-channel playback needs alignment 8x32bit regardless of the channels
  * actually used
  */
@@ -1046,6 +1065,7 @@ static int snd_vt1724_playback_pro_open(struct snd_pcm_substream *substream)
 				   VT1724_BUFFER_ALIGN);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				   VT1724_BUFFER_ALIGN);
+	constrain_rate_if_locked(substream);
 	if (ice->pro_open)
 		ice->pro_open(ice, substream);
 	return 0;
@@ -1066,6 +1086,7 @@ static int snd_vt1724_capture_pro_open(struct snd_pcm_substream *substream)
 				   VT1724_BUFFER_ALIGN);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				   VT1724_BUFFER_ALIGN);
+	constrain_rate_if_locked(substream);
 	if (ice->pro_open)
 		ice->pro_open(ice, substream);
 	return 0;
@@ -1215,6 +1236,7 @@ static int snd_vt1724_playback_spdif_open(struct snd_pcm_substream *substream)
 				   VT1724_BUFFER_ALIGN);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				   VT1724_BUFFER_ALIGN);
+	constrain_rate_if_locked(substream);
 	if (ice->spdif.ops.open)
 		ice->spdif.ops.open(ice, substream);
 	return 0;
@@ -1251,6 +1273,7 @@ static int snd_vt1724_capture_spdif_open(struct snd_pcm_substream *substream)
 				   VT1724_BUFFER_ALIGN);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
 				   VT1724_BUFFER_ALIGN);
+	constrain_rate_if_locked(substream);
 	if (ice->spdif.ops.open)
 		ice->spdif.ops.open(ice, substream);
 	return 0;
-- 
1.7.0.4
