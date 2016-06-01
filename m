From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib] async: Handle previously installed
	signal handler
Date: Wed,  1 Jun 2016 08:19:13 +0200
Message-ID: <20160601061913.7942-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 684152656FD
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 08:19:17 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 29BEBAAEF
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 06:19:17 +0000 (UTC)
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

From: Eliot Miranda <eliot.miranda@gmail.com>

The issue is with the signal handler installed and deinstalled in
alsa-lib async handler.  This code makes no attempt to remember any
previously installed signal handlers for SIGIO, if SIGIO is used.
Consequently it does not call any previous handlers from its own
handler once installed, and does not reinstall any previous handler
when deinstalling its handler.  Consequently, use of also-lib within
applications that depend on SIGIO will break those applications,
rendering them inoperative once alsa-lib is running because their
signal handlers are no longer called.

This patch does remember and restore any previous handler, and chains
calls to the handler if it exists.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/async.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/async.c b/src/async.c
index 98aec78e00a8..0e133c3a34cd 100644
--- a/src/async.c
+++ b/src/async.c
@@ -28,6 +28,9 @@
 #include "control/control_local.h"
 #include <signal.h>
 
+static struct sigaction previous_action;
+#define MAX_SIG_FUNCTION_CODE 10 /* i.e. SIG_DFL SIG_IGN SIG_HOLD et al */
+
 #ifdef SND_ASYNC_RT_SIGNAL
 /** async signal number */
 static int snd_async_signo;
@@ -54,6 +57,9 @@ static void snd_async_handler(int signo ATTRIBUTE_UNUSED, siginfo_t *siginfo, vo
 	int fd;
 	struct list_head *i;
 	//assert(siginfo->si_code == SI_SIGIO);
+	if (signo == SIGIO
+	 && (unsigned long)(previous_action.sa_sigaction) > MAX_SIG_FUNCTION_CODE)
+		previous_action.sa_sigaction(signo, siginfo, context);
 	fd = siginfo->si_fd;
 	list_for_each(i, &snd_async_handlers) {
 		snd_async_handler_t *h = list_entry(i, snd_async_handler_t, glist);
@@ -114,7 +120,8 @@ int snd_async_add_handler(snd_async_handler_t **handler, int fd,
 		act.sa_flags = SA_RESTART | SA_SIGINFO;
 		act.sa_sigaction = snd_async_handler;
 		sigemptyset(&act.sa_mask);
-		err = sigaction(snd_async_signo, &act, NULL);
+		assert(!previous_action.sa_sigaction);
+		err = sigaction(snd_async_signo, &act, &previous_action);
 		if (err < 0) {
 			SYSERR("sigaction");
 			return -errno;
@@ -131,18 +138,17 @@ int snd_async_add_handler(snd_async_handler_t **handler, int fd,
 int snd_async_del_handler(snd_async_handler_t *handler)
 {
 	int err = 0;
+	int was_empty = list_empty(&snd_async_handlers);
 	assert(handler);
 	list_del(&handler->glist);
-	if (list_empty(&snd_async_handlers)) {
-		struct sigaction act;
-		memset(&act, 0, sizeof(act));
-		act.sa_flags = 0;
-		act.sa_handler = SIG_DFL;
-		err = sigaction(snd_async_signo, &act, NULL);
+	if (!was_empty
+	 && list_empty(&snd_async_handlers)) {
+		err = sigaction(snd_async_signo, &previous_action, NULL);
 		if (err < 0) {
 			SYSERR("sigaction");
 			return -errno;
 		}
+		memset(&previous_action, 0, sizeof(previous_action));
 	}
 	if (handler->type == SND_ASYNC_HANDLER_GENERIC)
 		goto _end;
-- 
2.8.3
