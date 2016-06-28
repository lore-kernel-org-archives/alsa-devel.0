From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ctl: use consistent name for second argument
	of snd_ctl_elem_read/write
Date: Tue, 28 Jun 2016 22:39:50 +0900
Message-ID: <1467121190-17992-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 6E7E9266FE9
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 15:39:56 +0200 (CEST)
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

Second argument of these functions has three different names in
documentation/header/code (obj/control/value). This easily causes users'
confusion.

This commit applies consistent names for the arguments.

Fixes: 90020c05f886 ('ctl: improve comments for handling element data')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/control.h     |  4 ++--
 src/control/control.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/control.h b/include/control.h
index 0d4ae86..6931b1f 100644
--- a/include/control.h
+++ b/include/control.h
@@ -245,8 +245,8 @@ int snd_ctl_subscribe_events(snd_ctl_t *ctl, int subscribe);
 int snd_ctl_card_info(snd_ctl_t *ctl, snd_ctl_card_info_t *info);
 int snd_ctl_elem_list(snd_ctl_t *ctl, snd_ctl_elem_list_t *list);
 int snd_ctl_elem_info(snd_ctl_t *ctl, snd_ctl_elem_info_t *info);
-int snd_ctl_elem_read(snd_ctl_t *ctl, snd_ctl_elem_value_t *value);
-int snd_ctl_elem_write(snd_ctl_t *ctl, snd_ctl_elem_value_t *value);
+int snd_ctl_elem_read(snd_ctl_t *ctl, snd_ctl_elem_value_t *data);
+int snd_ctl_elem_write(snd_ctl_t *ctl, snd_ctl_elem_value_t *data);
 int snd_ctl_elem_lock(snd_ctl_t *ctl, snd_ctl_elem_id_t *id);
 int snd_ctl_elem_unlock(snd_ctl_t *ctl, snd_ctl_elem_id_t *id);
 int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
diff --git a/src/control/control.c b/src/control/control.c
index 6090abd..bbb5a78 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -803,27 +803,27 @@ int snd_ctl_elem_remove(snd_ctl_t *ctl, snd_ctl_elem_id_t *id)
 /**
  * \brief Get CTL element value
  * \param ctl CTL handle
- * \param obj Data of an element.
+ * \param data Data of an element.
  * \return 0 on success otherwise a negative error code
  */
-int snd_ctl_elem_read(snd_ctl_t *ctl, snd_ctl_elem_value_t *control)
+int snd_ctl_elem_read(snd_ctl_t *ctl, snd_ctl_elem_value_t *data)
 {
-	assert(ctl && control && (control->id.name[0] || control->id.numid));
-	return ctl->ops->element_read(ctl, control);
+	assert(ctl && data && (data->id.name[0] || data->id.numid));
+	return ctl->ops->element_read(ctl, data);
 }
 
 /**
  * \brief Set CTL element value
  * \param ctl CTL handle
- * \param obj Data of an element.
+ * \param data Data of an element.
  * \retval 0 on success
  * \retval >0 on success when value was changed
  * \retval <0 a negative error code
  */
-int snd_ctl_elem_write(snd_ctl_t *ctl, snd_ctl_elem_value_t *control)
+int snd_ctl_elem_write(snd_ctl_t *ctl, snd_ctl_elem_value_t *data)
 {
-	assert(ctl && control && (control->id.name[0] || control->id.numid));
-	return ctl->ops->element_write(ctl, control);
+	assert(ctl && data && (data->id.name[0] || data->id.numid));
+	return ctl->ops->element_write(ctl, data);
 }
 
 static int snd_ctl_tlv_do(snd_ctl_t *ctl, int op_flag,
-- 
2.7.4
