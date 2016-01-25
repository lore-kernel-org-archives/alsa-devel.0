From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: seq: Degrade the error message for
	too many opens
Date: Mon, 25 Jan 2016 13:53:28 +0100
Message-ID: <1453726408-16004-2-git-send-email-tiwai@suse.de>
References: <1453726408-16004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AAB07260532
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 13:53:34 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 32DD1ABB4
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 12:53:33 +0000 (UTC)
In-Reply-To: <1453726408-16004-1-git-send-email-tiwai@suse.de>
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

ALSA OSS sequencer spews a kernel error message ("ALSA: seq_oss: too
many applications") when user-space tries to open more than the
limit.  This means that it can easily fill the log buffer.

Since it's merely a normal error, it's safe to suppress it via
pr_debug() instead.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index b1221b29728e..6779e82b46dd 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -202,7 +202,7 @@ snd_seq_oss_open(struct file *file, int level)
 
 	dp->index = i;
 	if (i >= SNDRV_SEQ_OSS_MAX_CLIENTS) {
-		pr_err("ALSA: seq_oss: too many applications\n");
+		pr_debug("ALSA: seq_oss: too many applications\n");
 		rc = -ENOMEM;
 		goto _error;
 	}
-- 
2.7.0
