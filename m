From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] ctl: improve documentation of APIs
	to add an element set
Date: Sat,  9 Jul 2016 10:44:19 +0900
Message-ID: <1468028659-15897-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5F3F6265848
 for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2016 03:44:26 +0200 (CEST)
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

Currently, documentation of APIs to add an element set describes causes of
errors partly. But it gives an opinion to describe them thoroughly. This
is not good for users.

This commit changes the documentation so that it partly describes the
causes.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 85485aa..9bb8021 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -358,7 +358,8 @@ static bool validate_element_member_dimension(snd_ctl_elem_info_t *info)
  * <dt>-EBUSY
  * <dd>A element with ID \a id already exists.
  * <dt>-EINVAL
- * <dd>ID has no name, or the number of members is not between 1 to 127.
+ * <dd>Some arguments include invalid value; i.e. ID field in \a info has no
+ *     name, or the number of members is not between 1 to 127.
  * <dt>-ENOMEM
  * <dd>Out of memory, or there are too many user elements.
  * <dt>-ENXIO
@@ -446,7 +447,8 @@ int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
  * <dt>-EBUSY
  * <dd>A element with ID \a id already exists.
  * <dt>-EINVAL
- * <dd>ID has no name, or the number of members is not between 1 to 127.
+ * <dd>Some arguments include invalid value; i.e. ID has no name, or the number
+ *     of members is not between 1 to 127.
  * <dt>-ENOMEM
  * <dd>Out of memory, or there are too many user elements.
  * <dt>-ENXIO
@@ -530,7 +532,8 @@ int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
  * <dt>-EBUSY
  * <dd>A element with ID \a id already exists.
  * <dt>-EINVAL
- * <dd>ID has no name, or the number of members is not between 1 to 127.
+ * <dd>Some parameters include invalid value; i.e. ID has no name, or the number
+ *      of members is not between 1 to 127.
  * <dt>-ENOMEM
  * <dd>Out of memory, or there are too many user elements.
  * <dt>-ENXIO
@@ -591,9 +594,10 @@ int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
  * <dt>-EBUSY
  * <dd>A control element with ID \a id already exists.
  * <dt>-EINVAL
- * <dd>\a element_count is not between 1 to 127, or \a items is not at least
- *     one, or a string in \a labels is empty, or longer than 63 bytes, or total
- *     length of the labels requires more than 64 KiB storage.
+ * <dd>Some arguments include invalid value; i.e. \a element_count is not
+ *     between 1 to 127, or \a items is not at least one, or a string in \a
+ *     labels is empty, or longer than 63 bytes, or total length of the labels
+ *     requires more than 64 KiB storage.
  * <dt>-ENOMEM
  * <dd>Out of memory, or there are too many user control elements.
  * <dt>-ENXIO
@@ -677,7 +681,8 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
  * <dt>-EBUSY
  * <dd>A element with ID \a id already exists.
  * <dt>-EINVAL
- * <dd>ID has no name, or the number of members is not between 1 to 511.
+ * <dd>Some arguments include invalid value; i.e. ID has no name, or the number
+ *     of members is not between 1 to 511.
  * <dt>-ENOMEM
  * <dd>Out of memory, or there are too many user elements.
  * <dt>-ENXIO
-- 
2.7.4
