From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] ALSA: hda - Implement a poll loop for
 jacks as a module parameter
Date: Fri, 12 Oct 2012 08:49:08 +0200
Message-ID: <5077BD64.4070209@canonical.com>
References: <1349788784-11700-1-git-send-email-david.henningsson@canonical.com>
 <s5hbogbg497.wl%tiwai@suse.de> <50743477.9050401@canonical.com>
 <s5h1uh7g0b8.wl%tiwai@suse.de> <50757C73.3050602@canonical.com>
 <s5hvceicte2.wl%tiwai@suse.de> <5075961A.7010909@canonical.com>
 <s5hehl6co85.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080703060005090004000102"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 22E602615F1
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2012 08:49:10 +0200 (CEST)
In-Reply-To: <s5hehl6co85.wl%tiwai@suse.de>
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
--------------080703060005090004000102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/2012 05:59 PM, Takashi Iwai wrote:
> At Wed, 10 Oct 2012 17:36:58 +0200,
> David Henningsson wrote:
>>
>> On 10/10/2012 04:07 PM, Takashi Iwai wrote:
>>> At Wed, 10 Oct 2012 15:47:31 +0200,
>>> David Henningsson wrote:
>>>>
>>>> On 10/09/2012 04:57 PM, Takashi Iwai wrote:
>>>>> At Tue, 09 Oct 2012 16:28:07 +0200,
>>>>> David Henningsson wrote:
>>>>>> Or, to make it a bit more pragmatic, what other things are broken with
>>>>>> single_cmd? Could you give an example where this change would be harmful?
>>>>>
>>>>> The single cmd mode itself was introduced as a sort of rescue command
>>>>> without CORB/RIRB.  We shouldn't use it in normal situations.  It's
>>>>> simply no considered use case.
>>>>>
>>>>> With a lack of unsol event, you can't handle the volume knob, or any
>>>>> GPIO events, too.
>>>>
>>>> Those two are quite uncommon, and can be polled too if necessary.
>>>
>>> I wonder from where your love to polling comes...
>>
>> It's not a love for polling. It's a pragmatic view of having people's
>> machines working at best effort.
>
> I'm not against to implement the polling if the hardware is really
> broken and doesn't emit the unsol event properly.
> But preferring the poll is a different question.  The poll should be
> always a second choice.

Of course. Polling should be disabled by default.

>> If we, due to lack of time, hardware,
>> specifications, whatever, can't have the best option available to our
>> users, I prefer to have it working but "secretly performing worse", to
>> not having it working at all.
>
> It works more or less but just without unsol event.  It should be
> enough not to stop most of works, but enough for people noticing the
> problem they face.  Again, if single_cmd mode fallback happens,
> something must be wrong.  This is the thing to be fixed.
>
>> I'm genuinely trying to understand what's so wrong with single cmd mode
>> *in practice*, but when what I get in return from you is stuff about
>> saving the world and peaceful living, I don't know how to interpret that
>> "information".
>
> Using single_cmd mode is like driving a car only with the side brake.

I'm not convinced; but it does not matter much, as you're the boss.

>>>>> Well, do you want to allow 1ms polling?
>>>>
>>>> I can't see why not, if people want to burn CPU cycles, why not let
>>>> them.
>>>
>>> You seem to trust users too much :)
>>
>> Well, there's already a single_cmd module parameter, which if enabled
>> causes "no peaceful living at all", can't be worse than that, can it? ;-)
>
> It's a completely different problem.

It was a joke.

> You are trying to allow user setting up a parameter which may freeze
> the machine immediately by 100% CPU hog.  It won't happen with
> single_cmd mode option.

Fair enough.

I tested with "jackpoll_ms=50 single_cmd=1" on a 2 year old laptop and I 
did not notice any performance difference (neither from the polling nor 
the single_cmd).

If people want less than 50 ms polling, they're probably trying to do 
something extraordinary that we don't imagine right now, and hopefully 
they know how to compile their own kernel, or can present their use case 
to us.

So I just picked 50 ms. Feel free to apply the attached patch.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------080703060005090004000102
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Implement-a-poll-loop-for-jacks-as-a-module.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Implement-a-poll-loop-for-jacks-as-a-module.pa";
 filename*1="tch"

>From 34695bf2c87309811877c40845db735dcc19b3c4 Mon Sep 17 00:00:00 2001
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
 sound/pci/hda/hda_intel.c |   20 ++++++++++++++++++++
 sound/pci/hda/hda_jack.c  |   22 ++++++++++++++++++++++
 sound/pci/hda/hda_jack.h  |    2 ++
 5 files changed, 74 insertions(+), 4 deletions(-)

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
index f09ff6c..899d78a 100644
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
@@ -1582,6 +1585,22 @@ static void azx_bus_reset(struct hda_bus *bus)
 	bus->in_reset = 0;
 }
 
+static int get_jackpoll_interval(struct azx *chip)
+{
+	int i = jackpoll_ms[chip->dev_index];
+	unsigned int j;
+	if (i == 0)
+		return 0;
+	if (i < 50 || i > 60000)
+		j = 0;
+	else
+		j = msecs_to_jiffies(i);
+	if (j == 0)
+		snd_printk(KERN_WARNING SFX
+			   "jackpoll_ms value out of range: %d\n", i);
+	return j;
+}
+
 /*
  * Codec initialization
  */
@@ -1666,6 +1685,7 @@ static int DELAYED_INIT_MARK azx_codec_create(struct azx *chip, const char *mode
 			err = snd_hda_codec_new(chip->bus, c, &codec);
 			if (err < 0)
 				continue;
+			codec->jackpoll_interval = get_jackpoll_interval(chip);
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


--------------080703060005090004000102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080703060005090004000102--
