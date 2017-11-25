From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 09/24] ALSA: ctl: unify calls of D0-wait
	function for ELEM_INFO request
Date: Sat, 25 Nov 2017 18:19:51 +0900
Message-ID: <20171125092006.24408-10-o-takashi@sakamocchi.jp>
References: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1B74A266FBF
 for <alsa-devel@alsa-project.org>; Sat, 25 Nov 2017 10:20:15 +0100 (CET)
In-Reply-To: <20171125092006.24408-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When handling I/O request for ELEM_INFO, 'snd_power_wait()' function is
used before a call of 'snd_ctl_elem_info()' function. This is perhaps due
to performing I/O operation to actual devices. The same thing is done by
helper functions for native/compat ABI, and they can be unified.

This commit moves these duplicated codes into the callee function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c        | 7 ++++---
 sound/core/control_compat.c | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index ad4d27c681c4..91966b190b8b 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -842,6 +842,10 @@ static int snd_ctl_elem_info(struct snd_ctl_file *ctl,
 	unsigned int index_offset;
 	int result;
 	
+	result = snd_power_wait(ctl->card, SNDRV_CTL_POWER_D0);
+	if (result < 0)
+		return result;
+
 	down_read(&card->controls_rwsem);
 	kctl = snd_ctl_find_id(card, &info->id);
 	if (kctl == NULL) {
@@ -879,9 +883,6 @@ static int snd_ctl_elem_info_user(struct snd_ctl_file *ctl,
 
 	if (copy_from_user(&info, _info, sizeof(info)))
 		return -EFAULT;
-	result = snd_power_wait(ctl->card, SNDRV_CTL_POWER_D0);
-	if (result < 0)
-		return result;
 	result = snd_ctl_elem_info(ctl, &info);
 	if (result < 0)
 		return result;
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index f0559ed785e0..e6169b2bc6b3 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -489,9 +489,6 @@ static int snd_ctl_elem_info_compat(struct snd_ctl_file *ctl,
 	if (get_user(data->value.enumerated.item, &data32->value.enumerated.item))
 		goto error;
 
-	err = snd_power_wait(ctl->card, SNDRV_CTL_POWER_D0);
-	if (err < 0)
-		goto error;
 	err = snd_ctl_elem_info(ctl, data);
 	if (err < 0)
 		goto error;
-- 
2.14.1
