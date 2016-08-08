From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/27] ALSA: seq: obsolete address limit helper
Date: Mon,  8 Aug 2016 23:54:33 +0900
Message-ID: <1470668093-31027-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D05EA26713E
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:01 +0200 (CEST)
In-Reply-To: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Former commits make it useless to change address limit of running task.
This commit obsoletes helper functions for it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/seq/seq_clientmgr.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 449eb7a..a6369ca 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -87,21 +87,6 @@ static int snd_seq_deliver_single_event(struct snd_seq_client *client,
 
 /*
  */
- 
-static inline mm_segment_t snd_enter_user(void)
-{
-	mm_segment_t fs = get_fs();
-	set_fs(get_ds());
-	return fs;
-}
-
-static inline void snd_leave_user(mm_segment_t fs)
-{
-	set_fs(fs);
-}
-
-/*
- */
 static inline unsigned short snd_seq_file_flags(struct file *file)
 {
         switch (file->f_mode & (FMODE_READ | FMODE_WRITE)) {
-- 
2.7.4
