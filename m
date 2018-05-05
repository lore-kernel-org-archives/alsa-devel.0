From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] ALSA: control: fix a redundant-copy issue
Date: Sat,  5 May 2018 13:38:03 -0500
Message-ID: <1525545485-12183-1-git-send-email-wang6495@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In snd_ctl_elem_add_compat(), the fields of the struct 'data' need to be
copied from the corresponding fields of the struct 'data32' in userspace.
This is achieved by invoking copy_from_user() and get_user() functions. The
problem here is that the 'type' field is copied twice. One is by
copy_from_user() and one is by get_user(). Given that the 'type' field is
not used between the two copies, the second copy is *completely* redundant
and should be removed for better performance and cleanup. Also, these two
copies can cause inconsistent data: as the struct 'data32' resides in
userspace and a malicious userspace process can race to change the 'type'
field between the two copies to cause inconsistent data. Depending on how
the data is used in the future, such an inconsistency may cause potential
security risks.

For above reasons, we should take out the second copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/core/control_compat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index a848836..507fd52 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -396,8 +396,7 @@ static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
 	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
 		goto error;
-	if (get_user(data->owner, &data32->owner) ||
-	    get_user(data->type, &data32->type))
+	if (get_user(data->owner, &data32->owner))
 		goto error;
 	switch (data->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
-- 
2.7.4
