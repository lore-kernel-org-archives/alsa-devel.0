From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: opl3: Kill unused set_fs()
Date: Tue, 16 May 2017 09:31:59 +0200
Message-ID: <20170516073200.29504-2-tiwai@suse.de>
References: <20170516073200.29504-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6291E2674CF
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:32:02 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D2C1EABCA
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 07:32:01 +0000 (UTC)
In-Reply-To: <20170516073200.29504-1-tiwai@suse.de>
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

snd_enter_user() and snd_leave_user() that call set_fs() are the dead
code in opl3 driver.  Let's rip them off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl3/opl3_oss.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/drivers/opl3/opl3_oss.c b/sound/drivers/opl3/opl3_oss.c
index c1cb249acfaa..22c3e4bca220 100644
--- a/sound/drivers/opl3/opl3_oss.c
+++ b/sound/drivers/opl3/opl3_oss.c
@@ -27,20 +27,6 @@ static int snd_opl3_ioctl_seq_oss(struct snd_seq_oss_arg *arg, unsigned int cmd,
 static int snd_opl3_load_patch_seq_oss(struct snd_seq_oss_arg *arg, int format, const char __user *buf, int offs, int count);
 static int snd_opl3_reset_seq_oss(struct snd_seq_oss_arg *arg);
 
-/* */
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
 /* operators */
 
 extern struct snd_midi_op opl3_ops;
-- 
2.12.2
