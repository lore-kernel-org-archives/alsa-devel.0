From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: No snd_pcm_resume_all() ?
Date: Tue, 18 Apr 2006 10:58:38 +1000
Message-ID: <1145321918.4705.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EE2A81AC
	for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2006 02:58:47 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

Hi !

While tweaking a bit the power management code in Johannes' new snd-aoa
for powermac, I got it to properly suspend & resume playback on
sleep/waekup of the machine. However, an Alsa bit is missing for that to
work and I'd like to understand why.

On suspend, it's fairly simple, we call snd_pcm_suspend_all() to suspend
all streams before we go put the hardware into low power state.

On resume, I would expect to have a similar snd_pcm_resume_all() to call
after I've restored the hardware & codecs state. However... it's not
there. I hacked one up myself (patch below) and it seems to work fine.

It appears that Alsa expects the streams to be resumed via some userland
initiated ioctl, which for some reason is never called on my machine.
What is the rationale there ? it's userland that is expected to
save/restore hardware state ? That doesn't really match the linux PM
model at this point and it seems that Alsa userland isn't notified of
suspend/resume at least on powermacs.

Just adding snd_pcm_resume_all() and calling it at the right time seems
to work fine for us, thus is there any reason why the patch below
couldn't be pushed upstream ?

Cheers,
Ben.

Index: linux-work/sound/core/pcm_native.c
===================================================================
--- linux-work.orig/sound/core/pcm_native.c	2006-04-13 09:58:55.000000000 +1000
+++ linux-work/sound/core/pcm_native.c	2006-04-18 10:34:46.000000000 +1000
@@ -1176,6 +1176,35 @@
 	return res;
 }
 
+/**
+ * snd_pcm_resume_all
+ * @pcm: the PCM instance
+ *
+ * Trigger RESUME to all substreams in the given pcm.
+ * After this call, all streams that were SUSPENDED gets resumed to RUNNING state.
+ */
+int snd_pcm_resume_all(struct snd_pcm *pcm)
+{
+        struct snd_pcm_substream *substream;
+        int stream, err = 0;
+
+        if (! pcm)
+                return 0;
+
+        for (stream = 0; stream < 2; stream++) {
+                for (substream = pcm->streams[stream].substream;
+                     substream; substream = substream->next) {
+                        /* FIXME: the open/close code should lock this as well */
+                        if (substream->runtime == NULL)
+                                continue;
+                        err = snd_pcm_resume(substream);
+                        if (err < 0 && err != -EBUSY)
+                                return err;
+                }
+        }
+        return 0;
+}
+
 #else
 
 static int snd_pcm_resume(struct snd_pcm_substream *substream)
@@ -1183,6 +1212,11 @@
 	return -ENOSYS;
 }
 
+int snd_pcm_resume_all(struct snd_pcm *pcm)
+{
+	return -ENOSYS;
+}
+
 #endif /* CONFIG_PM */
 
 /*
Index: linux-work/include/sound/pcm.h
===================================================================
--- linux-work.orig/include/sound/pcm.h	2006-04-13 09:58:51.000000000 +1000
+++ linux-work/include/sound/pcm.h	2006-04-18 10:37:23.000000000 +1000
@@ -464,6 +464,7 @@
 #ifdef CONFIG_PM
 int snd_pcm_suspend(struct snd_pcm_substream *substream);
 int snd_pcm_suspend_all(struct snd_pcm *pcm);
+int snd_pcm_resume_all(struct snd_pcm *pcm);
 #endif
 int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg);
 int snd_pcm_open_substream(struct snd_pcm *pcm, int stream, struct file *file,
Index: linux-work/sound/core/pcm.c
===================================================================
--- linux-work.orig/sound/core/pcm.c	2006-04-13 09:58:55.000000000 +1000
+++ linux-work/sound/core/pcm.c	2006-04-18 10:36:35.000000000 +1000
@@ -1110,6 +1110,7 @@
 #ifdef CONFIG_PM
 EXPORT_SYMBOL(snd_pcm_suspend);
 EXPORT_SYMBOL(snd_pcm_suspend_all);
+EXPORT_SYMBOL(snd_pcm_resume_all);
 #endif
 EXPORT_SYMBOL(snd_pcm_kernel_ioctl);
 EXPORT_SYMBOL(snd_pcm_mmap_data);




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
