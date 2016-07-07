From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH v2] ctl: add dimension validator
Date: Fri,  8 Jul 2016 06:33:17 +0900
Message-ID: <1467927197-14454-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id D3549261561
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 23:33:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Linux 4.7 or former have no validator of dimension information. This can
causes an issue related to user-defined element set. For example, When
calculated total members in multi-dimensional matrix is larger than actual
capacity of snd_ctl_elem_value_t, processes to handle the element can
cause buffer-over-run.

For backward portability of this userspace library, this commit adds a
validator of dimension information. When userspace applications give
invalid dimension information to APIs to add element set, they receive
-EINVAL.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/src/control/control.c b/src/control/control.c
index 2ad3e0d..85485aa 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -91,6 +91,7 @@ I/O operations.
 #include <fcntl.h>
 #include <signal.h>
 #include <sys/poll.h>
+#include <stdbool.h>
 #include "control_local.h"
 
 /**
@@ -302,6 +303,32 @@ int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info)
 	return ctl->ops->element_info(ctl, info);
 }
 
+static bool validate_element_member_dimension(snd_ctl_elem_info_t *info)
+{
+	unsigned int members;
+	unsigned int i;
+
+	if (info->dimen.d[0] == 0)
+		return true;
+
+	members = 1;
+	for (i = 0; i < ARRAY_SIZE(info->dimen.d); ++i) {
+		if (info->dimen.d[i] == 0)
+			break;
+		members *= info->dimen.d[i];
+
+		if (members > info->count)
+			return false;
+	}
+
+	for (++i; i < ARRAY_SIZE(info->dimen.d); ++i) {
+		if (info->dimen.d[i] > 0)
+			return false;
+	}
+
+	return members == info->count;
+}
+
 /**
  * \brief Create and add some user-defined control elements of integer type.
  * \param ctl A handle of backend module for control interface.
@@ -366,6 +393,9 @@ int snd_ctl_elem_add_integer_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 	info->value.integer.max = max;
 	info->value.integer.step = step;
 
+	if (!validate_element_member_dimension(info))
+		return -EINVAL;
+
 	err = ctl->ops->element_add(ctl, info);
 	if (err < 0)
 		return err;
@@ -451,6 +481,9 @@ int snd_ctl_elem_add_integer64_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 	info->value.integer64.max = max;
 	info->value.integer64.step = step;
 
+	if (!validate_element_member_dimension(info))
+		return -EINVAL;
+
 	err = ctl->ops->element_add(ctl, info);
 	if (err < 0)
 		return err;
@@ -524,6 +557,9 @@ int snd_ctl_elem_add_boolean_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 	info->value.integer.min = 0;
 	info->value.integer.max = 1;
 
+	if (!validate_element_member_dimension(info))
+		return -EINVAL;
+
 	return ctl->ops->element_add(ctl, info);
 }
 
@@ -605,6 +641,9 @@ int snd_ctl_elem_add_enumerated_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 		p += strlen(labels[i]) + 1;
 	}
 
+	if (!validate_element_member_dimension(info))
+		return -EINVAL;
+
 	err = ctl->ops->element_add(ctl, info);
 
 	free(buf);
@@ -663,6 +702,9 @@ int snd_ctl_elem_add_bytes_set(snd_ctl_t *ctl, snd_ctl_elem_info_t *info,
 	info->owner = element_count;
 	info->count = member_count;
 
+	if (!validate_element_member_dimension(info))
+		return -EINVAL;
+
 	return ctl->ops->element_add(ctl, info);
 }
 
-- 
2.7.4
