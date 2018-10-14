From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 1/9] alsactl: split event loop code
	to a function
Date: Sun, 14 Oct 2018 23:36:26 +0900
Message-ID: <20181014143634.26066-2-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ADFE2677E3
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:44 +0200 (CEST)
Received: by mail-pf1-f195.google.com with SMTP id l17-v6so8400407pff.2
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:44 -0700 (PDT)
In-Reply-To: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In a mode of 'monitor', an event loop runs.

This commit applies a small refactoring to splits the loop into a
function for readability.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 51 ++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 8351a79..fb3fc18 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -84,6 +84,35 @@ static int print_event(int card, snd_ctl_t *ctl)
 	return 0;
 }
 
+static int run_dispatcher(snd_ctl_t **ctls, int ncards, int show_cards)
+{
+	int err = 0;
+
+	for (;ncards > 0;) {
+		struct pollfd fds[ncards];
+		int i;
+
+		for (i = 0; i < ncards; i++)
+			snd_ctl_poll_descriptors(ctls[i], &fds[i], 1);
+
+		err = poll(fds, ncards, -1);
+		if (err <= 0) {
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
 #define MAX_CARDS	256
 
 int monitor(const char *name)
@@ -117,27 +146,7 @@ int monitor(const char *name)
 		show_cards = 0;
 	}
 
-	for (;ncards > 0;) {
-		struct pollfd fds[ncards];
-
-		for (i = 0; i < ncards; i++)
-			snd_ctl_poll_descriptors(ctls[i], &fds[i], 1);
-
-		err = poll(fds, ncards, -1);
-		if (err <= 0) {
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
2.19.1
