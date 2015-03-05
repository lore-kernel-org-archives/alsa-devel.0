From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/2] ALSA: core: use precomputed table to check
	userspace control params
Date: Fri,  6 Mar 2015 00:43:25 +0900
Message-ID: <1425570206-21026-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
 <1425570206-21026-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 53AC12604A1
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 16:43:33 +0100 (CET)
In-Reply-To: <1425570206-21026-1-git-send-email-o-takashi@sakamocchi.jp>
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

The parameters can be decided in compile time.

This commit adds precomputed table to reduce calculating time.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 60 ++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 32 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 35324a8..3955115 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1161,6 +1161,23 @@ static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
 static int snd_ctl_elem_add(struct snd_ctl_file *file,
 			    struct snd_ctl_elem_info *info, int replace)
 {
+	/* The capacity of struct snd_ctl_elem_value.value.*/
+	static const unsigned int value_sizes[] = {
+		[SNDRV_CTL_ELEM_TYPE_BOOLEAN]	= sizeof(long),
+		[SNDRV_CTL_ELEM_TYPE_INTEGER]	= sizeof(long),
+		[SNDRV_CTL_ELEM_TYPE_ENUMERATED] = sizeof(unsigned int),
+		[SNDRV_CTL_ELEM_TYPE_BYTES]	= sizeof(unsigned char),
+		[SNDRV_CTL_ELEM_TYPE_IEC958]	= sizeof(struct snd_aes_iec958),
+		[SNDRV_CTL_ELEM_TYPE_INTEGER64] = sizeof(long long),
+	};
+	static const unsigned int max_value_counts[] = {
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
@@ -1168,8 +1185,6 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	struct user_element *ue;
 	int idx, err;
 
-	if (info->count < 1)
-		return -EINVAL;
 	access = info->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
 		(info->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
 				 SNDRV_CTL_ELEM_ACCESS_INACTIVE|
@@ -1201,37 +1216,18 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		kctl.tlv.c = snd_ctl_elem_user_tlv;
 		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
 	}
-	switch (info->type) {
-	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
-	case SNDRV_CTL_ELEM_TYPE_INTEGER:
-		private_size = sizeof(long);
-		if (info->count > 128)
-			return -EINVAL;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
-		private_size = sizeof(long long);
-		if (info->count > 64)
-			return -EINVAL;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
-		private_size = sizeof(unsigned int);
-		if (info->count > 128 || info->value.enumerated.items == 0)
-			return -EINVAL;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_BYTES:
-		private_size = sizeof(unsigned char);
-		if (info->count > 512)
-			return -EINVAL;
-		break;
-	case SNDRV_CTL_ELEM_TYPE_IEC958:
-		private_size = sizeof(struct snd_aes_iec958);
-		if (info->count != 1)
-			return -EINVAL;
-		break;
-	default:
+
+	if ((info->type < SNDRV_CTL_ELEM_TYPE_BOOLEAN) ||
+	    (info->type > SNDRV_CTL_ELEM_TYPE_INTEGER64))
 		return -EINVAL;
-	}
-	private_size *= info->count;
+	if ((info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED) &&
+	    (info->value.enumerated.items == 0))
+		return -EINVAL;
+	if ((info->count < 1) ||
+	    (info->count > max_value_counts[info->type]))
+		return -EINVAL;
+
+	private_size = value_sizes[info->type] * info->count;
 	ue = kzalloc(sizeof(struct user_element) + private_size, GFP_KERNEL);
 	if (ue == NULL)
 		return -ENOMEM;
-- 
2.1.0
