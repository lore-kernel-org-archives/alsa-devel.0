From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: rawmidi: handle error state for
	broken logical channel
Date: Sat, 13 Aug 2016 21:39:16 +0900
Message-ID: <1471091957-14757-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1471091957-14757-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 8700D265CC7
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 14:39:23 +0200 (CEST)
In-Reply-To: <1471091957-14757-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In packet-oriented drivers such as USB Audio Device class or IEC 61883-1/6,
data transmission can fail due to data bus issue. In this case, retries of
transmission should be performed as long as any MIDI messages are in time
of their presentation time.

When the retries fails, the channel should be broken. In this case, any
messages are lost. Userspace applications should close the channel because
logical transmission channel lost its reliability, then re-open the channel
to recover. Although, Current implementation of ALSA rawmidi core has no
mechanism to promote the applications to handle the situation.

This commit is for this idea. A structure for rawmidi runtime get a member
to describe error state. Once the runtime lapses into the situation, the
member should be set. Then any I/O operations from userspace returns EPIPE
and masks from poll includes POLLERR.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/rawmidi.h |  1 +
 sound/core/rawmidi.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index f730b91..da1e93f 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -76,6 +76,7 @@ struct snd_rawmidi_runtime {
 	size_t avail_min;	/* min avail for wakeup */
 	size_t avail;		/* max used buffer for wakeup */
 	size_t xruns;		/* over/underruns counter */
+	bool error;		/* Transmission channel is under disorder. */
 	/* misc */
 	spinlock_t lock;
 	wait_queue_head_t sleep;
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 795437b..1ca820e 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -129,6 +129,7 @@ static int snd_rawmidi_runtime_create(struct snd_rawmidi_substream *substream)
 		return -ENOMEM;
 	}
 	runtime->appl_ptr = runtime->hw_ptr = 0;
+	runtime->error = false;
 	substream->runtime = runtime;
 	return 0;
 }
@@ -191,7 +192,10 @@ int snd_rawmidi_drain_output(struct snd_rawmidi_substream *substream)
 		rmidi_warn(substream->rmidi,
 			   "rawmidi drain error (avail = %li, buffer_size = %li)\n",
 			   (long)runtime->avail, (long)runtime->buffer_size);
-		err = -EIO;
+		if (runtime->error)
+			err = -EPIPE;
+		else
+			err = -EIO;
 	}
 	runtime->drain = 0;
 	if (err != -ERESTARTSYS) {
@@ -210,14 +214,19 @@ int snd_rawmidi_drain_input(struct snd_rawmidi_substream *substream)
 {
 	unsigned long flags;
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
+	int err;
 
 	snd_rawmidi_input_trigger(substream, 0);
 	runtime->drain = 0;
 	spin_lock_irqsave(&runtime->lock, flags);
 	runtime->appl_ptr = runtime->hw_ptr = 0;
 	runtime->avail = 0;
+	if (runtime->error)
+		err = -EPIPE;
+	else
+		err = 0;
 	spin_unlock_irqrestore(&runtime->lock, flags);
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_drain_input);
 
@@ -628,10 +637,13 @@ int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
 {
 	char *newbuf;
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
+	int err;
 	
 	if (substream->append && substream->use_count > 1)
 		return -EBUSY;
-	snd_rawmidi_drain_output(substream);
+	err = snd_rawmidi_drain_output(substream);
+	if (err < 0)
+		return err;
 	if (params->buffer_size < 32 || params->buffer_size > 1024L * 1024L) {
 		return -EINVAL;
 	}
@@ -658,8 +670,11 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 {
 	char *newbuf;
 	struct snd_rawmidi_runtime *runtime = substream->runtime;
+	int err;
 
-	snd_rawmidi_drain_input(substream);
+	err = snd_rawmidi_drain_input(substream);
+	if (err < 0)
+		return err;
 	if (params->buffer_size < 32 || params->buffer_size > 1024L * 1024L) {
 		return -EINVAL;
 	}
@@ -946,6 +961,10 @@ static long snd_rawmidi_kernel_read1(struct snd_rawmidi_substream *substream,
 
 	spin_lock_irqsave(&runtime->lock, flags);
 	while (count > 0 && runtime->avail) {
+		if (runtime->error) {
+			spin_lock_irqrestore(&runtime->lock, flags);
+			return -EPIPE;
+		}
 		count1 = runtime->buffer_size - runtime->appl_ptr;
 		if (count1 > count)
 			count1 = count;
@@ -1017,6 +1036,8 @@ static ssize_t snd_rawmidi_read(struct file *file, char __user *buf, size_t coun
 				return -ENODEV;
 			if (signal_pending(current))
 				return result > 0 ? result : -ERESTARTSYS;
+			if (runtime->error)
+				return -EPIPE;
 			if (!runtime->avail)
 				return result > 0 ? result : -EIO;
 			spin_lock_irq(&runtime->lock);
@@ -1244,6 +1265,10 @@ static long snd_rawmidi_kernel_write1(struct snd_rawmidi_substream *substream,
 		}
 	}
 	while (count > 0 && runtime->avail > 0) {
+		if (runtime->error) {
+			result = -EPIPE;
+			goto _end;
+		}
 		count1 = runtime->buffer_size - runtime->appl_ptr;
 		if (count1 > count)
 			count1 = count;
@@ -1321,6 +1346,8 @@ static ssize_t snd_rawmidi_write(struct file *file, const char __user *buf,
 				return -ENODEV;
 			if (signal_pending(current))
 				return result > 0 ? result : -ERESTARTSYS;
+			if (runtime->error)
+				return -EPIPE;
 			if (!runtime->avail && !timeout)
 				return result > 0 ? result : -EIO;
 			spin_lock_irq(&runtime->lock);
@@ -1348,6 +1375,8 @@ static ssize_t snd_rawmidi_write(struct file *file, const char __user *buf,
 			remove_wait_queue(&runtime->sleep, &wait);
 			if (signal_pending(current))
 				return result > 0 ? result : -ERESTARTSYS;
+			if (runtime->error)
+				return -EPIPE;
 			if (runtime->avail == last_avail && !timeout)
 				return result > 0 ? result : -EIO;
 			spin_lock_irq(&runtime->lock);
@@ -1375,11 +1404,33 @@ static unsigned int snd_rawmidi_poll(struct file *file, poll_table * wait)
 	}
 	mask = 0;
 	if (rfile->input != NULL) {
+		runtime = rfile->input->runtime;
+
+		/* Logical channel for communication is broken. */
+		spin_lock_irq(&runtime->lock);
+		if (runtime->error)
+			mask |= POLLERR;
+		spin_unlock_irq(&runtime->lock);
+
+		/*
+		 * ALSA rawmidi character devices are available for
+		 * bi-directional communication, thus it's impossible to use
+		 * POLLHUP/POLLRDHUP due to logical contradiction with POLLOUT,
+		 * even if any drivers detects peers' disconnection.
+		 */
 		if (snd_rawmidi_ready(rfile->input))
 			mask |= POLLIN | POLLRDNORM;
 	}
 	if (rfile->output != NULL) {
-		if (snd_rawmidi_ready(rfile->output))
+		runtime = rfile->output->runtime;
+
+		/* Logical channel for communication is broken. */
+		spin_lock_irq(&runtime->lock);
+		if (runtime->error)
+			mask |= POLLERR;
+		spin_unlock_irq(&runtime->lock);
+
+		if (!(mask & POLLERR) && snd_rawmidi_ready(rfile->output))
 			mask |= POLLOUT | POLLWRNORM;
 	}
 	return mask;
-- 
2.7.4
