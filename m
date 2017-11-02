From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH v2 6/7] sound: core: Avoid using timespec for struct snd_pcm_sync_ptr
Date: Thu,  2 Nov 2017 19:06:56 +0800
Message-ID: <090460a6a5c77d266ec119afbc216ff47ba62f38.1509612176.git.baolin.wang@linaro.org>
References: <cover.1509612175.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509612175.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1509612175.git.baolin.wang@linaro.org>
References: <cover.1509612175.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, arnd@arndb.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, o-takashi@sakamocchi.jp, mingo@kernel.org, elfring@users.sourceforge.net, dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com, subhransu.s.prusty@intel.com, bhumirks@gmail.com, gudishax.kranthikumar@intel.com, naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org
List-Id: alsa-devel@alsa-project.org

The struct snd_pcm_sync_ptr will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Thus we introduced 'struct snd_pcm_sync_ptr32' and 'struct snd_pcm_sync_ptr64'
to handle 32bit time_t and 64bit time_t in native mode, which replace
timespec with s64 type.

In compat mode, we renamed or introduced new structures to handle 32bit/64bit
time_t in compatible mode. The 'struct compat_snd_pcm_sync_ptr32' and
snd_pcm_ioctl_sync_ptr_compat() are used to handle 32bit time_t in compat mode.
'struct compat_snd_pcm_sync_ptr64' and snd_pcm_ioctl_sync_ptr_compat64() are used
to handle 64bit time_t with 64bit alignment. 'struct compat_snd_pcm_sync_ptr64_x86_32'
and snd_pcm_ioctl_sync_ptr_compat64_x86_32() are used to handle 64bit time_t with
32bit alignment.

When glibc changes time_t to 64bit, any recompiled program will issue ioctl
commands that the kernel does not understand without this patch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/sound/pcm.h     |   51 ++++++++++-
 sound/core/pcm.c        |    8 +-
 sound/core/pcm_compat.c |  233 ++++++++++++++++++++++++++++++++++++-----------
 sound/core/pcm_lib.c    |    9 +-
 sound/core/pcm_native.c |  122 +++++++++++++++++++------
 5 files changed, 336 insertions(+), 87 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 7524b54..b23b4f5 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -64,6 +64,18 @@ struct snd_pcm_hardware {
 struct snd_pcm_audio_tstamp_config; /* definitions further down */
 struct snd_pcm_audio_tstamp_report;
 
+struct snd_pcm_mmap_status64 {
+	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
+	int pad1;			/* Needed for 64 bit alignment */
+	u64 hw_ptr;			/* RO: hw ptr (0...boundary-1) */
+	s64 tstamp_sec;			/* Timestamp */
+	s64 tstamp_nsec;
+	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
+	u32 pad3;
+	s64 audio_tstamp_sec;		/* from sample counter or wall clock */
+	s64 audio_tstamp_nsec;
+};
+
 struct snd_pcm_ops {
 	int (*open)(struct snd_pcm_substream *substream);
 	int (*close)(struct snd_pcm_substream *substream);
@@ -389,7 +401,7 @@ struct snd_pcm_runtime {
 	union snd_pcm_sync_id sync;	/* hardware synchronization ID */
 
 	/* -- mmap -- */
-	struct snd_pcm_mmap_status *status;
+	struct snd_pcm_mmap_status64 *status;
 	struct snd_pcm_mmap_control *control;
 
 	/* -- locking / scheduling -- */
@@ -1463,8 +1475,32 @@ struct snd_pcm_status64 {
 	unsigned char reserved[52-4*sizeof(s64)]; /* must be filled with zero */
 };
 
+struct snd_pcm_sync_ptr64 {
+	unsigned int flags;
+	union {
+		struct snd_pcm_mmap_status64 status;
+		unsigned char reserved[64];
+	} s;
+	union {
+		struct snd_pcm_mmap_control control;
+		unsigned char reserved[64];
+	} c;
+};
+
+struct snd_pcm_mmap_status32 {
+	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
+	int pad1;			/* Needed for 64 bit alignment */
+	u32 hw_ptr;			/* RO: hw ptr (0...boundary-1) */
+	s32 tstamp_sec;			/* Timestamp */
+	s32 tstamp_nsec;
+	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
+	s32 audio_tstamp_sec;		/* from sample counter or wall clock */
+	s32 audio_tstamp_nsec;
+};
+
 #define SNDRV_PCM_IOCTL_STATUS64	_IOR('A', 0x20, struct snd_pcm_status64)
 #define SNDRV_PCM_IOCTL_STATUS_EXT64	_IOWR('A', 0x24, struct snd_pcm_status64)
+#define SNDRV_PCM_IOCTL_SYNC_PTR64	_IOWR('A', 0x23, struct snd_pcm_sync_ptr64)
 
 #if __BITS_PER_LONG == 32
 struct snd_pcm_status32 {
@@ -1489,8 +1525,21 @@ struct snd_pcm_status32 {
 	unsigned char reserved[52-4*sizeof(s32)]; /* must be filled with zero */
 };
 
+struct snd_pcm_sync_ptr32 {
+	unsigned int flags;
+	union {
+		struct snd_pcm_mmap_status32 status;
+		unsigned char reserved[64];
+	} s;
+	union {
+		struct snd_pcm_mmap_control control;
+		unsigned char reserved[64];
+	} c;
+};
+
 #define SNDRV_PCM_IOCTL_STATUS32	_IOR('A', 0x20, struct snd_pcm_status32)
 #define SNDRV_PCM_IOCTL_STATUS_EXT32	_IOWR('A', 0x24, struct snd_pcm_status32)
+#define SNDRV_PCM_IOCTL_SYNC_PTR32	_IOWR('A', 0x23, struct snd_pcm_sync_ptr32)
 #endif
 
 #endif /* __SOUND_PCM_H */
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index c19e656..3c27e68 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -478,7 +478,7 @@ static void snd_pcm_substream_proc_status_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "avail       : %ld\n", status.avail);
 	snd_iprintf(buffer, "avail_max   : %ld\n", status.avail_max);
 	snd_iprintf(buffer, "-----\n");
-	snd_iprintf(buffer, "hw_ptr      : %ld\n", runtime->status->hw_ptr);
+	snd_iprintf(buffer, "hw_ptr      : %lld\n", runtime->status->hw_ptr);
 	snd_iprintf(buffer, "appl_ptr    : %ld\n", runtime->control->appl_ptr);
  unlock:
 	mutex_unlock(&substream->pcm->open_mutex);
@@ -1001,7 +1001,7 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	if (runtime == NULL)
 		return -ENOMEM;
 
-	size = PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status));
+	size = PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status64));
 	runtime->status = snd_malloc_pages(size, GFP_KERNEL);
 	if (runtime->status == NULL) {
 		kfree(runtime);
@@ -1013,7 +1013,7 @@ int snd_pcm_attach_substream(struct snd_pcm *pcm, int stream,
 	runtime->control = snd_malloc_pages(size, GFP_KERNEL);
 	if (runtime->control == NULL) {
 		snd_free_pages((void*)runtime->status,
-			       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
+			       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status64)));
 		kfree(runtime);
 		return -ENOMEM;
 	}
@@ -1044,7 +1044,7 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 	if (runtime->private_free != NULL)
 		runtime->private_free(runtime);
 	snd_free_pages((void*)runtime->status,
-		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)));
+		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status64)));
 	snd_free_pages((void*)runtime->control,
 		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control)));
 	kfree(runtime->hw_constraints.rules);
diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 53b83d4..885aefb 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -557,42 +557,33 @@ static int snd_pcm_ioctl_xfern_compat(struct snd_pcm_substream *substream,
 	return err;
 }
 
-
-struct snd_pcm_mmap_status32 {
-	s32 state;
-	s32 pad1;
-	u32 hw_ptr;
-	struct compat_timespec tstamp;
-	s32 suspended_state;
-	struct compat_timespec audio_tstamp;
-} __attribute__((packed));
-
-struct snd_pcm_mmap_control32 {
+struct compat_snd_pcm_mmap_control32 {
 	u32 appl_ptr;
 	u32 avail_min;
 };
 
-struct snd_pcm_sync_ptr32 {
+struct compat_snd_pcm_sync_ptr32 {
 	u32 flags;
 	union {
 		struct snd_pcm_mmap_status32 status;
 		unsigned char reserved[64];
 	} s;
 	union {
-		struct snd_pcm_mmap_control32 control;
+		struct compat_snd_pcm_mmap_control32 control;
 		unsigned char reserved[64];
 	} c;
 } __attribute__((packed));
 
 static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
-					 struct snd_pcm_sync_ptr32 __user *src)
+					 struct compat_snd_pcm_sync_ptr32 __user *src)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	volatile struct snd_pcm_mmap_status *status;
+	volatile struct snd_pcm_mmap_status64 *status;
 	volatile struct snd_pcm_mmap_control *control;
 	u32 sflags;
 	struct snd_pcm_mmap_control scontrol;
-	struct snd_pcm_mmap_status sstatus;
+	struct snd_pcm_mmap_status64 sstatus;
+	struct compat_snd_pcm_sync_ptr32 sync_ptr;
 	snd_pcm_uframes_t boundary;
 	int err;
 
@@ -625,63 +616,76 @@ static int snd_pcm_ioctl_sync_ptr_compat(struct snd_pcm_substream *substream,
 		scontrol.avail_min = control->avail_min;
 	sstatus.state = status->state;
 	sstatus.hw_ptr = status->hw_ptr % boundary;
-	sstatus.tstamp = status->tstamp;
+	sstatus.tstamp_sec = status->tstamp_sec;
+	sstatus.tstamp_nsec = status->tstamp_nsec;
 	sstatus.suspended_state = status->suspended_state;
-	sstatus.audio_tstamp = status->audio_tstamp;
+	sstatus.audio_tstamp_sec = status->audio_tstamp_sec;
+	sstatus.audio_tstamp_nsec = status->audio_tstamp_nsec;
 	snd_pcm_stream_unlock_irq(substream);
-	if (put_user(sstatus.state, &src->s.status.state) ||
-	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
-	    compat_put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
-	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
-	    compat_put_timespec(&sstatus.audio_tstamp,
-		    &src->s.status.audio_tstamp) ||
-	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
-	    put_user(scontrol.avail_min, &src->c.control.avail_min))
+
+	memset(&sync_ptr, 0, sizeof(sync_ptr));
+	sync_ptr.s.status = (struct snd_pcm_mmap_status32) {
+		.state = sstatus.state,
+		.hw_ptr = sstatus.hw_ptr,
+		.tstamp_sec = sstatus.tstamp_sec,
+		.tstamp_nsec = sstatus.tstamp_nsec,
+		.suspended_state = sstatus.suspended_state,
+		.audio_tstamp_sec = sstatus.audio_tstamp_sec,
+		.audio_tstamp_nsec = sstatus.audio_tstamp_nsec,
+	};
+
+	sync_ptr.c.control = (struct compat_snd_pcm_mmap_control32) {
+		.appl_ptr = scontrol.appl_ptr,
+		.avail_min = scontrol.avail_min,
+	};
+
+	if (copy_to_user(src, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
 
 	return 0;
 }
 
-#ifdef CONFIG_X86_X32
-/* X32 ABI has 64bit timespec and 64bit alignment */
-struct snd_pcm_mmap_status_x32 {
+struct compat_snd_pcm_mmap_status64 {
 	s32 state;
 	s32 pad1;
 	u32 hw_ptr;
 	u32 pad2; /* alignment */
-	struct timespec tstamp;
+	s64 tstamp_sec;
+	s64 tstamp_nsec;
 	s32 suspended_state;
 	s32 pad3;
-	struct timespec audio_tstamp;
+	s64 audio_tstamp_sec;
+	s64 audio_tstamp_nsec;
 } __packed;
 
-struct snd_pcm_mmap_control_x32 {
+struct compat_snd_pcm_mmap_control64 {
 	u32 appl_ptr;
 	u32 avail_min;
 };
 
-struct snd_pcm_sync_ptr_x32 {
+struct compat_snd_pcm_sync_ptr64 {
 	u32 flags;
 	u32 rsvd; /* alignment */
 	union {
-		struct snd_pcm_mmap_status_x32 status;
+		struct compat_snd_pcm_mmap_status64 status;
 		unsigned char reserved[64];
 	} s;
 	union {
-		struct snd_pcm_mmap_control_x32 control;
+		struct compat_snd_pcm_mmap_control64 control;
 		unsigned char reserved[64];
 	} c;
 } __packed;
 
-static int snd_pcm_ioctl_sync_ptr_x32(struct snd_pcm_substream *substream,
-				      struct snd_pcm_sync_ptr_x32 __user *src)
+static int snd_pcm_ioctl_sync_ptr_compat64(struct snd_pcm_substream *substream,
+				struct compat_snd_pcm_sync_ptr64 __user *src)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	volatile struct snd_pcm_mmap_status *status;
+	volatile struct snd_pcm_mmap_status64 *status;
 	volatile struct snd_pcm_mmap_control *control;
 	u32 sflags;
 	struct snd_pcm_mmap_control scontrol;
-	struct snd_pcm_mmap_status sstatus;
+	struct snd_pcm_mmap_status64 sstatus;
+	struct compat_snd_pcm_sync_ptr64 sync_ptr;
 	snd_pcm_uframes_t boundary;
 	int err;
 
@@ -714,22 +718,136 @@ static int snd_pcm_ioctl_sync_ptr_x32(struct snd_pcm_substream *substream,
 		scontrol.avail_min = control->avail_min;
 	sstatus.state = status->state;
 	sstatus.hw_ptr = status->hw_ptr % boundary;
-	sstatus.tstamp = status->tstamp;
+	sstatus.tstamp_sec = status->tstamp_sec;
+	sstatus.tstamp_nsec = status->tstamp_nsec;
 	sstatus.suspended_state = status->suspended_state;
-	sstatus.audio_tstamp = status->audio_tstamp;
+	sstatus.audio_tstamp_sec = status->audio_tstamp_sec;
+	sstatus.audio_tstamp_nsec = status->audio_tstamp_nsec;
 	snd_pcm_stream_unlock_irq(substream);
-	if (put_user(sstatus.state, &src->s.status.state) ||
-	    put_user(sstatus.hw_ptr, &src->s.status.hw_ptr) ||
-	    put_timespec(&sstatus.tstamp, &src->s.status.tstamp) ||
-	    put_user(sstatus.suspended_state, &src->s.status.suspended_state) ||
-	    put_timespec(&sstatus.audio_tstamp, &src->s.status.audio_tstamp) ||
-	    put_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
-	    put_user(scontrol.avail_min, &src->c.control.avail_min))
+
+	memset(&sync_ptr, 0, sizeof(sync_ptr));
+	sync_ptr.s.status = (struct compat_snd_pcm_mmap_status64) {
+		.state = sstatus.state,
+		.hw_ptr = sstatus.hw_ptr,
+		.tstamp_sec = sstatus.tstamp_sec,
+		.tstamp_nsec = sstatus.tstamp_nsec,
+		.suspended_state = sstatus.suspended_state,
+		.audio_tstamp_sec = sstatus.audio_tstamp_sec,
+		.audio_tstamp_nsec = sstatus.audio_tstamp_nsec,
+	};
+
+	sync_ptr.c.control = (struct compat_snd_pcm_mmap_control64) {
+		.appl_ptr = scontrol.appl_ptr,
+		.avail_min = scontrol.avail_min,
+	};
+
+	if (copy_to_user(src, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
 
 	return 0;
 }
-#endif /* CONFIG_X86_X32 */
+
+#ifdef IA32_EMULATION
+struct compat_snd_pcm_mmap_status64_x86_32 {
+	s32 state;
+	s32 pad1;
+	u32 hw_ptr;
+	s64 tstamp_sec;
+	s64 tstamp_nsec;
+	s32 suspended_state;
+	s64 audio_tstamp_sec;
+	s64 audio_tstamp_nsec;
+} __packed;
+
+struct compat_snd_pcm_mmap_control64_x86_32 {
+	u32 appl_ptr;
+	u32 avail_min;
+};
+
+struct compat_snd_pcm_sync_ptr64_x86_32 {
+	u32 flags;
+	union {
+		struct compat_snd_pcm_mmap_status64_x86_32 status;
+		unsigned char reserved[64];
+	} s;
+	union {
+		struct compat_snd_pcm_mmap_control64_x86_32 control;
+		unsigned char reserved[64];
+	} c;
+} __packed;
+
+static int
+snd_pcm_ioctl_sync_ptr_compat64_x86_32(struct snd_pcm_substream *substream,
+			struct compat_snd_pcm_sync_ptr64_x86_32 __user *src)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	volatile struct snd_pcm_mmap_status64 *status;
+	volatile struct snd_pcm_mmap_control *control;
+	u32 sflags;
+	struct snd_pcm_mmap_control scontrol;
+	struct snd_pcm_mmap_status64 sstatus;
+	struct compat_snd_pcm_sync_ptr64_x86_32 sync_ptr;
+	snd_pcm_uframes_t boundary;
+	int err;
+
+	if (snd_BUG_ON(!runtime))
+		return -EINVAL;
+
+	if (get_user(sflags, &src->flags) ||
+	    get_user(scontrol.appl_ptr, &src->c.control.appl_ptr) ||
+	    get_user(scontrol.avail_min, &src->c.control.avail_min))
+		return -EFAULT;
+	if (sflags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
+		err = snd_pcm_hwsync(substream);
+		if (err < 0)
+			return err;
+	}
+	status = runtime->status;
+	control = runtime->control;
+	boundary = recalculate_boundary(runtime);
+	if (!boundary)
+		boundary = 0x7fffffff;
+	snd_pcm_stream_lock_irq(substream);
+	/* FIXME: we should consider the boundary for the sync from app */
+	if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL))
+		control->appl_ptr = scontrol.appl_ptr;
+	else
+		scontrol.appl_ptr = control->appl_ptr % boundary;
+	if (!(sflags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
+		control->avail_min = scontrol.avail_min;
+	else
+		scontrol.avail_min = control->avail_min;
+	sstatus.state = status->state;
+	sstatus.hw_ptr = status->hw_ptr % boundary;
+	sstatus.tstamp_sec = status->tstamp_sec;
+	sstatus.tstamp_nsec = status->tstamp_nsec;
+	sstatus.suspended_state = status->suspended_state;
+	sstatus.audio_tstamp_sec = status->audio_tstamp_sec;
+	sstatus.audio_tstamp_nsec = status->audio_tstamp_nsec;
+	snd_pcm_stream_unlock_irq(substream);
+
+	memset(&sync_ptr, 0, sizeof(sync_ptr));
+	sync_ptr.s.status = (struct compat_snd_pcm_mmap_status64_x86_32) {
+		.state = sstatus.state,
+		.hw_ptr = sstatus.hw_ptr,
+		.tstamp_sec = sstatus.tstamp_sec,
+		.tstamp_nsec = sstatus.tstamp_nsec,
+		.suspended_state = sstatus.suspended_state,
+		.audio_tstamp_sec = sstatus.audio_tstamp_sec,
+		.audio_tstamp_nsec = sstatus.audio_tstamp_nsec,
+	};
+
+	sync_ptr.c.control = (struct compat_snd_pcm_mmap_control64_x86_32) {
+		.appl_ptr = scontrol.appl_ptr,
+		.avail_min = scontrol.avail_min,
+	};
+
+	if (copy_to_user(src, &sync_ptr, sizeof(sync_ptr)))
+		return -EFAULT;
+
+	return 0;
+}
+#endif
 
 /*
  */
@@ -747,12 +865,14 @@ enum {
 	SNDRV_PCM_IOCTL_READI_FRAMES32 = _IOR('A', 0x51, struct snd_xferi32),
 	SNDRV_PCM_IOCTL_WRITEN_FRAMES32 = _IOW('A', 0x52, struct snd_xfern32),
 	SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct snd_xfern32),
-	SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct snd_pcm_sync_ptr32),
+	SNDRV_PCM_IOCTL_SYNC_PTR_COMPAT32 = _IOWR('A', 0x23, struct compat_snd_pcm_sync_ptr32),
+	SNDRV_PCM_IOCTL_SYNC_PTR_COMPAT64 = _IOWR('A', 0x23, struct compat_snd_pcm_sync_ptr64),
 	SNDRV_PCM_IOCTL_STATUS_COMPAT64 = _IOR('A', 0x20, struct compat_snd_pcm_status64),
 	SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64 = _IOWR('A', 0x24, struct compat_snd_pcm_status64),
 #ifdef IA32_EMULATION
 	SNDRV_PCM_IOCTL_STATUS_COMPAT64_X86_32 = _IOR('A', 0x20, struct compat_snd_pcm_status64_x86_32),
 	SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64_X86_32 = _IOWR('A', 0x24, struct compat_snd_pcm_status64_x86_32),
+	SNDRV_PCM_IOCTL_SYNC_PTR_COMPAT64_X86_32 = _IOWR('A', 0x23, struct compat_snd_pcm_sync_ptr64_x86_32),
 #endif
 #ifdef CONFIG_X86_X32
 	SNDRV_PCM_IOCTL_CHANNEL_INFO_X32 = _IOR('A', 0x32, struct snd_pcm_channel_info),
@@ -809,8 +929,17 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
 		return snd_pcm_status_user_compat(substream, argp, false);
 	case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT32:
 		return snd_pcm_status_user_compat(substream, argp, true);
-	case SNDRV_PCM_IOCTL_SYNC_PTR32:
-		return snd_pcm_ioctl_sync_ptr_compat(substream, argp);
+	case SNDRV_PCM_IOCTL_SYNC_PTR_COMPAT32:
+	{
+		if (sizeof(__kernel_long_t) == sizeof(time_t))
+			return snd_pcm_ioctl_sync_ptr_compat(substream, argp);
+#ifdef IA32_EMULATION
+		else
+			return snd_pcm_ioctl_sync_ptr_compat64_x86_32(substream, argp);
+#endif
+	}
+	case SNDRV_PCM_IOCTL_SYNC_PTR_COMPAT64:
+		return snd_pcm_ioctl_sync_ptr_compat64(substream, argp);
 	case SNDRV_PCM_IOCTL_CHANNEL_INFO32:
 		return snd_pcm_ioctl_channel_info_compat(substream, argp);
 	case SNDRV_PCM_IOCTL_WRITEI_FRAMES32:
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 5ca9dc3..f3e5d43 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -162,7 +162,8 @@ static void xrun(struct snd_pcm_substream *substream)
 		struct timespec64 tstamp;
 
 		snd_pcm_gettime(runtime, &tstamp);
-		runtime->status->tstamp = timespec64_to_timespec(tstamp);
+		runtime->status->tstamp_sec = tstamp.tv_sec;
+		runtime->status->tstamp_nsec = tstamp.tv_nsec;
 	}
 	snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
 	if (xrun_debug(substream, XRUN_DEBUG_BASIC)) {
@@ -252,8 +253,10 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
 				runtime->rate);
 		*audio_tstamp = ns_to_timespec64(audio_nsecs);
 	}
-	runtime->status->audio_tstamp = timespec64_to_timespec(*audio_tstamp);
-	runtime->status->tstamp = timespec64_to_timespec(*curr_tstamp);
+	runtime->status->audio_tstamp_sec = audio_tstamp->tv_sec;
+	runtime->status->audio_tstamp_nsec = audio_tstamp->tv_nsec;
+	runtime->status->tstamp_sec = curr_tstamp->tv_sec;
+	runtime->status->tstamp_nsec = curr_tstamp->tv_nsec;
 
 	/*
 	 * re-take a driver timestamp to let apps detect if the reference tstamp
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 7a70848..6063522 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -886,17 +886,17 @@ int snd_pcm_status64(struct snd_pcm_substream *substream,
 	if (snd_pcm_running(substream)) {
 		snd_pcm_update_hw_ptr(substream);
 		if (runtime->tstamp_mode == SNDRV_PCM_TSTAMP_ENABLE) {
-			status->tstamp_sec = runtime->status->tstamp.tv_sec;
+			status->tstamp_sec = runtime->status->tstamp_sec;
 			status->tstamp_nsec =
-				runtime->status->tstamp.tv_nsec;
+				runtime->status->tstamp_nsec;
 			status->driver_tstamp_sec =
 				runtime->driver_tstamp.tv_sec;
 			status->driver_tstamp_nsec =
 				runtime->driver_tstamp.tv_nsec;
 			status->audio_tstamp_sec =
-				runtime->status->audio_tstamp.tv_sec;
+				runtime->status->audio_tstamp_sec;
 			status->audio_tstamp_nsec =
-				runtime->status->audio_tstamp.tv_nsec;
+				runtime->status->audio_tstamp_nsec;
 			if (runtime->audio_tstamp_report.valid == 1)
 				/* backwards compatibility, no report provided in COMPAT mode */
 				snd_pcm_pack_audio_tstamp_report(&status->audio_tstamp_data,
@@ -2766,50 +2766,109 @@ static snd_pcm_sframes_t snd_pcm_delay(struct snd_pcm_substream *substream)
 	snd_pcm_stream_unlock_irq(substream);
 	return err < 0 ? err : n;
 }
-		
+
 static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
-			    struct snd_pcm_sync_ptr __user *_sync_ptr)
+			    struct snd_pcm_sync_ptr64 *sync_ptr)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_pcm_sync_ptr sync_ptr;
-	volatile struct snd_pcm_mmap_status *status;
+	volatile struct snd_pcm_mmap_status64 *status;
 	volatile struct snd_pcm_mmap_control *control;
 	int err;
 
-	memset(&sync_ptr, 0, sizeof(sync_ptr));
-	if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
-		return -EFAULT;
-	if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control), sizeof(struct snd_pcm_mmap_control)))
-		return -EFAULT;	
 	status = runtime->status;
 	control = runtime->control;
-	if (sync_ptr.flags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
+	if (sync_ptr->flags & SNDRV_PCM_SYNC_PTR_HWSYNC) {
 		err = snd_pcm_hwsync(substream);
 		if (err < 0)
 			return err;
 	}
 	snd_pcm_stream_lock_irq(substream);
-	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
+	if (!(sync_ptr->flags & SNDRV_PCM_SYNC_PTR_APPL)) {
 		err = pcm_lib_apply_appl_ptr(substream,
-					     sync_ptr.c.control.appl_ptr);
+					     sync_ptr->c.control.appl_ptr);
 		if (err < 0) {
 			snd_pcm_stream_unlock_irq(substream);
 			return err;
 		}
 	} else {
-		sync_ptr.c.control.appl_ptr = control->appl_ptr;
+		sync_ptr->c.control.appl_ptr = control->appl_ptr;
 	}
-	if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
-		control->avail_min = sync_ptr.c.control.avail_min;
+	if (!(sync_ptr->flags & SNDRV_PCM_SYNC_PTR_AVAIL_MIN))
+		control->avail_min = sync_ptr->c.control.avail_min;
 	else
-		sync_ptr.c.control.avail_min = control->avail_min;
-	sync_ptr.s.status.state = status->state;
-	sync_ptr.s.status.hw_ptr = status->hw_ptr;
-	sync_ptr.s.status.tstamp = status->tstamp;
-	sync_ptr.s.status.suspended_state = status->suspended_state;
+		sync_ptr->c.control.avail_min = control->avail_min;
+	sync_ptr->s.status.state = status->state;
+	sync_ptr->s.status.hw_ptr = status->hw_ptr;
+	sync_ptr->s.status.tstamp_sec = status->tstamp_sec;
+	sync_ptr->s.status.tstamp_nsec = status->tstamp_nsec;
+	sync_ptr->s.status.suspended_state = status->suspended_state;
 	snd_pcm_stream_unlock_irq(substream);
+
+	return 0;
+}
+
+#if __BITS_PER_LONG == 32
+static int snd_pcm_sync_ptr32(struct snd_pcm_substream *substream,
+			      struct snd_pcm_sync_ptr32 __user *_sync_ptr)
+{
+	struct snd_pcm_sync_ptr64 sync_ptr64;
+	struct snd_pcm_sync_ptr32 sync_ptr32;
+	int ret;
+
+	memset(&sync_ptr64, 0, sizeof(sync_ptr64));
+	memset(&sync_ptr32, 0, sizeof(sync_ptr32));
+	if (get_user(sync_ptr64.flags, (unsigned __user *)&(_sync_ptr->flags)))
+		return -EFAULT;
+	if (copy_from_user(&sync_ptr64.c.control, &(_sync_ptr->c.control),
+			   sizeof(struct snd_pcm_mmap_control)))
+		return -EFAULT;
+
+	ret = snd_pcm_sync_ptr(substream, &sync_ptr64);
+	if (ret)
+		return ret;
+
+	sync_ptr32.s.status = (struct snd_pcm_mmap_status32) {
+		.state = sync_ptr64.s.status.state,
+		.hw_ptr = sync_ptr64.s.status.hw_ptr,
+		.tstamp_sec = sync_ptr64.s.status.tstamp_sec,
+		.tstamp_nsec = sync_ptr64.s.status.tstamp_nsec,
+		.suspended_state = sync_ptr64.s.status.suspended_state,
+		.audio_tstamp_sec = sync_ptr64.s.status.audio_tstamp_sec,
+		.audio_tstamp_nsec = sync_ptr64.s.status.audio_tstamp_nsec,
+	};
+
+	sync_ptr32.c.control = (struct snd_pcm_mmap_control) {
+		.appl_ptr = sync_ptr64.c.control.appl_ptr,
+		.avail_min = sync_ptr64.c.control.avail_min,
+	};
+
+	if (copy_to_user(_sync_ptr, &sync_ptr32, sizeof(sync_ptr32)))
+		return -EFAULT;
+
+	return 0;
+}
+#endif
+
+static int snd_pcm_sync_ptr64(struct snd_pcm_substream *substream,
+			      struct snd_pcm_sync_ptr64 __user *_sync_ptr)
+{
+	struct snd_pcm_sync_ptr64 sync_ptr;
+	int ret;
+
+	memset(&sync_ptr, 0, sizeof(sync_ptr));
+	if (get_user(sync_ptr.flags, (unsigned __user *)&(_sync_ptr->flags)))
+		return -EFAULT;
+	if (copy_from_user(&sync_ptr.c.control, &(_sync_ptr->c.control),
+			   sizeof(struct snd_pcm_mmap_control)))
+		return -EFAULT;
+
+	ret = snd_pcm_sync_ptr(substream, &sync_ptr);
+	if (ret)
+		return ret;
+
 	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
+
 	return 0;
 }
 
@@ -2987,8 +3046,17 @@ static int snd_pcm_common_ioctl(struct file *file,
 			return -EFAULT;
 		return 0;
 	}
-	case SNDRV_PCM_IOCTL_SYNC_PTR:
-		return snd_pcm_sync_ptr(substream, arg);
+	case SNDRV_PCM_IOCTL_SYNC_PTR64:
+	{
+#if __BITS_PER_LONG == 64
+		return snd_pcm_sync_ptr64(substream, arg);
+#else
+		if (sizeof(__kernel_long_t) == sizeof(time_t))
+			return snd_pcm_sync_ptr32(substream, arg);
+		else
+			return snd_pcm_sync_ptr64(substream, arg);
+#endif
+	}
 #ifdef CONFIG_SND_SUPPORT_OLD_API
 	case SNDRV_PCM_IOCTL_HW_REFINE_OLD:
 		return snd_pcm_hw_refine_old_user(substream, arg);
@@ -3321,7 +3389,7 @@ static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file
 	if (!(area->vm_flags & VM_READ))
 		return -EINVAL;
 	size = area->vm_end - area->vm_start;
-	if (size != PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status)))
+	if (size != PAGE_ALIGN(sizeof(struct snd_pcm_mmap_status64)))
 		return -EINVAL;
 	area->vm_ops = &snd_pcm_vm_ops_status;
 	area->vm_private_data = substream;
-- 
1.7.9.5
