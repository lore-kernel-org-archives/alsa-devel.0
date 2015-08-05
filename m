From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: Update ABI with improvements
	for TLV, operations and private data.
Date: Wed,  5 Aug 2015 11:11:07 +0100
Message-ID: <1438769467-18729-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5235E265D63
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 12:11:19 +0200 (CEST)
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

This is the kernel patch - a corresponding alsa-lib patch has also been sent.

This patch updates the topology ABI version and adds support for private data
types, specfic structures for each TLV data type and refactors the operations mapping
structure to be generic (so that it can be used by other types). This code is only
used within Intel atm and is not in an official alsa-lib release so impact should be
minimali for the ABI update.

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

Added TLV structure to generic control header and removed TLV structure from mixer control.

Added generic ops to geneic control header.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/uapi/sound/asoc.h | 32 +++++++++++++++++---------
 sound/soc/soc-topology.c  | 58 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 62 insertions(+), 28 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 2819fc1..69383b0 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -77,7 +77,7 @@
 #define SND_SOC_TPLG_NUM_TEXTS		16
 
 /* ABI version */
-#define SND_SOC_TPLG_ABI_VERSION	0x2
+#define SND_SOC_TPLG_ABI_VERSION	0x3
 
 /* Max size of TLV data */
 #define SND_SOC_TPLG_TLV_SIZE		32
@@ -97,7 +97,8 @@
 #define SND_SOC_TPLG_TYPE_PCM		7
 #define SND_SOC_TPLG_TYPE_MANIFEST	8
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
-#define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_CODEC_LINK
+#define SND_SOC_TPLG_TYPE_PDATA		10
+#define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_PDATA
 
 /* vendor block IDs - please add new vendor types to end */
 #define SND_SOC_TPLG_TYPE_VENDOR_FW	1000
@@ -137,11 +138,18 @@ struct snd_soc_tplg_private {
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
@@ -155,9 +163,11 @@ struct snd_soc_tplg_channel {
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
@@ -171,8 +181,8 @@ struct snd_soc_tplg_ctl_hdr {
 	__le32 type;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	__le32 access;
-	struct snd_soc_tplg_kcontrol_ops_id ops;
-	__le32 tlv_size;	/* non zero means control has TLV data */
+	struct snd_soc_tplg_io_ops ops;
+	struct snd_soc_tplg_ctl_tlv tlv;
 } __attribute__((packed));
 
 /*
@@ -260,7 +270,6 @@ struct snd_soc_tplg_mixer_control {
 	__le32 invert;
 	__le32 num_channels;
 	struct snd_soc_tplg_channel channel[SND_SOC_TPLG_MAX_CHAN];
-	struct snd_soc_tplg_ctl_tlv tlv;
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
@@ -304,6 +313,7 @@ struct snd_soc_tplg_bytes_control {
 	__le32 mask;
 	__le32 base;
 	__le32 num_regs;
+	struct snd_soc_tplg_io_ops ext_ops;
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 4dadb5e..bebd6f3 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -33,6 +33,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/soc-topology.h>
+#include <sound/tlv.h>
 
 /*
  * We make several passes over the data (since it wont necessarily be ordered)
@@ -579,28 +580,51 @@ static int soc_tplg_init_kcontrol(struct soc_tplg *tplg,
 	return 0;
 }
 
+
+static int soc_tplg_create_tlv_db_scale(struct soc_tplg *tplg,
+	struct snd_kcontrol_new *kc, struct snd_soc_tplg_tlv_dbscale *scale)
+{
+	unsigned int item_len = 2 * sizeof(unsigned int);
+	unsigned int *p;
+
+	p = kzalloc(item_len + 2 * sizeof(unsigned int), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p[0] = SNDRV_CTL_TLVT_DB_SCALE;
+	p[1] = item_len;
+	p[2] = scale->min;
+	p[3] = (scale->step & TLV_DB_SCALE_MASK)
+			| (scale->mute ? TLV_DB_SCALE_MUTE : 0);
+
+	kc->tlv.p = (void *)p;
+	return 0;
+}
+
 static int soc_tplg_create_tlv(struct soc_tplg *tplg,
-	struct snd_kcontrol_new *kc, struct snd_soc_tplg_ctl_tlv *tplg_tlv)
+	struct snd_kcontrol_new *kc, struct snd_soc_tplg_ctl_hdr *tc)
 {
-	struct snd_ctl_tlv *tlv;
-	int size;
+	struct snd_soc_tplg_ctl_tlv *tplg_tlv;
 
-	if (tplg_tlv->count == 0)
+	if (!(tc->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE))
 		return 0;
 
-	size = ((tplg_tlv->count + (sizeof(unsigned int) - 1)) &
-		~(sizeof(unsigned int) - 1));
-	tlv = kzalloc(sizeof(*tlv) + size, GFP_KERNEL);
-	if (tlv == NULL)
-		return -ENOMEM;
-
-	dev_dbg(tplg->dev, " created TLV type %d size %d bytes\n",
-		tplg_tlv->numid, size);
+	if (tc->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK)
+		kc->tlv.c = snd_soc_bytes_tlv_callback;
+	else {
+		tplg_tlv = &tc->tlv;
+		switch (tplg_tlv->type) {
+		case SNDRV_CTL_TLVT_DB_SCALE:
+			return soc_tplg_create_tlv_db_scale(tplg, kc,
+					&tplg_tlv->scale);
 
-	tlv->numid = tplg_tlv->numid;
-	tlv->length = size;
-	memcpy(&tlv->tlv[0], tplg_tlv->data, size);
-	kc->tlv.p = (void *)tlv;
+		/* TODO: add support for other TLV types */
+		default:
+			dev_dbg(tplg->dev, "Unsupported TLV type %d\n",
+					tplg_tlv->type);
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -772,7 +796,7 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
 		}
 
 		/* create any TLV data */
-		soc_tplg_create_tlv(tplg, &kc, &mc->tlv);
+		soc_tplg_create_tlv(tplg, &kc, &mc->hdr);
 
 		/* register control here */
 		err = soc_tplg_add_kcontrol(tplg, &kc,
-- 
2.1.4
