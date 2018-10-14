From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-utils][PATCH 2/9] alsactl: add an iterator of
	registered instances of sound card
Date: Sun, 14 Oct 2018 23:36:27 +0900
Message-ID: <20181014143634.26066-3-o-takashi@sakamocchi.jp>
References: <20181014143634.26066-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B0F82677D8
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 16:36:46 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so8058265plb.2
 for <alsa-devel@alsa-project.org>; Sun, 14 Oct 2018 07:36:46 -0700 (PDT)
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

In a mode of 'monitor', when given no argument, all of available control
node is observed for their events. At present, discovering the nodes is
done according to sound card number, instead of listing nodes in
configuration space of alsa-lib.

This commit adds a structure to discover sound cards with a simple
interface.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 alsactl/monitor.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/alsactl/monitor.c b/alsactl/monitor.c
index fb3fc18..008ceb3 100644
--- a/alsactl/monitor.c
+++ b/alsactl/monitor.c
@@ -22,6 +22,36 @@
 #include <stdio.h>
 #include <alsa/asoundlib.h>
 
+#define MAX_CARDS	256
+
+struct snd_card_iterator {
+        int card;
+        char name[16];
+};
+
+void snd_card_iterator_init(struct snd_card_iterator *iter)
+{
+        iter->card = -1;
+        memset(iter->name, 0, sizeof(iter->name));
+}
+
+static const char *snd_card_iterator_next(struct snd_card_iterator *iter)
+{
+        if (snd_card_next(&iter->card) < 0)
+                return NULL;
+        if (iter->card < 0)
+                return NULL;
+	if (iter->card >= MAX_CARDS) {
+		fprintf(stderr, "alsactl: too many cards\n");
+		return NULL;
+	}
+
+
+        snprintf(iter->name, sizeof(iter->name), "hw:%d", iter->card);
+
+        return (const char *)iter->name;
+}
+
 static int open_ctl(const char *name, snd_ctl_t **ctlp)
 {
 	snd_ctl_t *ctl;
@@ -113,8 +143,6 @@ static int run_dispatcher(snd_ctl_t **ctls, int ncards, int show_cards)
 	return err;
 }
 
-#define MAX_CARDS	256
-
 int monitor(const char *name)
 {
 	snd_ctl_t *ctls[MAX_CARDS];
@@ -123,15 +151,11 @@ int monitor(const char *name)
 	int i, err = 0;
 
 	if (!name) {
-		int card = -1;
-		while (snd_card_next(&card) >= 0 && card >= 0) {
-			char cardname[16];
-			if (ncards >= MAX_CARDS) {
-				fprintf(stderr, "alsactl: too many cards\n");
-				err = -E2BIG;
-				goto error;
-			}
-			sprintf(cardname, "hw:%d", card);
+		struct snd_card_iterator iter;
+		const char *cardname;
+
+		snd_card_iterator_init(&iter);
+		while ((cardname = snd_card_iterator_next(&iter))) {
 			err = open_ctl(cardname, &ctls[ncards]);
 			if (err < 0)
 				goto error;
-- 
2.19.1
