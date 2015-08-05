From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: Update ABI to improve TLV,
	operations and private data support.
Date: Wed,  5 Aug 2015 11:10:42 +0100
Message-ID: <1438769442-18681-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DBDA2614D6
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 12:10:54 +0200 (CEST)
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

This is the alsa-lib patch - a corresponding kernel patch has also been sent.

This patch updates the topology ABI version and adds support for private data
types, specfic structures for each TLV data type and refactors the operations mapping
structure to be generic (so that it can be used by other types). This code is only
used within Intel atm and is not in an official alsa-lib release so impact should be
minimal for the ABI update.

Currently the TLV topology structure is targeted at only supporting the
DB scale data. This patch extends support for the other TLV types so they
can be easily added at a later stage.

TLV structure is moved to common topology control header since it's a
common field for controls and can be processed in a general way.

Users must set a proper access flag for a control since it's used to decide
if the TLV field is valid and if a TLV callback is needed.

Removed the following fields from topology TLV struct:
 - size/count: type can decide the size.
 - numid: not needed to initialize TLV for kcontrol.
 - data: replaced by the type specific struct.

Added TLV structure to generic control header and removed TLV structure from
mixer control.

Added generic ops to geneic control header.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/asoc.h | 27 ++++++++++++++++++---------
 src/topology/ctl.c   | 20 ++++++++------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index bb6dcf3..61b8473 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -135,11 +135,18 @@ struct snd_soc_tplg_private {
 /*
  * Kcontrol TLV data.
  */
+struct snd_soc_tplg_tlv_dbscale {
+	__le32 min;
+	__le32 step;
+	__le32 mute;
+} __attribute__((packed));
+
 struct snd_soc_tplg_ctl_tlv {
-	__le32 size;	/* in bytes aligned to 4 */
-	__le32 numid;	/* control element numeric identification */
-	__le32 count;	/* number of elem in data array */
-	__le32 data[SND_SOC_TPLG_TLV_SIZE];
+	__le32 size;	/* in bytes of this structure */
+	__le32 type;	/* SNDRV_CTL_TLVT_*, type of TLV */
+	union {
+		struct snd_soc_tplg_tlv_dbscale scale;
+	};
 } __attribute__((packed));
 
 /*
@@ -153,9 +160,11 @@ struct snd_soc_tplg_channel {
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
@@ -169,8 +178,8 @@ struct snd_soc_tplg_ctl_hdr {
 	__le32 type;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	__le32 access;
-	struct snd_soc_tplg_kcontrol_ops_id ops;
-	__le32 tlv_size;	/* non zero means control has TLV data */
+	struct snd_soc_tplg_io_ops ops;
+	struct snd_soc_tplg_ctl_tlv tlv;
 } __attribute__((packed));
 
 /*
@@ -258,7 +267,6 @@ struct snd_soc_tplg_mixer_control {
 	__le32 invert;
 	__le32 num_channels;
 	struct snd_soc_tplg_channel channel[SND_SOC_TPLG_MAX_CHAN];
-	struct snd_soc_tplg_ctl_tlv tlv;
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
@@ -302,6 +310,7 @@ struct snd_soc_tplg_bytes_control {
 	__le32 mask;
 	__le32 base;
 	__le32 num_regs;
+	struct snd_soc_tplg_io_ops ext_ops;
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index aa06ff6..930b508 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -28,10 +28,7 @@ static int copy_tlv(struct tplg_elem *elem, struct tplg_elem *ref)
 	tplg_dbg("TLV '%s' used by '%s\n", ref->id, elem->id);
 
 	/* TLV has a fixed size */
-	mixer_ctrl->tlv = *tlv;
-
-	/* set size of TLV data */
-	mixer_ctrl->hdr.tlv_size = tlv->count * sizeof(uint32_t);
+	mixer_ctrl->hdr.tlv = *tlv;
 	return 0;
 }
 
@@ -209,20 +206,19 @@ static int tplg_parse_tlv_dbscale(snd_config_t *cfg, struct tplg_elem *elem)
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	struct snd_soc_tplg_ctl_tlv *tplg_tlv;
+	struct snd_soc_tplg_tlv_dbscale *scale;
 	const char *id = NULL, *value = NULL;
-	int *data;
 
 	tplg_dbg(" scale: %s\n", elem->id);
 
 	tplg_tlv = calloc(1, sizeof(*tplg_tlv));
 	if (!tplg_tlv)
 		return -ENOMEM;
-	data = (int*)(tplg_tlv->data);
 
 	elem->tlv = tplg_tlv;
-	tplg_tlv->numid = SNDRV_CTL_TLVT_DB_SCALE;
-	tplg_tlv->count = 8;
-	tplg_tlv->size = sizeof(*tplg_tlv);
+	tplg_tlv->size = sizeof(struct snd_soc_tplg_ctl_tlv);
+	tplg_tlv->type = SNDRV_CTL_TLVT_DB_SCALE;
+	scale = &tplg_tlv->scale;
 
 	snd_config_for_each(i, next, cfg) {
 
@@ -242,11 +238,11 @@ static int tplg_parse_tlv_dbscale(snd_config_t *cfg, struct tplg_elem *elem)
 
 		/* get TLV data */
 		if (strcmp(id, "min") == 0)
-			data[0] = atoi(value);
+			scale->min = atoi(value);
 		else if (strcmp(id, "step") == 0)
-			data[1] = atoi(value);
+			scale->step = atoi(value);
 		else if (strcmp(id, "mute") == 0)
-			data[2] = atoi(value);
+			scale->mute = atoi(value);
 		else
 			SNDERR("error: unknown key %s\n", id);
 	}
-- 
1.9.1
