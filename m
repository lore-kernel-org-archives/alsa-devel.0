From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: Fix compat_ioctl handling for OSS
	emulations
Date: Thu,  3 Dec 2015 17:28:16 +0100
Message-ID: <1449160096-23680-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 432DE260474
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 17:28:19 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 101F3ADCD
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 16:28:19 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The ALSA PCM, mixer and sequencer OSS emulations provide the 32bit
compatible ioctl, but they just call the 64bit native ioctl as is.
Although this works in most cases, passing the argument value as-is
isn't guaranteed to work on all architectures.  We need to convert it
via compat_ptr() instead.

This patch addresses the missing conversions.  Since all relevant
ioctls in these functions take the argument as a pointer, we do the
pointer conversion in each compat_ioctl and pass it as a 64bit value
to the native ioctl.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/oss/mixer_oss.c   | 8 +++++++-
 sound/core/oss/pcm_oss.c     | 7 ++++++-
 sound/core/seq/oss/seq_oss.c | 7 ++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 7a8c79dd9734..2ff9c12d664a 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -24,6 +24,7 @@
 #include <linux/time.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/compat.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/control.h>
@@ -397,7 +398,12 @@ int snd_mixer_oss_ioctl_card(struct snd_card *card, unsigned int cmd, unsigned l
 
 #ifdef CONFIG_COMPAT
 /* all compatible */
-#define snd_mixer_oss_ioctl_compat	snd_mixer_oss_ioctl
+static long snd_mixer_oss_ioctl_compat(struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return snd_mixer_oss_ioctl1(file->private_data, cmd,
+				    (unsigned long)compat_ptr(arg));
+}
 #else
 #define snd_mixer_oss_ioctl_compat	NULL
 #endif
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 58550cc93f28..e557dbe469f4 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/math64.h>
 #include <linux/string.h>
+#include <linux/compat.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
@@ -2648,7 +2649,11 @@ static long snd_pcm_oss_ioctl(struct file *file, unsigned int cmd, unsigned long
 
 #ifdef CONFIG_COMPAT
 /* all compatible */
-#define snd_pcm_oss_ioctl_compat	snd_pcm_oss_ioctl
+static long snd_pcm_oss_ioctl_compat(struct file *file, unsigned int cmd,
+				     unsigned long arg)
+{
+	return snd_pcm_oss_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
 #else
 #define snd_pcm_oss_ioctl_compat	NULL
 #endif
diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index 7354b8bed860..8db156b207f1 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/compat.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/initval.h>
@@ -189,7 +190,11 @@ odev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 
 #ifdef CONFIG_COMPAT
-#define odev_ioctl_compat	odev_ioctl
+static long odev_ioctl_compat(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	return odev_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+}
 #else
 #define odev_ioctl_compat	NULL
 #endif
-- 
2.6.3
