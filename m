From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 8/9] alsactl: handle detection of
	new sound card
Date: Sun, 14 Oct 2018 23:36:33 +0900
Message-ID: <20181014143634.26066-9-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F9526797E
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:58 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so8038778plt.3
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:58 -0700 (PDT)
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

At present, plug-and-play is not supported in a mode of 'monitor',
thus new sound card is not handled during runtime. This is not happy.

This commit uses Linux-specific inotify(7) to monitor '/dev/snd'
directory. When some files are newly added to the directory,
event dispatcher is suspended. Event sources are scanned again and the
dispatcher continue to run.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 118 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 10 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 559fb4c..a3c3ea4 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -23,6 +23,9 @@
 #include <stdbool.h>
 #include <string.h>
 #include <sys/epoll.h>
+#include <sys/inotify.h>
+#include <limits.h>
+#include <time.h>
 #include <alsa/asoundlib.h>
 
 #include <stddef.h>
@@ -133,6 +136,18 @@ static int open_ctl(const char *name, snd_ctl_t **ctlp)
 	return 0;
 }
 
+static inline bool seek_entry_by_name(struct list_head *srcs, const char *name)
+{
+	struct src_entry *entry;
+
+	list_for_each_entry(entry, srcs, list) {
+		if (!strcmp(entry->name, name))
+			return true;
+	}
+
+	return false;
+}
+
 static int prepare_source_entry(struct list_head *srcs, const char *name)
 {
 	snd_ctl_t *handle;
@@ -144,6 +159,8 @@ static int prepare_source_entry(struct list_head *srcs, const char *name)
 
 		snd_card_iterator_init(&iter);
 		while ((cardname = snd_card_iterator_next(&iter))) {
+			if (seek_entry_by_name(srcs, cardname))
+				continue;
 			err = open_ctl(cardname, &handle);
 			if (err < 0)
 				return err;
@@ -152,6 +169,8 @@ static int prepare_source_entry(struct list_head *srcs, const char *name)
 				return err;
 		}
 	} else {
+		if (seek_entry_by_name(srcs, name))
+			return 0;
 		err = open_ctl(name, &handle);
 		if (err < 0)
 			return err;
@@ -163,6 +182,41 @@ static int prepare_source_entry(struct list_head *srcs, const char *name)
 	return 0;
 }
 
+static int check_control_cdev(int infd, bool *retry)
+{
+	struct inotify_event *ev;
+	char *buf;
+	int err = 0;
+
+	buf = calloc(1, sizeof(*ev) + NAME_MAX);
+	if (!buf)
+		return -ENOMEM;
+
+	while (1) {
+		ssize_t len = read(infd, buf, sizeof(*ev) + NAME_MAX);
+		if (len < 0) {
+			if (errno != EAGAIN)
+				err = errno;
+			break;
+		} else if (len == 0) {
+			break;
+		}
+
+		size_t pos = 0;
+		while (pos < len) {
+			ev = (struct inotify_event *)(buf + pos);
+			if ((ev->mask & IN_CREATE) &&
+			    strstr(ev->name, "controlC") == ev->name)
+				*retry = true;
+			pos += sizeof(*ev) + ev->len;
+		}
+	}
+
+	free(buf);
+
+	return err;
+}
+
 static int print_event(snd_ctl_t *ctl, const char *name)
 {
 	snd_ctl_event_t *event;
@@ -236,13 +290,18 @@ end:
 	return err;
 }
 
-static int prepare_dispatcher(int epfd, struct list_head *srcs)
+static int prepare_dispatcher(int epfd, int infd, struct list_head *srcs)
 {
+	struct epoll_event ev = {0};
 	struct src_entry *entry;
 	int err = 0;
 
+	ev.events = EPOLLIN;
+	ev.data.fd = infd;
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, infd, &ev) < 0)
+		return -errno;
+
 	list_for_each_entry(entry, srcs, list) {
-		struct epoll_event ev;
 		ev.events = EPOLLIN;
 		ev.data.ptr = (void *)entry;
 		err = operate_dispatcher(epfd, EPOLL_CTL_ADD, &ev, entry);
@@ -253,7 +312,8 @@ static int prepare_dispatcher(int epfd, struct list_head *srcs)
 	return err;
 }
 
-static int run_dispatcher(int epfd, struct list_head *srcs)
+static int run_dispatcher(int epfd, int infd, struct list_head *srcs,
+			  bool *retry)
 {
 	struct src_entry *entry;
 	unsigned int max_ev_count;
@@ -282,7 +342,15 @@ static int run_dispatcher(int epfd, struct list_head *srcs)
 
 		for (i = 0; i < count; ++i) {
 			struct epoll_event *ev = epev + i;
-			struct src_entry *entry = (struct src_entry *)ev->data.ptr;
+
+			if (ev->data.fd == infd) {
+				err = check_control_cdev(infd, retry);
+				if (err < 0 || *retry)
+					goto end;
+				continue;
+			}
+
+			entry = ev->data.ptr;
 			if (ev->events & EPOLLIN)
 				print_event(entry->handle, entry->name);
 			if (ev->events & EPOLLERR) {
@@ -290,42 +358,72 @@ static int run_dispatcher(int epfd, struct list_head *srcs)
 				remove_source_entry(entry);
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
 
-static void clear_dispatcher(int epfd, struct list_head *srcs)
+static void clear_dispatcher(int epfd, int infd, struct list_head *srcs)
 {
 	struct src_entry *entry;
 
 	list_for_each_entry(entry, srcs, list)
 		operate_dispatcher(epfd, EPOLL_CTL_DEL, NULL, entry);
+
+	epoll_ctl(epfd, EPOLL_CTL_DEL, infd, NULL);
 }
 
 int monitor(const char *name)
 {
 	LIST_HEAD(srcs);
 	int epfd;
+	int infd;
+	int wd = 0;
+	bool retry;
 	int err = 0;
 
 	epfd = epoll_create(1);
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
 
-	err = prepare_dispatcher(epfd, &srcs);
+	err = prepare_dispatcher(epfd, infd, &srcs);
 	if (err >= 0)
-		err = run_dispatcher(epfd, &srcs);
-	clear_dispatcher(epfd, &srcs);
+		err = run_dispatcher(epfd, infd, &srcs, &retry);
+	clear_dispatcher(epfd, infd, &srcs);
+
+	if (retry) {
+		// A simple makeshift for timing gap between creation of nodes
+		// by devtmpfs and chmod() by udevd.
+		struct timespec req = { .tv_sec = 1 };
+		nanosleep(&req, NULL);
+		goto retry;
+	}
 error:
 	clear_source_list(&srcs);
 
+	if (wd > 0)
+		inotify_rm_watch(infd, wd);
+	close(infd);
+
 	close(epfd);
 
 	return err;
-- 
2.19.1
