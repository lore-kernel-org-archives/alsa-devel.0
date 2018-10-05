From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][RFC][alsa-utils 6/9] alsactl: use a list of
	source for event dispatcher instead of an array of source
Date: Fri,  5 Oct 2018 23:47:26 +0900
Message-ID: <20181005144729.21388-7-o-takashi@sakamocchi.jp>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B224267944
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 16:47:49 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so6960419plb.4
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2018 07:47:49 -0700 (PDT)
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

In a previous commit, handlers of control nodes are maintained by link
list.

This commit uses the list to register/unregister event sources to
dispatcher.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 76 +++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 8b16307..506f504 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -155,7 +155,7 @@ static int open_ctl(const char *name, snd_ctl_t **ctlp)
 	return 0;
 }
 
-static int print_event(int card, snd_ctl_t *ctl)
+static int print_event(snd_ctl_t *ctl, const char *name)
 {
 	snd_ctl_event_t *event;
 	unsigned int mask;
@@ -169,9 +169,8 @@ static int print_event(int card, snd_ctl_t *ctl)
 	if (snd_ctl_event_get_type(event) != SND_CTL_EVENT_ELEM)
 		return 0;
 
-	if (card >= 0)
-		printf("card %d, ", card);
-	printf("#%d (%i,%i,%i,%s,%i)",
+	printf("node %s, #%d (%i,%i,%i,%s,%i)",
+	       name,
 	       snd_ctl_event_elem_get_numid(event),
 	       snd_ctl_event_elem_get_interface(event),
 	       snd_ctl_event_elem_get_device(event),
@@ -198,36 +197,28 @@ static int print_event(int card, snd_ctl_t *ctl)
 }
 
 static int operate_dispatcher(int epfd, uint32_t op, struct epoll_event *epev,
-			      snd_ctl_t *ctl)
+			      struct src_entry *src)
 {
 	struct pollfd *pfds;
 	int count;
-	unsigned int pfd_count;
 	int i;
-	int err;
-
-	count = snd_ctl_poll_descriptors_count(ctl);
-	if (count < 0)
-		return count;
-	if (count == 0)
-		return -ENXIO;
-	pfd_count = count;
+	int err = 0;
 
-	pfds = calloc(pfd_count, sizeof(*pfds));
+	pfds = calloc(src->pfd_count, sizeof(*pfds));
 	if (!pfds)
 		return -ENOMEM;
 
-	count = snd_ctl_poll_descriptors(ctl, pfds, pfd_count);
+	count = snd_ctl_poll_descriptors(src->handle, pfds, src->pfd_count);
 	if (count < 0) {
 		err = count;
 		goto end;
 	}
-	if (count != pfd_count) {
+	if (count != src->pfd_count) {
 		err = -EIO;
 		goto end;
 	}
 
-	for (i = 0; i < pfd_count; ++i) {
+	for (i = 0; i < src->pfd_count; ++i) {
 		err = epoll_ctl(epfd, op, pfds[i].fd, epev);
 		if (err < 0)
 			break;
@@ -237,18 +228,17 @@ end:
 	return err;
 }
 
-static int prepare_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
+static int prepare_dispatcher(int epfd, struct src_entry *srcs)
 {
-	int i;
+	struct src_entry *src;
 	int err = 0;
 
-	for (i = 0; i < ncards; ++i) {
-		snd_ctl_t *ctl = ctls[i];
+	for (src = srcs; src; src = src->list.next) {
 		struct epoll_event ev = {
 			.events = EPOLLIN,
-			.data.ptr = (void *)ctl,
+			.data.ptr = (void *)src,
 		};
-		err = operate_dispatcher(epfd, EPOLL_CTL_ADD, &ev, ctl);
+		err = operate_dispatcher(epfd, EPOLL_CTL_ADD, &ev, src);
 		if (err < 0)
 			break;
 	}
@@ -256,11 +246,17 @@ static int prepare_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
 	return err;
 }
 
-static int run_dispatcher(int epfd, unsigned int max_ev_count, int show_cards)
+static int run_dispatcher(int epfd, struct src_entry *srcs)
 {
+	struct src_entry *src;
+	unsigned int max_ev_count;
 	struct epoll_event *epev;
 	int err = 0;
 
+	max_ev_count = 0;
+	for (src = srcs; src; src = src->list.next)
+		max_ev_count += src->pfd_count;
+
 	epev = calloc(max_ev_count, sizeof(*epev));
 	if (!epev)
 		return -ENOMEM;
@@ -287,10 +283,9 @@ static int run_dispatcher(int epfd, unsigned int max_ev_count, int show_cards)
 
 		for (i = 0; i < count; ++i) {
 			struct epoll_event *ev = epev + i;
-			snd_ctl_t *handle = (snd_ctl_t *)ev->data.ptr;
-
+			struct src_entry *src = (struct src_entry *)ev->data.ptr;
 			if (ev->events & EPOLLIN)
-				print_event(show_cards ? i : -1, handle);
+				print_event(src->handle, src->name);
 		}
 	}
 
@@ -299,14 +294,12 @@ static int run_dispatcher(int epfd, unsigned int max_ev_count, int show_cards)
 	return err;
 }
 
-static void clear_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
+static void clear_dispatcher(int epfd, struct src_entry *srcs)
 {
-	int i;
+	struct src_entry *src;
 
-	for (i = 0; i < ncards; ++i) {
-		snd_ctl_t *ctl = ctls[i];
-		operate_dispatcher(epfd, EPOLL_CTL_DEL, NULL, ctl);
-	}
+	for (src = srcs; src; src = src->list.next)
+		operate_dispatcher(epfd, EPOLL_CTL_DEL, NULL, src);
 }
 
 static void handle_unix_signal_for_finish(int sig)
@@ -338,9 +331,7 @@ int monitor(const char *name)
 	struct src_entry *srcs = NULL;
 	snd_ctl_t *ctls[MAX_CARDS] = {0};
 	int ncards = 0;
-	int show_cards;
 	int epfd;
-	int i;
 	int err = 0;
 
 	err = prepare_signal_handler();
@@ -365,7 +356,6 @@ int monitor(const char *name)
 				goto error;
 			++ncards;
 		}
-		show_cards = 1;
 	} else {
 		err = open_ctl(name, &ctls[0]);
 		if (err < 0)
@@ -374,20 +364,14 @@ int monitor(const char *name)
 		if (err < 0)
 			goto error;
 		ncards++;
-		show_cards = 0;
 	}
 
-	err = prepare_dispatcher(epfd, ctls, ncards);
+	err = prepare_dispatcher(epfd, srcs);
 	if (err >= 0)
-		err = run_dispatcher(epfd, ncards, show_cards);
-	clear_dispatcher(epfd, ctls, ncards);
-
+		err = run_dispatcher(epfd, srcs);
+	clear_dispatcher(epfd, srcs);
 error:
 	clear_source_list(&srcs);
-	for (i = 0; i < ncards; i++) {
-		if (ctls[i])
-			snd_ctl_close(ctls[i]);
-	}
 
 	close(epfd);
 
-- 
2.19.0
