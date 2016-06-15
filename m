From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/9] ctl: improve API documentation for
	threshold level operations
Date: Wed, 15 Jun 2016 23:57:44 +0900
Message-ID: <1466002665-30048-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 23F80266B46
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:57:53 +0200 (CEST)
In-Reply-To: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
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

In alsa-lib, threshold level operations require an array of unsigned-int
members, while there's little explanation about how to fill it. To usual
developers such as me, they're quite hard to understand.

This commit adds a few comment for easy understanding about how to use
the APIs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index a1d7098..d515cff 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -882,14 +882,12 @@ static int snd_ctl_tlv_do(snd_ctl_t *ctl, int op_flag,
 	return err;
 }
 
-
-
 /**
- * \brief Get CTL element TLV value
- * \param ctl CTL handle
- * \param id CTL element id pointer
- * \param tlv TLV array pointer to store 
- * \param tlv_size TLV array size in bytes
+ * \brief Set given data to an element as threshold level.
+ * \param ctl A handle of backend module for control interface.
+ * \param id ID of an element.
+ * \param tlv An array with members of unsigned int type.
+ * \param tlv_size The length of the array.
  * \return 0 on success otherwise a negative error code
  */
 int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
@@ -913,10 +911,11 @@ int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Set CTL element TLV value
- * \param ctl CTL handle
- * \param id CTL element id pointer
- * \param tlv TLV array pointer to store 
+ * \brief Set given data to an element as threshold level.
+ * \param ctl A handle of backend module for control interface.
+ * \param id ID of an element.
+ * \param tlv An array with members of unsigned int type. The second member
+ *	      must represent total bytes of the rest of array.
  * \retval 0 on success
  * \retval >0 on success when value was changed
  * \retval <0 a negative error code
@@ -929,10 +928,11 @@ int snd_ctl_elem_tlv_write(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Process CTL element TLV command
- * \param ctl CTL handle
- * \param id CTL element id pointer
- * \param tlv TLV array pointer to process
+ * \brief Set given data to an element as threshold level.
+ * \param ctl A handle of backend module for control interface.
+ * \param id ID of an element.
+ * \param tlv An array with members of unsigned int type. The second member
+ *	      must represent total bytes of the rest of array.
  * \retval 0 on success
  * \retval >0 on success when value was changed
  * \retval <0 a negative error code
-- 
2.7.4
