From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/8] ALSA: control: gathering evaluations to
	access
Date: Wed, 11 Feb 2015 19:37:27 +0900
Message-ID: <1423651052-19593-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651052-19593-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A74F260594
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

The confirmation of access parameter is spread in a function.

This commit gathers these in one block for easy reading.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index f248bde..0baff92 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1188,10 +1188,16 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	if (info->count < 1)
 		return -EINVAL;
 
-	access = info->access == 0 ? SNDRV_CTL_ELEM_ACCESS_READWRITE :
-		(info->access & (SNDRV_CTL_ELEM_ACCESS_READWRITE|
-				 SNDRV_CTL_ELEM_ACCESS_INACTIVE|
-				 SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE));
+	access = info->access;
+	if (access == 0)
+		access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	access &= SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		  SNDRV_CTL_ELEM_ACCESS_INACTIVE |
+		  SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE;
+	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE)
+		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+	access |= SNDRV_CTL_ELEM_ACCESS_USER;
+
 	info->id.numid = 0;
 	memset(&kctl, 0, sizeof(kctl));
 
@@ -1206,7 +1212,6 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 
 	memcpy(&kctl.id, &info->id, sizeof(info->id));
 	kctl.count = info->owner ? info->owner : 1;
-	access |= SNDRV_CTL_ELEM_ACCESS_USER;
 	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED)
 		kctl.info = snd_ctl_elem_user_enum_info;
 	else
@@ -1215,10 +1220,8 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		kctl.get = snd_ctl_elem_user_get;
 	if (access & SNDRV_CTL_ELEM_ACCESS_WRITE)
 		kctl.put = snd_ctl_elem_user_put;
-	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE) {
+	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE)
 		kctl.tlv.c = snd_ctl_elem_user_tlv;
-		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
-	}
 
 	if (info->type < SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
 	    info->type > SNDRV_CTL_ELEM_TYPE_INTEGER64)
-- 
2.1.0
