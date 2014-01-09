From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: Remove superfluous header inclusions
	in memalloc.c
Date: Thu,  9 Jan 2014 10:14:53 +0100
Message-ID: <1389258894-27940-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F902625D3
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 10:14:55 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0F4B1ABC7
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 09:14:55 +0000 (UTC)
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

After cutting off the proc and page reservation codes, we don't need
many headers any longer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/memalloc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index be1544ac4613..e568c14ca88d 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -22,17 +22,13 @@
  */
 
 #include <linux/module.h>
-#include <linux/proc_fs.h>
 #include <linux/init.h>
-#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
-#include <linux/seq_file.h>
 #include <asm/uaccess.h>
 #include <linux/dma-mapping.h>
 #include <linux/genalloc.h>
 #include <linux/moduleparam.h>
-#include <linux/mutex.h>
 #include <sound/memalloc.h>
 
 
-- 
1.8.5.2
