From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: core - Define llseek fops
Date: Wed, 14 Apr 2010 10:18:02 +0200
Message-ID: <1271233083-16310-5-git-send-email-tiwai@suse.de>
References: <1271233083-16310-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 89A4624480
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 73F2D89783
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
In-Reply-To: <1271233083-16310-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Set no_llseek to llseek file ops of each sound component (but for hwdep).
This avoids the implicit BKL invocation via generic_file_llseek() used
as default when fops.llseek is NULL.

Also call nonseekable_open() at each open ops to ensure the file flags
have no seek bit.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c           |    5 +++++
 sound/core/oss/mixer_oss.c     |    5 +++++
 sound/core/oss/pcm_oss.c       |    5 +++++
 sound/core/pcm_native.c        |   10 ++++++++--
 sound/core/rawmidi.c           |    5 +++++
 sound/core/seq/seq_clientmgr.c |    6 ++++++
 sound/core/timer.c             |    6 ++++++
 7 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 439ce64..070aab4 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -50,6 +50,10 @@ static int snd_ctl_open(struct inode *inode, struct file *file)
 	struct snd_ctl_file *ctl;
 	int err;
 
+	err = nonseekable_open(inode, file);
+	if (err < 0)
+		return err;
+
 	card = snd_lookup_minor_data(iminor(inode), SNDRV_DEVICE_TYPE_CONTROL);
 	if (!card) {
 		err = -ENODEV;
@@ -1388,6 +1392,7 @@ static const struct file_operations snd_ctl_f_ops =
 	.read =		snd_ctl_read,
 	.open =		snd_ctl_open,
 	.release =	snd_ctl_release,
+	.llseek =	no_llseek,
 	.poll =		snd_ctl_poll,
 	.unlocked_ioctl =	snd_ctl_ioctl,
 	.compat_ioctl =	snd_ctl_ioctl_compat,
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 54e2eb5..f50ebf2 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -43,6 +43,10 @@ static int snd_mixer_oss_open(struct inode *inode, struct file *file)
 	struct snd_mixer_oss_file *fmixer;
 	int err;
 
+	err = nonseekable_open(inode, file);
+	if (err < 0)
+		return err;
+
 	card = snd_lookup_oss_minor_data(iminor(inode),
 					 SNDRV_OSS_DEVICE_TYPE_MIXER);
 	if (card == NULL)
@@ -397,6 +401,7 @@ static const struct file_operations snd_mixer_oss_f_ops =
 	.owner =	THIS_MODULE,
 	.open =		snd_mixer_oss_open,
 	.release =	snd_mixer_oss_release,
+	.llseek =	no_llseek,
 	.unlocked_ioctl =	snd_mixer_oss_ioctl,
 	.compat_ioctl =	snd_mixer_oss_ioctl_compat,
 };
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 82d4e33..5c8c7df 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2379,6 +2379,10 @@ static int snd_pcm_oss_open(struct inode *inode, struct file *file)
 	int nonblock;
 	wait_queue_t wait;
 
+	err = nonseekable_open(inode, file);
+	if (err < 0)
+		return err;
+
 	pcm = snd_lookup_oss_minor_data(iminor(inode),
 					SNDRV_OSS_DEVICE_TYPE_PCM);
 	if (pcm == NULL) {
@@ -2977,6 +2981,7 @@ static const struct file_operations snd_pcm_oss_f_reg =
 	.write =	snd_pcm_oss_write,
 	.open =		snd_pcm_oss_open,
 	.release =	snd_pcm_oss_release,
+	.llseek =	no_llseek,
 	.poll =		snd_pcm_oss_poll,
 	.unlocked_ioctl =	snd_pcm_oss_ioctl,
 	.compat_ioctl =	snd_pcm_oss_ioctl_compat,
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index cadba30..5b22443 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2107,7 +2107,9 @@ static int snd_pcm_open_file(struct file *file,
 static int snd_pcm_playback_open(struct inode *inode, struct file *file)
 {
 	struct snd_pcm *pcm;
-
+	int err = nonseekable_open(inode, file);
+	if (err < 0)
+		return err;
 	pcm = snd_lookup_minor_data(iminor(inode),
 				    SNDRV_DEVICE_TYPE_PCM_PLAYBACK);
 	return snd_pcm_open(file, pcm, SNDRV_PCM_STREAM_PLAYBACK);
@@ -2116,7 +2118,9 @@ static int snd_pcm_playback_open(struct inode *inode, struct file *file)
 static int snd_pcm_capture_open(struct inode *inode, struct file *file)
 {
 	struct snd_pcm *pcm;
-
+	int err = nonseekable_open(inode, file);
+	if (err < 0)
+		return err;
 	pcm = snd_lookup_minor_data(iminor(inode),
 				    SNDRV_DEVICE_TYPE_PCM_CAPTURE);
 	return snd_pcm_open(file, pcm, SNDRV_PCM_STREAM_CAPTURE);
@@ -3450,6 +3454,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.aio_write =		snd_pcm_aio_write,
 		.open =			snd_pcm_playback_open,
 		.release =		snd_pcm_release,
+		.llseek =		no_llseek,
 		.poll =			snd_pcm_playback_poll,
 		.unlocked_ioctl =	snd_pcm_playback_ioctl,
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
@@ -3463,6 +3468,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 		.aio_read =		snd_pcm_aio_read,
 		.open =			snd_pcm_capture_open,
 		.release =		snd_pcm_release,
+		.llseek =		no_llseek,
 		.poll =			snd_pcm_capture_poll,
 		.unlocked_ioctl =	snd_pcm_capture_ioctl,
 		.compat_ioctl = 	snd_pcm_ioctl_compat,
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 0f5a194..eb68326 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -376,6 +376,10 @@ static int snd_rawmidi_open(struct inode *inode, struct file *file)
 	if ((file->f_flags & O_APPEND) && !(file->f_flags & O_NONBLOCK)) 
 		return -EINVAL;		/* invalid combination */
 
+	err = nonseekable_open(inode, file);
+	if (err < 0)
+		return err;
+
 	if (maj == snd_major) {
 		rmidi = snd_lookup_minor_data(iminor(inode),
 					      SNDRV_DEVICE_TYPE_RAWMIDI);
@@ -1391,6 +1395,7 @@ static const struct file_operations snd_rawmidi_f_ops =
 	.write =	snd_rawmidi_write,
 	.open =		snd_rawmidi_open,
 	.release =	snd_rawmidi_release,
+	.llseek =	no_llseek,
 	.poll =		snd_rawmidi_poll,
 	.unlocked_ioctl =	snd_rawmidi_ioctl,
 	.compat_ioctl =	snd_rawmidi_ioctl_compat,
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 48eca9f..99a485f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -318,6 +318,11 @@ static int snd_seq_open(struct inode *inode, struct file *file)
 	int c, mode;			/* client id */
 	struct snd_seq_client *client;
 	struct snd_seq_user_client *user;
+	int err;
+
+	err = nonseekable_open(inode, file);
+	if (err < 0)
+		return err;
 
 	if (mutex_lock_interruptible(&register_mutex))
 		return -ERESTARTSYS;
@@ -2550,6 +2555,7 @@ static const struct file_operations snd_seq_f_ops =
 	.write =	snd_seq_write,
 	.open =		snd_seq_open,
 	.release =	snd_seq_release,
+	.llseek =	no_llseek,
 	.poll =		snd_seq_poll,
 	.unlocked_ioctl =	snd_seq_ioctl,
 	.compat_ioctl =	snd_seq_ioctl_compat,
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 7394365..8c9a661 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1237,6 +1237,11 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 static int snd_timer_user_open(struct inode *inode, struct file *file)
 {
 	struct snd_timer_user *tu;
+	int err;
+
+	err = nonseekable_open(inode, file);
+	if (err < 0)
+		return err;
 
 	tu = kzalloc(sizeof(*tu), GFP_KERNEL);
 	if (tu == NULL)
@@ -1921,6 +1926,7 @@ static const struct file_operations snd_timer_f_ops =
 	.read =		snd_timer_user_read,
 	.open =		snd_timer_user_open,
 	.release =	snd_timer_user_release,
+	.llseek =	no_llseek,
 	.poll =		snd_timer_user_poll,
 	.unlocked_ioctl =	snd_timer_user_ioctl,
 	.compat_ioctl =	snd_timer_user_ioctl_compat,
-- 
1.7.0.4
