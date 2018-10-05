From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][RFC][alsa-utils 7/9] alsactl: obsolete array
	for maintenance of handlers
Date: Fri,  5 Oct 2018 23:47:27 +0900
Message-ID: <20181005144729.21388-8-o-takashi@sakamocchi.jp>
References: <20181005144729.21388-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 2502626792E
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 16:47:51 +0200 (CEST)
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so6957200plr.1
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2018 07:47:51 -0700 (PDT)
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

In former commits, handlers of control node are maintained by link list,
instead of one-dimensional array.

This commit obsoletes the array and split source preparation to a
function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 68 +++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 506f504..807963c 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -39,8 +39,6 @@ struct src_entry {
 	} list;
 };
 
-#define MAX_CARDS	256
-
 struct snd_card_iterator {
         int card;
         char name[16];
@@ -58,11 +56,6 @@ static const char *snd_card_iterator_next(struct snd_card_iterator *iter)
                 return NULL;
         if (iter->card < 0)
                 return NULL;
-	if (iter->card >= MAX_CARDS) {
-		fprintf(stderr, "alsactl: too many cards\n");
-		return NULL;
-	}
-
 
         snprintf(iter->name, sizeof(iter->name), "hw:%d", iter->card);
 
@@ -88,6 +81,8 @@ static void clear_source_list(struct src_entry **srcs)
 		struct src_entry *src = *srcs;
 		*srcs = src->list.next;
 
+		snd_ctl_subscribe_events(src->handle, 0);
+		snd_ctl_close(src->handle);
 		remove_source_entry(src);
 	}
 }
@@ -131,6 +126,7 @@ static int insert_source_entry(struct src_entry **head, snd_ctl_t *handle,
 
 	return 0;
 error:
+	free(src->name);
 	free(src);
 	return err;
 }
@@ -155,6 +151,36 @@ static int open_ctl(const char *name, snd_ctl_t **ctlp)
 	return 0;
 }
 
+static int prepare_source_entry(struct src_entry **srcs, const char *name)
+{
+	snd_ctl_t *handle;
+	int err;
+
+	if (!name) {
+		struct snd_card_iterator iter;
+		const char *cardname;
+
+		snd_card_iterator_init(&iter);
+		while ((cardname = snd_card_iterator_next(&iter))) {
+			err = open_ctl(cardname, &handle);
+			if (err < 0)
+				return err;
+			err = insert_source_entry(srcs, handle, cardname);
+			if (err < 0)
+				return err;
+		}
+	} else {
+		err = open_ctl(name, &handle);
+		if (err < 0)
+			return err;
+		err = insert_source_entry(srcs, handle, name);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int print_event(snd_ctl_t *ctl, const char *name)
 {
 	snd_ctl_event_t *event;
@@ -329,8 +355,6 @@ static int prepare_signal_handler(void)
 int monitor(const char *name)
 {
 	struct src_entry *srcs = NULL;
-	snd_ctl_t *ctls[MAX_CARDS] = {0};
-	int ncards = 0;
 	int epfd;
 	int err = 0;
 
@@ -342,29 +366,9 @@ int monitor(const char *name)
 	if (epfd < 0)
 		return -errno;
 
-	if (!name) {
-		struct snd_card_iterator iter;
-		const char *cardname;
-
-		snd_card_iterator_init(&iter);
-		while ((cardname = snd_card_iterator_next(&iter))) {
-			err = open_ctl(cardname, &ctls[ncards]);
-			if (err < 0)
-				goto error;
-			err = insert_source_entry(&srcs, ctls[ncards], cardname);
-			if (err < 0)
-				goto error;
-			++ncards;
-		}
-	} else {
-		err = open_ctl(name, &ctls[0]);
-		if (err < 0)
-			goto error;
-		err = insert_source_entry(&srcs, ctls[ncards], name);
-		if (err < 0)
-			goto error;
-		ncards++;
-	}
+	err = prepare_source_entry(&srcs, name);
+	if (err < 0)
+		goto error;
 
 	err = prepare_dispatcher(epfd, srcs);
 	if (err >= 0)
-- 
2.19.0
