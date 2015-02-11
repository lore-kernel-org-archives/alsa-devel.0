From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] ALSA: control: drop a sub-effect for
	caller's data
Date: Wed, 11 Feb 2015 19:40:09 +0900
Message-ID: <1423651213-19829-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 87CFA264FE3
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:40:21 +0100 (CET)
In-Reply-To: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
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

In snd_ctl_elem_add(), the given information data is changed when
calling snd_ctl_elem_add(). The numid field is set as zero.

This commit drops this sub-effect for a better API design.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index af95783..d98b990 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1192,11 +1192,12 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
 	access |= SNDRV_CTL_ELEM_ACCESS_USER;
 
-	info->id.numid = 0;
 	memset(&kctl, 0, sizeof(kctl));
+	kctl.id = info->id;
+	kctl.id.numid = 0;
 
 	if (replace) {
-		err = snd_ctl_remove_user_ctl(file, &info->id);
+		err = snd_ctl_remove_user_ctl(file, &kctl.id);
 		if (err)
 			return err;
 	}
@@ -1204,7 +1205,6 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	if (card->user_ctl_count >= MAX_USER_CONTROLS)
 		return -ENOMEM;
 
-	memcpy(&kctl.id, &info->id, sizeof(info->id));
 	kctl.count = info->owner ? info->owner : 1;
 	if (info->type == SNDRV_CTL_ELEM_TYPE_ENUMERATED)
 		kctl.info = snd_ctl_elem_user_enum_info;
-- 
2.1.0
