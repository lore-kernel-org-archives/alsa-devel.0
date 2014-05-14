From: JongHo Kim <furmuwon@gmail.com>
Subject: [Resend] Add the stream report feature. Could you
	review my idea?
Date: Thu, 15 May 2014 01:59:48 +0900
Message-ID: <CANXQt8a_T2ZZ_G6k15ajBpJvcmbQq1=JPn4L8mP3OUT=NZGeew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Abramo Bagnara <abramo@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(Add the alsa-devel@alsa-project.org)

Hi

I am work on ASoC part and developing the smartphone(Android).
we have been doing the stress and long runtime test.
audio output is no problem but I sometimes face
the "playback write error(DMA or IRQ trouble?)" error message.
I know the meaning of the message and I can solve the error.
the problem may be caused by AP(clk) or I2S or DMA or Codec.

I would like to trace the hardware error at the printed message.

Could you review my idea?

Thanks
---
 include/sound/pcm.h     |  2 ++
 include/sound/soc-dai.h |  2 ++
 include/sound/soc.h     |  1 +
 sound/core/pcm_lib.c    |  3 +++
 sound/core/pcm_native.c | 51
+++++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-pcm.c     | 26 +++++++++++++++++++++++++
 6 files changed, 85 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index b4d6697..cd3093a 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -82,6 +82,7 @@ struct snd_pcm_ops {
      unsigned long offset);
  int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct
*vma);
  int (*ack)(struct snd_pcm_substream *substream);
+ void (*report)(struct snd_pcm_substream *substream);
 };

 /*
@@ -502,6 +503,7 @@ int snd_pcm_status(struct snd_pcm_substream *substream,
 int snd_pcm_start(struct snd_pcm_substream *substream);
 int snd_pcm_stop(struct snd_pcm_substream *substream, snd_pcm_state_t
status);
 int snd_pcm_drain_done(struct snd_pcm_substream *substream);
+void snd_pcm_report(struct snd_pcm_substream *substream);
 #ifdef CONFIG_PM
 int snd_pcm_suspend(struct snd_pcm_substream *substream);
 int snd_pcm_suspend_all(struct snd_pcm *pcm);
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index fad7676..c032393 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -184,6 +184,8 @@ struct snd_soc_dai_ops {
  struct snd_soc_dai *);
  int (*bespoke_trigger)(struct snd_pcm_substream *, int,
  struct snd_soc_dai *);
+ void (*report)(struct snd_pcm_substream *,
+ struct snd_soc_dai *);
  /*
  * For hardware based FIFO caused delay reporting.
  * Optional.
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0b83168..7685839 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -641,6 +641,7 @@ struct snd_soc_ops {
  int (*hw_free)(struct snd_pcm_substream *);
  int (*prepare)(struct snd_pcm_substream *);
  int (*trigger)(struct snd_pcm_substream *, int);
+ void (*report)(struct snd_pcm_substream *);
 };

 struct snd_soc_compr_ops {
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index ce83def..0d6c9a3 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1944,6 +1944,9 @@ static int wait_for_avail(struct snd_pcm_substream
*substream,
  "%s write error (DMA or IRQ trouble?)\n",
  is_playback ? "playback" : "capture");
  err = -EIO;
+ snd_pcm_stream_unlock_irq(substream);
+ snd_pcm_report(substream);
+ snd_pcm_stream_lock_irq(substream);
  break;
  }
  }
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index b653ab0..0ccdc10 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -978,6 +978,57 @@ int snd_pcm_drain_done(struct snd_pcm_substream
*substream)
      SNDRV_PCM_STATE_SETUP);
 }

+void snd_pcm_report(struct snd_pcm_substream *substream)
+{
+ struct snd_pcm_runtime *runtime = substream->runtime;
+
+ if (!runtime) {
+ snd_printd("runtime disappear\n");
+ return;
+ }
+
+ mutex_lock(&substream->pcm->open_mutex);
+ snd_printd("access: %i\n", runtime->access);
+ snd_printd("format: %i\n", runtime->format);
+ snd_printd("subformat: %d\n", runtime->subformat);
+ snd_printd("channels: %u\n", runtime->channels);
+ snd_printd("rate: %u (%u/%u)\n", runtime->rate, runtime->rate_num,
+   runtime->rate_den);
+ snd_printd("period_size: %lu\n", runtime->period_size);
+ snd_printd("buffer_size: %lu\n", runtime->buffer_size);
+ snd_printd("tstamp_mode: %i\n", runtime->tstamp_mode);
+ snd_printd("period_step: %u\n", runtime->period_step);
+ snd_printd("avail_min: %lu\n", runtime->control->avail_min);
+ snd_printd("start_threshold: %lu\n", runtime->start_threshold);
+ snd_printd("stop_threshold: %lu\n", runtime->stop_threshold);
+ snd_printd("silence_threshold: %lu\n", runtime->silence_threshold);
+ snd_printd("silence_size: %lu\n", runtime->silence_size);
+ snd_printd("boundary: %lu\n", runtime->boundary);
+ snd_printd("state: %i\n", runtime->status->state);
+ snd_printd("owner_pid: %d\n", pid_vnr(substream->pid));
+ snd_printd("trigger_time: %ld.%09ld\n",
+   runtime->trigger_tstamp.tv_sec,
+   runtime->trigger_tstamp.tv_nsec);
+ snd_printd("tstamp: %ld.%09ld\n",
+   runtime->status->tstamp.tv_sec,
+   runtime->status->tstamp.tv_nsec);
+ snd_printd("delay: %ld\n", runtime->delay);
+ if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+ snd_printd("avail: %ld\n", snd_pcm_playback_avail(runtime));
+ else
+ snd_printd("avail: %ld\n", snd_pcm_capture_avail(runtime));
+ snd_printd("avail_max: %ld\n", runtime->avail_max);
+ snd_printd("hw_ptr: %ld\n", runtime->status->hw_ptr);
+ snd_printd("appl_ptr: %ld\n", runtime->control->appl_ptr);
+
+ mutex_unlock(&substream->pcm->open_mutex);
+
+ if (substream->ops->report)
+ substream->ops->report(substream);
+
+ return;
+}
+
 /*
  * pause callbacks
  */
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2cedf09..98a47b3 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -883,6 +883,30 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct
snd_pcm_substream *substream)
  return offset;
 }

+static void soc_pcm_report(struct snd_pcm_substream *substream)
+{
+ struct snd_soc_pcm_runtime *rtd = substream->private_data;
+ struct snd_soc_platform *platform = rtd->platform;
+ struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+ struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+ mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+ /* report the audio subsystem */
+ if (rtd->dai_link->ops && rtd->dai_link->ops->report)
+ rtd->dai_link->ops->report(substream);
+
+ if (cpu_dai->driver->ops->report)
+ cpu_dai->driver->ops->report(substream, cpu_dai);
+
+ if (platform->driver->ops && platform->driver->ops->report)
+ platform->driver->ops->report(substream);
+
+ if (codec_dai->driver->ops->report)
+ codec_dai->driver->ops->report(substream, codec_dai);
+
+ mutex_unlock(&rtd->pcm_mutex);
+}
+
 /* connect a FE and BE */
 static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
  struct snd_soc_pcm_runtime *be, int stream)
@@ -2267,6 +2291,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int
num)
  rtd->ops.close = dpcm_fe_dai_close;
  rtd->ops.pointer = soc_pcm_pointer;
  rtd->ops.ioctl = soc_pcm_ioctl;
+ rtd->ops.report = soc_pcm_report;
  } else {
  rtd->ops.open = soc_pcm_open;
  rtd->ops.hw_params = soc_pcm_hw_params;
@@ -2276,6 +2301,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int
num)
  rtd->ops.close = soc_pcm_close;
  rtd->ops.pointer = soc_pcm_pointer;
  rtd->ops.ioctl = soc_pcm_ioctl;
+ rtd->ops.report = soc_pcm_report;
  }

  if (platform->driver->ops) {
-- 
1.8.1.2
