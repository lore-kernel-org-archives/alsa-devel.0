From: Hans Wennborg <hans@hanshq.net>
Subject: [PATCH 18/19] sound: fireworks: fix %d confusingly prefixed with 0x in format strings
Date: Sun,  3 Aug 2014 17:21:16 -0700
Message-ID: <1407111676-15309-1-git-send-email-hans@hanshq.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: clemens@ladisch.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Hans Wennborg <hans@hanshq.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Hans Wennborg <hans@hanshq.net>
---
 sound/firewire/fireworks/fireworks_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/fireworks/fireworks_proc.c b/sound/firewire/fireworks/fireworks_proc.c
index f29d4aa..02bf394 100644
--- a/sound/firewire/fireworks/fireworks_proc.c
+++ b/sound/firewire/fireworks/fireworks_proc.c
@@ -64,7 +64,7 @@ proc_read_hwinfo(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		    hwinfo->phys_in_grp_count);
 	for (i = 0; i < hwinfo->phys_in_grp_count; i++) {
 		snd_iprintf(buffer,
-			    "phys in grp[0x%d]: type 0x%d, count 0x%d\n",
+			    "phys in grp[0x%d]: type 0x%d, count 0x%x\n",
 			    i, hwinfo->phys_out_grps[i].type,
 			    hwinfo->phys_out_grps[i].count);
 	}
@@ -73,7 +73,7 @@ proc_read_hwinfo(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 		    hwinfo->phys_out_grp_count);
 	for (i = 0; i < hwinfo->phys_out_grp_count; i++) {
 		snd_iprintf(buffer,
-			    "phys out grps[0x%d]: type 0x%d, count 0x%d\n",
+			    "phys out grps[0x%d]: type 0x%d, count 0x%x\n",
 			    i, hwinfo->phys_out_grps[i].type,
 			    hwinfo->phys_out_grps[i].count);
 	}
-- 
2.0.0.526.g5318336
