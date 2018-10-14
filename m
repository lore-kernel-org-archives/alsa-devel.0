From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 9/9] alsactl: use signalfd to catch
	UNIX signal
Date: Sun, 14 Oct 2018 23:36:34 +0900
Message-ID: <20181014143634.26066-10-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D348267962
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:59 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so8034836plp.6
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:59 -0700 (PDT)
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

In a mode of 'monitor, event loop runs to dispatch asynchronous event
emitted by control node. In this case, UNIX signal is used to terminate
the event loop.

This commit uses signalfd to catch the UNIX signal.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 57 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index a3c3ea4..282fb1c 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -26,6 +26,8 @@
 #include <sys/inotify.h>
 #include <limits.h>
 #include <time.h>
+#include <signal.h>
+#include <sys/signalfd.h>
 #include <alsa/asoundlib.h>
 
 #include <stddef.h>
@@ -290,12 +292,18 @@ end:
 	return err;
 }
 
-static int prepare_dispatcher(int epfd, int infd, struct list_head *srcs)
+static int prepare_dispatcher(int epfd, int sigfd, int infd,
+			      struct list_head *srcs)
 {
 	struct epoll_event ev = {0};
 	struct src_entry *entry;
 	int err = 0;
 
+	ev.events = EPOLLIN;
+	ev.data.fd = sigfd;
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, sigfd, &ev) < 0)
+		return -errno;
+
 	ev.events = EPOLLIN;
 	ev.data.fd = infd;
 	if (epoll_ctl(epfd, EPOLL_CTL_ADD, infd, &ev) < 0)
@@ -312,7 +320,7 @@ static int prepare_dispatcher(int epfd, int infd, struct list_head *srcs)
 	return err;
 }
 
-static int run_dispatcher(int epfd, int infd, struct list_head *srcs,
+static int run_dispatcher(int epfd, int sigfd, int infd, struct list_head *srcs,
 			  bool *retry)
 {
 	struct src_entry *entry;
@@ -343,6 +351,9 @@ static int run_dispatcher(int epfd, int infd, struct list_head *srcs,
 		for (i = 0; i < count; ++i) {
 			struct epoll_event *ev = epev + i;
 
+			if (ev->data.fd == sigfd)
+				goto end;
+
 			if (ev->data.fd == infd) {
 				err = check_control_cdev(infd, retry);
 				if (err < 0 || *retry)
@@ -366,7 +377,8 @@ end:
 	return err;
 }
 
-static void clear_dispatcher(int epfd, int infd, struct list_head *srcs)
+static void clear_dispatcher(int epfd, int sigfd, int infd,
+			     struct list_head *srcs)
 {
 	struct src_entry *entry;
 
@@ -374,20 +386,49 @@ static void clear_dispatcher(int epfd, int infd, struct list_head *srcs)
 		operate_dispatcher(epfd, EPOLL_CTL_DEL, NULL, entry);
 
 	epoll_ctl(epfd, EPOLL_CTL_DEL, infd, NULL);
+
+	epoll_ctl(epfd, EPOLL_CTL_DEL, sigfd, NULL);
+}
+
+static int prepare_signalfd(int *sigfd)
+{
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0)
+		return -errno;
+
+	fd = signalfd(-1, &mask, 0);
+	if (fd < 0)
+		return -errno;
+	*sigfd = fd;
+
+	return 0;
 }
 
 int monitor(const char *name)
 {
 	LIST_HEAD(srcs);
+	int sigfd = 0;
 	int epfd;
 	int infd;
 	int wd = 0;
 	bool retry;
 	int err = 0;
 
+	err = prepare_signalfd(&sigfd);
+	if (err < 0)
+		return err;
+
 	epfd = epoll_create(1);
-	if (epfd < 0)
+	if (epfd < 0) {
+		close(sigfd);
 		return -errno;
+	}
 
 	infd = inotify_init1(IN_NONBLOCK);
 	if (infd < 0) {
@@ -405,10 +446,10 @@ retry:
 	if (err < 0)
 		goto error;
 
-	err = prepare_dispatcher(epfd, infd, &srcs);
+	err = prepare_dispatcher(epfd, sigfd, infd, &srcs);
 	if (err >= 0)
-		err = run_dispatcher(epfd, infd, &srcs, &retry);
-	clear_dispatcher(epfd, infd, &srcs);
+		err = run_dispatcher(epfd, sigfd, infd, &srcs, &retry);
+	clear_dispatcher(epfd, sigfd, infd, &srcs);
 
 	if (retry) {
 		// A simple makeshift for timing gap between creation of nodes
@@ -426,5 +467,7 @@ error:
 
 	close(epfd);
 
+	close(sigfd);
+
 	return err;
 }
-- 
2.19.1
