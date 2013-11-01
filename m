From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Implement tpacpi_set_led
Date: Fri,  1 Nov 2013 08:17:27 +0100
Message-ID: <1383290247-6852-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C28A82650DA
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 08:17:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This allows for testing the feature as well as avoiding a warning
when testing the relevant codecs.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/wrapper.h |    3 +--
 snd-wrapper.c     |    7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

Note: the i915 power well functions probably needs implementing as well now
that symbol_request is changed, but this does not seem to be a problem here,
maybe because hda_i915 is not in the kernel/Makefile.am file?

diff --git a/include/wrapper.h b/include/wrapper.h
index f7dd65d..93a9f93 100644
--- a/include/wrapper.h
+++ b/include/wrapper.h
@@ -238,8 +238,7 @@ void mylock_write_unlock(int *lock, const char *file, int line);
 /* FIXME */
 #define IS_ENABLED(x)		1
 
-/* FIXME */
-#define symbol_request(x)	NULL
+#define symbol_request(x)	x
 #define symbol_put(x)
 
 static inline long copy_from_user(void *to, const void __user *from, unsigned long n)
diff --git a/snd-wrapper.c b/snd-wrapper.c
index 1ec8a49..dbc62c5 100644
--- a/snd-wrapper.c
+++ b/snd-wrapper.c
@@ -720,3 +720,10 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_pcm_add_chmap_ctls);
+
+int tpacpi_led_set(int whichled, bool on)
+{
+	hda_log(HDA_LOG_INFO, "Setting thinkpad LED %d to %s\n", whichled, on ? "on" : "off" );
+	return 0;
+}
+
-- 
1.7.9.5
