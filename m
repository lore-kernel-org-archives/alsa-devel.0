From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireworks: fix specifiers in format
	strings for propper output
Date: Tue,  5 Aug 2014 11:17:10 +0900
Message-ID: <1407205030-12568-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A5A1426501D
 for <alsa-devel@alsa-project.org>; Tue,  5 Aug 2014 04:17:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: hans@hanshq.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use %d for loop counter and %X for device capabilities. This is a
supplemental patch for Hans Wennborg's patch.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/fireworks_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_proc.c b/sound/firewire/fireworks/fireworks_proc.c
index 02bf394..0639dcb 100644
--- a/sound/firewire/fireworks/fireworks_proc.c
+++ b/sound/firewire/fireworks/fireworks_proc.c
@@ -64,7 +64,7 @@ proc_read_hwinfo(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		    hwinfo->phys_in_grp_count);
 	for (i = 0; i < hwinfo->phys_in_grp_count; i++) {
 		snd_iprintf(buffer,
-			    "phys in grp[0x%d]: type 0x%d, count 0x%x\n",
+			    "phys in grp[%d]: type 0x%X, count 0x%X\n",
 			    i, hwinfo->phys_out_grps[i].type,
 			    hwinfo->phys_out_grps[i].count);
 	}
@@ -73,7 +73,7 @@ proc_read_hwinfo(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		    hwinfo->phys_out_grp_count);
 	for (i = 0; i < hwinfo->phys_out_grp_count; i++) {
 		snd_iprintf(buffer,
-			    "phys out grps[0x%d]: type 0x%d, count 0x%x\n",
+			    "phys out grps[%d]: type 0x%X, count 0x%X\n",
 			    i, hwinfo->phys_out_grps[i].type,
 			    hwinfo->phys_out_grps[i].count);
 	}
-- 
1.9.1
