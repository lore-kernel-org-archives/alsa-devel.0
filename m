From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Fix poll() error return
Date: Wed, 25 Jul 2018 22:53:07 +0200
Message-ID: <20180725205307.16761-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A47DA26774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 22:53:09 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D3369B05D
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 20:53:08 +0000 (UTC)
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

The sanity checks in ALSA sequencer and OSS sequencer emulation codes
return falsely -ENXIO from poll callback.  They should be EPOLLERR
instead.

This was caught thanks to the recent change to the return value.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss.c   | 2 +-
 sound/core/seq/seq_clientmgr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index 5f64d0d88320..e1f44fc86885 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -203,7 +203,7 @@ odev_poll(struct file *file, poll_table * wait)
 	struct seq_oss_devinfo *dp;
 	dp = file->private_data;
 	if (snd_BUG_ON(!dp))
-		return -ENXIO;
+		return EPOLLERR;
 	return snd_seq_oss_poll(dp, file, wait);
 }
 
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 56ca78423040..6fd4b074b206 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1101,7 +1101,7 @@ static __poll_t snd_seq_poll(struct file *file, poll_table * wait)
 
 	/* check client structures are in place */
 	if (snd_BUG_ON(!client))
-		return -ENXIO;
+		return EPOLLERR;
 
 	if ((snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_INPUT) &&
 	    client->data.user.fifo) {
-- 
2.18.0
