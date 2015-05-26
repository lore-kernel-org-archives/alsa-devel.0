From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 2/2] ALSA: set no sound proc fs for reduced
	memory footprint
Date: Tue, 26 May 2015 19:04:25 +0800
Message-ID: <1432638265-16646-3-git-send-email-yang.jie@intel.com>
References: <1432638265-16646-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B7F1265133
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 13:00:48 +0200 (CEST)
In-Reply-To: <1432638265-16646-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: vivian.zhang@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Disable sound proc fs, when CONFIG_SND_NO_PROC_FS is selected,
which can save about 9KB memory size for reducing memory
footprint purpose.
---
 include/sound/info.h               | 8 ++++----
 sound/core/Makefile                | 2 +-
 sound/core/hwdep.c                 | 6 +++---
 sound/core/init.c                  | 8 ++++----
 sound/core/oss/mixer_oss.c         | 6 +++---
 sound/core/pcm.c                   | 6 +++---
 sound/core/seq/oss/seq_oss.c       | 6 +++---
 sound/core/seq/oss/seq_oss_init.c  | 5 ++---
 sound/core/seq/oss/seq_oss_midi.c  | 4 ++--
 sound/core/seq/oss/seq_oss_readq.c | 4 ++--
 sound/core/seq/oss/seq_oss_synth.c | 4 ++--
 sound/core/seq/seq_clientmgr.c     | 4 ++--
 sound/core/seq/seq_device.c        | 2 +-
 sound/core/seq/seq_info.h          | 2 +-
 sound/core/seq/seq_queue.c         | 4 ++--
 sound/core/seq/seq_timer.c         | 4 ++--
 sound/core/sound.c                 | 4 ++--
 sound/core/sound_oss.c             | 4 ++--
 sound/core/timer.c                 | 4 ++--
 sound/pci/hda/Makefile             | 3 ++-
 sound/pci/hda/hda_eld.c            | 4 ++--
 sound/pci/hda/hda_local.h          | 4 ++--
 sound/pci/hda/patch_hdmi.c         | 4 ++--
 sound/pci/hda/patch_sigmatel.c     | 2 +-
 24 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index 1626995..67390ee 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -92,14 +92,14 @@ struct snd_info_entry {
 	struct list_head list;
 };
 
-#if defined(CONFIG_SND_OSSEMUL) && defined(CONFIG_PROC_FS)
+#if defined(CONFIG_SND_OSSEMUL) && defined(CONFIG_SND_PROC_FS)
 int snd_info_minor_register(void);
 #else
 #define snd_info_minor_register()	0
 #endif
 
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 
 extern struct snd_info_entry *snd_seq_root;
 #ifdef CONFIG_SND_OSSEMUL
@@ -197,7 +197,7 @@ static inline int snd_info_check_reserved_words(const char *str) { return 1; }
  * OSS info part
  */
 
-#if defined(CONFIG_SND_OSSEMUL) && defined(CONFIG_PROC_FS)
+#if defined(CONFIG_SND_OSSEMUL) && defined(CONFIG_SND_PROC_FS)
 
 #define SNDRV_OSS_INFO_DEV_AUDIO	0
 #define SNDRV_OSS_INFO_DEV_SYNTH	1
@@ -210,6 +210,6 @@ static inline int snd_info_check_reserved_words(const char *str) { return 1; }
 int snd_oss_info_register(int dev, int num, char *string);
 #define snd_oss_info_unregister(dev, num) snd_oss_info_register(dev, num, NULL)
 
-#endif /* CONFIG_SND_OSSEMUL && CONFIG_PROC_FS */
+#endif /* CONFIG_SND_OSSEMUL && CONFIG_SND_PROC_FS */
 
 #endif /* __SOUND_INFO_H */
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 7dd17a3..9e5bb10 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -4,7 +4,7 @@
 #
 
 snd-y     := sound.o init.o memory.o control.o misc.o device.o
-ifneq ($(CONFIG_PROC_FS),)
+ifneq ($(CONFIG_SND_PROC_FS),)
 snd-y += info.o
 snd-$(CONFIG_SND_OSSEMUL) += info_oss.o
 endif
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 51692c8..36d2416 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -484,7 +484,7 @@ static int snd_hwdep_dev_disconnect(struct snd_device *device)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  *  Info interface
  */
@@ -521,10 +521,10 @@ static void __exit snd_hwdep_proc_done(void)
 {
 	snd_info_free_entry(snd_hwdep_proc_entry);
 }
-#else /* !CONFIG_PROC_FS */
+#else /* !CONFIG_SND_PROC_FS */
 #define snd_hwdep_proc_init()
 #define snd_hwdep_proc_done()
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 
 /*
diff --git a/sound/core/init.c b/sound/core/init.c
index f8abd2d..3e0ceba 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -100,7 +100,7 @@ int (*snd_mixer_oss_notify_callback)(struct snd_card *card, int free_flag);
 EXPORT_SYMBOL(snd_mixer_oss_notify_callback);
 #endif
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static void snd_card_id_read(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
 {
@@ -122,7 +122,7 @@ static int init_info_for_card(struct snd_card *card)
 
 	return snd_info_card_register(card);
 }
-#else /* !CONFIG_PROC_FS */
+#else /* !CONFIG_SND_PROC_FS */
 #define init_info_for_card(card)
 #endif
 
@@ -776,7 +776,7 @@ int snd_card_register(struct snd_card *card)
 
 EXPORT_SYMBOL(snd_card_register);
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static void snd_card_info_read(struct snd_info_entry *entry,
 			       struct snd_info_buffer *buffer)
 {
@@ -861,7 +861,7 @@ int __init snd_card_info_init(void)
 
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 /**
  *  snd_component_add - add a component string
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 056f8e2..a99f720 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1111,7 +1111,7 @@ static int snd_mixer_oss_build_input(struct snd_mixer_oss *mixer, struct snd_mix
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  */
 #define MIXER_VOL(name) [SOUND_MIXER_##name] = #name
@@ -1255,10 +1255,10 @@ static void snd_mixer_oss_proc_done(struct snd_mixer_oss *mixer)
 	snd_info_free_entry(mixer->proc_entry);
 	mixer->proc_entry = NULL;
 }
-#else /* !CONFIG_PROC_FS */
+#else /* !CONFIG_SND_PROC_FS */
 #define snd_mixer_oss_proc_init(mix)
 #define snd_mixer_oss_proc_done(mix)
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 static void snd_mixer_oss_build(struct snd_mixer_oss *mixer)
 {
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index b25bcf5..e537943 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1181,7 +1181,7 @@ int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree)
 }
 EXPORT_SYMBOL(snd_pcm_notify);
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  *  Info interface
  */
@@ -1227,10 +1227,10 @@ static void snd_pcm_proc_done(void)
 	snd_info_free_entry(snd_pcm_proc_entry);
 }
 
-#else /* !CONFIG_PROC_FS */
+#else /* !CONFIG_SND_PROC_FS */
 #define snd_pcm_proc_init()
 #define snd_pcm_proc_done()
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 
 /*
diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index 72873a4..7354b8b 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -45,7 +45,7 @@ MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_MUSIC);
  */
 static int register_device(void);
 static void unregister_device(void);
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static int register_proc(void);
 static void unregister_proc(void);
 #else
@@ -261,7 +261,7 @@ unregister_device(void)
  * /proc interface
  */
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 
 static struct snd_info_entry *info_entry;
 
@@ -303,4 +303,4 @@ unregister_proc(void)
 	snd_info_free_entry(info_entry);
 	info_entry = NULL;
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 2de3fef..b1221b2 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -479,8 +479,7 @@ snd_seq_oss_reset(struct seq_oss_devinfo *dp)
 	snd_seq_oss_timer_stop(dp->timer);
 }
 
-
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  * misc. functions for proc interface
  */
@@ -531,4 +530,4 @@ snd_seq_oss_system_info_read(struct snd_info_buffer *buf)
 			snd_seq_oss_readq_info_read(dp->readq, buf);
 	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
diff --git a/sound/core/seq/oss/seq_oss_midi.c b/sound/core/seq/oss/seq_oss_midi.c
index 96e8395..aaff9ee 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -665,7 +665,7 @@ snd_seq_oss_midi_make_info(struct seq_oss_devinfo *dp, int dev, struct midi_info
 }
 
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  * proc interface
  */
@@ -705,4 +705,4 @@ snd_seq_oss_midi_info_read(struct snd_info_buffer *buf)
 		snd_use_lock_free(&mdev->use_lock);
 	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
diff --git a/sound/core/seq/oss/seq_oss_readq.c b/sound/core/seq/oss/seq_oss_readq.c
index c080c73..ccd8935 100644
--- a/sound/core/seq/oss/seq_oss_readq.c
+++ b/sound/core/seq/oss/seq_oss_readq.c
@@ -222,7 +222,7 @@ snd_seq_oss_readq_put_timestamp(struct seq_oss_readq *q, unsigned long curt, int
 }
 
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  * proc interface
  */
@@ -233,4 +233,4 @@ snd_seq_oss_readq_info_read(struct seq_oss_readq *q, struct snd_info_buffer *buf
 		    (waitqueue_active(&q->midi_sleep) ? "sleeping":"running"),
 		    q->qlen, q->input_time);
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index 48e4fe1..0f3b381 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -630,7 +630,7 @@ snd_seq_oss_synth_make_info(struct seq_oss_devinfo *dp, int dev, struct synth_in
 }
 
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  * proc interface
  */
@@ -658,4 +658,4 @@ snd_seq_oss_synth_info_read(struct snd_info_buffer *buf)
 		snd_use_lock_free(&rec->use_lock);
 	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index edbdab8..b64f20d 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2447,7 +2447,7 @@ EXPORT_SYMBOL(snd_seq_kernel_client_write_poll);
 
 /*---------------------------------------------------------------------------*/
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  *  /proc interface
  */
@@ -2549,7 +2549,7 @@ void snd_seq_info_clients_read(struct snd_info_entry *entry,
 		snd_seq_client_unlock(client);
 	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 /*---------------------------------------------------------------------------*/
 
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index d99f99d..288af56 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -72,7 +72,7 @@ static struct bus_type snd_seq_bus_type = {
 /*
  * proc interface -- just for compatibility
  */
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static struct snd_info_entry *info_entry;
 
 static int print_dev_info(struct device *dev, void *data)
diff --git a/sound/core/seq/seq_info.h b/sound/core/seq/seq_info.h
index 4892a7f..f8549f8 100644
--- a/sound/core/seq/seq_info.h
+++ b/sound/core/seq/seq_info.h
@@ -29,7 +29,7 @@ void snd_seq_info_timer_read(struct snd_info_entry *entry, struct snd_info_buffe
 void snd_seq_info_queues_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer);
 
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 int snd_seq_info_init( void );
 int snd_seq_info_done( void );
 #else
diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index a0cda38..7dfd0f4 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -753,7 +753,7 @@ int snd_seq_control_queue(struct snd_seq_event *ev, int atomic, int hop)
 
 /*----------------------------------------------------------------*/
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /* exported to seq_info.c */
 void snd_seq_info_queues_read(struct snd_info_entry *entry, 
 			      struct snd_info_buffer *buffer)
@@ -787,5 +787,5 @@ void snd_seq_info_queues_read(struct snd_info_entry *entry,
 		queuefree(q);
 	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 186f161..82b220c 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -422,7 +422,7 @@ snd_seq_tick_time_t snd_seq_timer_get_cur_tick(struct snd_seq_timer *tmr)
 }
 
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /* exported to seq_info.c */
 void snd_seq_info_timer_read(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
@@ -449,5 +449,5 @@ void snd_seq_info_timer_read(struct snd_info_entry *entry,
 		queuefree(q);
  	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
diff --git a/sound/core/sound.c b/sound/core/sound.c
index e5d37bd..175f9e4 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -330,7 +330,7 @@ int snd_unregister_device(struct device *dev)
 }
 EXPORT_SYMBOL(snd_unregister_device);
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  *  INFO PART
  */
@@ -391,7 +391,7 @@ int __init snd_minor_info_init(void)
 	entry->c.text.read = snd_minor_info_read;
 	return snd_info_register(entry); /* freed in error path */
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 /*
  *  INIT PART
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index 86e2d91..0ca9d72 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(snd_unregister_oss_device);
  *  INFO PART
  */
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static const char *snd_oss_device_type_name(int type)
 {
 	switch (type) {
@@ -259,4 +259,4 @@ int __init snd_minor_info_oss_init(void)
 	entry->c.text.read = snd_minor_info_oss_read;
 	return snd_info_register(entry); /* freed in error path */
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
diff --git a/sound/core/timer.c b/sound/core/timer.c
index a9a1a04..31f40f0 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1034,7 +1034,7 @@ static int snd_timer_register_system(void)
 	return snd_timer_global_register(timer);
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 /*
  *  Info interface
  */
@@ -1104,7 +1104,7 @@ static void __exit snd_timer_proc_done(void)
 {
 	snd_info_free_entry(snd_timer_proc_entry);
 }
-#else /* !CONFIG_PROC_FS */
+#else /* !CONFIG_SND_PROC_FS */
 #define snd_timer_proc_init()
 #define snd_timer_proc_done()
 #endif
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 9c259ce..2732890 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -5,7 +5,8 @@ snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
 snd-hda-codec-y := hda_bind.o hda_codec.o hda_jack.o hda_auto_parser.o hda_sysfs.o
 snd-hda-codec-y += hda_controller.o
-snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
+snd-hda-codec-$(CONFIG_SND_PROC_FS) += hda_proc.o
+
 snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 
diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 0e6d753..c746cd9 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -448,7 +448,7 @@ void snd_hdmi_show_eld(struct hda_codec *codec, struct parsed_hdmi_eld *e)
 		hdmi_show_short_audio_desc(codec, e->sad + i);
 }
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 
 static void hdmi_print_sad_info(int i, struct cea_sad *a,
 				struct snd_info_buffer *buffer)
@@ -586,7 +586,7 @@ void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
 		}
 	}
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_SND_PROC_FS */
 
 /* update PCM info based on ELD */
 void snd_hdmi_eld_update_pcm_info(struct parsed_hdmi_eld *e,
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 3b567f4..be7c66d 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -330,7 +330,7 @@ int snd_hda_multi_out_analog_cleanup(struct hda_codec *codec,
 /*
  * generic proc interface
  */
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 int snd_hda_codec_proc_new(struct hda_codec *codec);
 #else
 static inline int snd_hda_codec_proc_new(struct hda_codec *codec) { return 0; }
@@ -777,7 +777,7 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 			 unsigned char *buf, int *eld_size,
 			 bool rev3_or_later);
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 void snd_hdmi_print_eld_info(struct hdmi_eld *eld,
 			     struct snd_info_buffer *buffer);
 void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ef8a562..73c20c0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -86,7 +86,7 @@ struct hdmi_spec_per_pin {
 	bool non_pcm;
 	bool chmap_set;		/* channel-map override by ALSA API? */
 	unsigned char chmap[8]; /* ALSA API channel-map */
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 	struct snd_info_entry *proc_entry;
 #endif
 };
@@ -548,7 +548,7 @@ static void hdmi_set_channel_count(struct hda_codec *codec,
  * ELD proc files
  */
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static void print_eld_info(struct snd_info_entry *entry,
 			   struct snd_info_buffer *buffer)
 {
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 43c99ce..054026a 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4337,7 +4337,7 @@ static void stac_shutup(struct hda_codec *codec)
 
 #define stac_free	snd_hda_gen_free
 
-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_SND_PROC_FS
 static void stac92hd_proc_hook(struct snd_info_buffer *buffer,
 			       struct hda_codec *codec, hda_nid_t nid)
 {
-- 
1.9.1
