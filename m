From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: asihpi: Put missing KERN_CONT prefix
Date: Thu, 31 Aug 2017 11:33:31 +0200
Message-ID: <20170831093334.9050-4-tiwai@suse.de>
References: <20170831093334.9050-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BF3B2672BB
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:33:37 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 43163AD4E
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 09:33:37 +0000 (UTC)
In-Reply-To: <20170831093334.9050-1-tiwai@suse.de>
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

The asihpi driver has a debug printk code without proper KERN_
prefix.  On recent kernels, KERN_CONT prefix is mandatory for
continued output lines.  Put it properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/asihpi/hpidebug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/hpidebug.c b/sound/pci/asihpi/hpidebug.c
index ac86a1f1d3bf..9e122327dc05 100644
--- a/sound/pci/asihpi/hpidebug.c
+++ b/sound/pci/asihpi/hpidebug.c
@@ -71,8 +71,8 @@ void hpi_debug_data(u16 *pdata, u32 len)
 		printk(KERN_DEBUG "%p:", (pdata + i));
 
 		for (k = 0; k < cols && i < len; i++, k++)
-			printk("%s%04x", k == 0 ? "" : " ", pdata[i]);
+			printk(KERN_CONT "%s%04x", k == 0 ? "" : " ", pdata[i]);
 
-		printk("\n");
+		printk(KERN_CONT "\n");
 	}
 }
-- 
2.14.1
