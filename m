From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] ctl: use condition statements
	instead of assert() for new APIs to add an element set
Date: Wed, 20 Jul 2016 18:58:52 +0900
Message-ID: <1469008732-9166-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 722FD2659DD
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2016 11:59:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Usage of assert() is not better practice of programming as shared library
APIs. They should return appropriate error code to promote applications to
handle error state.

This commit applies condition statements with return value of -EINVAL,
instead of assert(). As a backward compatibility for existent applications,
old APIs still call assert().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index aa05130..6c00b8e 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -382,7 +382,8 @@ int snd_ctl_add_integer_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 	unsigned int numid;
 	int err;
 
-	assert(ctl && info && info->id.name[0]);
+	if (ctl == NULL || info == NULL || info->id.name[0] == '\0')
+		return -EINVAL;
 
 	info->type = SND_CTL_ELEM_TYPE_INTEGER;
 	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -471,7 +472,8 @@ int snd_ctl_add_integer64_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 	unsigned int numid;
 	int err;
 
-	assert(ctl && info && info->id.name[0]);
+	if (ctl == NULL || info == NULL || info->id.name[0] == '\0')
+		return -EINVAL;
 
 	info->type = SND_CTL_ELEM_TYPE_INTEGER64;
 	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -549,7 +551,8 @@ int snd_ctl_add_boolean_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 				 unsigned int element_count,
 				 unsigned int member_count)
 {
-	assert(ctl && info && info->id.name[0]);
+	if (ctl == NULL || info == NULL || info->id.name[0] == '\0')
+		return -EINVAL;
 
 	info->type = SND_CTL_ELEM_TYPE_BOOLEAN;
 	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -619,7 +622,9 @@ int snd_ctl_add_enumerated_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 	char *buf, *p;
 	int err;
 
-	assert(ctl && info && info->id.name[0] && labels);
+	if (ctl == NULL || info == NULL || info->id.name[0] == '\0' ||
+	    labels == NULL)
+		return -EINVAL;
 
 	info->type = SND_CTL_ELEM_TYPE_ENUMERATED;
 	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -698,7 +703,8 @@ int snd_ctl_add_bytes_elem_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 			       unsigned int element_count,
 			       unsigned int member_count)
 {
-	assert(ctl && info && info->id.name[0]);
+	if (ctl == NULL || info == NULL || info->id.name[0] == '\0')
+		return -EINVAL;
 
 	info->type = SND_CTL_ELEM_TYPE_BYTES;
 	info->access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -726,6 +732,8 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 {
 	snd_ctl_elem_info_t info = {0};
 
+	assert(ctl && id && id->name[0]);
+
 	info.id = *id;
 
 	return snd_ctl_add_integer_elem_set(ctl, &info, 1, member_count,
@@ -745,6 +753,8 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 {
 	snd_ctl_elem_info_t info = {0};
 
+	assert(ctl && id && id->name[0]);
+
 	info.id = *id;
 
 	return snd_ctl_add_integer64_elem_set(ctl, &info, 1, member_count,
@@ -763,6 +773,8 @@ int snd_ctl_elem_add_boolean(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 {
 	snd_ctl_elem_info_t info = {0};
 
+	assert(ctl && id && id->name[0]);
+
 	info.id = *id;
 
 	return snd_ctl_add_boolean_elem_set(ctl, &info, 1, member_count);
@@ -783,6 +795,8 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 {
 	snd_ctl_elem_info_t info = {0};
 
+	assert(ctl && id && id->name[0] && labels);
+
 	info.id = *id;
 
 	return snd_ctl_add_enumerated_elem_set(ctl, &info, 1, member_count,
-- 
2.7.4
