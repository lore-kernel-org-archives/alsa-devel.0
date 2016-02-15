From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] control: add a function to add an element
	of bytes type
Date: Mon, 15 Feb 2016 22:33:12 +0900
Message-ID: <1455543193-28109-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1455543193-28109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 35DF52619F5
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 14:33:19 +0100 (CET)
In-Reply-To: <1455543193-28109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA Ctl core allows userspace applications to add elements of bytes type,
while there's no APIs for this purpose in alsa-lib.

This commit adds the missing function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/control/control.c b/src/control/control.c
index 3533ffe..38d66e8 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -488,6 +488,51 @@ int snd_ctl_elem_add_enumerated(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
+ * \brief Create and add a user-defined control element of bytes type.
+ * \param[in] ctl Control device handle.
+ * \param[in/out] id ID of the new control element.
+ * \param[in] channels The number of channels which one control element includes
+ * \return Zero on success, otherwise a negative error code.
+ *
+ * This function creates a user control element, This control element is not
+ * controlled by device drivers in kernel but that is handled by the same way as
+ * the control elements added by the device drivers.
+ *
+ * The fields of \a id, except numid, must be set with unique values to identify
+ * the new element. After returning, all fields of \a id are filled.
+ *
+ * All of channels in the new element are locked; these values are initialized
+ * with the minimum value.
+ *
+ * \par Errors:
+ * <dl>
+ * <dt>-EBUSY<dd>A control element with ID \a id already exists.
+ * <dt>-EINVAL<dd>\a channels is not between 1 to 511.
+ * <dt>-ENOMEM<dd>Out of memory, or there are too many user control elements.
+ * <dt>-ENXIO<dd>This driver does not support (bytes) user controls.
+ * <dt>-ENODEV<dd>Device unplugged.
+ * </dl>
+ *
+ * \par Compatibility:
+ * This function is added in ALSA 1.1.1.
+ */
+int snd_ctl_elem_add_bytes(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
+			   unsigned int channels)
+{
+	snd_ctl_elem_info_t *info;
+
+	assert(ctl && id && id->name[0]);
+
+	snd_ctl_elem_info_alloca(&info);
+	info->id = *id;
+	info->type = SND_CTL_ELEM_TYPE_BYTES;
+	info->owner = 1;
+	info->count = channels;
+
+	return ctl->ops->element_add(ctl, info);
+}
+
+/**
  * \brief Create and add a user-defined control element of IEC958 type.
  * \param[in] ctl CTL handle
  * \param[in/out] id ID of the new control element.
-- 
2.5.0
