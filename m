From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][RFC][alsa-utils 1/9] alsactl: install signal
	handler
Date: Fri,  5 Oct 2018 23:47:21 +0900
Message-ID: <20181005144729.21388-2-o-takashi@sakamocchi.jp>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9769726792B
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 16:47:40 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so4843665pgm.7
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2018 07:47:40 -0700 (PDT)
In-Reply-To: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, thomas@coldfix.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a mode of 'monitor, event loop runs to dispatch asynchronous event
emitted by control node. In this case, installation of signal handler
is good for safe cancellation.

This commit install signal handler to allow some operation to clear
event loop.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 8351a79..a2abacb 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -20,8 +20,14 @@
 #include "aconfig.h"
 #include "version.h"
 #include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <signal.h>
 #include <alsa/asoundlib.h>
 
+static int signal_type;
+static bool interrupted;
+
 static int open_ctl(const char *name, snd_ctl_t **ctlp)
 {
 	snd_ctl_t *ctl;
@@ -84,6 +90,30 @@ static int print_event(int card, snd_ctl_t *ctl)
 	return 0;
 }
 
+static void handle_unix_signal_for_finish(int sig)
+{
+	signal_type = sig;
+	interrupted = true;
+}
+
+static int prepare_signal_handler(void)
+{
+	struct sigaction sa = {0};
+
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	sa.sa_handler = handle_unix_signal_for_finish;
+
+	if (sigaction(SIGABRT, &sa, NULL) < 0)
+		return -errno;
+	if (sigaction(SIGINT, &sa, NULL) < 0)
+		return -errno;
+	if (sigaction(SIGTERM, &sa, NULL) < 0)
+		return -errno;
+
+	return 0;
+}
+
 #define MAX_CARDS	256
 
 int monitor(const char *name)
@@ -93,6 +123,10 @@ int monitor(const char *name)
 	int show_cards;
 	int i, err = 0;
 
+	err = prepare_signal_handler();
+	if (err < 0)
+		return err;
+
 	if (!name) {
 		int card = -1;
 		while (snd_card_next(&card) >= 0 && card >= 0) {
@@ -117,14 +151,26 @@ int monitor(const char *name)
 		show_cards = 0;
 	}
 
+	interrupted = false;
 	for (;ncards > 0;) {
 		struct pollfd fds[ncards];
 
+		if (interrupted) {
+			printf("interrupted: %s\n", strsignal(signal_type));
+			break;
+		}
+
 		for (i = 0; i < ncards; i++)
 			snd_ctl_poll_descriptors(ctls[i], &fds[i], 1);
 
 		err = poll(fds, ncards, -1);
 		if (err <= 0) {
+			// Catch this case by an above condition statement to
+			// check value set by signal handler. I note that
+			// poll(2) returns EINTR even if configured with
+			// SA_RESTART.
+			if (errno == EINTR)
+				continue;
 			err = 0;
 			break;
 		}
-- 
2.19.0
