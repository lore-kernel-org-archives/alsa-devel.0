From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ctl: improve documentation about
	TLV-related APIs
Date: Sat, 17 Sep 2016 23:49:28 +0900
Message-ID: <1474123768-13160-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1474123768-13160-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id EF00726644C
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2016 16:49:33 +0200 (CEST)
In-Reply-To: <1474123768-13160-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, broonie@kernel.org
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The documentation gives no hints to users about content of threshold level
information.

This commit add hints to parse the information.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/control/control.c b/src/control/control.c
index 383f401..7165222 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -918,6 +918,11 @@ static int snd_ctl_tlv_do(snd_ctl_t *ctl, int op_flag,
  * \param tlv An array with members of unsigned int type.
  * \param tlv_size The length of the array.
  * \return 0 on success otherwise a negative error code
+ *
+ * The format of an array of \a tlv argument is:
+ *   tlv[0]: Data type. One of SND_CTL_TLVT_XXX.
+ *   tlv[1]: Lengh of data in units of byte.
+ *   tlv[2..]: Data. Details are described in <sound/tlv.h>.
  */
 int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			  unsigned int *tlv, unsigned int tlv_size)
@@ -948,6 +953,11 @@ int snd_ctl_elem_tlv_read(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \retval 0 on success
  * \retval >0 on success when value was changed
  * \retval <0 a negative error code
+ *
+ * The format of an array of \a tlv argument is:
+ *   tlv[0]: Data type. One of SND_CTL_TLVT_XXX.
+ *   tlv[1]: Lengh of data in units of byte.
+ *   tlv[2..]: Data. Details are described in <sound/tlv.h>.
  */
 int snd_ctl_elem_tlv_write(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			   const unsigned int *tlv)
@@ -965,6 +975,11 @@ int snd_ctl_elem_tlv_write(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
  * \retval 0 on success
  * \retval >0 on success when value was changed
  * \retval <0 a negative error code
+ *
+ * The format of an array of \a tlv argument is:
+ *   tlv[0]: Data type. One of SND_CTL_TLVT_XXX.
+ *   tlv[1]: Lengh of data in units of byte.
+ *   tlv[2..]: Data. Details are described in <sound/tlv.h>.
  */
 int snd_ctl_elem_tlv_command(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 			     const unsigned int *tlv)
-- 
2.7.4
