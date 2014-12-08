From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 5/9] ALSA: core: selection of audio_tstamp
	type and accuracy reports
Date: Mon,  8 Dec 2014 16:23:42 -0600
Message-ID: <1418077426-8309-6-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AF1A4260568
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 23:24:41 +0100 (CET)
In-Reply-To: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Audio timestamps can be extracted from sample counters, wall clocks,
PHC clocks (Ethernet AVB), on-demand synchronized snapshots. This
patch provides the ability to report timestamping capabilities, select
timestamp types and retrieve timestamp accuracy, if supported.

This functionality is introduced by reclaiming the reserved_aligned
field introduced by commit9c7066aef4a5eb8e4063de28f06c508bf6f2963a
in snd_pcm_status to provide userspace with selection/query capabilities.

snd_pcm_mmap_status remains a read-only structure with only
the audio timestamp value accessible from user space. The selection
of audio timestamp type is done through snd_pcm_status only

This commit does not impact ABI and does not impact the default
behavior. By default audio timestamp is aligned with hw_pointer and
reports the DMA position

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/sound/alsa/timestamping.txt | 171 ++++++++++++++++++++++++++++++
 include/sound/pcm.h                       |  44 ++++++++
 include/uapi/sound/asound.h               |  20 +++-
 3 files changed, 232 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/sound/alsa/timestamping.txt

diff --git a/Documentation/sound/alsa/timestamping.txt b/Documentation/sound/alsa/timestamping.txt
new file mode 100644
index 0000000..d3170ba
--- /dev/null
+++ b/Documentation/sound/alsa/timestamping.txt
@@ -0,0 +1,171 @@
+The ALSA API can provide two different system timestamps:
+
+- Trigger_tstamp is the system time snapshot taken when the .trigger
+callback is invoked. This snapshot is taken by the ALSA core in the
+general case, but specific hardware may have synchronization
+capabilities or conversely may only be able to provide a correct
+estimate with a delay. In the latter two cases, the low-level driver
+is responsible for updating the trigger_tstamp at the most appropriate
+and precise moment. Applications should not rely solely on the first
+trigger_tstamp but update their internal calculations if the driver
+provides a refined estimate with a delay.
+
+- tstamp is the current system timestamp updated during the last
+event or application query.
+The difference (tstamp - trigger_tstamp) defines the elapsed time.
+
+The ALSA API provides reports two basic pieces of information, avail
+and delay, which combined with the trigger and current system
+timestamps allow for applications to keep track of the 'fullness' of
+the ring buffer and the amount of queued samples.
+
+The use of these different pointers and time information depends on
+the application needs:
+
+- 'avail' reports how much can be written in the ring buffer
+- 'delay' reports the time it will take to hear a new sample after all
+queued samples have been played out.
+
+When timestamps are enabled, the avail/delay information is reported
+along with a snapshot of system time. Applications can select from
+CLOCK_REALTIME (NTP corrections including going backwards),
+CLOCK_MONOTONIC (NTP corrections but never going backwards),
+CLOCK_MONOTIC_RAW (without NTP corrections) and change the mode
+dynamically with sw_params
+
+
+The ALSA API also provide an audio_tstamp which reflects the passage
+of time as measured by different components of audio hardware.  In
+ascii-art, this could be represented as follows (for the playback
+case):
+
+
+--------------------------------------------------------------> time
+  ^               ^              ^                ^           ^
+  |               |              |                |           |
+ analog         link            dma              app       FullBuffer
+ time           time           time              time        time
+  |               |              |                |           |
+  |< codec delay >|<--hw delay-->|<queued samples>|<---avail->|
+  |<----------------- delay---------------------->|           |
+			         |<----ring buffer length---->|
+
+The analog time is taken at the last stage of the playback, as close
+as possible to the actual transducer
+
+The link time is taken at the output of the SOC/chipset as the samples
+are pushed on a link. The link time can be directly measured if
+supported in hardware by sample counters or wallclocks (e.g. with
+HDAudio 24MHz or PTP clock for networked solutions) or indirectly
+estimated (e.g. with the frame counter in USB).
+
+The DMA time is measured using counters - typically the least reliable
+of all measurements due to the bursty natured of DMA transfers.
+
+The app time corresponds to the time tracked by an application after
+writing in the ring buffer.
+
+The application can query what the hardware supports, define which
+audio time it wants reported by selecting the relevant settings in
+audio_tstamp_config fields, get an estimate of the timestamp
+accuracy. It can also request the delay-to-analog be included in the
+measurement. Direct access to the link time is very interesting on
+platforms that provide an embedded DSP; measuring directly the link
+time with dedicated hardware, possibly synchronized with system time,
+removes the need to keep track of internal DSP processing times and
+latency.
+
+In case the application requests an audio tstamp that is not supported
+in hardware/low-level driver, the type is overriden as DEFAULT and the
+timestamp will report the DMA time based on the hw_pointer value.
+
+The audio timestamp accuracy can be returned to user-space, so that
+appropriate decisions are made:
+
+- for dma time (default), the granularity of the transfers can be
+  inferred from the steps between updates and in turn provide
+  information on how much the application pointer can be rewound
+  safely.
+
+- the link time can be used to track long-term drifts between audio
+  and system time using the (tstamp-trigger_tstamp)/audio_tstamp
+  ratio, the precision helps define how much smoothing/low-pass
+  filtering is required. The link time can be either reset on startup
+  or reported as is (the latter being useful to compare progress of
+  different streams - but may require the wallclock to be always
+  running and not wrap-around during idle periods). If supported in
+  hardware, the absolute link time could also be used to define a
+  precise start time (patches WIP)
+
+- including the delay in the audio timestamp may
+  counter-intuitively not increase the precision of timestamps, e.g. if a
+  codec includes variable-latency DSP processing or a chain of
+  hardware components the delay is typically not known with precision.
+
+The accuracy is reported with a mantissa and base10 exponent to cover
+the wide range of precision from 10s of ns to 10s of ms. The exponent is set
+to zero for ns, 3 for us, 6 for ms, 9 for s.
+
+Due to the varied nature of timestamping needs, even for a single
+application, the audio_tstamp_config can be changed dynamically.
+
+Examples of typestamping with HDaudio:
+
+1. DMA timestamp, no compensation for DMA+analog delay
+$ ./audio_time  -p --ts_type=0
+playback: systime: 341121338 nsec, audio time 342000000 nsec, 	systime delta -878662
+playback: systime: 426236663 nsec, audio time 427187500 nsec, 	systime delta -950837
+playback: systime: 597080580 nsec, audio time 598000000 nsec, 	systime delta -919420
+playback: systime: 682059782 nsec, audio time 683020833 nsec, 	systime delta -961051
+playback: systime: 852896415 nsec, audio time 853854166 nsec, 	systime delta -957751
+playback: systime: 937903344 nsec, audio time 938854166 nsec, 	systime delta -950822
+
+2. DMA timestamp, compensation for DMA+analog delay
+$ ./audio_time  -p --ts_type=0 -d
+playback: systime: 341053347 nsec, audio time 341062500 nsec, 	systime delta -9153
+playback: systime: 426072447 nsec, audio time 426062500 nsec, 	systime delta 9947
+playback: systime: 596899518 nsec, audio time 596895833 nsec, 	systime delta 3685
+playback: systime: 681915317 nsec, audio time 681916666 nsec, 	systime delta -1349
+playback: systime: 852741306 nsec, audio time 852750000 nsec, 	systime delta -8694
+
+3. link timestamp, compensation for DMA+analog delay
+$ ./audio_time  -p --ts_type=1 -d
+playback: systime: 341060004 nsec, audio time 341062791 nsec, 	systime delta -2787
+playback: systime: 426242074 nsec, audio time 426244875 nsec, 	systime delta -2801
+playback: systime: 597080992 nsec, audio time 597084583 nsec, 	systime delta -3591
+playback: systime: 682084512 nsec, audio time 682088291 nsec, 	systime delta -3779
+playback: systime: 852936229 nsec, audio time 852940916 nsec, 	systime delta -4687
+playback: systime: 938107562 nsec, audio time 938112708 nsec, 	systime delta -5146
+
+Example 1 shows that the timestamp at the DMA level is close to 1ms
+ahead of the actual playback time (as a side time this sort of
+measurement can help define rewind safeguards). Compensating for the
+DMA-link delay in example 2 helps remove the hardware buffering abut
+the information is still very jittery, with up to one sample of
+error. In example 3 where the timestamps are measured with the link
+wallclock, the timestamps show a monotonic behavior and a lower
+dispersion.
+
+Example 3 and 4 are with USB audio class. Example 3 shows a high
+offset between audio time and system time due to buffering. Example 4
+shows how compensating for the delay exposes a 1ms accuracy (due to
+the use of the frame counter by the driver)
+
+Example 3: DMA timestamp, no compensation for delay, delta of ~5ms
+$ ./audio_time -p -Dhw:1 -t0
+playback: systime: 120174019 nsec, audio time 125000000 nsec, 	systime delta -4825981
+playback: systime: 245041136 nsec, audio time 250000000 nsec, 	systime delta -4958864
+playback: systime: 370106088 nsec, audio time 375000000 nsec, 	systime delta -4893912
+playback: systime: 495040065 nsec, audio time 500000000 nsec, 	systime delta -4959935
+playback: systime: 620038179 nsec, audio time 625000000 nsec, 	systime delta -4961821
+playback: systime: 745087741 nsec, audio time 750000000 nsec, 	systime delta -4912259
+playback: systime: 870037336 nsec, audio time 875000000 nsec, 	systime delta -4962664
+
+Example 4: DMA timestamp, compensation for delay, delay of ~1ms
+$ ./audio_time -p -Dhw:1 -t0 -d
+playback: systime: 120190520 nsec, audio time 120000000 nsec, 	systime delta 190520
+playback: systime: 245036740 nsec, audio time 244000000 nsec, 	systime delta 1036740
+playback: systime: 370034081 nsec, audio time 369000000 nsec, 	systime delta 1034081
+playback: systime: 495159907 nsec, audio time 494000000 nsec, 	systime delta 1159907
+playback: systime: 620098824 nsec, audio time 619000000 nsec, 	systime delta 1098824
+playback: systime: 745031847 nsec, audio time 744000000 nsec, 	systime delta 1031847
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 83c669f..2bd7914 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -60,6 +60,9 @@ struct snd_pcm_hardware {
 
 struct snd_pcm_substream;
 
+struct snd_pcm_audio_tstamp_config; /* definitions further down */
+struct snd_pcm_audio_tstamp_report;
+
 struct snd_pcm_ops {
 	int (*open)(struct snd_pcm_substream *substream);
 	int (*close)(struct snd_pcm_substream *substream);
@@ -277,6 +280,43 @@ struct snd_pcm_hw_constraint_list {
 
 struct snd_pcm_hwptr_log;
 
+/* user space provides config to kernel */
+struct snd_pcm_audio_tstamp_config {
+	__u32 type_requested:4;
+	__u32 report_delay:1; /* add total delay to A/D or D/A */
+};
+
+static inline void snd_pcm_unpack_audio_tstamp_config(__u32 data,
+						struct snd_pcm_audio_tstamp_config *config)
+{
+	config->type_requested = data & 0xFF;
+	config->report_delay = (data >> 4) & 1;
+}
+
+/* kernel provides report to user-space */
+struct snd_pcm_audio_tstamp_report {
+	/* actual type if hardware could not support requested timestamp */
+	__u32 actual_type:4;
+
+	/* accuracy represented in mantissa/exponent form */
+	__u32 accuracy_report:1; /* 0 if accuracy unknown, 1 if rest of structure is valid */
+	__u32 accuracy_m:7; /* 0..127, ~3 significant digit for mantissa */
+	__u32 accuracy_e:4; /* base10 exponent, 0 for ns, 3 for us, 6 for ms, 9 for s */
+};
+
+static inline void snd_pcm_pack_audio_tstamp_report(__u32 *data,
+						struct snd_pcm_audio_tstamp_report *report)
+{
+	*data = report->accuracy_e;
+	*data <<= 7;
+	*data |= report->accuracy_m;
+	*data <<= 1;
+	*data |= report->accuracy_report;
+	*data <<= 4;
+	*data |= report->actual_type;
+}
+
+
 struct snd_pcm_runtime {
 	/* -- Status -- */
 	struct snd_pcm_substream *trigger_master;
@@ -358,6 +398,10 @@ struct snd_pcm_runtime {
 
 	struct snd_dma_buffer *dma_buffer_p;	/* allocated buffer */
 
+	/* -- audio timestamp config -- */
+	struct snd_pcm_audio_tstamp_config audio_tstamp_config;
+	struct snd_pcm_audio_tstamp_report audio_tstamp_report;
+
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
 	/* -- OSS things -- */
 	struct snd_pcm_oss_runtime oss;
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 941d32f..b89ad01 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -266,7 +266,12 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
 #define SNDRV_PCM_INFO_NO_PERIOD_WAKEUP	0x00800000	/* period wakeup can be disabled */
-#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* has audio wall clock for audio/system time sync */
+
+#define SNDRV_PCM_INFO_HAS_LINK_ATIME   0x01000000      /* report hardware link audio time, reset on startup */
+#define SNDRV_PCM_INFO_HAS_LINK_ABSOLUTE_ATIME    0x02000000  /* report absolute hardware link audio time, not reset on startup */
+#define SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME    0x04000000  /* report estimated link audio time */
+#define SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME 0x08000000  /* report synchronized audio/system time */
+#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   SNDRV_PCM_INFO_HAS_LINK_ATIME /* deprecated, use LINK_ATIME */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
 typedef int __bitwise snd_pcm_state_t;
@@ -406,6 +411,15 @@ struct snd_pcm_channel_info {
 	unsigned int step;		/* samples distance in bits */
 };
 
+enum {
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT = 0,           /* DMA time, reported as per hw_ptr */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK = 1,	           /* link time reported by sample or wallclock counter, reset on startup */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ABSOLUTE = 2,	   /* link time reported by sample or wallclock counter, not reset on startup */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ESTIMATED = 3,    /* link time estimated indirectly */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED = 4, /* link time synchronized with system time */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED
+};
+
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
 	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
@@ -417,8 +431,8 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
-	__u32 reserved_alignment;	/* must be filled with zero */
-	struct timespec audio_tstamp;	/* from sample counter or wall clock */
+	__u32 audio_tstamp_data;	 /* needed for 64-bit alignment, used for configs/report to/from userspace */
+	struct timespec audio_tstamp;	/* sample counter, wall clock, PHC or on-demand sync'ed */
 	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
 };
 
-- 
2.1.0
