From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: proc: Avoid possible leaks of
	snd_info_entry objects
Date: Wed, 23 Jan 2019 18:11:26 +0100
Message-ID: <20190123171126.28451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A63FB267561
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 18:11:29 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 347F4B10D
 for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2019 17:11:29 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch changes the parent pointer assignment of snd_info_entry
object to be always non-NULL.  More specifically,check the parent
argument in snd_info_create_module_entry() & co, and assign
snd_proc_root if NULL is passed there.

This assures that the proc object is always freed when the root is
freed, so avoid possible memory leaks.  For example, some error paths
(e.g. snd_info_register() error at snd_minor_info_init()) may leave
snd_info_entry object although the proc file itself is freed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index fe502bc5e6d2..2dfb6389c084 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -741,7 +741,11 @@ struct snd_info_entry *snd_info_create_module_entry(struct module * module,
 					       const char *name,
 					       struct snd_info_entry *parent)
 {
-	struct snd_info_entry *entry = snd_info_create_entry(name, parent);
+	struct snd_info_entry *entry;
+
+	if (!parent)
+		parent = snd_proc_root;
+	entry = snd_info_create_entry(name, parent);
 	if (entry)
 		entry->module = module;
 	return entry;
@@ -762,7 +766,11 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
 					     const char *name,
 					     struct snd_info_entry * parent)
 {
-	struct snd_info_entry *entry = snd_info_create_entry(name, parent);
+	struct snd_info_entry *entry;
+
+	if (!parent)
+		parent = card->proc_root;
+	entry = snd_info_create_entry(name, parent);
 	if (entry) {
 		entry->module = card->module;
 		entry->card = card;
-- 
2.16.4
