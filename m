From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][RFC][alsa-utils 9/9] alsactl: handle detection
	of new sound card
Date: Fri,  5 Oct 2018 23:47:29 +0900
Message-ID: <20181005144729.21388-10-o-takashi@sakamocchi.jp>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 572CD26795C
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 16:47:57 +0200 (CEST)
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so4835670pgq.9
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2018 07:47:57 -0700 (PDT)
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

At present, plug-and-play is not supported in a mode of 'monitor',
thus new sound card is not handled during runtime. This is not happy.

This commit uses Linux-specific inotify(7) to monitor '/dev/snd'
directory. When some files are newly added to the directory,
event dispatcher is suspended. Event sources are scanned again and the
dispatcher continue to run.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 93 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 4eb1ad1..6b5cfd4 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -24,6 +24,7 @@
 #include <string.h>
 #include <signal.h>
 #include <sys/epoll.h>
+#include <sys/inotify.h>
 #include <alsa/asoundlib.h>
 
 static int signal_type;
@@ -94,6 +95,12 @@ static int insert_source_entry(struct src_entry **head, snd_ctl_t *handle,
 	int count;
 	int err;
 
+	// Avoid duplication at retry case.
+	for (src = *head; src; src = src->list.next) {
+		if (!strcmp(src->name, name))
+			return 0;
+	}
+
 	src = calloc(1, sizeof(*src));
 	if (!src)
 		return -ENOMEM;
@@ -181,6 +188,28 @@ static int prepare_source_entry(struct src_entry **srcs, const char *name)
 	return 0;
 }
 
+static int dump_notification(int infd)
+{
+	char buf[1024];
+	ssize_t len;
+	int err = 0;
+
+	while (1) {
+		len = read(infd, buf, 1024);
+		if (len < 0) {
+			if (errno = EAGAIN)
+				break;
+			else
+				err = errno;
+			break;
+		}
+		if (len == 0)
+			break;
+	}
+
+	return err;
+}
+
 static int print_event(snd_ctl_t *ctl, const char *name)
 {
 	snd_ctl_event_t *event;
@@ -254,16 +283,20 @@ end:
 	return err;
 }
 
-static int prepare_dispatcher(int epfd, struct src_entry *srcs)
+static int prepare_dispatcher(int epfd, int infd, struct src_entry *srcs)
 {
+	struct epoll_event ev = {0};
 	struct src_entry *src;
 	int err = 0;
 
+	ev.events = EPOLLIN;
+	ev.data.fd = infd;
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, infd, &ev) < 0)
+		return -errno;
+
 	for (src = srcs; src; src = src->list.next) {
-		struct epoll_event ev = {
-			.events = EPOLLIN,
-			.data.ptr = (void *)src,
-		};
+		ev.events = EPOLLIN;
+		ev.data.ptr = (void *)src;
 		err = operate_dispatcher(epfd, EPOLL_CTL_ADD, &ev, src);
 		if (err < 0)
 			break;
@@ -272,7 +305,8 @@ static int prepare_dispatcher(int epfd, struct src_entry *srcs)
 	return err;
 }
 
-static int run_dispatcher(int epfd, struct src_entry *srcs)
+static int run_dispatcher(int epfd, int infd, struct src_entry *srcs,
+			  bool *retry)
 {
 	struct src_entry *src;
 	unsigned int max_ev_count;
@@ -309,7 +343,16 @@ static int run_dispatcher(int epfd, struct src_entry *srcs)
 
 		for (i = 0; i < count; ++i) {
 			struct epoll_event *ev = epev + i;
-			struct src_entry *src = (struct src_entry *)ev->data.ptr;
+			struct src_entry *src;
+
+			if (ev->data.fd == infd) {
+				err = dump_notification(infd);
+				if (err == 0)
+					*retry = true;
+				goto end;
+			}
+
+			src = ev->data.ptr;
 			if (ev->events & EPOLLIN)
 				print_event(src->handle, src->name);
 			if (ev->events & EPOLLERR) {
@@ -317,19 +360,22 @@ static int run_dispatcher(int epfd, struct src_entry *srcs)
 				remove_source_entry(src);
 			}
 		}
+		if (err < 0)
+			break;
 	}
-
+end:
 	free(epev);
-
 	return err;
 }
 
-static void clear_dispatcher(int epfd, struct src_entry *srcs)
+static void clear_dispatcher(int epfd, int infd, struct src_entry *srcs)
 {
 	struct src_entry *src;
 
 	for (src = srcs; src; src = src->list.next)
 		operate_dispatcher(epfd, EPOLL_CTL_DEL, NULL, src);
+
+	epoll_ctl(epfd, EPOLL_CTL_DEL, infd, NULL);
 }
 
 static void handle_unix_signal_for_finish(int sig)
@@ -360,6 +406,9 @@ int monitor(const char *name)
 {
 	struct src_entry *srcs = NULL;
 	int epfd;
+	int infd;
+	int wd = 0;
+	bool retry;
 	int err = 0;
 
 	err = prepare_signal_handler();
@@ -370,17 +419,35 @@ int monitor(const char *name)
 	if (epfd < 0)
 		return -errno;
 
+	infd = inotify_init1(IN_NONBLOCK);
+	if (infd < 0) {
+		err = -errno;
+		goto error;
+	}
+	wd = inotify_add_watch(infd, "/dev/snd/", IN_CREATE);
+	if (wd < 0) {
+		err = -errno;
+		goto error;
+	}
+retry:
+	retry = false;
 	err = prepare_source_entry(&srcs, name);
 	if (err < 0)
 		goto error;
 
-	err = prepare_dispatcher(epfd, srcs);
+	err = prepare_dispatcher(epfd, infd, srcs);
 	if (err >= 0)
-		err = run_dispatcher(epfd, srcs);
-	clear_dispatcher(epfd, srcs);
+		err = run_dispatcher(epfd, infd, srcs, &retry);
+	clear_dispatcher(epfd, infd, srcs);
+
+	if (retry)
+		goto retry;
 error:
+	if (wd > 0)
+		inotify_rm_watch(infd, wd);
 	clear_source_list(&srcs);
 
+	close(infd);
 	close(epfd);
 
 	return err;
-- 
2.19.0
