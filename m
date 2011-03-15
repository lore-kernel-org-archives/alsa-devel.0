From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH 12/13] alsa: use list_move() instead of list_del()/list_add() combination
Date: Wed, 16 Mar 2011 00:53:24 +0200
Message-ID: <1300229605-14499-12-git-send-email-kirill@shutemov.name>
References: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300229605-14499-1-git-send-email-kirill@shutemov.name>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/ctxfi/ctvmem.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ctxfi/ctvmem.c b/sound/pci/ctxfi/ctvmem.c
index 65da6e4..b78f3fc 100644
--- a/sound/pci/ctxfi/ctvmem.c
+++ b/sound/pci/ctxfi/ctvmem.c
@@ -52,8 +52,7 @@ get_vm_block(struct ct_vm *vm, unsigned int size)
 
 	if (entry->size == size) {
 		/* Move the vm node from unused list to used list directly */
-		list_del(&entry->list);
-		list_add(&entry->list, &vm->used);
+		list_move(&entry->list, &vm->used);
 		vm->size -= size;
 		block = entry;
 		goto out;
-- 
1.7.4.1
