From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: [PATCH] sound: core: move exports next to corresponding symbols
Date: Tue,  2 May 2017 23:58:34 +0200
Message-ID: <20170502215834.19455-1-kirkseraph@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, o-takashi@sakamocchi.jp, linux-kernel@vger.kernel.org, Seraphime Kirkovski <kirkseraph@gmail.com>
List-Id: alsa-devel@alsa-project.org

With this patch all files in sound/core export symbols next to
their definition, as the kernel coding style mandates.

Signed-off-by: Seraphime Kirkovski <kirkseraph@gmail.com>
---
 sound/core/memalloc.c           | 14 ++++----------
 sound/core/seq/seq_midi_emul.c  |  9 ++++-----
 sound/core/seq/seq_midi_event.c | 21 ++++++++-------------
 sound/core/timer.c              | 27 +++++++++++++--------------
 4 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index f05cb6a8cbe0..207de142ee3d 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -54,6 +54,7 @@ void *snd_malloc_pages(size_t size, gfp_t gfp_flags)
 	pg = get_order(size);
 	return (void *) __get_free_pages(gfp_flags, pg);
 }
+EXPORT_SYMBOL(snd_malloc_pages);
 
 /**
  * snd_free_pages - release the pages
@@ -71,6 +72,7 @@ void snd_free_pages(void *ptr, size_t size)
 	pg = get_order(size);
 	free_pages((unsigned long) ptr, pg);
 }
+EXPORT_SYMBOL(snd_free_pages);
 
 /*
  *
@@ -217,6 +219,7 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
 	dmab->bytes = size;
 	return 0;
 }
+EXPORT_SYMBOL(snd_dma_alloc_pages);
 
 /**
  * snd_dma_alloc_pages_fallback - allocate the buffer area according to the given type with fallback
@@ -254,7 +257,7 @@ int snd_dma_alloc_pages_fallback(int type, struct device *device, size_t size,
 		return -ENOMEM;
 	return 0;
 }
-
+EXPORT_SYMBOL(snd_dma_alloc_pages_fallback);
 
 /**
  * snd_dma_free_pages - release the allocated buffer
@@ -287,13 +290,4 @@ void snd_dma_free_pages(struct snd_dma_buffer *dmab)
 		pr_err("snd-malloc: invalid device type %d\n", dmab->dev.type);
 	}
 }
-
-/*
- * exports
- */
-EXPORT_SYMBOL(snd_dma_alloc_pages);
-EXPORT_SYMBOL(snd_dma_alloc_pages_fallback);
 EXPORT_SYMBOL(snd_dma_free_pages);
-
-EXPORT_SYMBOL(snd_malloc_pages);
-EXPORT_SYMBOL(snd_free_pages);
diff --git a/sound/core/seq/seq_midi_emul.c b/sound/core/seq/seq_midi_emul.c
index 7ba937399ac7..9e2912e3e80f 100644
--- a/sound/core/seq/seq_midi_emul.c
+++ b/sound/core/seq/seq_midi_emul.c
@@ -236,6 +236,7 @@ snd_midi_process_event(struct snd_midi_op *ops,
 		break;
 	}
 }
+EXPORT_SYMBOL(snd_midi_process_event);
 
 
 /*
@@ -409,6 +410,7 @@ snd_midi_channel_set_clear(struct snd_midi_channel_set *chset)
 			chan->drum_channel = 0;
 	}
 }
+EXPORT_SYMBOL(snd_midi_channel_set_clear);
 
 /*
  * Process a rpn message.
@@ -701,6 +703,7 @@ struct snd_midi_channel_set *snd_midi_channel_alloc_set(int n)
 	}
 	return chset;
 }
+EXPORT_SYMBOL(snd_midi_channel_alloc_set);
 
 /*
  * Reset the midi controllers on a particular channel to default values.
@@ -724,6 +727,7 @@ void snd_midi_channel_free_set(struct snd_midi_channel_set *chset)
 	kfree(chset->channels);
 	kfree(chset);
 }
+EXPORT_SYMBOL(snd_midi_channel_free_set);
 
 static int __init alsa_seq_midi_emul_init(void)
 {
@@ -736,8 +740,3 @@ static void __exit alsa_seq_midi_emul_exit(void)
 
 module_init(alsa_seq_midi_emul_init)
 module_exit(alsa_seq_midi_emul_exit)
-
-EXPORT_SYMBOL(snd_midi_process_event);
-EXPORT_SYMBOL(snd_midi_channel_set_clear);
-EXPORT_SYMBOL(snd_midi_channel_alloc_set);
-EXPORT_SYMBOL(snd_midi_channel_free_set);
diff --git a/sound/core/seq/seq_midi_event.c b/sound/core/seq/seq_midi_event.c
index 37db7ba492a6..90bbbdbeba03 100644
--- a/sound/core/seq/seq_midi_event.c
+++ b/sound/core/seq/seq_midi_event.c
@@ -134,6 +134,7 @@ int snd_midi_event_new(int bufsize, struct snd_midi_event **rdev)
 	*rdev = dev;
 	return 0;
 }
+EXPORT_SYMBOL(snd_midi_event_new);
 
 void snd_midi_event_free(struct snd_midi_event *dev)
 {
@@ -142,6 +143,7 @@ void snd_midi_event_free(struct snd_midi_event *dev)
 		kfree(dev);
 	}
 }
+EXPORT_SYMBOL(snd_midi_event_free);
 
 /*
  * initialize record
@@ -161,6 +163,7 @@ void snd_midi_event_reset_encode(struct snd_midi_event *dev)
 	reset_encode(dev);
 	spin_unlock_irqrestore(&dev->lock, flags);
 }
+EXPORT_SYMBOL(snd_midi_event_reset_encode);
 
 void snd_midi_event_reset_decode(struct snd_midi_event *dev)
 {
@@ -170,6 +173,7 @@ void snd_midi_event_reset_decode(struct snd_midi_event *dev)
 	dev->lastcmd = 0xff;
 	spin_unlock_irqrestore(&dev->lock, flags);
 }
+EXPORT_SYMBOL(snd_midi_event_reset_decode);
 
 #if 0
 void snd_midi_event_init(struct snd_midi_event *dev)
@@ -183,6 +187,7 @@ void snd_midi_event_no_status(struct snd_midi_event *dev, int on)
 {
 	dev->nostat = on ? 1 : 0;
 }
+EXPORT_SYMBOL(snd_midi_event_no_status);
 
 /*
  * resize buffer
@@ -232,6 +237,7 @@ long snd_midi_event_encode(struct snd_midi_event *dev, unsigned char *buf, long
 
 	return result;
 }
+EXPORT_SYMBOL(snd_midi_event_encode);
 
 /*
  *  read one byte and encode to sequencer event:
@@ -307,6 +313,7 @@ int snd_midi_event_encode_byte(struct snd_midi_event *dev, int c,
 	spin_unlock_irqrestore(&dev->lock, flags);
 	return rc;
 }
+EXPORT_SYMBOL(snd_midi_event_encode_byte);
 
 /* encode note event */
 static void note_event(struct snd_midi_event *dev, struct snd_seq_event *ev)
@@ -408,6 +415,7 @@ long snd_midi_event_decode(struct snd_midi_event *dev, unsigned char *buf, long
 		return qlen;
 	}
 }
+EXPORT_SYMBOL(snd_midi_event_decode);
 
 
 /* decode note event */
@@ -524,19 +532,6 @@ static int extra_decode_xrpn(struct snd_midi_event *dev, unsigned char *buf,
 	return idx;
 }
 
-/*
- *  exports
- */
- 
-EXPORT_SYMBOL(snd_midi_event_new);
-EXPORT_SYMBOL(snd_midi_event_free);
-EXPORT_SYMBOL(snd_midi_event_reset_encode);
-EXPORT_SYMBOL(snd_midi_event_reset_decode);
-EXPORT_SYMBOL(snd_midi_event_no_status);
-EXPORT_SYMBOL(snd_midi_event_encode);
-EXPORT_SYMBOL(snd_midi_event_encode_byte);
-EXPORT_SYMBOL(snd_midi_event_decode);
-
 static int __init alsa_seq_midi_event_init(void)
 {
 	return 0;
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6d4fbc439246..f7fb15790d0a 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -319,6 +319,7 @@ int snd_timer_open(struct snd_timer_instance **ti,
 	*ti = timeri;
 	return 0;
 }
+EXPORT_SYMBOL(snd_timer_open);
 
 /*
  * close a timer instance
@@ -384,6 +385,7 @@ int snd_timer_close(struct snd_timer_instance *timeri)
 	mutex_unlock(&register_mutex);
 	return 0;
 }
+EXPORT_SYMBOL(snd_timer_close);
 
 unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 {
@@ -398,6 +400,7 @@ unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(snd_timer_resolution);
 
 static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 {
@@ -589,6 +592,7 @@ int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks)
 	else
 		return snd_timer_start1(timeri, true, ticks);
 }
+EXPORT_SYMBOL(snd_timer_start);
 
 /*
  * stop the timer instance.
@@ -602,6 +606,7 @@ int snd_timer_stop(struct snd_timer_instance *timeri)
 	else
 		return snd_timer_stop1(timeri, true);
 }
+EXPORT_SYMBOL(snd_timer_stop);
 
 /*
  * start again..  the tick is kept.
@@ -617,6 +622,7 @@ int snd_timer_continue(struct snd_timer_instance *timeri)
 	else
 		return snd_timer_start1(timeri, false, 0);
 }
+EXPORT_SYMBOL(snd_timer_continue);
 
 /*
  * pause.. remember the ticks left
@@ -628,6 +634,7 @@ int snd_timer_pause(struct snd_timer_instance * timeri)
 	else
 		return snd_timer_stop1(timeri, false);
 }
+EXPORT_SYMBOL(snd_timer_pause);
 
 /*
  * reschedule the timer
@@ -809,6 +816,7 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
 	if (use_tasklet)
 		tasklet_schedule(&timer->task_queue);
 }
+EXPORT_SYMBOL(snd_timer_interrupt);
 
 /*
 
@@ -859,6 +867,7 @@ int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid,
 		*rtimer = timer;
 	return 0;
 }
+EXPORT_SYMBOL(snd_timer_new);
 
 static int snd_timer_free(struct snd_timer *timer)
 {
@@ -978,6 +987,7 @@ void snd_timer_notify(struct snd_timer *timer, int event, struct timespec *tstam
 	}
 	spin_unlock_irqrestore(&timer->lock, flags);
 }
+EXPORT_SYMBOL(snd_timer_notify);
 
 /*
  * exported functions for global timers
@@ -993,11 +1003,13 @@ int snd_timer_global_new(char *id, int device, struct snd_timer **rtimer)
 	tid.subdevice = 0;
 	return snd_timer_new(NULL, id, &tid, rtimer);
 }
+EXPORT_SYMBOL(snd_timer_global_new);
 
 int snd_timer_global_free(struct snd_timer *timer)
 {
 	return snd_timer_free(timer);
 }
+EXPORT_SYMBOL(snd_timer_global_free);
 
 int snd_timer_global_register(struct snd_timer *timer)
 {
@@ -1007,6 +1019,7 @@ int snd_timer_global_register(struct snd_timer *timer)
 	dev.device_data = timer;
 	return snd_timer_dev_register(&dev);
 }
+EXPORT_SYMBOL(snd_timer_global_register);
 
 /*
  *  System timer
@@ -2119,17 +2132,3 @@ static void __exit alsa_timer_exit(void)
 
 module_init(alsa_timer_init)
 module_exit(alsa_timer_exit)
-
-EXPORT_SYMBOL(snd_timer_open);
-EXPORT_SYMBOL(snd_timer_close);
-EXPORT_SYMBOL(snd_timer_resolution);
-EXPORT_SYMBOL(snd_timer_start);
-EXPORT_SYMBOL(snd_timer_stop);
-EXPORT_SYMBOL(snd_timer_continue);
-EXPORT_SYMBOL(snd_timer_pause);
-EXPORT_SYMBOL(snd_timer_new);
-EXPORT_SYMBOL(snd_timer_notify);
-EXPORT_SYMBOL(snd_timer_global_new);
-EXPORT_SYMBOL(snd_timer_global_free);
-EXPORT_SYMBOL(snd_timer_global_register);
-EXPORT_SYMBOL(snd_timer_interrupt);
-- 
2.11.0
