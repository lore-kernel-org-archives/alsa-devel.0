From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: control: Fix missing __user annotation
Date: Mon, 23 Apr 2018 15:29:33 +0200
Message-ID: <20180423132933.13246-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B05D0266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 15:29:39 +0200 (CEST)
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

There is one place missing __user annotation to the pointer used by
the recent code refactoring.  Reported by sparse.

Fixes: 450296f305f1 ("ALSA: control: code refactoring TLV ioctl handler")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 69734b0eafd0..9aa15bfc7936 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1492,7 +1492,7 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
                              int op_flag)
 {
 	struct snd_ctl_tlv header;
-	unsigned int *container;
+	unsigned int __user *container;
 	unsigned int container_size;
 	struct snd_kcontrol *kctl;
 	struct snd_ctl_elem_id id;
-- 
2.16.3
