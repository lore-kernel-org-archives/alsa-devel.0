From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 2/5] test: use actual information for TLV
	operation
Date: Thu, 29 Sep 2016 08:57:21 +0900
Message-ID: <1475107044-30647-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id BE9AC2665D9
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

Currently, this test program uses undefined type of TLV data. This can
bring confusions to userspace applications.

This commit replaces the array with valid information, constructed by newly
exported TLV macros from kernel land.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 214 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 178 insertions(+), 36 deletions(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 9b9dc59..75083d2 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -8,6 +8,7 @@
  */
 
 #include "../include/asoundlib.h"
+#include <sound/tlv.h>
 
 struct elem_set_trial {
 	snd_ctl_t *handle;
@@ -25,8 +26,30 @@ struct elem_set_trial {
 				snd_ctl_elem_info_t *info);
 	void (*change_elem_members)(struct elem_set_trial *trial,
 				    snd_ctl_elem_value_t *elem_data);
+	int (*allocate_elem_set_tlv)(struct elem_set_trial *trial,
+				     unsigned int **tlv);
 };
 
+struct chmap_entry {
+	unsigned int type;
+	unsigned int length;
+	unsigned int maps[0];
+};
+
+/*
+ * History of TLV feature:
+ *
+ * 2016/09/15: 398fa4db6c69 ("ALSA: control: move layout of TLV payload to UAPI
+ *			      header")
+ * 2012/07/21: 2d3391ec0ecc ("ALSA: PCM: channel mapping API implementation")
+ * 2011/11/20: bf1d1c9b6179 ("ALSA: tlv: add DECLARE_TLV_DB_RANGE()")
+ * 2009/07/16: 085f30654175 ("ALSA: Add new TLV types for dBwith min/max")
+ * 2006/09/06: 55a29af5ed5d ("[ALSA] Add definition of TLV dB range compound")
+ * 2006/08/28: 063a40d9111c ("Add the definition of linear volume TLV")
+ * 2006/08/28: 42750b04c5ba ("[ALSA] Control API - TLV implementation for
+ *			      additional information like dB scale")
+ */
+
 /* Operations for elements in an element set with boolean type. */
 static int add_bool_elem_set(struct elem_set_trial *trial,
 			     snd_ctl_elem_info_t *info)
@@ -47,13 +70,30 @@ static void change_bool_elem_members(struct elem_set_trial *trial,
 	}
 }
 
+static int allocate_bool_elem_set_tlv(struct elem_set_trial *trial,
+				      unsigned int **tlv)
+{
+	/*
+	 * Performs like a toggle switch for attenuation, because they're bool
+	 * elements.
+	 */
+	static const SNDRV_CTL_TLVD_DECLARE_DB_MINMAX(range, -10000, 0);
+
+	*tlv = malloc(sizeof(range));
+	if (*tlv == NULL)
+		return -ENOMEM;
+	memcpy(*tlv, range, sizeof(range));
+
+	return 0;
+}
+
 /* Operations for elements in an element set with integer type. */
 static int add_int_elem_set(struct elem_set_trial *trial,
 			    snd_ctl_elem_info_t *info)
 {
 	return snd_ctl_add_integer_elem_set(trial->handle, info,
 				trial->element_count, trial->member_count,
-				0, 99, 1);
+				0, 25, 1);
 }
 
 static int check_int_elem_props(struct elem_set_trial *trial,
@@ -61,7 +101,7 @@ static int check_int_elem_props(struct elem_set_trial *trial,
 {
 	if (snd_ctl_elem_info_get_min(info) != 0)
 		return -EIO;
-	if (snd_ctl_elem_info_get_max(info) != 99)
+	if (snd_ctl_elem_info_get_max(info) != 25)
 		return -EIO;
 	if (snd_ctl_elem_info_get_step(info) != 1)
 		return -EIO;
@@ -81,6 +121,41 @@ static void change_int_elem_members(struct elem_set_trial *trial,
 	}
 }
 
+static int allocate_int_elem_set_tlv(struct elem_set_trial *trial,
+				     unsigned int **tlv)
+{
+	unsigned int len, pos;
+	unsigned int i, j;
+	struct chmap_entry *entry;
+
+	/* Calculate size of TLV packet for channel-mapping information. */
+	len = 0;
+	for (i = 1; i <= 25; ++i) {
+		len += sizeof(struct chmap_entry);
+		len += i * sizeof(unsigned int);
+	}
+
+	*tlv = malloc(len);
+	if (*tlv == NULL)
+		return -ENOMEM;
+
+	/*
+	 * Emulate channel-mapping information in in-kernel implementation.
+	 * Here, 25 entries are for each different channel.
+	 */
+	pos = 0;
+	for (i = 1; i <= 25 && pos < len; ++i) {
+		entry = (struct chmap_entry *)&(*tlv)[pos];
+		entry->type = SNDRV_CTL_TLVT_CHMAP_FIXED;
+		entry->length = i * sizeof(unsigned int);
+		for (j = 0; j < i; ++j)
+			entry->maps[j] = SND_CHMAP_MONO + j;
+		pos += sizeof(struct chmap_entry) + i * sizeof(unsigned int);
+	}
+
+	return 0;
+}
+
 /* Operations for elements in an element set with enumerated type. */
 static const char *const labels[] = {
 	"trusty",
@@ -158,6 +233,24 @@ static void change_bytes_elem_members(struct elem_set_trial *trial,
 	}
 }
 
+static int allocate_bytes_elem_set_tlv(struct elem_set_trial *trial,
+				       unsigned int **tlv)
+{
+	/*
+	 * Emulate AK4396.
+	 * 20 * log10(x/255) (dB)
+	 * Here, x is written value.
+	 */
+	static const SNDRV_CTL_TLVD_DECLARE_DB_LINEAR(range, -4813, 0);
+
+	*tlv = malloc(sizeof(range));
+	if (*tlv == NULL)
+		return -ENOMEM;
+	memcpy(*tlv, range, sizeof(range));
+
+	return 0;
+}
+
 /* Operations for elements in an element set with iec958 type. */
 static int add_iec958_elem_set(struct elem_set_trial *trial,
 			       snd_ctl_elem_info_t *info)
@@ -197,17 +290,17 @@ static int add_int64_elem_set(struct elem_set_trial *trial,
 {
 	return snd_ctl_add_integer64_elem_set(trial->handle, info,
 				trial->element_count, trial->member_count,
-				100, 10000, 30);
+				0, 10000, 1);
 }
 
 static int check_int64_elem_props(struct elem_set_trial *trial,
 				  snd_ctl_elem_info_t *info)
 {
-	if (snd_ctl_elem_info_get_min64(info) != 100)
+	if (snd_ctl_elem_info_get_min64(info) != 0)
 		return -EIO;
 	if (snd_ctl_elem_info_get_max64(info) != 10000)
 		return -EIO;
-	if (snd_ctl_elem_info_get_step64(info) != 30)
+	if (snd_ctl_elem_info_get_step64(info) != 1)
 		return -EIO;
 
 	return 0;
@@ -225,6 +318,45 @@ static void change_int64_elem_members(struct elem_set_trial *trial,
 	}
 }
 
+static int allocate_int64_elem_set_tlv(struct elem_set_trial *trial,
+				       unsigned int **tlv)
+{
+	/*
+	 * Use this fomula between linear/dB value:
+	 *
+	 *  Linear: dB range (coeff)
+	 *   0<-> 4: -59.40<->-56.36 (44)
+	 *   4<->22: -56.36<->-45.56 (60)
+	 *  22<->33: -45.56<->-40.72 (76)
+	 *  33<->37: -40.72<->-38.32 (44)
+	 *  37<->48: -38.32<->-29.96 (76)
+	 *  48<->66: -29.96<->-22.04 (60)
+	 *  66<->84: -22.04<-> -8.36 (44)
+	 *  84<->95:  -8.36<-> -1.76 (60)
+	 *  95<->99:  -1.76<->  0.00 (76)
+	 * 100<->..:   0.0
+	 */
+	static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(range,
+		 0,   4, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-5940, 44, 1),
+		 4,  22, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-5636, 60, 0),
+		22,  33, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-4556, 76, 0),
+		33,  37, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-4072, 44, 0),
+		37,  48, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-3832, 76, 0),
+		48,  66, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-2996, 60, 0),
+		66,  84, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-2204, 44, 0),
+		84,  95, SNDRV_CTL_TLVD_DB_SCALE_ITEM( -836, 60, 0),
+		95,  99, SNDRV_CTL_TLVD_DB_SCALE_ITEM( -176, 76, 0),
+		100, 10000, SNDRV_CTL_TLVD_DB_SCALE_ITEM(0, 0, 0),
+	);
+
+	*tlv = malloc(sizeof(range));
+	if (*tlv == NULL)
+		return -ENOMEM;
+	memcpy(*tlv, range, sizeof(range));
+
+	return 0;
+}
+
 /* Common operations. */
 static int add_elem_set(struct elem_set_trial *trial)
 {
@@ -414,41 +546,41 @@ static int check_elems(struct elem_set_trial *trial)
 
 static int check_tlv(struct elem_set_trial *trial)
 {
-	unsigned int orig[8], curr[8];
+	unsigned int *tlv;
+	unsigned int len;
+	unsigned int *curr;
 	int err;
 
-	/*
-	 * See a layout of 'struct snd_ctl_tlv'. I don't know the reason to
-	 * construct this buffer with the same layout. It should be abstracted
-	 * inner userspace library...
-	 */
-	orig[0] = snd_ctl_elem_id_get_numid(trial->id);
-	orig[1] = 6 * sizeof(orig[0]);
-	orig[2] = 'a';
-	orig[3] = 'b';
-	orig[4] = 'c';
-	orig[5] = 'd';
-	orig[6] = 'e';
-	orig[7] = 'f';
+	err = trial->allocate_elem_set_tlv(trial, &tlv);
+	if (err < 0)
+		return err;
+
+	len = tlv[1] + sizeof(unsigned int) * 2;
+	curr = malloc(len);
+	if (curr == NULL) {
+		free(tlv);
+		return -ENOMEM;
+	}
 
 	/*
 	 * In in-kernel implementation, write and command operations are the
-	 * same  for an element set added by userspace applications. Here, I
+	 * same for an element set added by userspace applications. Here, I
 	 * use write.
 	 */
 	err = snd_ctl_elem_tlv_write(trial->handle, trial->id,
-				     (const unsigned int *)orig);
+				     (const unsigned int *)tlv);
 	if (err < 0)
-		return err;
+		goto end;
 
-	err = snd_ctl_elem_tlv_read(trial->handle, trial->id, curr,
-				    sizeof(curr));
+	err = snd_ctl_elem_tlv_read(trial->handle, trial->id, curr, len);
 	if (err < 0)
-		return err;
-
-	if (memcmp(curr, orig, sizeof(orig)) != 0)
-		return -EIO;
+		goto end;
 
+	if (memcmp(curr, tlv, len) != 0)
+		err = -EIO;
+end:
+	free(tlv);
+	free(curr);
 	return 0;
 }
 
@@ -484,6 +616,8 @@ int main(void)
 			trial.add_elem_set = add_bool_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_bool_elem_members;
+			trial.allocate_elem_set_tlv =
+						allocate_bool_elem_set_tlv;
 			break;
 		case SND_CTL_ELEM_TYPE_INTEGER:
 			trial.element_count = 900;
@@ -495,6 +629,8 @@ int main(void)
 			trial.add_elem_set = add_int_elem_set;
 			trial.check_elem_props = check_int_elem_props;
 			trial.change_elem_members = change_int_elem_members;
+			trial.allocate_elem_set_tlv =
+						allocate_int_elem_set_tlv;
 			break;
 		case SND_CTL_ELEM_TYPE_ENUMERATED:
 			trial.element_count = 900;
@@ -506,6 +642,7 @@ int main(void)
 			trial.add_elem_set = add_enum_elem_set;
 			trial.check_elem_props = check_enum_elem_props;
 			trial.change_elem_members = change_enum_elem_members;
+			trial.allocate_elem_set_tlv = NULL;
 			break;
 		case SND_CTL_ELEM_TYPE_BYTES:
 			trial.element_count = 900;
@@ -517,6 +654,8 @@ int main(void)
 			trial.add_elem_set = add_bytes_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_bytes_elem_members;
+			trial.allocate_elem_set_tlv =
+						allocate_bytes_elem_set_tlv;
 			break;
 		case SND_CTL_ELEM_TYPE_IEC958:
 			trial.element_count = 1;
@@ -528,6 +667,7 @@ int main(void)
 			trial.add_elem_set = add_iec958_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_iec958_elem_members;
+			trial.allocate_elem_set_tlv = NULL;
 			break;
 		case SND_CTL_ELEM_TYPE_INTEGER64:
 		default:
@@ -540,6 +680,8 @@ int main(void)
 			trial.add_elem_set = add_int64_elem_set;
 			trial.check_elem_props = check_int64_elem_props;
 			trial.change_elem_members = change_int64_elem_members;
+			trial.allocate_elem_set_tlv =
+						allocate_int64_elem_set_tlv;
 			break;
 		}
 
@@ -589,22 +731,22 @@ int main(void)
 		}
 
 		/*
-		 * Test an operation to change threshold data of this element set,
-		 * except for IEC958 type.
+		 * Test an operation to change TLV data of this element set,
+		 * except for enumerated and IEC958 type.
 		 */
-		if (trial.type != SND_CTL_ELEM_TYPE_IEC958) {
+		if (trial.allocate_elem_set_tlv != NULL) {
 			err = check_tlv(&trial);
 			if (err < 0) {
-				printf("Fail to change threshold level of an "
-				       "element set with %s type.\n",
+				printf("Fail to change TLV data of an element "
+				       "set with %s type.\n",
 				       snd_ctl_elem_type_name(trial.type));
 				break;
 			}
 			err = check_event(&trial, SND_CTL_EVENT_MASK_TLV, 1);
 			if (err < 0) {
-				printf("Fail to check an event to change "
-				       "threshold level of an an element set "
-				       "with %s type.\n",
+				printf("Fail to check an event to change TLV"
+				       "data of an an element set with %s "
+				       "type.\n",
 				       snd_ctl_elem_type_name(trial.type));
 				break;
 			}
-- 
2.7.4
