From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: info: Fix leaks of child entries at
	snd_info_free_entry()
Date: Mon, 18 May 2015 09:57:01 +0200
Message-ID: <1431935824-8670-2-git-send-email-tiwai@suse.de>
References: <1431935824-8670-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 240C726048D
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 09:57:07 +0200 (CEST)
In-Reply-To: <1431935824-8670-1-git-send-email-tiwai@suse.de>
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
Cc: libin.yang@intel.com, han.lu@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

snd_info_free_entry() releases the all children nodes as well, but due
to the wrong timing of releasing the link, the children nodes may be
disconnected but left unreleased.  This patch fixes it by moving the
link free at the right position.  Also it eases list_for_each_entry()
without _safe option in snd_info_disconnect() because it no longer
frees the children nodes there.

Fixes: c560a6797e3b ('ALSA: core: Remove child proc file elements recursively')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index c8a413d6cc9b..566279374683 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -738,13 +738,12 @@ EXPORT_SYMBOL(snd_info_create_card_entry);
 
 static void snd_info_disconnect(struct snd_info_entry *entry)
 {
-	struct snd_info_entry *p, *n;
+	struct snd_info_entry *p;
 
 	if (!entry->p)
 		return;
-	list_for_each_entry_safe(p, n, &entry->children, list)
+	list_for_each_entry(p, &entry->children, list)
 		snd_info_disconnect(p);
-	list_del_init(&entry->list);
 	proc_remove(entry->p);
 	entry->p = NULL;
 }
@@ -771,6 +770,7 @@ void snd_info_free_entry(struct snd_info_entry * entry)
 	list_for_each_entry_safe(p, n, &entry->children, list)
 		snd_info_free_entry(p);
 
+	list_del(&entry->list);
 	kfree(entry->name);
 	if (entry->private_free)
 		entry->private_free(entry);
-- 
2.3.6
