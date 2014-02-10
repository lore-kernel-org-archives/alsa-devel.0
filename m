From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: Replace with IS_ENABLED()
Date: Mon, 10 Feb 2014 09:55:26 +0100
Message-ID: <1392022526-12581-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 079E62619E6
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 09:55:27 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8F5FBABEB
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 08:55:26 +0000 (UTC)
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

Replace the lengthy #if defined(XXX) || defined(XXX_MODULE) with the
new IS_ENABLED() macro.

The sequencer-related ifdefs in some places (e.g. rawmidi.c) are a bit
tricky.  Instead of adding the extra dependency on CONFIG_MODULE, use
the another Kconfig such as CONFIG_SND_RAQMIDI_SEQ that already takes
such a dependency into account.

The patch still doesn't cover all ifdefs.  For example, the dependency
on CONFIG_GAMEPORT is still open-coded because this also has an extra
dependency on CONFIG_MODULE.  Similarly, an open-coded ifdef is still
left in pcm_oss.c for OSS mixer ioctl.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c            |  2 +-
 sound/core/info.c               |  4 ++--
 sound/core/init.c               |  8 ++++----
 sound/core/pcm.c                | 10 +++++-----
 sound/core/pcm_native.c         |  2 +-
 sound/core/rawmidi.c            |  4 ++--
 sound/core/rtctimer.c           |  4 ++--
 sound/core/sound_oss.c          |  2 +-
 sound/core/timer.c              |  4 ++--
 sound/drivers/opl3/opl3_lib.c   |  2 +-
 sound/drivers/opl3/opl3_synth.c |  2 +-
 sound/drivers/opl4/opl4_lib.c   |  4 ++--
 sound/drivers/opl4/opl4_local.h |  2 +-
 sound/isa/sb/emu8000.c          |  2 +-
 sound/isa/sb/sb16.c             |  2 +-
 sound/pci/emu10k1/emu10k1.c     |  2 +-
 sound/pci/hda/hda_intel.c       |  2 +-
 17 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index d8aa206e8bde..c228f00e5701 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -151,7 +151,7 @@ void snd_ctl_notify(struct snd_card *card, unsigned int mask,
 	if (snd_BUG_ON(!card || !id))
 		return;
 	read_lock(&card->ctl_files_rwlock);
-#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	card->mixer_oss_change_count++;
 #endif
 	list_for_each_entry(ctl, &card->ctl_files, list) {
diff --git a/sound/core/info.c b/sound/core/info.c
index e79baa11b60e..7916c07b9324 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -540,7 +540,7 @@ int __init snd_info_init(void)
 		snd_oss_root = entry;
 	}
 #endif
-#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+#if IS_ENABLED(CONFIG_SND_SEQUENCER)
 	{
 		struct snd_info_entry *entry;
 		if ((entry = snd_info_create_module_entry(THIS_MODULE, "seq", NULL)) == NULL)
@@ -567,7 +567,7 @@ int __exit snd_info_done(void)
 	snd_minor_info_done();
 	snd_info_version_done();
 	if (snd_proc_root) {
-#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+#if IS_ENABLED(CONFIG_SND_SEQUENCER)
 		snd_info_free_entry(snd_seq_root);
 #endif
 #ifdef CONFIG_SND_OSSEMUL
diff --git a/sound/core/init.c b/sound/core/init.c
index 0d42fcda0de2..a16d765cdf47 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -94,7 +94,7 @@ static int module_slot_match(struct module *module, int idx)
 	return match;
 }
 
-#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 int (*snd_mixer_oss_notify_callback)(struct snd_card *card, int free_flag);
 EXPORT_SYMBOL(snd_mixer_oss_notify_callback);
 #endif
@@ -394,7 +394,7 @@ int snd_card_disconnect(struct snd_card *card)
 	/* phase 3: notify all connected devices about disconnection */
 	/* at this point, they cannot respond to any calls except release() */
 
-#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_DISCONNECT);
 #endif
@@ -430,7 +430,7 @@ EXPORT_SYMBOL(snd_card_disconnect);
  */
 static int snd_card_do_free(struct snd_card *card)
 {
-#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
@@ -723,7 +723,7 @@ int snd_card_register(struct snd_card *card)
 	snd_cards[card->number] = card;
 	mutex_unlock(&snd_card_mutex);
 	init_info_for_card(card);
-#if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_REGISTER);
 #endif
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index e1e9e0c999fe..091a05c1d5b3 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -295,7 +295,7 @@ static const char *snd_pcm_state_name(snd_pcm_state_t state)
 	return snd_pcm_state_names[(__force int)state];
 }
 
-#if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
 #include <linux/soundcard.h>
 
 static const char *snd_pcm_oss_format_name(int format)
@@ -398,7 +398,7 @@ static void snd_pcm_substream_proc_hw_params_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "rate: %u (%u/%u)\n", runtime->rate, runtime->rate_num, runtime->rate_den);	
 	snd_iprintf(buffer, "period_size: %lu\n", runtime->period_size);	
 	snd_iprintf(buffer, "buffer_size: %lu\n", runtime->buffer_size);	
-#if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	if (substream->oss.oss) {
 		snd_iprintf(buffer, "OSS format: %s\n", snd_pcm_oss_format_name(runtime->oss.format));
 		snd_iprintf(buffer, "OSS channels: %u\n", runtime->oss.channels);	
@@ -651,7 +651,7 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 	struct snd_pcm_str *pstr = &pcm->streams[stream];
 	struct snd_pcm_substream *substream, *prev;
 
-#if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	mutex_init(&pstr->oss.setup_mutex);
 #endif
 	pstr->stream = stream;
@@ -807,7 +807,7 @@ EXPORT_SYMBOL(snd_pcm_new_internal);
 static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
 {
 	struct snd_pcm_substream *substream, *substream_next;
-#if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	struct snd_pcm_oss_setup *setup, *setupn;
 #endif
 	substream = pstr->substream;
@@ -819,7 +819,7 @@ static void snd_pcm_free_stream(struct snd_pcm_str * pstr)
 		substream = substream_next;
 	}
 	snd_pcm_stream_proc_done(pstr);
-#if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	for (setup = pstr->oss.setup_list; setup; setup = setupn) {
 		setupn = setup->next;
 		kfree(setup->task_name);
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 10b5d1a9dec0..e3664116736b 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -399,7 +399,7 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 		return -EBADFD;
 	}
 	snd_pcm_stream_unlock_irq(substream);
-#if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	if (!substream->oss.oss)
 #endif
 		if (atomic_read(&substream->mmap_count))
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index f016be72b100..f15dbb8001f1 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1530,7 +1530,7 @@ static int snd_rawmidi_dev_free(struct snd_device *device)
 	return snd_rawmidi_free(rmidi);
 }
 
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_ENABLED(CONFIG_SND_RAWMIDI_SEQ)
 static void snd_rawmidi_dev_seq_free(struct snd_seq_device *device)
 {
 	struct snd_rawmidi *rmidi = device->private_data;
@@ -1605,7 +1605,7 @@ static int snd_rawmidi_dev_register(struct snd_device *device)
 		}
 	}
 	rmidi->proc_entry = entry;
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_ENABLED(CONFIG_SND_RAWMIDI_SEQ)
 	if (!rmidi->ops || !rmidi->ops->dev_register) { /* own registration mechanism */
 		if (snd_seq_device_new(rmidi->card, rmidi->device, SNDRV_SEQ_DEV_ID_MIDISYNTH, 0, &rmidi->seq_dev) >= 0) {
 			rmidi->seq_dev->private_data = rmidi;
diff --git a/sound/core/rtctimer.c b/sound/core/rtctimer.c
index e85e72baff9e..b27223746b0e 100644
--- a/sound/core/rtctimer.c
+++ b/sound/core/rtctimer.c
@@ -27,7 +27,7 @@
 #include <sound/core.h>
 #include <sound/timer.h>
 
-#if defined(CONFIG_RTC) || defined(CONFIG_RTC_MODULE)
+#if IS_ENABLED(CONFIG_RTC)
 
 #include <linux/mc146818rtc.h>
 
@@ -185,4 +185,4 @@ MODULE_LICENSE("GPL");
 
 MODULE_ALIAS("snd-timer-" __stringify(SNDRV_TIMER_GLOBAL_RTC));
 
-#endif /* CONFIG_RTC || CONFIG_RTC_MODULE */
+#endif /* IS_ENABLED(CONFIG_RTC) */
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 726a49ac9725..5391c5e139ef 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -21,7 +21,7 @@
 
 #ifdef CONFIG_SND_OSSEMUL
 
-#if !defined(CONFIG_SOUND) && !(defined(MODULE) && defined(CONFIG_SOUND_MODULE))
+#if !IS_ENABLED(CONFIG_SOUND)
 #error "Enable the OSS soundcore multiplexer (CONFIG_SOUND) in the kernel."
 #endif
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6ddcf06f52f9..cbec51464c5b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -35,9 +35,9 @@
 #include <sound/initval.h>
 #include <linux/kmod.h>
 
-#if defined(CONFIG_SND_HRTIMER) || defined(CONFIG_SND_HRTIMER_MODULE)
+#if IS_ENABLED(CONFIG_SND_HRTIMER)
 #define DEFAULT_TIMER_LIMIT 4
-#elif defined(CONFIG_SND_RTCTIMER) || defined(CONFIG_SND_RTCTIMER_MODULE)
+#elif IS_ENABLED(CONFIG_SND_RTCTIMER)
 #define DEFAULT_TIMER_LIMIT 2
 #else
 #define DEFAULT_TIMER_LIMIT 1
diff --git a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
index 33d9a857a262..d7091e56d0d0 100644
--- a/sound/drivers/opl3/opl3_lib.c
+++ b/sound/drivers/opl3/opl3_lib.c
@@ -530,7 +530,7 @@ int snd_opl3_hwdep_new(struct snd_opl3 * opl3,
 
 	opl3->hwdep = hw;
 	opl3->seq_dev_num = seq_device;
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_ENABLED(CONFIG_SND_OPL3_LIB_SEQ)
 	if (snd_seq_device_new(card, seq_device, SNDRV_SEQ_DEV_ID_OPL3,
 			       sizeof(struct snd_opl3 *), &opl3->seq_dev) >= 0) {
 		strcpy(opl3->seq_dev->name, hw->name);
diff --git a/sound/drivers/opl3/opl3_synth.c b/sound/drivers/opl3/opl3_synth.c
index 742a4b642fd9..ddcc1a325a61 100644
--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -24,7 +24,7 @@
 #include <sound/opl3.h>
 #include <sound/asound_fm.h>
 
-#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+#if IS_ENABLED(CONFIG_SND_SEQUENCER)
 #define OPL3_SUPPORT_SYNTH
 #endif
 
diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index b953fb4aa298..c88679291091 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -153,7 +153,7 @@ static int snd_opl4_detect(struct snd_opl4 *opl4)
 	return 0;
 }
 
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_ENABLED(CONFIG_SND_OPL4_LIB_SEQ)
 static void snd_opl4_seq_dev_free(struct snd_seq_device *seq_dev)
 {
 	struct snd_opl4 *opl4 = seq_dev->private_data;
@@ -253,7 +253,7 @@ int snd_opl4_create(struct snd_card *card,
 	snd_opl4_create_proc(opl4);
 #endif
 
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_ENABLED(SND_OPL4_LIB_SEQ)
 	opl4->seq_client = -1;
 	if (opl4->hardware < OPL3_HW_OPL4_ML)
 		snd_opl4_create_seq_dev(opl4, seq_device);
diff --git a/sound/drivers/opl4/opl4_local.h b/sound/drivers/opl4/opl4_local.h
index 470e5a758a02..be10b3981365 100644
--- a/sound/drivers/opl4/opl4_local.h
+++ b/sound/drivers/opl4/opl4_local.h
@@ -184,7 +184,7 @@ struct snd_opl4 {
 #endif
 	struct mutex access_mutex;
 
-#if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
+#if IS_ENABLED(SND_OPL4_LIB_SEQ)
 	int used;
 
 	int seq_dev_num;
diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index 45fcdff611f9..83de44cd74a3 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -1139,7 +1139,7 @@ snd_emu8000_new(struct snd_card *card, int index, long port, int seq_ports,
 		snd_emu8000_free(hw);
 		return err;
 	}
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_ENABLED(CONFIG_SND_SBAWE_SEQ)
 	if (snd_seq_device_new(card, index, SNDRV_SEQ_DEV_ID_EMU8000,
 			       sizeof(struct snd_emu8000*), &awe) >= 0) {
 		strcpy(awe->name, "EMU-8000");
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index a4130993955f..2bfbb3aaf51b 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -62,7 +62,7 @@ MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB AWE 32},"
 #define SNDRV_DEBUG_IRQ
 #endif
 
-#if defined(SNDRV_SBAWE) && (defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE)))
+#if defined(SNDRV_SBAWE) && IS_ENABLED(CONFIG_SND_SBAWE_SEQ)
 #define SNDRV_SBAWE_EMU8000
 #endif
 
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 9e1bd0c39a8c..887540ff5c62 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -37,7 +37,7 @@ MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB Live!/PCI512/E-mu APS},"
 	       "{Creative Labs,SB Audigy}}");
 
-#if defined(CONFIG_SND_SEQUENCER) || (defined(MODULE) && defined(CONFIG_SND_SEQUENCER_MODULE))
+#if IS_ENABLED(CONFIG_SND_EMU10K1_SEQ)
 #define ENABLE_SYNTH
 #include <sound/emu10k1_synth.h>
 #endif
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e87eac552ec5..17c83fbc9f84 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -4137,7 +4137,7 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .driver_data = AZX_DRIVER_CTHDA | AZX_DCAPS_PRESET_CTHDA },
 	{ PCI_DEVICE(0x1102, 0x0012),
 	  .driver_data = AZX_DRIVER_CTHDA | AZX_DCAPS_PRESET_CTHDA },
-#if !defined(CONFIG_SND_CTXFI) && !defined(CONFIG_SND_CTXFI_MODULE)
+#if !IS_ENABLED(CONFIG_SND_CTXFI)
 	/* the following entry conflicts with snd-ctxfi driver,
 	 * as ctxfi driver mutates from HD-audio to native mode with
 	 * a special command sequence.
-- 
1.8.5.2
