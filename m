From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 6/9] alsactl: obsolete array for
	maintenance of handlers
Date: Sun, 14 Oct 2018 23:36:31 +0900
Message-ID: <20181014143634.26066-7-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A70626797E
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:54 +0200 (CEST)
Received: by mail-pf1-f195.google.com with SMTP id l81-v6so8401286pfg.3
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:54 -0700 (PDT)
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

In former commits, handlers of control node are maintained by link list,
instead of one-dimensional array.

This commit obsoletes the array and split source preparation to a
function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 65 ++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 878d003..09ef63c 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -35,8 +35,6 @@ struct src_entry {
 	struct list_head list;
 };
 
-#define MAX_CARDS	256
-
 struct snd_card_iterator {
         int card;
         char name[16];
@@ -54,11 +52,6 @@ static const char *snd_card_iterator_next(struct snd_card_iterator *iter)
                 return NULL;
         if (iter->card < 0)
                 return NULL;
-	if (iter->card >= MAX_CARDS) {
-		fprintf(stderr, "alsactl: too many cards\n");
-		return NULL;
-	}
-
 
         snprintf(iter->name, sizeof(iter->name), "hw:%d", iter->card);
 
@@ -140,6 +133,36 @@ static int open_ctl(const char *name, snd_ctl_t **ctlp)
 	return 0;
 }
 
+static int prepare_source_entry(struct list_head *srcs, const char *name)
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
@@ -281,8 +304,6 @@ static void clear_dispatcher(int epfd, struct list_head *srcs)
 int monitor(const char *name)
 {
 	LIST_HEAD(srcs);
-	snd_ctl_t *ctls[MAX_CARDS] = {0};
-	int ncards = 0;
 	int epfd;
 	int err = 0;
 
@@ -290,29 +311,9 @@ int monitor(const char *name)
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
-			ncards++;
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
 
 	err = prepare_dispatcher(epfd, &srcs);
 	if (err >= 0)
-- 
2.19.1
