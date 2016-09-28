From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 4/5] ctl: improve documentation about
	TLV-related APIs
Date: Thu, 29 Sep 2016 08:57:23 +0900
Message-ID: <1475107044-30647-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C322926699C
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

The documentation gives no hints to users about format of TLV data.

This commit add hints to construct/parse the information.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/control/control.c b/src/control/control.c
index 422582d..40ee9b7 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -918,6 +918,13 @@ static int snd_ctl_tlv_do(snd_ctl_t *ctl, int op_flag,
  * \param tlv An array with members of unsigned int type.
  * \param tlv_size The length of the array.
  * \return 0 on success otherwise a negative error code
+ *
+ * The format of an array of \a tlv argument is:
+ *   tlv[0]:   Type. One of SND_CTL_TLVT_XXX.
+ *   tlv[1]:   Length. The length of value in units of byte.
+ *   tlv[2..]: Value. Depending on the type.
+ *
+ * Details are described in <sound/tlv.h>.
  */
 int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			  unsigned int *tlv, unsigned int tlv_size)
@@ -948,6 +955,13 @@ int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \retval 0 on success
  * \retval >0 on success when value was changed
  * \retval <0 a negative error code
+ *
+ * The format of an array of \a tlv argument is:
+ *   tlv[0]:   Type. One of SND_CTL_TLVT_XXX.
+ *   tlv[1]:   Length. The length of value in units of byte.
+ *   tlv[2..]: Value. Depending on the type.
+ *
+ * Details are described in <sound/tlv.h>.
  */
 int snd_ctl_elem_tlv_write(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			   const unsigned int *tlv)
@@ -965,6 +979,13 @@ int snd_ctl_elem_tlv_write(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \retval 0 on success
  * \retval >0 on success when value was changed
  * \retval <0 a negative error code
+ *
+ * The format of an array of \a tlv argument is:
+ *   tlv[0]:   Type. One of SND_CTL_TLVT_XXX.
+ *   tlv[1]:   Length. The length of value in units of byte.
+ *   tlv[2..]: Value. Depending on the type.
+ *
+ * Details are described in <sound/tlv.h>.
  */
 int snd_ctl_elem_tlv_command(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     const unsigned int *tlv)
-- 
2.7.4
