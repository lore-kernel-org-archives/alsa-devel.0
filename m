From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 7/7] sound: core: Avoid using timespec for struct snd_timer_tread
Date: Thu, 21 Sep 2017 14:18:09 +0800
Message-ID: <1091b589bec6317ea686937060c0f9f9db10651a.1505973912.git.baolin.wang@linaro.org>
References: <cover.1505973912.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1505973912.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1505973912.git.baolin.wang@linaro.org>
References: <cover.1505973912.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, mingo@kernel.org, o-takashi@sakamocchi.jp, elfring@users.sourceforge.net, dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com, dharageswari.r@intel.com, guneshwor.o.singh@intel.com, bhumirks@gmail.com, gudishax.kranthikumar@intel.com, naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be, arnd@arndb.de, broonie@kernel.org, deepa.kernel@gmail.com, baolin.wang@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The struct snd_timer_tread will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Since the struct snd_timer_tread is passed through read() rather than
ioctl(), and the read syscall has no command number that lets us pick
between the 32-bit or 64-bit version of this structure.

Thus we introduced one new command SNDRV_TIMER_IOCTL_TREAD64 and new
struct snd_timer_tread64 replacing timespec with s64 type to handle
64bit time_t. Also add one struct compat_snd_timer_tread64_x86_32 to
handle 64bit time_t with 32bit alignment. That means we will set
tu->tread = 2 when user space has a 64bit time_t, then we will copy
to user with struct snd_timer_tread64. For x86_32 mode, we will set
tu->tread = 3 to copy struct compat_snd_timer_tread64_x86_32 for user.
Otherwise we will use 32bit time_t variables when copying to user.

Moreover this patch replaces timespec type with timespec64 type and
related y2038 safe APIs.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/uapi/sound/asound.h |   11 ++-
 sound/core/timer.c          |  163 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 142 insertions(+), 32 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 71bce52..ef738bf 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -760,7 +760,7 @@ struct snd_timer_status {
 
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
-#define SNDRV_TIMER_IOCTL_TREAD		_IOW('T', 0x02, int)
+#define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
 #define SNDRV_TIMER_IOCTL_GINFO		_IOWR('T', 0x03, struct snd_timer_ginfo)
 #define SNDRV_TIMER_IOCTL_GPARAMS	_IOW('T', 0x04, struct snd_timer_gparams)
 #define SNDRV_TIMER_IOCTL_GSTATUS	_IOWR('T', 0x05, struct snd_timer_gstatus)
@@ -773,6 +773,15 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_STOP		_IO('T', 0xa1)
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
+#define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+
+#if __BITS_PER_LONG == 64
+#define SNDRV_TIMER_IOCTL_TREAD SNDRV_TIMER_IOCTL_TREAD_OLD
+#else
+#define SNDRV_TIMER_IOCTL_TREAD ((sizeof(__kernel_long_t) > sizeof(time_t)) ? \
+				 SNDRV_TIMER_IOCTL_TREAD_OLD : \
+				 SNDRV_TIMER_IOCTL_TREAD64)
+#endif
 
 struct snd_timer_read {
 	unsigned int resolution;
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 376b7e6..c33a1be 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -58,6 +58,22 @@
 MODULE_ALIAS_CHARDEV(CONFIG_SND_MAJOR, SNDRV_MINOR_TIMER);
 MODULE_ALIAS("devname:snd/timer");
 
+struct snd_timer_tread64 {
+	int event;
+	u32 pad1;
+	struct { s64 tv_sec; s64 tv_nsec; } tstamp;
+	unsigned int val;
+	u32 pad2;
+};
+
+#ifdef IA32_EMULATION
+struct compat_snd_timer_tread64_x86_32 {
+	int event;
+	struct { s64 tv_sec; s64 tv_nsec; } tstamp;
+	unsigned int val;
+} __packed;
+#endif
+
 struct snd_timer_user {
 	struct snd_timer_instance *timeri;
 	int tread;		/* enhanced read with timestamps and events */
@@ -69,7 +85,7 @@ struct snd_timer_user {
 	int queue_size;
 	bool disconnected;
 	struct snd_timer_read *queue;
-	struct snd_timer_tread *tqueue;
+	struct snd_timer_tread64 *tqueue;
 	spinlock_t qlock;
 	unsigned long last_resolution;
 	unsigned int filter;
@@ -1262,7 +1278,7 @@ static void snd_timer_user_interrupt(struct snd_timer_instance *timeri,
 }
 
 static void snd_timer_user_append_to_tqueue(struct snd_timer_user *tu,
-					    struct snd_timer_tread *tread)
+					    struct snd_timer_tread64 *tread)
 {
 	if (tu->qused >= tu->queue_size) {
 		tu->overrun++;
@@ -1279,7 +1295,7 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 				     unsigned long resolution)
 {
 	struct snd_timer_user *tu = timeri->callback_data;
-	struct snd_timer_tread r1;
+	struct snd_timer_tread64 r1;
 	unsigned long flags;
 
 	if (event >= SNDRV_TIMER_EVENT_START &&
@@ -1289,7 +1305,8 @@ static void snd_timer_user_ccallback(struct snd_timer_instance *timeri,
 		return;
 	memset(&r1, 0, sizeof(r1));
 	r1.event = event;
-	r1.tstamp = timespec64_to_timespec(*tstamp);
+	r1.tstamp.tv_sec = tstamp->tv_sec;
+	r1.tstamp.tv_nsec = tstamp->tv_nsec;
 	r1.val = resolution;
 	spin_lock_irqsave(&tu->qlock, flags);
 	snd_timer_user_append_to_tqueue(tu, &r1);
@@ -1311,7 +1328,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 				      unsigned long ticks)
 {
 	struct snd_timer_user *tu = timeri->callback_data;
-	struct snd_timer_tread *r, r1;
+	struct snd_timer_tread64 *r, r1;
 	struct timespec64 tstamp;
 	int prev, append = 0;
 
@@ -1332,7 +1349,8 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 	if ((tu->filter & (1 << SNDRV_TIMER_EVENT_RESOLUTION)) &&
 	    tu->last_resolution != resolution) {
 		r1.event = SNDRV_TIMER_EVENT_RESOLUTION;
-		r1.tstamp = timespec64_to_timespec(tstamp);
+		r1.tstamp.tv_sec = tstamp.tv_sec;
+		r1.tstamp.tv_nsec = tstamp.tv_nsec;
 		r1.val = resolution;
 		snd_timer_user_append_to_tqueue(tu, &r1);
 		tu->last_resolution = resolution;
@@ -1346,14 +1364,16 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 		prev = tu->qtail == 0 ? tu->queue_size - 1 : tu->qtail - 1;
 		r = &tu->tqueue[prev];
 		if (r->event == SNDRV_TIMER_EVENT_TICK) {
-			r->tstamp = timespec64_to_timespec(tstamp);
+			r->tstamp.tv_sec = tstamp.tv_sec;
+			r->tstamp.tv_nsec = tstamp.tv_nsec;
 			r->val += ticks;
 			append++;
 			goto __wake;
 		}
 	}
 	r1.event = SNDRV_TIMER_EVENT_TICK;
-	r1.tstamp = timespec64_to_timespec(tstamp);
+	r1.tstamp.tv_sec = tstamp.tv_sec;
+	r1.tstamp.tv_nsec = tstamp.tv_nsec;
 	r1.val = ticks;
 	snd_timer_user_append_to_tqueue(tu, &r1);
 	append++;
@@ -1368,7 +1388,7 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 static int realloc_user_queue(struct snd_timer_user *tu, int size)
 {
 	struct snd_timer_read *queue = NULL;
-	struct snd_timer_tread *tqueue = NULL;
+	struct snd_timer_tread64 *tqueue = NULL;
 
 	if (tu->tread) {
 		tqueue = kcalloc(size, sizeof(*tqueue), GFP_KERNEL);
@@ -1797,7 +1817,7 @@ static int snd_timer_user_params(struct file *file,
 	tu->qhead = tu->qtail = tu->qused = 0;
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
 		if (tu->tread) {
-			struct snd_timer_tread tread;
+			struct snd_timer_tread64 tread;
 			memset(&tread, 0, sizeof(tread));
 			tread.event = SNDRV_TIMER_EVENT_EARLY;
 			tread.tstamp.tv_sec = 0;
@@ -1921,6 +1941,39 @@ static int snd_timer_user_pause(struct file *file)
 	return (err = snd_timer_pause(tu->timeri)) < 0 ? err : 0;
 }
 
+static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
+				unsigned int cmd)
+{
+	int __user *p = argp;
+	int xarg, old_tread;
+
+	if (tu->timeri)	/* too late */
+		return -EBUSY;
+	if (get_user(xarg, p))
+		return -EFAULT;
+
+	old_tread = tu->tread;
+#if __BITS_PER_LONG == 64
+	tu->tread = xarg ? 2 : 0;
+#ifdef IA32_EMULATION
+	tu->tread = xarg ? 3 : 0;
+#endif
+#else
+	if (cmd == SNDRV_TIMER_IOCTL_TREAD64)
+		tu->tread = xarg ? 2 : 0;
+	else
+		tu->tread = xarg ? 1 : 0;
+#endif
+
+	if (tu->tread != old_tread &&
+	    realloc_user_queue(tu, tu->queue_size) < 0) {
+		tu->tread = old_tread;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 enum {
 	SNDRV_TIMER_IOCTL_START_OLD = _IO('T', 0x20),
 	SNDRV_TIMER_IOCTL_STOP_OLD = _IO('T', 0x21),
@@ -1941,23 +1994,9 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 		return put_user(SNDRV_TIMER_VERSION, p) ? -EFAULT : 0;
 	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
 		return snd_timer_user_next_device(argp);
-	case SNDRV_TIMER_IOCTL_TREAD:
-	{
-		int xarg, old_tread;
-
-		if (tu->timeri)	/* too late */
-			return -EBUSY;
-		if (get_user(xarg, p))
-			return -EFAULT;
-		old_tread = tu->tread;
-		tu->tread = xarg ? 1 : 0;
-		if (tu->tread != old_tread &&
-		    realloc_user_queue(tu, tu->queue_size) < 0) {
-			tu->tread = old_tread;
-			return -ENOMEM;
-		}
-		return 0;
-	}
+	case SNDRV_TIMER_IOCTL_TREAD_OLD:
+	case SNDRV_TIMER_IOCTL_TREAD64:
+		return snd_timer_user_tread(argp, tu, cmd);
 	case SNDRV_TIMER_IOCTL_GINFO:
 		return snd_timer_user_ginfo(file, argp);
 	case SNDRV_TIMER_IOCTL_GPARAMS:
@@ -2021,7 +2060,25 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 	int err = 0;
 
 	tu = file->private_data;
-	unit = tu->tread ? sizeof(struct snd_timer_tread) : sizeof(struct snd_timer_read);
+	switch (tu->tread) {
+#ifdef IA32_EMULATION
+	case 3:
+		unit = sizeof(struct compat_snd_timer_tread64_x86_32);
+		break;
+#endif
+	case 2:
+		unit = sizeof(struct snd_timer_tread64);
+		break;
+	case 1:
+		unit = sizeof(struct snd_timer_tread);
+		break;
+	case 0:
+		unit = sizeof(struct snd_timer_read);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
 	mutex_lock(&tu->ioctl_lock);
 	spin_lock_irq(&tu->qlock);
 	while ((long)count - result >= unit) {
@@ -2061,9 +2118,53 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		spin_unlock_irq(&tu->qlock);
 
 		if (tu->tread) {
-			if (copy_to_user(buffer, &tu->tqueue[qhead],
-					 sizeof(struct snd_timer_tread)))
-				err = -EFAULT;
+			struct snd_timer_tread64 *tread = &tu->tqueue[qhead];
+			struct snd_timer_tread tread32;
+#ifdef IA32_EMULATION
+			struct compat_snd_timer_tread64_x86_32 compat_tread64;
+#endif
+
+			switch (tu->tread) {
+#ifdef IA32_EMULATION
+			case 3:
+				memset(&compat_tread64, 0, sizeof(compat_tread64));
+				compat_tread64 = (struct compat_snd_timer_tread64_x86_32) {
+					.event = tread->event,
+					.tstamp = {
+						.tv_sec = tread->tstamp.tv_sec,
+						.tv_nsec = tread->tstamp.tv_nsec,
+					},
+					.val = tread->val,
+				};
+
+				if (copy_to_user(buffer, &compat_tread64,
+						 sizeof(compat_tread64)))
+					err = -EFAULT;
+				break;
+#endif
+			case 2:
+				if (copy_to_user(buffer, tread,
+						 sizeof(struct snd_timer_tread64)))
+					err = -EFAULT;
+				break;
+			case 1:
+				memset(&tread32, 0, sizeof(tread32));
+				tread32 = (struct snd_timer_tread) {
+					.event = tread->event,
+					.tstamp = {
+						.tv_sec = tread->tstamp.tv_sec,
+						.tv_nsec = tread->tstamp.tv_nsec,
+					},
+					.val = tread->val,
+				};
+
+				if (copy_to_user(buffer, &tread32, sizeof(tread32)))
+					err = -EFAULT;
+				break;
+			default:
+				err = -ENOTSUPP;
+				break;
+			}
 		} else {
 			if (copy_to_user(buffer, &tu->queue[qhead],
 					 sizeof(struct snd_timer_read)))
-- 
1.7.9.5
