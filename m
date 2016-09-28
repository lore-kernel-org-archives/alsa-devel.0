From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 3/5] ctl: improve API documentation for TLV
	operation
Date: Thu, 29 Sep 2016 08:57:22 +0900
Message-ID: <1475107044-30647-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id BE70C2614A0
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 01:57:28 +0200 (CEST)
In-Reply-To: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
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

A commit fe1b08803db6 ("ctl: improve API documentation for threshold level
operations") changes documentations for some TLV-related APIs with wrong
explanations.

This commit fix it with better explanations.

Fixes: fe1b08803db6 ("ctl: improve API documentation for threshold level operations")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 6c00b8e..422582d 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -912,7 +912,7 @@ static int snd_ctl_tlv_do(snd_ctl_t *ctl, int op_flag,
 }
 
 /**
- * \brief Set given data to an element as threshold level.
+ * \brief Read structured data from an element set to given buffer.
  * \param ctl A handle of backend module for control interface.
  * \param id ID of an element.
  * \param tlv An array with members of unsigned int type.
@@ -940,7 +940,7 @@ int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Set given data to an element as threshold level.
+ * \brief Write structured data from given buffer to an element set.
  * \param ctl A handle of backend module for control interface.
  * \param id ID of an element.
  * \param tlv An array with members of unsigned int type. The second member
@@ -957,7 +957,7 @@ int snd_ctl_elem_tlv_write(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 }
 
 /**
- * \brief Set given data to an element as threshold level.
+ * \brief Process structured data from given buffer for an element set.
  * \param ctl A handle of backend module for control interface.
  * \param id ID of an element.
  * \param tlv An array with members of unsigned int type. The second member
-- 
2.7.4
