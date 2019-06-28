From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: seq: fix incorrect order of dest_client/dest_ports arguments
Date: Fri, 28 Jun 2019 10:54:29 +0100
Message-ID: <20190628095429.13369-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There are two occurrances of a call to snd_seq_oss_fill_addr where
the dest_client and dest_port arguments are in the wrong order. Fix
this by swapping them around.

Addresses-Coverity: ("Arguments in wrong order")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/seq/oss/seq_oss_ioctl.c | 2 +-
 sound/core/seq/oss/seq_oss_rw.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_ioctl.c b/sound/core/seq/oss/seq_oss_ioctl.c
index 96ad01fb668c..ccf682689ec9 100644
--- a/sound/core/seq/oss/seq_oss_ioctl.c
+++ b/sound/core/seq/oss/seq_oss_ioctl.c
@@ -49,7 +49,7 @@ static int snd_seq_oss_oob_user(struct seq_oss_devinfo *dp, void __user *arg)
 	if (copy_from_user(ev, arg, 8))
 		return -EFAULT;
 	memset(&tmpev, 0, sizeof(tmpev));
-	snd_seq_oss_fill_addr(dp, &tmpev, dp->addr.port, dp->addr.client);
+	snd_seq_oss_fill_addr(dp, &tmpev, dp->addr.client, dp->addr.port);
 	tmpev.time.tick = 0;
 	if (! snd_seq_oss_process_event(dp, (union evrec *)ev, &tmpev)) {
 		snd_seq_oss_dispatch(dp, &tmpev, 0, 0);
diff --git a/sound/core/seq/oss/seq_oss_rw.c b/sound/core/seq/oss/seq_oss_rw.c
index 79ef430e56e1..537d5f423e20 100644
--- a/sound/core/seq/oss/seq_oss_rw.c
+++ b/sound/core/seq/oss/seq_oss_rw.c
@@ -161,7 +161,7 @@ insert_queue(struct seq_oss_devinfo *dp, union evrec *rec, struct file *opt)
 	memset(&event, 0, sizeof(event));
 	/* set dummy -- to be sure */
 	event.type = SNDRV_SEQ_EVENT_NOTEOFF;
-	snd_seq_oss_fill_addr(dp, &event, dp->addr.port, dp->addr.client);
+	snd_seq_oss_fill_addr(dp, &event, dp->addr.client, dp->addr.port);
 
 	if (snd_seq_oss_process_event(dp, rec, &event))
 		return 0; /* invalid event - no need to insert queue */
-- 
2.20.1
