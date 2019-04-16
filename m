From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: info: Fix racy addition/deletion of
	nodes
Date: Tue, 16 Apr 2019 17:21:02 +0200
Message-ID: <20190416152103.6189-2-tiwai@suse.de>
References: <20190416152103.6189-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94BB0F89616
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 17:21:05 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E30D7AEFF
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 15:21:04 +0000 (UTC)
In-Reply-To: <20190416152103.6189-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The ALSA proc helper manages the child nodes in a linked list, but its
addition and deletion is done without any lock.  This leads to a
corruption if they are operated concurrently.  Usually this isn't a
problem because the proc entries are added sequentially in the driver
probe procedure itself.  But the card registrations are done often
asynchronously, and the crash could be actually reproduced with
syzkaller.

This patch papers over it by protecting the link addition and deletion
with the parent's mutex.  There is "access" mutex that is used for the
file access, and this can be reused for this purpose as well.

Reported-by: syzbot+48df349490c36f9f54ab@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 96a074019c33..0eb169acc850 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -713,8 +713,11 @@ snd_info_create_entry(const char *name, struct snd_info_entry *parent,
 	INIT_LIST_HEAD(&entry->list);
 	entry->parent = parent;
 	entry->module = module;
-	if (parent)
+	if (parent) {
+		mutex_lock(&parent->access);
 		list_add_tail(&entry->list, &parent->children);
+		mutex_unlock(&parent->access);
+	}
 	return entry;
 }
 
@@ -792,7 +795,12 @@ void snd_info_free_entry(struct snd_info_entry * entry)
 	list_for_each_entry_safe(p, n, &entry->children, list)
 		snd_info_free_entry(p);
 
-	list_del(&entry->list);
+	p = entry->parent;
+	if (p) {
+		mutex_lock(&p->access);
+		list_del(&entry->list);
+		mutex_unlock(&p->access);
+	}
 	kfree(entry->name);
 	if (entry->private_free)
 		entry->private_free(entry);
-- 
2.16.4
