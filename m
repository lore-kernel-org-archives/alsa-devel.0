From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: control: Fix breakage of user ctl
	element addition
Date: Thu, 12 Mar 2015 17:02:10 +0100
Message-ID: <1426176130-1163-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 420112605DD
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 17:02:14 +0100 (CET)
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

In the commit [2225e79b9b03: 'ALSA: core: reduce stack usage related
to snd_ctl_new()'], the id field of the newly added kctl is untouched,
thus all attribute like name string remain empty.  The fix is just to
add the forgotten memcpy of the id field.

Fixes: 2225e79b9b03 ('ALSA: core: reduce stack usage related to snd_ctl_new()')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 54a412af3224..d677c27746e9 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1267,6 +1267,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	err = snd_ctl_new(&kctl, count, access, file);
 	if (err < 0)
 		return err;
+	memcpy(&kctl->id, &info->id, sizeof(kctl->id));
 	kctl->private_data = kzalloc(sizeof(struct user_element) + private_size,
 				     GFP_KERNEL);
 	if (kctl->private_data == NULL) {
-- 
2.3.2
