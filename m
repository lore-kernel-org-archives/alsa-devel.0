From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] ALSA: hda - Implement a poll loop for
 jacks as a module parameter
Date: Tue, 09 Oct 2012 16:28:07 +0200
Message-ID: <50743477.9050401@canonical.com>
References: <1349788784-11700-1-git-send-email-david.henningsson@canonical.com>
 <s5hbogbg497.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040002020107080601060807"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B8DCB2617B0
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 16:28:06 +0200 (CEST)
In-Reply-To: <s5hbogbg497.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040002020107080601060807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2012 03:32 PM, Takashi Iwai wrote:
> At Tue,  9 Oct 2012 15:19:44 +0200,
> David Henningsson wrote:
>>
>> Now that we have a generic unsol mechanism, we can implement a generic
>> poll loop, which can be used for debugging, or if a codec's unsol
>> mechanism is broken.

Oh, and I was also considering not turning on unsol at all (in 
snd_hda_jack_detect_enable) when this is enabled. Then it would help 
against "unstable" pins which trigger repeatedly on/off even though 
nothing is happening physically.

>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>
> The patch almost looks good, but I postpone as a 3.8 thing.

Ok. I never understood the release timings, but I figured anything 
before rc1 would be okay to merge as a feature... (And I couldn't start 
a week earlier; because I didn't know if you would accept the generic 
unsol event.)

That said, it's not very important to me personally which kernel this 
goes into.

>> I'm also considering activating it by default if we go into single_cmd mode
>> due to codec not responding. What do you think?
>
> Well, I don't buy it.  Falling back to single_cmd doesn't mean that we
> are saving the world perfectly.I recently even think it might be
> even better not to do that, otherwise people won't notice the
> breakage.

This is almost philosophical, but if a bug occurs and no user notices, 
is it really a bug? :-)

Or, to make it a bit more pragmatic, what other things are broken with 
single_cmd? Could you give an example where this change would be harmful?

>> +			codec->jackpoll_interval =
>> +				msecs_to_jiffies(jackpoll_ms[chip->dev_index]);
>
> Better to add a sanity check of the interval value.

Ok. Attaching modified patch.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------040002020107080601060807
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Implement-a-poll-loop-for-jacks-as-a-module.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Implement-a-poll-loop-for-jacks-as-a-module.pa";
 filename*1="tch"

>From 67a8012f1e8eef1b67119f8d6699ddf5b88d9fa0 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 9 Oct 2012 15:04:21 +0200
Subject: [PATCH] ALSA: hda - Implement a poll loop for jacks as a module
 parameter

Now that we have a generic unsol mechanism, we can implement a generic
poll loop, which can be used for debugging, or if a codec's unsol
mechanism is broken.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_codec.c |   32 ++++++++++++++++++++++++++++----
 sound/pci/hda/hda_codec.h |    2 ++
 sound/pci/hda/hda_intel.c |   11 +++++++++++
 sound/pci/hda/hda_jack.c  |   22 ++++++++++++++++++++++
 sound/pci/hda/hda_jack.h  |    2 ++
 5 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index c0ab72c..626e45b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1135,6 +1135,19 @@ static void restore_shutup_pins(struct hda_codec *codec)
 }
 #endif
 
+static void hda_jackpoll_work(struct work_struct *work)
+{
+	struct hda_codec *codec =
+		container_of(work, struct hda_codec, jackpoll_work.work);
+	if (!codec->jackpoll_interval)
+		return;
+
+	snd_hda_jack_set_dirty_all(codec);
+	snd_hda_jack_poll_all(codec);
+	queue_delayed_work(codec->bus->workq, &codec->jackpoll_work,
+			   codec->jackpoll_interval);
+}
+
 static void init_hda_cache(struct hda_cache_rec *cache,
 			   unsigned int record_size);
 static void free_hda_cache(struct hda_cache_rec *cache);
@@ -1190,6 +1203,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 {
 	if (!codec)
 		return;
+	cancel_delayed_work_sync(&codec->jackpoll_work);
 	snd_hda_jack_tbl_clear(codec);
 	restore_init_pincfgs(codec);
 #ifdef CONFIG_PM
@@ -1273,6 +1287,7 @@ int /*__devinit*/ snd_hda_codec_new(struct hda_bus *bus,
 	snd_array_init(&codec->cvt_setups, sizeof(struct hda_cvt_setup), 8);
 	snd_array_init(&codec->conn_lists, sizeof(hda_nid_t), 64);
 	snd_array_init(&codec->spdif_out, sizeof(struct hda_spdif_out), 16);
+	INIT_DELAYED_WORK(&codec->jackpoll_work, hda_jackpoll_work);
 
 #ifdef CONFIG_PM
 	spin_lock_init(&codec->power_lock);
@@ -2349,7 +2364,7 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 		return -EBUSY;
 
 	/* OK, let it free */
-
+	cancel_delayed_work_sync(&codec->jackpoll_work);
 #ifdef CONFIG_PM
 	cancel_delayed_work_sync(&codec->power_work);
 	codec->power_on = 0;
@@ -3646,7 +3661,6 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	restore_pincfgs(codec); /* restore all current pin configs */
 	restore_shutup_pins(codec);
 	hda_exec_init_verbs(codec);
-	snd_hda_jack_set_dirty_all(codec);
 	if (codec->patch_ops.resume)
 		codec->patch_ops.resume(codec);
 	else {
@@ -3655,7 +3669,13 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 		snd_hda_codec_resume_amp(codec);
 		snd_hda_codec_resume_cache(codec);
 	}
-	snd_hda_jack_report_sync(codec);
+
+	if (codec->jackpoll_interval)
+		hda_jackpoll_work(&codec->jackpoll_work.work);
+	else {
+		snd_hda_jack_set_dirty_all(codec);
+		snd_hda_jack_report_sync(codec);
+	}
 	snd_hda_power_down(codec); /* flag down before returning */
 }
 #endif /* CONFIG_PM */
@@ -3737,7 +3757,10 @@ int snd_hda_codec_build_controls(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	snd_hda_jack_report_sync(codec); /* call at the last init point */
+	if (codec->jackpoll_interval)
+		hda_jackpoll_work(&codec->jackpoll_work.work);
+	else
+		snd_hda_jack_report_sync(codec); /* call at the last init point */
 	return 0;
 }
 
@@ -5128,6 +5151,7 @@ int snd_hda_suspend(struct hda_bus *bus)
 	struct hda_codec *codec;
 
 	list_for_each_entry(codec, &bus->codec_list, list) {
+		cancel_delayed_work_sync(&codec->jackpoll_work);
 		if (hda_codec_is_power_on(codec))
 			hda_call_codec_suspend(codec, false);
 	}
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 507fe8a..10a03b0 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -884,6 +884,8 @@ struct hda_codec {
 
 	/* jack detection */
 	struct snd_array jacktbl;
+	unsigned long jackpoll_interval; /* In jiffies. Zero means no poll, rely on unsol events */
+	struct delayed_work jackpoll_work;
 
 #ifdef CONFIG_SND_HDA_INPUT_JACK
 	/* jack detection */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f09ff6c..5f0f276 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -68,6 +68,7 @@ static int position_fix[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = -1};
 static int bdl_pos_adj[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = -1};
 static int probe_mask[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = -1};
 static int probe_only[SNDRV_CARDS];
+static int jackpoll_ms[SNDRV_CARDS];
 static bool single_cmd;
 static int enable_msi = -1;
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
@@ -95,6 +96,8 @@ module_param_array(probe_mask, int, NULL, 0444);
 MODULE_PARM_DESC(probe_mask, "Bitmask to probe codecs (default = -1).");
 module_param_array(probe_only, int, NULL, 0444);
 MODULE_PARM_DESC(probe_only, "Only probing and no codec initialization.");
+module_param_array(jackpoll_ms, int, NULL, 0444);
+MODULE_PARM_DESC(jackpoll_ms, "Ms between polling for jack events (default = 0, using unsol events only)");
 module_param(single_cmd, bool, 0444);
 MODULE_PARM_DESC(single_cmd, "Use single command to communicate with codecs "
 		 "(for debugging only).");
@@ -1597,6 +1600,7 @@ static int DELAYED_INIT_MARK azx_codec_create(struct azx *chip, const char *mode
 	struct hda_bus_template bus_temp;
 	int c, codecs, err;
 	int max_slots;
+	unsigned int jackpoll_interval = 0;
 
 	memset(&bus_temp, 0, sizeof(bus_temp));
 	bus_temp.private_data = chip;
@@ -1625,6 +1629,12 @@ static int DELAYED_INIT_MARK azx_codec_create(struct azx *chip, const char *mode
 	if (!max_slots)
 		max_slots = AZX_DEFAULT_CODECS;
 
+	if (jackpoll_ms[chip->dev_index] < 0 || jackpoll_ms[chip->dev_index] > 60000)
+		snd_printk(KERN_WARNING SFX "jackpoll_ms value out of range: %d\n",
+			   jackpoll_ms[chip->dev_index]);
+	else if (jackpoll_ms[chip->dev_index] > 0)
+		jackpoll_interval = msecs_to_jiffies(jackpoll_ms[chip->dev_index]);
+
 	/* First try to probe all given codec slots */
 	for (c = 0; c < max_slots; c++) {
 		if ((chip->codec_mask & (1 << c)) & chip->codec_probe_mask) {
@@ -1666,6 +1676,7 @@ static int DELAYED_INIT_MARK azx_codec_create(struct azx *chip, const char *mode
 			err = snd_hda_codec_new(chip->bus, c, &codec);
 			if (err < 0)
 				continue;
+			codec->jackpoll_interval = jackpoll_interval;
 			codec->beep_mode = chip->beep_mode;
 			codecs++;
 		}
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 5c690cb..07d5288 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -439,3 +439,25 @@ void snd_hda_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 }
 EXPORT_SYMBOL_HDA(snd_hda_jack_unsol_event);
 
+void snd_hda_jack_poll_all(struct hda_codec *codec)
+{
+	struct hda_jack_tbl *jack = codec->jacktbl.list;
+	int i, changes = 0;
+
+	for (i = 0; i < codec->jacktbl.used; i++, jack++) {
+		unsigned int old_sense;
+		if (!jack->nid || !jack->jack_dirty || jack->phantom_jack)
+			continue;
+		old_sense = get_jack_plug_state(jack->pin_sense);
+		jack_detect_update(codec, jack);
+		if (old_sense == get_jack_plug_state(jack->pin_sense))
+			continue;
+		changes = 1;
+		if (jack->callback)
+			jack->callback(codec, jack);
+	}
+	if (changes)
+		snd_hda_jack_report_sync(codec);
+}
+EXPORT_SYMBOL_HDA(snd_hda_jack_poll_all);
+
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index af8dd47..4487785 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -84,4 +84,6 @@ void snd_hda_jack_report_sync(struct hda_codec *codec);
 
 void snd_hda_jack_unsol_event(struct hda_codec *codec, unsigned int res);
 
+void snd_hda_jack_poll_all(struct hda_codec *codec);
+
 #endif /* __SOUND_HDA_JACK_H */
-- 
1.7.9.5


--------------040002020107080601060807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040002020107080601060807--
