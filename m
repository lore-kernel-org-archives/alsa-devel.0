From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][RFC][alsa-utils 2/9] alsactl: split event loop
	code to a function
Date: Fri,  5 Oct 2018 23:47:22 +0900
Message-ID: <20181005144729.21388-3-o-takashi@sakamocchi.jp>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 87613267924
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 16:47:42 +0200 (CEST)
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so5205902pfi.1
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2018 07:47:42 -0700 (PDT)
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

In a mode of 'monitor', an event loop runs.

This commit applies a small refactoring to splits the loop into a
function for readability.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 78 ++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index a2abacb..ae1653c 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -90,6 +90,47 @@ static int print_event(int card, snd_ctl_t *ctl)
 	return 0;
 }
 
+static int run_dispatcher(snd_ctl_t **ctls, int ncards, int show_cards)
+{
+	interrupted = false;
+	int err = 0;
+
+	for (;ncards > 0;) {
+		struct pollfd fds[ncards];
+		int i;
+
+		if (interrupted) {
+			printf("interrupted: %s\n", strsignal(signal_type));
+			break;
+		}
+
+		for (i = 0; i < ncards; i++)
+			snd_ctl_poll_descriptors(ctls[i], &fds[i], 1);
+
+		err = poll(fds, ncards, -1);
+		if (err <= 0) {
+			// Catch this case by an above condition statement to
+			// check value set by signal handler. I note that
+			// poll(2) returns EINTR even if configured with
+			// SA_RESTART.
+			if (errno == EINTR)
+				continue;
+			err = 0;
+			break;
+		}
+
+		for (i = 0; i < ncards; i++) {
+			unsigned short revents;
+			snd_ctl_poll_descriptors_revents(ctls[i], &fds[i], 1,
+							 &revents);
+			if (revents & POLLIN)
+				print_event(show_cards ? i : -1, ctls[i]);
+		}
+	}
+
+	return err;
+}
+
 static void handle_unix_signal_for_finish(int sig)
 {
 	signal_type = sig;
@@ -121,7 +162,8 @@ int monitor(const char *name)
 	snd_ctl_t *ctls[MAX_CARDS];
 	int ncards = 0;
 	int show_cards;
-	int i, err = 0;
+	int i;
+	int err = 0;
 
 	err = prepare_signal_handler();
 	if (err < 0)
@@ -151,39 +193,7 @@ int monitor(const char *name)
 		show_cards = 0;
 	}
 
-	interrupted = false;
-	for (;ncards > 0;) {
-		struct pollfd fds[ncards];
-
-		if (interrupted) {
-			printf("interrupted: %s\n", strsignal(signal_type));
-			break;
-		}
-
-		for (i = 0; i < ncards; i++)
-			snd_ctl_poll_descriptors(ctls[i], &fds[i], 1);
-
-		err = poll(fds, ncards, -1);
-		if (err <= 0) {
-			// Catch this case by an above condition statement to
-			// check value set by signal handler. I note that
-			// poll(2) returns EINTR even if configured with
-			// SA_RESTART.
-			if (errno == EINTR)
-				continue;
-			err = 0;
-			break;
-		}
-
-		for (i = 0; i < ncards; i++) {
-			unsigned short revents;
-			snd_ctl_poll_descriptors_revents(ctls[i], &fds[i], 1,
-							 &revents);
-			if (revents & POLLIN)
-				print_event(show_cards ? i : -1, ctls[i]);
-		}
-	}
-
+	err = run_dispatcher(ctls, ncards, show_cards);
  error:
 	for (i = 0; i < ncards; i++)
 		snd_ctl_close(ctls[i]);
-- 
2.19.0
