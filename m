From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda - Handle open while transitioning to
	D3.
Date: Fri, 15 Jun 2012 19:36:23 -0700
Message-ID: <1339814183-29728-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f201.google.com (mail-qc0-f201.google.com
	[209.85.216.201])
	by alsa0.perex.cz (Postfix) with ESMTP id CC9B1103E5D
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2012 04:36:26 +0200 (CEST)
Received: by qcha6 with SMTP id a6so310417qch.2
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2012 19:36:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: olofj@chromium.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

This addresses an issue encountered when a pcm is opened while
transitioning to low power state (codec->power_on == 1 &&
codec->power_transition == -1).  Add snd_pcm_power_up_d3wait to
hda_codec.  This function is used to power up from azx_open as opposed
to snd_hda_power_up used from codec_exec_verb. When powering up from
azx_open, wait for pending power downs to complete, avoiding the power
up continuing in parallel with the power down on the work queue.

The specific issue seen was with the CS4210 codec, it powers off the ADC
and DAC nid in its suspend handler.  If it is re-opened before the
~100ms power down process completes, the ADC and DAC nid are initialized
while powered down and audio is lost until another suspend/resume cycle.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_codec.c |   46 ++++++++++++++++++++++++++++++++++++--------
 sound/pci/hda/hda_codec.h |    2 +
 sound/pci/hda/hda_intel.c |    2 +-
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 851e6ec..604699c 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -4423,20 +4423,19 @@ void snd_hda_update_power_acct(struct hda_codec *codec)
 	codec->power_jiffies += delta;
 }
 
-/**
- * snd_hda_power_up - Power-up the codec
- * @codec: HD-audio codec
- *
- * Increment the power-up counter and power up the hardware really when
- * not turned on yet.
- */
-void snd_hda_power_up(struct hda_codec *codec)
+/* Transition to powered up, if wait_power_down then wait for a pending
+ * transition to D3 to complete. A pending D3 transition is indicated
+ * with power_transition == -1. */
+static void __snd_hda_power_up(struct hda_codec *codec, bool wait_power_down)
 {
 	struct hda_bus *bus = codec->bus;
 
 	spin_lock(&codec->power_lock);
 	codec->power_count++;
-	if (codec->power_on || codec->power_transition > 0) {
+	/* Return if power_on or transitioning to power_on, unless currently
+	 * powering down. */
+	if ((codec->power_on || codec->power_transition > 0) &&
+	    !(wait_power_down && codec->power_transition < 0)) {
 		spin_unlock(&codec->power_lock);
 		return;
 	}
@@ -4460,8 +4459,37 @@ void snd_hda_power_up(struct hda_codec *codec)
 	codec->power_transition = 0;
 	spin_unlock(&codec->power_lock);
 }
+
+/**
+ * snd_hda_power_up - Power-up the codec
+ * @codec: HD-audio codec
+ *
+ * Increment the power-up counter and power up the hardware really when
+ * not turned on yet.
+ */
+void snd_hda_power_up(struct hda_codec *codec)
+{
+	__snd_hda_power_up(codec, false);
+}
 EXPORT_SYMBOL_HDA(snd_hda_power_up);
 
+/**
+ * snd_hda_power_up_d3wait - Power-up the codec after waiting for any pending
+ *   D3 transition to complete.  This differs from snd_hda_power_up() when
+ *   power_transition == -1.  snd_hda_power_up sees this case as a nop,
+ *   snd_hda_power_up_d3wait waits for the D3 transition to complete then powers
+ *   back up.
+ * @codec: HD-audio codec
+ *
+ * Cancel any power down operation hapenning on the work queue, then power up.
+ */
+void snd_hda_power_up_d3wait(struct hda_codec *codec)
+{
+	/* This will cancel and wait for pending power_work to complete. */
+	__snd_hda_power_up(codec, true);
+}
+EXPORT_SYMBOL_HDA(snd_hda_power_up_d3wait);
+
 #define power_save(codec)	\
 	((codec)->bus->power_save ? *(codec)->bus->power_save : 0)
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 71864cdd..a4ac1de 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -1059,10 +1059,12 @@ const char *snd_hda_get_jack_location(u32 cfg);
  */
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 void snd_hda_power_up(struct hda_codec *codec);
+void snd_hda_power_up_d3wait(struct hda_codec *codec);
 void snd_hda_power_down(struct hda_codec *codec);
 void snd_hda_update_power_acct(struct hda_codec *codec);
 #else
 static inline void snd_hda_power_up(struct hda_codec *codec) {}
+static inline void snd_hda_power_up_d3wait(struct hda_codec *codec) {}
 static inline void snd_hda_power_down(struct hda_codec *codec) {}
 #endif
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8f85d30..86758dd 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1767,7 +1767,7 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 				   buff_step);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   buff_step);
-	snd_hda_power_up(apcm->codec);
+	snd_hda_power_up_d3wait(apcm->codec);
 	err = hinfo->ops.open(hinfo, apcm->codec, substream);
 	if (err < 0) {
 		azx_release_device(azx_dev);
-- 
1.7.9.rc0
