From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v5 05/10] ALSA: core: selection of audio_tstamp
	type and accuracy reports
Date: Fri,  6 Feb 2015 15:55:54 -0600
Message-ID: <1423259759-4100-6-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1423259759-4100-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DD63D265363
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 22:56:21 +0100 (CET)
In-Reply-To: <1423259759-4100-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Details can be found in Documentations/sound/alsa/timestamping.txt

This functionality is introduced by reclaiming the reserved_aligned
field introduced by commit9c7066aef4a5eb8e4063de28f06c508bf6f2963a
in snd_pcm_status to provide userspace with selection/query capabilities.
Additional driver_tstamp and audio_tstamp_accuracy fields are also added.

snd_pcm_mmap_status remains a read-only structure with only
the audio timestamp value accessible from user space. The selection
of audio timestamp type is done through snd_pcm_status only

This commit does not impact ABI and does not impact the default
behavior. By default audio timestamp is aligned with hw_pointer and
reports the DMA position. Backwards compatibility is handled by using
the HDAudio wall clock for playback and the hw_ptr for all other
cases.

For timestamp selection a new STATUS_EXT ioctl is introduced with
read/write parameters. Alsa-lib will be modified to make use of
STATUS_EXT.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/sound/alsa/timestamping.txt | 200 ++++++++++++++++++++++++++++++
 include/sound/pcm.h                       |  59 +++++++++
 include/uapi/sound/asound.h               |  34 ++++-
 3 files changed, 289 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/sound/alsa/timestamping.txt

diff --git a/Documentation/sound/alsa/timestamping.txt b/Documentation/sound/alsa/timestamping.txt
new file mode 100644
index 0000000..0b191a2
--- /dev/null
+++ b/Documentation/sound/alsa/timestamping.txt
@@ -0,0 +1,200 @@
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
+in hardware/low-level driver, the type is overridden as DEFAULT and the
+timestamp will report the DMA time based on the hw_pointer value.
+
+For backwards compatibility with previous implementations that did not
+provide timestamp selection, with a zero-valued COMPAT timestamp type
+the results will default to the HDAudio wall clock for playback
+streams and to the DMA time (hw_ptr) in all other cases.
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
+The accuracy is reported in nanosecond units (using an unsigned 32-bit
+word), which gives a max precision of 4.29s, more than enough for
+audio applications...
+
+Due to the varied nature of timestamping needs, even for a single
+application, the audio_tstamp_config can be changed dynamically. In
+the STATUS ioctl, the parameters are read-only and do not allow for
+any application selection. To work around this limitation without
+impacting legacy applications, a new STATUS_EXT ioctl is introduced
+with read/write parameters. ALSA-lib will be modified to make use of
+STATUS_EXT and effectively deprecate STATUS.
+
+The ALSA API only allows for a single audio timestamp to be reported
+at a time. This is a conscious design decision, reading the audio
+timestamps from hardware registers or from IPC takes time, the more
+timestamps are read the more imprecise the combined measurements
+are. To avoid any interpretation issues, a single (system, audio)
+timestamp is reported. Applications that need different timestamps
+will be required to issue multiple queries and perform an
+interpolation of the results
+
+In some hardware-specific configuration, the system timestamp is
+latched by a low-level audio subsytem, and the information provided
+back to the driver. Due to potential delays in the communication with
+the hardware, there is a risk of misalignment with the avail and delay
+information. To make sure applications are not confused, a
+driver_timestamp field is added in the snd_pcm_status structure; this
+timestamp shows when the information is put together by the driver
+before returning from the STATUS and STATUS_EXT ioctl. in most cases
+this driver_timestamp will be identical to the regular system tstamp.
+
+Examples of typestamping with HDaudio:
+
+1. DMA timestamp, no compensation for DMA+analog delay
+$ ./audio_time  -p --ts_type=1
+playback: systime: 341121338 nsec, audio time 342000000 nsec, 	systime delta -878662
+playback: systime: 426236663 nsec, audio time 427187500 nsec, 	systime delta -950837
+playback: systime: 597080580 nsec, audio time 598000000 nsec, 	systime delta -919420
+playback: systime: 682059782 nsec, audio time 683020833 nsec, 	systime delta -961051
+playback: systime: 852896415 nsec, audio time 853854166 nsec, 	systime delta -957751
+playback: systime: 937903344 nsec, audio time 938854166 nsec, 	systime delta -950822
+
+2. DMA timestamp, compensation for DMA+analog delay
+$ ./audio_time  -p --ts_type=1 -d
+playback: systime: 341053347 nsec, audio time 341062500 nsec, 	systime delta -9153
+playback: systime: 426072447 nsec, audio time 426062500 nsec, 	systime delta 9947
+playback: systime: 596899518 nsec, audio time 596895833 nsec, 	systime delta 3685
+playback: systime: 681915317 nsec, audio time 681916666 nsec, 	systime delta -1349
+playback: systime: 852741306 nsec, audio time 852750000 nsec, 	systime delta -8694
+
+3. link timestamp, compensation for DMA+analog delay
+$ ./audio_time  -p --ts_type=2 -d
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
+$ ./audio_time -p -Dhw:1 -t1
+playback: systime: 120174019 nsec, audio time 125000000 nsec, 	systime delta -4825981
+playback: systime: 245041136 nsec, audio time 250000000 nsec, 	systime delta -4958864
+playback: systime: 370106088 nsec, audio time 375000000 nsec, 	systime delta -4893912
+playback: systime: 495040065 nsec, audio time 500000000 nsec, 	systime delta -4959935
+playback: systime: 620038179 nsec, audio time 625000000 nsec, 	systime delta -4961821
+playback: systime: 745087741 nsec, audio time 750000000 nsec, 	systime delta -4912259
+playback: systime: 870037336 nsec, audio time 875000000 nsec, 	systime delta -4962664
+
+Example 4: DMA timestamp, compensation for delay, delay of ~1ms
+$ ./audio_time -p -Dhw:1 -t1 -d
+playback: systime: 120190520 nsec, audio time 120000000 nsec, 	systime delta 190520
+playback: systime: 245036740 nsec, audio time 244000000 nsec, 	systime delta 1036740
+playback: systime: 370034081 nsec, audio time 369000000 nsec, 	systime delta 1034081
+playback: systime: 495159907 nsec, audio time 494000000 nsec, 	systime delta 1159907
+playback: systime: 620098824 nsec, audio time 619000000 nsec, 	systime delta 1098824
+playback: systime: 745031847 nsec, audio time 744000000 nsec, 	systime delta 1031847
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e158036..05ad56a 100644
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
@@ -275,6 +278,57 @@ struct snd_pcm_hw_constraint_list {
 
 struct snd_pcm_hwptr_log;
 
+/*
+ * userspace-provided audio timestamp config to kernel,
+ * structure is for internal use only and filled with dedicated unpack routine
+ */
+struct snd_pcm_audio_tstamp_config {
+	/* 5 of max 16 bits used */
+	u32 type_requested:4;
+	u32 report_delay:1; /* add total delay to A/D or D/A */
+};
+
+static inline void snd_pcm_unpack_audio_tstamp_config(__u32 data,
+						struct snd_pcm_audio_tstamp_config *config)
+{
+	config->type_requested = data & 0xF;
+	config->report_delay = (data >> 4) & 1;
+}
+
+/*
+ * kernel-provided audio timestamp report to user-space
+ * structure is for internal use only and read by dedicated pack routine
+ */
+struct snd_pcm_audio_tstamp_report {
+	/* 6 of max 16 bits used for bit-fields */
+
+	/* for backwards compatibility */
+	u32 valid:1;
+
+	/* actual type if hardware could not support requested timestamp */
+	u32 actual_type:4;
+
+	/* accuracy represented in ns units */
+	u32 accuracy_report:1; /* 0 if accuracy unknown, 1 if accuracy field is valid */
+	u32 accuracy; /* up to 4.29s, will be packed in separate field  */
+};
+
+static inline void snd_pcm_pack_audio_tstamp_report(__u32 *data, __u32 *accuracy,
+						struct snd_pcm_audio_tstamp_report *report)
+{
+	u32 tmp;
+
+	tmp = report->accuracy_report;
+	tmp <<= 4;
+	tmp |= report->actual_type;
+	tmp <<= 1;
+	tmp |= report->valid;
+
+	*data |= (tmp << 16);
+	*accuracy = report->accuracy;
+}
+
+
 struct snd_pcm_runtime {
 	/* -- Status -- */
 	struct snd_pcm_substream *trigger_master;
@@ -355,6 +409,11 @@ struct snd_pcm_runtime {
 
 	struct snd_dma_buffer *dma_buffer_p;	/* allocated buffer */
 
+	/* -- audio timestamp config -- */
+	struct snd_pcm_audio_tstamp_config audio_tstamp_config;
+	struct snd_pcm_audio_tstamp_report audio_tstamp_report;
+	struct timespec driver_tstamp;
+
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
 	/* -- OSS things -- */
 	struct snd_pcm_oss_runtime oss;
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 0e88e7a..acef4e4 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -267,10 +267,17 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
 #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
 #define SNDRV_PCM_INFO_NO_PERIOD_WAKEUP	0x00800000	/* period wakeup can be disabled */
-#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* has audio wall clock for audio/system time sync */
+#define SNDRV_PCM_INFO_HAS_WALL_CLOCK   0x01000000      /* (Deprecated)has audio wall clock for audio/system time sync */
+#define SNDRV_PCM_INFO_HAS_LINK_ATIME              0x01000000  /* report hardware link audio time, reset on startup */
+#define SNDRV_PCM_INFO_HAS_LINK_ABSOLUTE_ATIME     0x02000000  /* report absolute hardware link audio time, not reset on startup */
+#define SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME    0x04000000  /* report estimated link audio time */
+#define SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME 0x08000000  /* report synchronized audio/system time */
+
 #define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
+
+
 typedef int __bitwise snd_pcm_state_t;
 #define	SNDRV_PCM_STATE_OPEN		((__force snd_pcm_state_t) 0) /* stream is open */
 #define	SNDRV_PCM_STATE_SETUP		((__force snd_pcm_state_t) 1) /* stream has a setup */
@@ -408,6 +415,22 @@ struct snd_pcm_channel_info {
 	unsigned int step;		/* samples distance in bits */
 };
 
+enum {
+	/*
+	 *  first definition for backwards compatibility only,
+	 *  maps to wallclock/link time for HDAudio playback and DEFAULT/DMA time for everything else
+	 */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_COMPAT = 0,
+
+	/* timestamp definitions */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_DEFAULT = 1,           /* DMA time, reported as per hw_ptr */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK = 2,	           /* link time reported by sample or wallclock counter, reset on startup */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ABSOLUTE = 3,	   /* link time reported by sample or wallclock counter, not reset on startup */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_ESTIMATED = 4,    /* link time estimated indirectly */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED = 5, /* link time synchronized with system time */
+	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED
+};
+
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
 	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
@@ -419,9 +442,11 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
-	__u32 reserved_alignment;	/* must be filled with zero */
-	struct timespec audio_tstamp;	/* from sample counter or wall clock */
-	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
+	__u32 audio_tstamp_data;	 /* needed for 64-bit alignment, used for configs/report to/from userspace */
+	struct timespec audio_tstamp;	/* sample counter, wall clock, PHC or on-demand sync'ed */
+	struct timespec driver_tstamp;	/* useful in case reference system tstamp is reported with delay */
+	__u32 audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
+	unsigned char reserved[52-2*sizeof(struct timespec)]; /* must be filled with zero */
 };
 
 struct snd_pcm_mmap_status {
@@ -534,6 +559,7 @@ enum {
 #define SNDRV_PCM_IOCTL_DELAY		_IOR('A', 0x21, snd_pcm_sframes_t)
 #define SNDRV_PCM_IOCTL_HWSYNC		_IO('A', 0x22)
 #define SNDRV_PCM_IOCTL_SYNC_PTR	_IOWR('A', 0x23, struct snd_pcm_sync_ptr)
+#define SNDRV_PCM_IOCTL_STATUS_EXT	_IOWR('A', 0x24, struct snd_pcm_status)
 #define SNDRV_PCM_IOCTL_CHANNEL_INFO	_IOR('A', 0x32, struct snd_pcm_channel_info)
 #define SNDRV_PCM_IOCTL_PREPARE		_IO('A', 0x40)
 #define SNDRV_PCM_IOCTL_RESET		_IO('A', 0x41)
-- 
1.9.1
