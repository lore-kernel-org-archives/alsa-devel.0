From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ALSA: have snd_BUG_ON() always refer to
	arguments
Date: Thu,  6 Nov 2008 21:05:21 -0500
Message-ID: <1226023521-10037-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 241C7103878
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 03:05:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The snd_BUG_ON() macro should always expand its argument even if we're
forcing it to false.  This kills off unused warnings that did not exist
before the snd_assert() -> snd_BUG_ON() conversion.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 include/sound/core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 35424a9..87de9fc 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -387,7 +387,7 @@ void snd_verbose_printd(const char *file, int line, const char *format, ...)
 
 #define snd_printd(fmt, args...)	/* nothing */
 #define snd_BUG()			/* nothing */
-#define snd_BUG_ON(cond)	({/*(void)(cond);*/ 0;})  /* always false */
+#define snd_BUG_ON(cond)	((cond) && 0)  /* always false */
 
 #endif /* CONFIG_SND_DEBUG */
 
-- 
1.6.0.3
