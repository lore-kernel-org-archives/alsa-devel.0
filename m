From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: hda - Refactor pm notification in
	hda_codec.c
Date: Tue, 26 Nov 2013 09:29:11 +0100
Message-ID: <1385454553-12000-4-git-send-email-tiwai@suse.de>
References: <1385454553-12000-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C60142608A2
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5E5CA7B65
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:29:26 +0100 (CET)
In-Reply-To: <1385454553-12000-1-git-send-email-tiwai@suse.de>
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

No functional change.

- codec->pm_down_notified flag is renamed to codec->pm_up_notified
  flag (and takes the reversed meaning), which is managed solely in
  hda_call_pm_notify() now.

- The explicit call of hda_call_pm_notify() is moved into
  hda_keep_power_on().

- Removed a redundant call of hda_call_pm_notify() in
  snd_hda_power_up(), as it's called in hda_call_codec_resume()
  anyway.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 37 ++++++++++++++-----------------------
 sound/pci/hda/hda_codec.h |  2 +-
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index bada677df8a7..8f7295bdccbd 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -99,16 +99,24 @@ EXPORT_SYMBOL_HDA(snd_hda_delete_codec_preset);
 static void hda_power_work(struct work_struct *work);
 static void hda_keep_power_on(struct hda_codec *codec);
 #define hda_codec_is_power_on(codec)	((codec)->power_on)
-static inline void hda_call_pm_notify(struct hda_bus *bus, bool power_up)
+
+static void hda_call_pm_notify(struct hda_codec *codec, bool power_up)
 {
+	struct hda_bus *bus = codec->bus;
+
+	if ((power_up && codec->pm_up_notified) ||
+	    (!power_up && !codec->pm_up_notified))
+		return;
 	if (bus->ops.pm_notify)
 		bus->ops.pm_notify(bus, power_up);
+	codec->pm_up_notified = power_up;
 }
+
 #else
 #define codec_in_pm(codec)	0
 static inline void hda_keep_power_on(struct hda_codec *codec) {}
 #define hda_codec_is_power_on(codec)	1
-#define hda_call_pm_notify(bus, state) {}
+#define hda_call_pm_notify(codec, state) {}
 #endif
 
 /**
@@ -1371,10 +1379,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	codec->bus->caddr_tbl[codec->addr] = NULL;
 	if (codec->patch_ops.free)
 		codec->patch_ops.free(codec);
-#ifdef CONFIG_PM
-	if (!codec->pm_down_notified) /* cancel leftover refcounts */
-		hda_call_pm_notify(codec->bus, false);
-#endif
+	hda_call_pm_notify(codec, false); /* cancel leftover refcounts */
 	unload_parser(codec);
 	module_put(codec->owner);
 	free_hda_cache(&codec->amp_cache);
@@ -1453,7 +1458,6 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	 * phase.
 	 */
 	hda_keep_power_on(codec);
-	hda_call_pm_notify(bus, true);
 #endif
 
 	if (codec->bus->modelname) {
@@ -4058,10 +4062,6 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	 * in the resume / power-save sequence
 	 */
 	hda_keep_power_on(codec);
-	if (codec->pm_down_notified) {
-		codec->pm_down_notified = 0;
-		hda_call_pm_notify(codec->bus, true);
-	}
 	hda_set_power_state(codec, AC_PWRST_D0);
 	restore_shutup_pins(codec);
 	hda_exec_init_verbs(codec);
@@ -4935,11 +4935,8 @@ static void hda_power_work(struct work_struct *work)
 	spin_unlock(&codec->power_lock);
 
 	state = hda_call_codec_suspend(codec, true);
-	if (!codec->pm_down_notified &&
-	    !bus->power_keep_link_on && (state & AC_PWRST_CLK_STOP_OK)) {
-		codec->pm_down_notified = 1;
-		hda_call_pm_notify(bus, false);
-	}
+	if (!bus->power_keep_link_on && (state & AC_PWRST_CLK_STOP_OK))
+		hda_call_pm_notify(codec, false);
 }
 
 static void hda_keep_power_on(struct hda_codec *codec)
@@ -4949,6 +4946,7 @@ static void hda_keep_power_on(struct hda_codec *codec)
 	codec->power_on = 1;
 	codec->power_jiffies = jiffies;
 	spin_unlock(&codec->power_lock);
+	hda_call_pm_notify(codec, true);
 }
 
 /* update the power on/off account with the current jiffies */
@@ -4968,8 +4966,6 @@ void snd_hda_update_power_acct(struct hda_codec *codec)
 /* call this with codec->power_lock held! */
 static void __snd_hda_power_up(struct hda_codec *codec, bool wait_power_down)
 {
-	struct hda_bus *bus = codec->bus;
-
 	/* Return if power_on or transitioning to power_on, unless currently
 	 * powering down. */
 	if ((codec->power_on || codec->power_transition > 0) &&
@@ -4996,11 +4992,6 @@ static void __snd_hda_power_up(struct hda_codec *codec, bool wait_power_down)
 	codec->power_transition = 1; /* avoid reentrance */
 	spin_unlock(&codec->power_lock);
 
-	if (codec->pm_down_notified) {
-		codec->pm_down_notified = 0;
-		hda_call_pm_notify(bus, true);
-	}
-
 	hda_call_codec_resume(codec);
 
 	spin_lock(&codec->power_lock);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index a45eaeebb4ec..6190d3f0d452 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -909,7 +909,7 @@ struct hda_codec {
 #ifdef CONFIG_PM
 	unsigned int power_on :1;	/* current (global) power-state */
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
-	unsigned int pm_down_notified:1; /* PM notified to controller */
+	unsigned int pm_up_notified:1;	/* PM notified to controller */
 	unsigned int in_pm:1;		/* suspend/resume being performed */
 	int power_transition;	/* power-state in transition */
 	int power_count;	/* current (global) power refcount */
-- 
1.8.4.3
