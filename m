From: Dan Carpenter <error27@gmail.com>
Subject: [patch] sound/oss: potential integer overflow
Date: Wed, 8 Sep 2010 09:26:32 +0200
Message-ID: <20100908072632.GB32047@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 23AFC24383
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 09:26:47 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2722330ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 00:26:46 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
List-Id: alsa-devel@alsa-project.org

We don't want "pre_event_timeout" to be negative because that would
result in a stack traces in dmesg when we schedule a negative timeout.
In the original code "HZ * val" could overflow so I just moved the 
check for negative below the multiply.

Also the code in snd_seq_oss_ioctl() deliberately set the timeout to -1
which is wrong.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/oss/sequencer.c b/sound/oss/sequencer.c
index e85789e..de61295 100644
--- a/sound/oss/sequencer.c
+++ b/sound/oss/sequencer.c
@@ -1507,9 +1507,9 @@ int sequencer_ioctl(int dev, struct file *file, unsigned int cmd, void __user *a
 		case SNDCTL_MIDI_PRETIME:
 			if (get_user(val, p))
 				return -EFAULT;
+			val = (HZ * val) / 10;
 			if (val < 0)
 				val = 0;
-			val = (HZ * val) / 10;
 			pre_event_timeout = val;
 			break;
 
diff --git a/sound/oss/midibuf.c b/sound/oss/midibuf.c
index 782b3b8..73acacd 100644
--- a/sound/oss/midibuf.c
+++ b/sound/oss/midibuf.c
@@ -380,9 +380,9 @@ int MIDIbuf_ioctl(int dev, struct file *file,
 			case SNDCTL_MIDI_PRETIME:
 				if (get_user(val, (int __user *)arg))
 					return -EFAULT;
+				val = (HZ * val) / 10;
 				if (val < 0)
 					val = 0;
-				val = (HZ * val) / 10;
 				parms[dev].prech_timeout = val;
 				return put_user(val, (int __user *)arg);
 			
diff --git a/sound/core/seq/oss/seq_oss_ioctl.c b/sound/core/seq/oss/seq_oss_ioctl.c
index 5ac701c..ae2a39f 100644
--- a/sound/core/seq/oss/seq_oss_ioctl.c
+++ b/sound/core/seq/oss/seq_oss_ioctl.c
@@ -191,10 +191,9 @@ snd_seq_oss_ioctl(struct seq_oss_devinfo *dp, unsigned int cmd, unsigned long ca
 			return 0;
 		if (get_user(val, p))
 			return -EFAULT;
-		if (val <= 0)
-			val = -1;
-		else
-			val = (HZ * val) / 10;
+		val = (HZ * val) / 10;
+		if (val < 0)
+			val = 0;
 		dp->readq->pre_event_timeout = val;
 		return put_user(val, p) ? -EFAULT : 0;
