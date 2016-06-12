From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/10] ctl: improve comments for API to add an
	element of IEC958 type
Date: Sun, 12 Jun 2016 17:16:05 +0900
Message-ID: <1465719371-27721-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8E72026057F
 for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2016 10:16:17 +0200 (CEST)
In-Reply-To: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
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

In ALSA control core, it's not allowed to an element set of IEC 958 type
to have several elements. Therefore, consecutive patchset doesn't touch an
API to add an element of IEC958 type. However, it's better to supplement
comments for the API.

This commit do it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 48b0080..9fad0c0 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -842,10 +842,33 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Create and add an user IEC958 CTL element
- * \param ctl CTL handle
- * \param id CTL element info to add
- * \return 0 on success otherwise a negative error code
+ * \brief Create and add a user-defined control element of IEC958 type.
+ * \param[in] ctl A handle of backend module for control interface.
+ * \param[in,out] id ID of the new control element.
+ *
+ * This function creates an user element with IEC958 type. This element is not
+ * controlled by device drivers in kernel. It can be operated by the same way as
+ * usual elements added by the device drivers.
+ *
+ * The name field of \a id must be set with unique value to identify a new
+ * control element. After returning, all fields of \a id are filled. A element
+ * can be identified by the combination of name and index, or by numid.
+ *
+ * A member in the new element is locked and filled with zero.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY
+ * <dd>A control element with ID \a id already exists.
+ * <dt>-EINVAL
+ * <dd>ID has no name.
+ * <dt>-ENOMEM
+ * <dd>Out of memory, or there are too many user elements.
+ * <dt>-ENXIO
+ * <dd>This backend module does not support user elements of IEC958 type.
+ * <dt>-ENODEV
+ * <dd>Device unplugged.
+ * </dl>
  */
 int snd_ctl_elem_add_iec958(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id)
 {
@@ -855,6 +878,7 @@ int snd_ctl_elem_add_iec958(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id)
 	snd_ctl_elem_info_alloca(&info);
 	info->id = *id;
 	info->type = SND_CTL_ELEM_TYPE_IEC958;
+	info->owner = 1;
 	info->count = 1;
 	return ctl->ops->element_add(ctl, info);
 }
-- 
2.7.4
