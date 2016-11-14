From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: core: Fix kernel-doc warnings
Date: Mon, 14 Nov 2016 22:30:05 +0100
Message-ID: <20161114213005.22443-4-tiwai@suse.de>
References: <20161114213005.22443-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E1F3266F1C
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 22:30:10 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 956D4AC72
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2016 21:30:10 +0000 (UTC)
In-Reply-To: <20161114213005.22443-1-tiwai@suse.de>
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

Several lines in sound/core.h get the kernel-doc warnings like

  ./include/sound/core.h:323: warning: No description found for parameter '...'

where we use define like foo(x, args...) and "args" isn't mentioned in
the comments.  As an easy workaround, use simple __VA_ARGS__ for VLA
in macros.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 31079ea5e484..f7d8c10c4c45 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -308,8 +308,8 @@ __printf(4, 5)
 void __snd_printk(unsigned int level, const char *file, int line,
 		  const char *format, ...);
 #else
-#define __snd_printk(level, file, line, format, args...) \
-	printk(format, ##args)
+#define __snd_printk(level, file, line, format, ...) \
+	printk(format, ##__VA_ARGS__)
 #endif
 
 /**
@@ -319,8 +319,8 @@ void __snd_printk(unsigned int level, const char *file, int line,
  * Works like printk() but prints the file and the line of the caller
  * when configured with CONFIG_SND_VERBOSE_PRINTK.
  */
-#define snd_printk(fmt, args...) \
-	__snd_printk(0, __FILE__, __LINE__, fmt, ##args)
+#define snd_printk(fmt, ...) \
+	__snd_printk(0, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
 
 #ifdef CONFIG_SND_DEBUG
 /**
@@ -330,10 +330,10 @@ void __snd_printk(unsigned int level, const char *file, int line,
  * Works like snd_printk() for debugging purposes.
  * Ignored when CONFIG_SND_DEBUG is not set.
  */
-#define snd_printd(fmt, args...) \
-	__snd_printk(1, __FILE__, __LINE__, fmt, ##args)
-#define _snd_printd(level, fmt, args...) \
-	__snd_printk(level, __FILE__, __LINE__, fmt, ##args)
+#define snd_printd(fmt, ...) \
+	__snd_printk(1, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
+#define _snd_printd(level, fmt, ...) \
+	__snd_printk(level, __FILE__, __LINE__, fmt, ##__VA_ARGS__)
 
 /**
  * snd_BUG - give a BUG warning message and stack trace
@@ -383,8 +383,8 @@ static inline bool snd_printd_ratelimit(void) { return false; }
  * Works like snd_printk() for debugging purposes.
  * Ignored when CONFIG_SND_DEBUG_VERBOSE is not set.
  */
-#define snd_printdd(format, args...) \
-	__snd_printk(2, __FILE__, __LINE__, format, ##args)
+#define snd_printdd(format, ...) \
+	__snd_printk(2, __FILE__, __LINE__, format, ##__VA_ARGS__)
 #else
 __printf(1, 2)
 static inline void snd_printdd(const char *format, ...) {}
-- 
2.10.2
