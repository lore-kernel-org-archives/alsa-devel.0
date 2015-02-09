From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: control: evaluate macro instead of
	numerical value
Date: Tue, 10 Feb 2015 00:02:27 +0900
Message-ID: <1423494147-24103-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp, tiwai@alsa-project.org, clemens@ladisch.de
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
index 8aae6ea..6a72b3e 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1077,7 +1077,7 @@ static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
 	int change = 0;
 	void *new_data;
 
-	if (op_flag > 0) {
+	if (op_flag == SNDRV_CTL_TLV_OP_WRITE) {
 		if (size > 1024 * 128)	/* sane value */
 			return -EINVAL;
 
@@ -1333,9 +1333,12 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
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
@@ -1352,7 +1355,7 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 			return 0;
 		}
 	} else {
-		if (op_flag) {
+		if (op_flag != SNDRV_CTL_TLV_OP_READ) {
 			err = -ENXIO;
 			goto __kctl_end;
 		}
-- 
2.1.0
