From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: ctl: evaluate macro instead of
	numerical value
Date: Thu,  9 Apr 2015 01:55:07 +0900
Message-ID: <1428512108-1852-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1428512108-1852-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E509265680
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 18:55:13 +0200 (CEST)
In-Reply-To: <1428512108-1852-1-git-send-email-o-takashi@sakamocchi.jp>
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

SNDRV_CTL_TLV_OP_XXX is defined but not used in core code. Instead,
raw numerical value is evaluated.

This commit replaces these values to these macros for better looking.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 2ab7ee5..de19d56 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1114,7 +1114,7 @@ static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
 	int change = 0;
 	void *new_data;
 
-	if (op_flag > 0) {
+	if (op_flag == SNDRV_CTL_TLV_OP_WRITE) {
 		if (size > 1024 * 128)	/* sane value */
 			return -EINVAL;
 
@@ -1411,9 +1411,12 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 		goto __kctl_end;
 	}
 	vd = &kctl->vd[tlv.numid - kctl->id.numid];
-	if ((op_flag == 0 && (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_READ) == 0) ||
-	    (op_flag > 0 && (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_WRITE) == 0) ||
-	    (op_flag < 0 && (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND) == 0)) {
+	if ((op_flag == SNDRV_CTL_TLV_OP_READ &&
+	     (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_READ) == 0) ||
+	    (op_flag == SNDRV_CTL_TLV_OP_WRITE &&
+	     (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_WRITE) == 0) ||
+	    (op_flag == SNDRV_CTL_TLV_OP_CMD &&
+	     (vd->access & SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND) == 0)) {
 	    	err = -ENXIO;
 	    	goto __kctl_end;
 	}
@@ -1430,7 +1433,7 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 			return 0;
 		}
 	} else {
-		if (op_flag) {
+		if (op_flag != SNDRV_CTL_ELEM_ACCESS_TLV_READ) {
 			err = -ENXIO;
 			goto __kctl_end;
 		}
-- 
2.1.0
