From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/8] ALSA: control: obsolete switch statement
	with const value table
Date: Wed, 11 Feb 2015 19:37:26 +0900
Message-ID: <1423651052-19593-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F26A2605C7
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:37:39 +0100 (CET)
In-Reply-To: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
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

To check parameters from userspace, snd_ctl_elem_add() has switch
statement. This statement checks the number of values in a control and
the size of each value. These two parameters are limited by
struct snd_ctl_elem_value.value and can be replaced with two sets of two
dimension array with constant values, without any calculation.

This commit obsolete the switch statement with the array.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 57 +++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index ea49abc..f248bde 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1161,6 +1161,23 @@ static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
 static int snd_ctl_elem_add(struct snd_ctl_file *file,
 			    struct snd_ctl_elem_info *info, int replace)
 {
+	/* The capacity of struct snd_ctl_elem_value.value.*/
+	const unsigned int value_sizes[] = {
+		[SNDRV_CTL_ELEM_TYPE_BOOLEAN]	= sizeof(long),
+		[SNDRV_CTL_ELEM_TYPE_INTEGER]	= sizeof(long),
+		[SNDRV_CTL_ELEM_TYPE_ENUMERATED] = sizeof(unsigned int),
+		[SNDRV_CTL_ELEM_TYPE_BYTES]	= sizeof(unsigned char),
+		[SNDRV_CTL_ELEM_TYPE_IEC958]	= sizeof(struct snd_aes_iec958),
+		[SNDRV_CTL_ELEM_TYPE_INTEGER64] = sizeof(long long),
+	};
+	const unsigned int max_value_counts[] = {
+		[SNDRV_CTL_ELEM_TYPE_BOOLEAN]	= 128,
+		[SNDRV_CTL_ELEM_TYPE_INTEGER]	= 128,
+		[SNDRV_CTL_ELEM_TYPE_ENUMERATED] = 128,
+		[SNDRV_CTL_ELEM_TYPE_BYTES]	= 512,
+		[SNDRV_CTL_ELEM_TYPE_IEC958]	= 1,
+		[SNDRV_CTL_ELEM_TYPE_INTEGER64] = 64,
+	};
 	struct snd_card *card = file->card;
 	struct snd_kcontrol kctl, *_kctl;
 	unsigned int access;
@@ -1170,6 +1187,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 
 	if (info->count < 1)
 		return -EINVAL;
+
 	access = info->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
 		(info->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
 				 SNDRV_CTL_ELEM_ACCESS_INACTIVE|
@@ -1201,37 +1219,16 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		kctl.tlv.c = snd_ctl_elem_user_tlv;
 		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
 	}
-	switch (info->type) {
-	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
-	case SNDRV_CTL_ELEM_TYPE_INTEGER:
-		elem_data_size = sizeof(long);
-		if (info->count > 128)
-			return -EINVAL;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
-		elem_data_size = sizeof(long long);
-		if (info->count > 64)
-			return -EINVAL;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
-		elem_data_size = sizeof(unsigned int);
-		if (info->count > 128 || info->value.enumerated.items == 0)
-			return -EINVAL;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_BYTES:
-		elem_data_size = sizeof(unsigned char);
-		if (info->count > 512)
-			return -EINVAL;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_IEC958:
-		elem_data_size = sizeof(struct snd_aes_iec958);
-		if (info->count != 1)
-			return -EINVAL;
-		break;
-	default:
+
+	if (info->type < SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
+	    info->type > SNDRV_CTL_ELEM_TYPE_INTEGER64)
 		return -EINVAL;
-	}
-	elem_data_size *= info->count;
+	if (info->count > max_value_counts[info->type])
+		return -EINVAL;
+	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED &&
+	    info->value.enumerated.items == 0)
+		return -EINVAL;
+	elem_data_size = value_sizes[info->type] * info->count;
 	ue = kzalloc(sizeof(struct user_element) + elem_data_size, GFP_KERNEL);
 	if (ue == NULL)
 		return -ENOMEM;
-- 
2.1.0
