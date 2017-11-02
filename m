From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH v2 3/7] sound: core: Avoid using timespec for struct snd_rawmidi_status
Date: Thu,  2 Nov 2017 19:06:53 +0800
Message-ID: <4aa4f178fed669b1d2b26965f81e934ae456322a.1509612176.git.baolin.wang@linaro.org>
References: <cover.1509612175.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509612175.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1509612175.git.baolin.wang@linaro.org>
References: <cover.1509612175.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, arnd@arndb.de
Cc: lgirdwood@gmail.com, broonie@kernel.org, o-takashi@sakamocchi.jp, mingo@kernel.org, elfring@users.sourceforge.net, dan.carpenter@oracle.com, jeeja.kp@intel.com, vinod.koul@intel.com, guneshwor.o.singh@intel.com, subhransu.s.prusty@intel.com, bhumirks@gmail.com, gudishax.kranthikumar@intel.com, naveen.m@intel.com, hardik.t.shah@intel.com, arvind.yadav.cs@gmail.com, fabf@skynet.be, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org
List-Id: alsa-devel@alsa-project.org

The struct snd_rawmidi_status will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Thus we introduced 'struct snd_rawmidi_status32' and 'struct snd_rawmidi_status64'
to handle 32bit time_t and 64bit time_t in native mode, which replace
timespec with s64 type.

In compat mode, we renamed or introduced new structures to handle 32bit/64bit
time_t in compatible mode. 'struct compat_snd_rawmidi_status32' and
snd_rawmidi_ioctl_status_compat() are used to handle 32bit time_t in compat mode.
'struct compat_snd_rawmidi_status64' and snd_rawmidi_ioctl_status_compat64() are used
to handle 64bit time_t with 64bit alignment. 'struct compat_snd_rawmidi_status64_x86_32'
and snd_rawmidi_ioctl_status_compat64_x86_32() are used to handle 64bit time_t with
32bit alignment.

When glibc changes time_t to 64-bit, any recompiled program will issue ioctl
commands that the kernel does not understand without this patch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/core/rawmidi.c        |   81 ++++++++++++++++++++++++++---
 sound/core/rawmidi_compat.c |  121 +++++++++++++++++++++++++++++++++----------
 2 files changed, 168 insertions(+), 34 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index b3b353d..af79009 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -63,6 +63,30 @@
 #define rmidi_dbg(rmidi, fmt, args...) \
 	dev_dbg(&(rmidi)->dev, fmt, ##args)
 
+#if __BITS_PER_LONG == 32
+struct snd_rawmidi_status32 {
+	int stream;
+	s32 tstamp_sec;			/* Timestamp */
+	s32 tstamp_nsec;
+	size_t avail;			/* available bytes */
+	size_t xruns;			/* count of overruns since last status (in bytes) */
+	unsigned char reserved[16];	/* reserved for future use */
+};
+
+#define SNDRV_RAWMIDI_IOCTL_STATUS32	_IOWR('W', 0x20, struct snd_rawmidi_status32)
+#endif
+
+struct snd_rawmidi_status64 {
+	int stream;
+	s64 tstamp_sec;			/* Timestamp */
+	s64 tstamp_nsec;
+	size_t avail;			/* available bytes */
+	size_t xruns;			/* count of overruns since last status (in bytes) */
+	unsigned char reserved[16];	/* reserved for future use */
+};
+
+#define SNDRV_RAWMIDI_IOCTL_STATUS64	_IOWR('W', 0x20, struct snd_rawmidi_status64)
+
 static struct snd_rawmidi *snd_rawmidi_search(struct snd_card *card, int device)
 {
 	struct snd_rawmidi *rawmidi;
@@ -680,7 +704,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 EXPORT_SYMBOL(snd_rawmidi_input_params);
 
 static int snd_rawmidi_output_status(struct snd_rawmidi_substream *substream,
-				     struct snd_rawmidi_status * status)
+				     struct snd_rawmidi_status64 * status)
 {
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
@@ -693,7 +717,7 @@ static int snd_rawmidi_output_status(struct snd_rawmidi_substream *substream,
 }
 
 static int snd_rawmidi_input_status(struct snd_rawmidi_substream *substream,
-				    struct snd_rawmidi_status * status)
+				    struct snd_rawmidi_status64 * status)
 {
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
 
@@ -751,11 +775,55 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 			return -EINVAL;
 		}
 	}
-	case SNDRV_RAWMIDI_IOCTL_STATUS:
+#if __BITS_PER_LONG == 32
+	case SNDRV_RAWMIDI_IOCTL_STATUS32:
+	{
+		int err = 0;
+		struct snd_rawmidi_status32 __user *status = argp;
+		struct snd_rawmidi_status32 status32;
+		struct snd_rawmidi_status64 status64;
+
+		if (copy_from_user(&status32, argp,
+				   sizeof(struct snd_rawmidi_status32)))
+			return -EFAULT;
+		switch (status32.stream) {
+		case SNDRV_RAWMIDI_STREAM_OUTPUT:
+			if (rfile->output == NULL)
+				return -EINVAL;
+			err = snd_rawmidi_output_status(rfile->output, &status64);
+			break;
+		case SNDRV_RAWMIDI_STREAM_INPUT:
+			if (rfile->input == NULL)
+				return -EINVAL;
+			err = snd_rawmidi_input_status(rfile->input, &status64);
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (err < 0)
+			return err;
+
+		status32 = (struct snd_rawmidi_status32) {
+			.stream = status64.stream,
+			.tstamp_sec = status64.tstamp_sec,
+			.tstamp_nsec = status64.tstamp_nsec,
+			.avail = status64.avail,
+			.xruns = status64.xruns,
+		};
+
+		if (copy_to_user(status, &status32, sizeof(*status)))
+			return -EFAULT;
+
+		return 0;
+	}
+#endif
+	case SNDRV_RAWMIDI_IOCTL_STATUS64:
 	{
 		int err = 0;
-		struct snd_rawmidi_status status;
-		if (copy_from_user(&status, argp, sizeof(struct snd_rawmidi_status)))
+		struct snd_rawmidi_status64 status;
+
+		if (copy_from_user(&status, argp,
+				   sizeof(struct snd_rawmidi_status64)))
 			return -EFAULT;
 		switch (status.stream) {
 		case SNDRV_RAWMIDI_STREAM_OUTPUT:
@@ -773,7 +841,8 @@ static long snd_rawmidi_ioctl(struct file *file, unsigned int cmd, unsigned long
 		}
 		if (err < 0)
 			return err;
-		if (copy_to_user(argp, &status, sizeof(struct snd_rawmidi_status)))
+		if (copy_to_user(argp, &status,
+				 sizeof(struct snd_rawmidi_status64)))
 			return -EFAULT;
 		return 0;
 	}
diff --git a/sound/core/rawmidi_compat.c b/sound/core/rawmidi_compat.c
index f69764d..5b5b5ea 100644
--- a/sound/core/rawmidi_compat.c
+++ b/sound/core/rawmidi_compat.c
@@ -53,19 +53,21 @@ static int snd_rawmidi_ioctl_params_compat(struct snd_rawmidi_file *rfile,
 	return -EINVAL;
 }
 
-struct snd_rawmidi_status32 {
+struct compat_snd_rawmidi_status32 {
 	s32 stream;
-	struct compat_timespec tstamp;
+	s32 tstamp_sec;
+	s32 tstamp_nsec;
 	u32 avail;
 	u32 xruns;
 	unsigned char reserved[16];
 } __attribute__((packed));
 
 static int snd_rawmidi_ioctl_status_compat(struct snd_rawmidi_file *rfile,
-					   struct snd_rawmidi_status32 __user *src)
+					   struct compat_snd_rawmidi_status32 __user *src)
 {
 	int err;
-	struct snd_rawmidi_status status;
+	struct snd_rawmidi_status64 status;
+	struct compat_snd_rawmidi_status32 compat_status;
 
 	if (rfile->output == NULL)
 		return -EINVAL;
@@ -85,32 +87,86 @@ static int snd_rawmidi_ioctl_status_compat(struct snd_rawmidi_file *rfile,
 	if (err < 0)
 		return err;
 
-	if (compat_put_timespec(&status.tstamp, &src->tstamp) ||
-	    put_user(status.avail, &src->avail) ||
-	    put_user(status.xruns, &src->xruns))
+	compat_status = (struct compat_snd_rawmidi_status32) {
+		.stream = status.stream,
+		.tstamp_sec = status.tstamp_sec,
+		.tstamp_nsec = status.tstamp_nsec,
+		.avail = status.avail,
+		.xruns = status.xruns,
+	};
+
+	if (copy_to_user(src, &compat_status, sizeof(*src)))
 		return -EFAULT;
 
 	return 0;
 }
 
-#ifdef CONFIG_X86_X32
-/* X32 ABI has 64bit timespec and 64bit alignment */
-struct snd_rawmidi_status_x32 {
+struct compat_snd_rawmidi_status64 {
 	s32 stream;
 	u32 rsvd; /* alignment */
-	struct timespec tstamp;
+	s64 tstamp_sec;
+	s64 tstamp_nsec;
 	u32 avail;
 	u32 xruns;
 	unsigned char reserved[16];
 } __attribute__((packed));
 
-#define put_timespec(src, dst) copy_to_user(dst, src, sizeof(*dst))
+static int snd_rawmidi_ioctl_status_compat64(struct snd_rawmidi_file *rfile,
+					     struct compat_snd_rawmidi_status64 __user *src)
+{
+	int err;
+	struct snd_rawmidi_status64 status;
+	struct compat_snd_rawmidi_status64 compat_status;
+
+	if (rfile->output == NULL)
+		return -EINVAL;
+	if (get_user(status.stream, &src->stream))
+		return -EFAULT;
+
+	switch (status.stream) {
+	case SNDRV_RAWMIDI_STREAM_OUTPUT:
+		err = snd_rawmidi_output_status(rfile->output, &status);
+		break;
+	case SNDRV_RAWMIDI_STREAM_INPUT:
+		err = snd_rawmidi_input_status(rfile->input, &status);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	compat_status = (struct compat_snd_rawmidi_status64) {
+		.stream = status.stream,
+		.tstamp_sec = status.tstamp_sec,
+		.tstamp_nsec = status.tstamp_nsec,
+		.avail = status.avail,
+		.xruns = status.xruns,
+	};
 
-static int snd_rawmidi_ioctl_status_x32(struct snd_rawmidi_file *rfile,
-					struct snd_rawmidi_status_x32 __user *src)
+	if (copy_to_user(src, &compat_status, sizeof(*src)))
+		return -EFAULT;
+
+	return 0;
+}
+
+#ifdef IA32_EMULATION
+struct compat_snd_rawmidi_status64_x86_32 {
+	s32 stream;
+	s64 tstamp_sec;
+	s64 tstamp_nsec;
+	u32 avail;
+	u32 xruns;
+	unsigned char reserved[16];
+} __attribute__((packed));
+
+static int
+snd_rawmidi_ioctl_status_compat64_x86_32(struct snd_rawmidi_file *rfile,
+					 struct compat_snd_rawmidi_status64_x86_32 __user *src)
 {
 	int err;
-	struct snd_rawmidi_status status;
+	struct snd_rawmidi_status64 status;
+	struct compat_snd_rawmidi_status64_x86_32 compat_status;
 
 	if (rfile->output == NULL)
 		return -EINVAL;
@@ -130,21 +186,28 @@ static int snd_rawmidi_ioctl_status_x32(struct snd_rawmidi_file *rfile,
 	if (err < 0)
 		return err;
 
-	if (put_timespec(&status.tstamp, &src->tstamp) ||
-	    put_user(status.avail, &src->avail) ||
-	    put_user(status.xruns, &src->xruns))
+	compat_status = (struct compat_snd_rawmidi_status64_x86_32) {
+		.stream = status.stream,
+		.tstamp_sec = status.tstamp_sec,
+		.tstamp_nsec = status.tstamp_nsec,
+		.avail = status.avail,
+		.xruns = status.xruns,
+	};
+
+	if (copy_to_user(src, &compat_status, sizeof(*src)))
 		return -EFAULT;
 
 	return 0;
 }
-#endif /* CONFIG_X86_X32 */
+#endif
 
 enum {
 	SNDRV_RAWMIDI_IOCTL_PARAMS32 = _IOWR('W', 0x10, struct snd_rawmidi_params32),
-	SNDRV_RAWMIDI_IOCTL_STATUS32 = _IOWR('W', 0x20, struct snd_rawmidi_status32),
-#ifdef CONFIG_X86_X32
-	SNDRV_RAWMIDI_IOCTL_STATUS_X32 = _IOWR('W', 0x20, struct snd_rawmidi_status_x32),
-#endif /* CONFIG_X86_X32 */
+	SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT32 = _IOWR('W', 0x20, struct compat_snd_rawmidi_status32),
+	SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT64 = _IOWR('W', 0x20, struct compat_snd_rawmidi_status64),
+#ifdef IA32_EMULATION
+	SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT64_X86_32 = _IOWR('W', 0x20, struct compat_snd_rawmidi_status64_x86_32),
+#endif
 };
 
 static long snd_rawmidi_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
@@ -161,12 +224,14 @@ static long snd_rawmidi_ioctl_compat(struct file *file, unsigned int cmd, unsign
 		return snd_rawmidi_ioctl(file, cmd, (unsigned long)argp);
 	case SNDRV_RAWMIDI_IOCTL_PARAMS32:
 		return snd_rawmidi_ioctl_params_compat(rfile, argp);
-	case SNDRV_RAWMIDI_IOCTL_STATUS32:
+	case SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT32:
 		return snd_rawmidi_ioctl_status_compat(rfile, argp);
-#ifdef CONFIG_X86_X32
-	case SNDRV_RAWMIDI_IOCTL_STATUS_X32:
-		return snd_rawmidi_ioctl_status_x32(rfile, argp);
-#endif /* CONFIG_X86_X32 */
+	case SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT64:
+		return snd_rawmidi_ioctl_status_compat64(rfile, argp);
+#ifdef IA32_EMULATION
+	case SNDRV_RAWMIDI_IOCTL_STATUS_COMPAT64_X86_32:
+		return snd_rawmidi_ioctl_status_compat64_x86_32(rfile, argp);
+#endif
 	}
 	return -ENOIOCTLCMD;
 }
-- 
1.7.9.5
