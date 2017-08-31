From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: vx: Put missing KERN_CONT prefix
Date: Thu, 31 Aug 2017 11:33:30 +0200
Message-ID: <20170831093334.9050-3-tiwai@suse.de>
References: <20170831093334.9050-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C0242672BE
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:33:37 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3F3B2AD35
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

The vx driver has a debug printk code without proper KERN_ prefix.
On recent kernels, KERN_CONT prefix is mandatory for continued output
lines.  Put it properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/vx/vx_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index f684fffd1397..121357397a6d 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -256,8 +256,8 @@ int vx_send_msg_nolock(struct vx_core *chip, struct vx_rmh *rmh)
 	if (rmh->LgCmd > 1) {
 		printk(KERN_DEBUG "  ");
 		for (i = 1; i < rmh->LgCmd; i++)
-			printk("0x%06x ", rmh->Cmd[i]);
-		printk("\n");
+			printk(KERN_CONT "0x%06x ", rmh->Cmd[i]);
+		printk(KERN_CONT "\n");
 	}
 #endif
 	/* Check bit M is set according to length of the command */
-- 
2.14.1
