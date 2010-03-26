From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [for 2.6.34][PATCH] ALSA: pcm_lib - fix xrun
	functionality
Date: Fri, 26 Mar 2010 16:07:25 +0200
Message-ID: <1269612445-14245-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f213.google.com (mail-ew0-f213.google.com
	[209.85.219.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 10CC610382F
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 15:05:06 +0100 (CET)
Received: by ewy5 with SMTP id 5so215699ewy.20
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 07:05:04 -0700 (PDT)
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

The commit 4d96eb255c53ab5e39b37fd4d484ea3dc39ab456 broke the interrupt
time xrun functionality (stream stop etc.) if the CONFIG_SND_PCM_XRUN_DEBUG
is not set. This is because the xrun() is null defined without it.

Fix this by letting the function xrun() to be always defined as it was
before.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/pcm_lib.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index b546ac2..a2ff861 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -148,6 +148,9 @@ static void pcm_debug_name(struct snd_pcm_substream *substream,
 
 #define xrun_debug(substream, mask) \
 			((substream)->pstr->xrun_debug & (mask))
+#else
+#define xrun_debug(substream, mask)	0
+#endif
 
 #define dump_stack_on_xrun(substream) do {			\
 		if (xrun_debug(substream, XRUN_DEBUG_STACK))	\
@@ -169,6 +172,7 @@ static void xrun(struct snd_pcm_substream *substream)
 	}
 }
 
+#ifdef CONFIG_SND_PCM_XRUN_DEBUG
 #define hw_ptr_error(substream, fmt, args...)				\
 	do {								\
 		if (xrun_debug(substream, XRUN_DEBUG_BASIC)) {		\
@@ -255,8 +259,6 @@ static void xrun_log_show(struct snd_pcm_substream *substream)
 
 #else /* ! CONFIG_SND_PCM_XRUN_DEBUG */
 
-#define xrun_debug(substream, mask)	0
-#define xrun(substream)			do { } while (0)
 #define hw_ptr_error(substream, fmt, args...) do { } while (0)
 #define xrun_log(substream, pos)	do { } while (0)
 #define xrun_log_show(substream)	do { } while (0)
-- 
1.7.0
