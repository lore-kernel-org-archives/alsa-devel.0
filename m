From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH v2 4/7] sound: core: Avoid using timespec for struct snd_timer_status
Date: Thu,  2 Nov 2017 19:06:54 +0800
Message-ID: <9902c3c02cccba879bc9b8359b4af4aadfdcc5c1.1509612176.git.baolin.wang@linaro.org>
References: <cover.1509612175.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509612175.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1509612175.git.baolin.wang@linaro.org>
References: <cover.1509612175.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, arnd@arndb.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, o-takashi@sakamocchi.jp, mingo@kernel.org, elfring@users.sourceforge.net, dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com, subhransu.s.prusty@intel.com, bhumirks@gmail.com, gudishax.kranthikumar@intel.com, naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org
List-Id: alsa-devel@alsa-project.org

The struct snd_timer_status will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Thus thia patch introduces 'struct snd_timer_status32' and 'struct snd_timer_status64'
to handle 32bit time_t and 64bit time_t in native mode, which replace
timespec with s64 type.

In compat mode, this patch renamed the structure as 'struct compat_snd_timer_status32'
to handle 32bit time_t. Moreover we should use 'struct snd_timer_status64'
to handle 64bit time_t no matter 32bit or 64bit alignment, since they have
the same size.

When glibc changes time_t to 64-bit, any recompiled program will issue ioctl
commands that the kernel does not understand without this patch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/core/timer.c        |   62 ++++++++++++++++++++++++++++++++++++++++-----
 sound/core/timer_compat.c |   57 +++++------------------------------------
 2 files changed, 62 insertions(+), 57 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index f44d702..9168365 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -79,6 +79,30 @@ struct snd_timer_user {
 	struct mutex ioctl_lock;
 };
 
+struct snd_timer_status32 {
+	s32 tstamp_sec;			/* Timestamp - last update */
+	s32 tstamp_nsec;
+	unsigned int resolution;	/* current period resolution in ns */
+	unsigned int lost;		/* counter of master tick lost */
+	unsigned int overrun;		/* count of read queue overruns */
+	unsigned int queue;		/* used queue size */
+	unsigned char reserved[64];	/* reserved */
+};
+
+#define SNDRV_TIMER_IOCTL_STATUS32	_IOR('T', 0x14, struct snd_timer_status32)
+
+struct snd_timer_status64 {
+	s64 tstamp_sec;			/* Timestamp - last update */
+	s64 tstamp_nsec;
+	unsigned int resolution;	/* current period resolution in ns */
+	unsigned int lost;		/* counter of master tick lost */
+	unsigned int overrun;		/* count of read queue overruns */
+	unsigned int queue;		/* used queue size */
+	unsigned char reserved[64];	/* reserved */
+};
+
+#define SNDRV_TIMER_IOCTL_STATUS64	_IOR('T', 0x14, struct snd_timer_status64)
+
 /* list of timers */
 static LIST_HEAD(snd_timer_list);
 
@@ -1798,17 +1822,41 @@ static int snd_timer_user_params(struct file *file,
 	return err;
 }
 
-static int snd_timer_user_status(struct file *file,
-				 struct snd_timer_status __user *_status)
+static int snd_timer_user_status32(struct file *file,
+				   struct snd_timer_status32 __user *_status)
+ {
+	struct snd_timer_user *tu;
+	struct snd_timer_status32 status;
+
+	tu = file->private_data;
+	if (!tu->timeri)
+		return -EBADFD;
+	memset(&status, 0, sizeof(status));
+	status.tstamp_sec = tu->tstamp.tv_sec;
+	status.tstamp_nsec = tu->tstamp.tv_nsec;
+	status.resolution = snd_timer_resolution(tu->timeri);
+	status.lost = tu->timeri->lost;
+	status.overrun = tu->overrun;
+	spin_lock_irq(&tu->qlock);
+	status.queue = tu->qused;
+	spin_unlock_irq(&tu->qlock);
+	if (copy_to_user(_status, &status, sizeof(status)))
+		return -EFAULT;
+	return 0;
+}
+
+static int snd_timer_user_status64(struct file *file,
+				   struct snd_timer_status64 __user *_status)
 {
 	struct snd_timer_user *tu;
-	struct snd_timer_status status;
+	struct snd_timer_status64 status;
 
 	tu = file->private_data;
 	if (!tu->timeri)
 		return -EBADFD;
 	memset(&status, 0, sizeof(status));
-	status.tstamp = timespec64_to_timespec(tu->tstamp);
+	status.tstamp_sec = tu->tstamp.tv_sec;
+	status.tstamp_nsec = tu->tstamp.tv_nsec;
 	status.resolution = snd_timer_resolution(tu->timeri);
 	status.lost = tu->timeri->lost;
 	status.overrun = tu->overrun;
@@ -1920,8 +1968,10 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 		return snd_timer_user_info(file, argp);
 	case SNDRV_TIMER_IOCTL_PARAMS:
 		return snd_timer_user_params(file, argp);
-	case SNDRV_TIMER_IOCTL_STATUS:
-		return snd_timer_user_status(file, argp);
+	case SNDRV_TIMER_IOCTL_STATUS32:
+		return snd_timer_user_status32(file, argp);
+	case SNDRV_TIMER_IOCTL_STATUS64:
+		return snd_timer_user_status64(file, argp);
 	case SNDRV_TIMER_IOCTL_START:
 	case SNDRV_TIMER_IOCTL_START_OLD:
 		return snd_timer_user_start(file);
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index 6a437eb..3e09548 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -83,54 +83,11 @@ static int snd_timer_user_info_compat(struct file *file,
 	return 0;
 }
 
-struct snd_timer_status32 {
-	struct compat_timespec tstamp;
-	u32 resolution;
-	u32 lost;
-	u32 overrun;
-	u32 queue;
-	unsigned char reserved[64];
-};
-
-static int snd_timer_user_status_compat(struct file *file,
-					struct snd_timer_status32 __user *_status)
-{
-	struct snd_timer_user *tu;
-	struct snd_timer_status32 status;
-	
-	tu = file->private_data;
-	if (snd_BUG_ON(!tu->timeri))
-		return -ENXIO;
-	memset(&status, 0, sizeof(status));
-	status.tstamp.tv_sec = tu->tstamp.tv_sec;
-	status.tstamp.tv_nsec = tu->tstamp.tv_nsec;
-	status.resolution = snd_timer_resolution(tu->timeri);
-	status.lost = tu->timeri->lost;
-	status.overrun = tu->overrun;
-	spin_lock_irq(&tu->qlock);
-	status.queue = tu->qused;
-	spin_unlock_irq(&tu->qlock);
-	if (copy_to_user(_status, &status, sizeof(status)))
-		return -EFAULT;
-	return 0;
-}
-
-#ifdef CONFIG_X86_X32
-/* X32 ABI has the same struct as x86-64 */
-#define snd_timer_user_status_x32(file, s) \
-	snd_timer_user_status(file, s)
-#endif /* CONFIG_X86_X32 */
-
-/*
- */
-
 enum {
 	SNDRV_TIMER_IOCTL_GPARAMS32 = _IOW('T', 0x04, struct snd_timer_gparams32),
 	SNDRV_TIMER_IOCTL_INFO32 = _IOR('T', 0x11, struct snd_timer_info32),
-	SNDRV_TIMER_IOCTL_STATUS32 = _IOW('T', 0x14, struct snd_timer_status32),
-#ifdef CONFIG_X86_X32
-	SNDRV_TIMER_IOCTL_STATUS_X32 = _IOW('T', 0x14, struct snd_timer_status),
-#endif /* CONFIG_X86_X32 */
+	SNDRV_TIMER_IOCTL_STATUS_COMPAT32 = _IOW('T', 0x14, struct snd_timer_status32),
+	SNDRV_TIMER_IOCTL_STATUS_COMPAT64 = _IOW('T', 0x14, struct snd_timer_status64),
 };
 
 static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -158,12 +115,10 @@ static long snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd, uns
 		return snd_timer_user_gparams_compat(file, argp);
 	case SNDRV_TIMER_IOCTL_INFO32:
 		return snd_timer_user_info_compat(file, argp);
-	case SNDRV_TIMER_IOCTL_STATUS32:
-		return snd_timer_user_status_compat(file, argp);
-#ifdef CONFIG_X86_X32
-	case SNDRV_TIMER_IOCTL_STATUS_X32:
-		return snd_timer_user_status_x32(file, argp);
-#endif /* CONFIG_X86_X32 */
+	case SNDRV_TIMER_IOCTL_STATUS_COMPAT32:
+		return snd_timer_user_status32(file, argp);
+	case SNDRV_TIMER_IOCTL_STATUS_COMPAT64:
+		return snd_timer_user_status64(file, argp);
 	}
 	return -ENOIOCTLCMD;
 }
-- 
1.7.9.5
