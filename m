From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 2/2] topology: Add ops support to byte
	control objects.
Date: Wed,  5 Aug 2015 14:41:51 +0100
Message-ID: <1438782111-20025-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1438782111-20025-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 73AA4265FA3
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 15:42:14 +0200 (CEST)
In-Reply-To: <1438782111-20025-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Rename the control ops structure to make it more generic so we can use it
with other objects like bytes controls. Add this structure to the byte
control structure.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/asoc.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 73eb80e..c642855 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -161,9 +161,11 @@ struct snd_soc_tplg_channel {
 } __attribute__((packed));
 
 /*
- * Kcontrol Operations IDs
+ * Genericl Operations IDs, for binding Kcontrol or Bytes ext ops
+ * Kcontrol ops need get/put/info.
+ * Bytes ext ops need get/put.
  */
-struct snd_soc_tplg_kcontrol_ops_id {
+struct snd_soc_tplg_io_ops {
 	__le32 get;
 	__le32 put;
 	__le32 info;
@@ -177,7 +179,7 @@ struct snd_soc_tplg_ctl_hdr {
 	__le32 type;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	__le32 access;
-	struct snd_soc_tplg_kcontrol_ops_id ops;
+	struct snd_soc_tplg_io_ops ops;
 	struct snd_soc_tplg_ctl_tlv tlv;
 } __attribute__((packed));
 
@@ -309,6 +311,7 @@ struct snd_soc_tplg_bytes_control {
 	__le32 mask;
 	__le32 base;
 	__le32 num_regs;
+	struct snd_soc_tplg_io_ops ext_ops;
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
-- 
2.1.4
