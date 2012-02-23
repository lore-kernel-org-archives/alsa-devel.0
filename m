From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [trivial] sound: Fix typo in ctvmem.c
Date: Thu, 23 Feb 2012 23:23:06 +0900
Message-ID: <1330006986-1696-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iwai@suse.de, alsa-devel@alsa-project.org, perex@perex.cz
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, Masanari Iida <standby24x7@gmail.com>
List-Id: alsa-devel@alsa-project.org

Correct spelling "virtural" to "virtual" in
sound/pci/ctxfi/ctvmem.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/pci/ctxfi/ctvmem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/ctxfi/ctvmem.c b/sound/pci/ctxfi/ctvmem.c
index b78f3fc..6109490 100644
--- a/sound/pci/ctxfi/ctvmem.c
+++ b/sound/pci/ctxfi/ctvmem.c
@@ -36,7 +36,7 @@ get_vm_block(struct ct_vm *vm, unsigned int size)
 
 	size = CT_PAGE_ALIGN(size);
 	if (size > vm->size) {
-		printk(KERN_ERR "ctxfi: Fail! No sufficient device virtural "
+		printk(KERN_ERR "ctxfi: Fail! No sufficient device virtual "
 				  "memory space available!\n");
 		return NULL;
 	}
-- 
1.7.6.5
