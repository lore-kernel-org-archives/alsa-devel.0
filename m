From: Joe Perches <joe@perches.com>
Subject: [PATCH 5/8] sound: Use printk_get_level and
	printk_skip_level
Date: Tue,  5 Jun 2012 02:46:34 -0700
Message-ID: <69c567123040afc72a785fe01af1f0417f38e0cb.1338889067.git.joe@perches.com>
References: <cover.1338889066.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BFEB245B9
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 11:47:41 +0200 (CEST)
In-Reply-To: <cover.1338889066.git.joe@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Kay Sievers <kay@vrfy.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Make the output logging routine independent of the
KERN_<LEVEL> style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/core/misc.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/core/misc.c b/sound/core/misc.c
index 7681679..30e027e 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -68,6 +68,7 @@ void __snd_printk(unsigned int level, const char *path, int line,
 {
 	va_list args;
 #ifdef CONFIG_SND_VERBOSE_PRINTK
+	int kern_level;
 	struct va_format vaf;
 	char verbose_fmt[] = KERN_DEFAULT "ALSA %s:%d %pV";
 #endif
@@ -81,12 +82,16 @@ void __snd_printk(unsigned int level, const char *path, int line,
 #ifdef CONFIG_SND_VERBOSE_PRINTK
 	vaf.fmt = format;
 	vaf.va = &args;
-	if (format[0] == '<' && format[2] == '>') {
-		memcpy(verbose_fmt, format, 3);
-		vaf.fmt = format + 3;
+
+	kern_level = printk_get_level(format);
+	if (kern_level) {
+		const char *end_of_header = printk_skip_level(format);
+		memcpy(verbose_fmt, format, end_of_header - format);
+		vaf.fmt = end_of_header;
 	} else if (level)
-		memcpy(verbose_fmt, KERN_DEBUG, 3);
+		memcpy(verbose_fmt, KERN_DEBUG, sizeof(KERN_DEBUG) - 1);
 	printk(verbose_fmt, sanity_file_name(path), line, &vaf);
+
 #else
 	vprintk(format, args);
 #endif
-- 
1.7.8.111.gad25c.dirty
