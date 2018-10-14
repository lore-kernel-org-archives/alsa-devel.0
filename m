From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 5/9] alsactl: use a list of source
	for event dispatcher instead of an array of source
Date: Sun, 14 Oct 2018 23:36:30 +0900
Message-ID: <20181014143634.26066-6-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id B92432678FE
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:52 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so7954332pge.0
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:52 -0700 (PDT)
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

In a previous commit, handlers of control nodes are maintained by link
list.

This commit uses the list to register/unregister event sources to
dispatcher.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 78 +++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 46 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 7a61f9c..878d003 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -68,6 +68,8 @@ static const char *snd_card_iterator_next(struct snd_card_iterator *iter)
 static void remove_source_entry(struct src_entry *entry)
 {
 	list_del(&entry->list);
+	if (entry->handle)
+		snd_ctl_close(entry->handle);
 	free(entry->name);
 	free(entry);
 }
@@ -138,7 +140,7 @@ static int open_ctl(const char *name, snd_ctl_t **ctlp)
 	return 0;
 }
 
-static int print_event(int card, snd_ctl_t *ctl)
+static int print_event(snd_ctl_t *ctl, const char *name)
 {
 	snd_ctl_event_t *event;
 	unsigned int mask;
@@ -152,9 +154,8 @@ static int print_event(int card, snd_ctl_t *ctl)
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
@@ -181,36 +182,28 @@ static int print_event(int card, snd_ctl_t *ctl)
 }
 
 static int operate_dispatcher(int epfd, uint32_t op, struct epoll_event *epev,
-			      snd_ctl_t *ctl)
+			      struct src_entry *entry)
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
+	pfds = calloc(entry->pfd_count, sizeof(*pfds));
 	if (!pfds)
 		return -ENOMEM;
 
-	count = snd_ctl_poll_descriptors(ctl, pfds, pfd_count);
+	count = snd_ctl_poll_descriptors(entry->handle, pfds, entry->pfd_count);
 	if (count < 0) {
 		err = count;
 		goto end;
 	}
-	if (count != pfd_count) {
+	if (count != entry->pfd_count) {
 		err = -EIO;
 		goto end;
 	}
 
-	for (i = 0; i < pfd_count; ++i) {
+	for (i = 0; i < entry->pfd_count; ++i) {
 		err = epoll_ctl(epfd, op, pfds[i].fd, epev);
 		if (err < 0)
 			break;
@@ -220,17 +213,16 @@ end:
 	return err;
 }
 
-static int prepare_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
+static int prepare_dispatcher(int epfd, struct list_head *srcs)
 {
-	int i;
+	struct src_entry *entry;
 	int err = 0;
 
-	for (i = 0; i < ncards; ++i) {
-		snd_ctl_t *ctl = ctls[i];
+	list_for_each_entry(entry, srcs, list) {
 		struct epoll_event ev;
 		ev.events = EPOLLIN;
-		ev.data.ptr = (void *)ctl;
-		err = operate_dispatcher(epfd, EPOLL_CTL_ADD, &ev, ctl);
+		ev.data.ptr = (void *)entry;
+		err = operate_dispatcher(epfd, EPOLL_CTL_ADD, &ev, entry);
 		if (err < 0)
 			break;
 	}
@@ -238,11 +230,17 @@ static int prepare_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
 	return err;
 }
 
-static int run_dispatcher(int epfd, unsigned int max_ev_count, int show_cards)
+static int run_dispatcher(int epfd, struct list_head *srcs)
 {
+	struct src_entry *entry;
+	unsigned int max_ev_count;
 	struct epoll_event *epev;
 	int err = 0;
 
+	max_ev_count = 0;
+	list_for_each_entry(entry, srcs, list)
+		max_ev_count += entry->pfd_count;
+
 	epev = calloc(max_ev_count, sizeof(*epev));
 	if (!epev)
 		return -ENOMEM;
@@ -261,10 +259,9 @@ static int run_dispatcher(int epfd, unsigned int max_ev_count, int show_cards)
 
 		for (i = 0; i < count; ++i) {
 			struct epoll_event *ev = epev + i;
-			snd_ctl_t *handle = (snd_ctl_t *)ev->data.ptr;
-
+			struct src_entry *entry = (struct src_entry *)ev->data.ptr;
 			if (ev->events & EPOLLIN)
-				print_event(show_cards ? i : -1, handle);
+				print_event(entry->handle, entry->name);
 		}
 	}
 
@@ -273,14 +270,12 @@ static int run_dispatcher(int epfd, unsigned int max_ev_count, int show_cards)
 	return err;
 }
 
-static void clear_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
+static void clear_dispatcher(int epfd, struct list_head *srcs)
 {
-	int i;
+	struct src_entry *entry;
 
-	for (i = 0; i < ncards; ++i) {
-		snd_ctl_t *ctl = ctls[i];
-		operate_dispatcher(epfd, EPOLL_CTL_DEL, NULL, ctl);
-	}
+	list_for_each_entry(entry, srcs, list)
+		operate_dispatcher(epfd, EPOLL_CTL_DEL, NULL, entry);
 }
 
 int monitor(const char *name)
@@ -288,9 +283,7 @@ int monitor(const char *name)
 	LIST_HEAD(srcs);
 	snd_ctl_t *ctls[MAX_CARDS] = {0};
 	int ncards = 0;
-	int show_cards;
 	int epfd;
-	int i;
 	int err = 0;
 
 	epfd = epoll_create(1);
@@ -311,7 +304,6 @@ int monitor(const char *name)
 				goto error;
 			ncards++;
 		}
-		show_cards = 1;
 	} else {
 		err = open_ctl(name, &ctls[0]);
 		if (err < 0)
@@ -320,20 +312,14 @@ int monitor(const char *name)
 		if (err < 0)
 			goto error;
 		ncards++;
-		show_cards = 0;
 	}
 
-	err = prepare_dispatcher(epfd, ctls, ncards);
+	err = prepare_dispatcher(epfd, &srcs);
 	if (err >= 0)
-		err = run_dispatcher(epfd, ncards, show_cards);
-	clear_dispatcher(epfd, ctls, ncards);
-
+		err = run_dispatcher(epfd, &srcs);
+	clear_dispatcher(epfd, &srcs);
 error:
 	clear_source_list(&srcs);
-	for (i = 0; i < ncards; i++) {
-		if (ctls[i])
-			snd_ctl_close(ctls[i]);
-	}
 
 	close(epfd);
 
-- 
2.19.1
