From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 3/9] alsactl: use epoll(7) instead
	of poll(2)
Date: Sun, 14 Oct 2018 23:36:28 +0900
Message-ID: <20181014143634.26066-4-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DFD372677E3
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:48 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so8050230plr.1
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:48 -0700 (PDT)
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

Linux kernel supports unique system call; epoll(7). This allows
applications to make associations for descriptor-unique data in a
easy way.

This commit uses epoll(7) instead of poll(2) for this point.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 134 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 113 insertions(+), 21 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 008ceb3..7050eeb 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -20,6 +20,9 @@
 #include "aconfig.h"
 #include "version.h"
 #include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/epoll.h>
 #include <alsa/asoundlib.h>
 
 #define MAX_CARDS	256
@@ -114,41 +117,121 @@ static int print_event(int card, snd_ctl_t *ctl)
 	return 0;
 }
 
-static int run_dispatcher(snd_ctl_t **ctls, int ncards, int show_cards)
+static int operate_dispatcher(int epfd, uint32_t op, struct epoll_event *epev,
+			      snd_ctl_t *ctl)
 {
+	struct pollfd *pfds;
+	int count;
+	unsigned int pfd_count;
+	int i;
+	int err;
+
+	count = snd_ctl_poll_descriptors_count(ctl);
+	if (count < 0)
+		return count;
+	if (count == 0)
+		return -ENXIO;
+	pfd_count = count;
+
+	pfds = calloc(pfd_count, sizeof(*pfds));
+	if (!pfds)
+		return -ENOMEM;
+
+	count = snd_ctl_poll_descriptors(ctl, pfds, pfd_count);
+	if (count < 0) {
+		err = count;
+		goto end;
+	}
+	if (count != pfd_count) {
+		err = -EIO;
+		goto end;
+	}
+
+	for (i = 0; i < pfd_count; ++i) {
+		err = epoll_ctl(epfd, op, pfds[i].fd, epev);
+		if (err < 0)
+			break;
+	}
+end:
+	free(pfds);
+	return err;
+}
+
+static int prepare_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
+{
+	int i;
 	int err = 0;
 
-	for (;ncards > 0;) {
-		struct pollfd fds[ncards];
-		int i;
+	for (i = 0; i < ncards; ++i) {
+		snd_ctl_t *ctl = ctls[i];
+		struct epoll_event ev;
+		ev.events = EPOLLIN;
+		ev.data.ptr = (void *)ctl;
+		err = operate_dispatcher(epfd, EPOLL_CTL_ADD, &ev, ctl);
+		if (err < 0)
+			break;
+	}
 
-		for (i = 0; i < ncards; i++)
-			snd_ctl_poll_descriptors(ctls[i], &fds[i], 1);
+	return err;
+}
 
-		err = poll(fds, ncards, -1);
-		if (err <= 0) {
-			err = 0;
+static int run_dispatcher(int epfd, unsigned int max_ev_count, int show_cards)
+{
+	struct epoll_event *epev;
+	int err = 0;
+
+	epev = calloc(max_ev_count, sizeof(*epev));
+	if (!epev)
+		return -ENOMEM;
+
+	while (true) {
+		int count;
+		int i;
+
+		count = epoll_wait(epfd, epev, max_ev_count, 200);
+		if (count < 0) {
+			err = count;
 			break;
 		}
+		if (count == 0)
+			continue;
+
+		for (i = 0; i < count; ++i) {
+			struct epoll_event *ev = epev + i;
+			snd_ctl_t *handle = (snd_ctl_t *)ev->data.ptr;
 
-		for (i = 0; i < ncards; i++) {
-			unsigned short revents;
-			snd_ctl_poll_descriptors_revents(ctls[i], &fds[i], 1,
-							 &revents);
-			if (revents & POLLIN)
-				print_event(show_cards ? i : -1, ctls[i]);
+			if (ev->events & EPOLLIN)
+				print_event(show_cards ? i : -1, handle);
 		}
 	}
 
+	free(epev);
+
 	return err;
 }
 
+static void clear_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
+{
+	int i;
+
+	for (i = 0; i < ncards; ++i) {
+		snd_ctl_t *ctl = ctls[i];
+		operate_dispatcher(epfd, EPOLL_CTL_DEL, NULL, ctl);
+	}
+}
+
 int monitor(const char *name)
 {
-	snd_ctl_t *ctls[MAX_CARDS];
+	snd_ctl_t *ctls[MAX_CARDS] = {0};
 	int ncards = 0;
 	int show_cards;
-	int i, err = 0;
+	int epfd;
+	int i;
+	int err = 0;
+
+	epfd = epoll_create(1);
+	if (epfd < 0)
+		return -errno;
 
 	if (!name) {
 		struct snd_card_iterator iter;
@@ -170,9 +253,18 @@ int monitor(const char *name)
 		show_cards = 0;
 	}
 
-	err = run_dispatcher(ctls, ncards, show_cards);
- error:
-	for (i = 0; i < ncards; i++)
-		snd_ctl_close(ctls[i]);
+	err = prepare_dispatcher(epfd, ctls, ncards);
+	if (err >= 0)
+		err = run_dispatcher(epfd, ncards, show_cards);
+	clear_dispatcher(epfd, ctls, ncards);
+
+error:
+	for (i = 0; i < ncards; i++) {
+		if (ctls[i])
+			snd_ctl_close(ctls[i]);
+	}
+
+	close(epfd);
+
 	return err;
 }
-- 
2.19.1
