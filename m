From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 4/9] alsactl: use link list to
	maintain source of events
Date: Sun, 14 Oct 2018 23:36:29 +0900
Message-ID: <20181014143634.26066-5-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DDA0A2678FE
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:50 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id c8-v6so8032432plo.9
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:50 -0700 (PDT)
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

At present, handlers for control nodes are maintained by one-dimensional
array. This is not necessarily useful to maintain handlers with
associated information.

This commit adds link-list for the maintenance.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index 7050eeb..7a61f9c 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -25,6 +25,16 @@
 #include <sys/epoll.h>
 #include <alsa/asoundlib.h>
 
+#include <stddef.h>
+#include "list.h"
+
+struct src_entry {
+	snd_ctl_t *handle;
+	char *name;
+	unsigned int pfd_count;
+	struct list_head list;
+};
+
 #define MAX_CARDS	256
 
 struct snd_card_iterator {
@@ -55,6 +65,59 @@ static const char *snd_card_iterator_next(struct snd_card_iterator *iter)
         return (const char *)iter->name;
 }
 
+static void remove_source_entry(struct src_entry *entry)
+{
+	list_del(&entry->list);
+	free(entry->name);
+	free(entry);
+}
+
+static void clear_source_list(struct list_head *srcs)
+{
+	struct src_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, srcs, list)
+		remove_source_entry(entry);
+}
+
+static int insert_source_entry(struct list_head *srcs, snd_ctl_t *handle,
+			       const char *name)
+{
+	struct src_entry *entry;
+	int count;
+	int err;
+
+	entry = calloc(1, sizeof(*entry));
+	if (!entry)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&entry->list);
+	entry->handle = handle;
+
+	entry->name = strdup(name);
+	if (!entry->name) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	count = snd_ctl_poll_descriptors_count(handle);
+	if (count < 0) {
+		err = count;
+		goto error;
+	}
+	if (count == 0) {
+		err = -ENXIO;
+		goto error;
+	}
+	entry->pfd_count = count;
+
+	list_add_tail(&entry->list, srcs);
+
+	return 0;
+error:
+	remove_source_entry(entry);
+	return err;
+}
+
 static int open_ctl(const char *name, snd_ctl_t **ctlp)
 {
 	snd_ctl_t *ctl;
@@ -222,6 +285,7 @@ static void clear_dispatcher(int epfd, snd_ctl_t **ctls, int ncards)
 
 int monitor(const char *name)
 {
+	LIST_HEAD(srcs);
 	snd_ctl_t *ctls[MAX_CARDS] = {0};
 	int ncards = 0;
 	int show_cards;
@@ -240,6 +304,9 @@ int monitor(const char *name)
 		snd_card_iterator_init(&iter);
 		while ((cardname = snd_card_iterator_next(&iter))) {
 			err = open_ctl(cardname, &ctls[ncards]);
+			if (err < 0)
+				goto error;
+			err = insert_source_entry(&srcs, ctls[ncards], cardname);
 			if (err < 0)
 				goto error;
 			ncards++;
@@ -247,6 +314,9 @@ int monitor(const char *name)
 		show_cards = 1;
 	} else {
 		err = open_ctl(name, &ctls[0]);
+		if (err < 0)
+			goto error;
+		err = insert_source_entry(&srcs, ctls[ncards], name);
 		if (err < 0)
 			goto error;
 		ncards++;
@@ -259,6 +329,7 @@ int monitor(const char *name)
 	clear_dispatcher(epfd, ctls, ncards);
 
 error:
+	clear_source_list(&srcs);
 	for (i = 0; i < ncards; i++) {
 		if (ctls[i])
 			snd_ctl_close(ctls[i]);
-- 
2.19.1
