From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH][alsa-lib] test: apply optimization for v4.14
	kernel about changes for TLV data handling on user-defined
	element set
Date: Thu, 24 Aug 2017 10:48:35 +0900
Message-ID: <20170824014835.29008-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id F093D266BED
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 03:48:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, fulup.arfoll@iot.bzh
List-Id: alsa-devel@alsa-project.org

At kernel v4.14, in initial state, elements on user-defined sets have
write-only flag. When applications write TLV data, then the elements
get readable flag and the TLV data is available. Originally TLV data
is shared by elements in the same set, thus events are generated for
all of elements in the set by the write operation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 84 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index 8635c156..f3710732 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -9,6 +9,7 @@
 
 #include "../include/asoundlib.h"
 #include <sound/tlv.h>
+#include <stdbool.h>
 
 struct elem_set_trial {
 	snd_ctl_t *handle;
@@ -28,6 +29,8 @@ struct elem_set_trial {
 				    snd_ctl_elem_value_t *elem_data);
 	int (*allocate_elem_set_tlv)(struct elem_set_trial *trial,
 				     unsigned int **tlv);
+
+	bool tlv_readable;
 };
 
 struct chmap_entry {
@@ -420,9 +423,9 @@ static int check_event(struct elem_set_trial *trial, unsigned int mask,
 			continue;
 		/*
 		 * I expect each event is generated separately to the same
-		 * element.
+		 * element or several events are generated at once.
 		 */
-		if (!(snd_ctl_event_elem_get_mask(event) & mask))
+		if ((snd_ctl_event_elem_get_mask(event) & mask) != mask)
 			continue;
 		--expected_count;
 	}
@@ -561,6 +564,16 @@ static int check_elem_set_props(struct elem_set_trial *trial)
 		if (!snd_ctl_elem_info_is_locked(info))
 			return -EIO;
 
+		/*
+		 * In initial state, any application can register TLV data for
+		 * user-defined element set except for IEC 958 type, thus
+		 * elements in any user-defined set should allow any write
+		 * operation.
+		 */
+		if (trial->type != SND_CTL_ELEM_TYPE_IEC958 &&
+		    !snd_ctl_elem_info_is_tlv_writable(info))
+			return -EIO;
+
 		/* Check type-specific properties. */
 		if (trial->check_elem_props != NULL) {
 			err = trial->check_elem_props(trial, info);
@@ -572,6 +585,25 @@ static int check_elem_set_props(struct elem_set_trial *trial)
 		err = snd_ctl_elem_unlock(trial->handle, id);
 		if (err < 0)
 			return err;
+
+		/*
+		 * Till kernel v4.14, ALSA control core allows elements in any
+		 * user-defined set to have TLV_READ flag even if they have no
+		 * TLV data in their initial state. In this case, any read
+		 * operation for TLV data should return -ENXIO.
+		 */
+		if (snd_ctl_elem_info_is_tlv_readable(info)) {
+			unsigned int data[32];
+			err = snd_ctl_elem_tlv_read(trial->handle, trial->id,
+						    data, sizeof(data));
+			if (err >= 0)
+				return -EIO;
+			if (err != -ENXIO)
+				return err;
+
+			trial->tlv_readable = true;
+		}
+
 	}
 
 	return 0;
@@ -619,6 +651,8 @@ static int check_elems(struct elem_set_trial *trial)
 static int check_tlv(struct elem_set_trial *trial)
 {
 	unsigned int *tlv;
+	int mask;
+	unsigned int count;
 	unsigned int len;
 	unsigned int *curr;
 	int err;
@@ -644,6 +678,36 @@ static int check_tlv(struct elem_set_trial *trial)
 	if (err < 0)
 		goto end;
 
+	/*
+	 * Since kernel v4.14, any write operation to an element in user-defined
+	 * set can change state of the other elements in the same set. In this
+	 * case, any TLV data is firstly available after the operation.
+	 */
+	if (!trial->tlv_readable) {
+		mask = SND_CTL_EVENT_MASK_INFO | SND_CTL_EVENT_MASK_TLV;
+		count = trial->element_count;
+	} else {
+		mask = SND_CTL_EVENT_MASK_TLV;
+		count = 1;
+	}
+	err = check_event(trial, mask, count);
+	if (err < 0)
+		goto end;
+	if (!trial->tlv_readable) {
+		snd_ctl_elem_info_t *info;
+		snd_ctl_elem_info_alloca(&info);
+
+		snd_ctl_elem_info_set_id(info, trial->id);
+		err = snd_ctl_elem_info(trial->handle, info);
+		if (err < 0)
+			return err;
+		if (!snd_ctl_elem_info_is_tlv_readable(info))
+			return -EIO;
+
+		/* Now TLV data is available for this element set. */
+		trial->tlv_readable = true;
+	}
+
 	err = snd_ctl_elem_tlv_read(trial->handle, trial->id, curr, len);
 	if (err < 0)
 		goto end;
@@ -690,6 +754,7 @@ int main(void)
 			trial.change_elem_members = change_bool_elem_members;
 			trial.allocate_elem_set_tlv =
 						allocate_bool_elem_set_tlv;
+			trial.tlv_readable = false;
 			break;
 		case SND_CTL_ELEM_TYPE_INTEGER:
 			trial.element_count = 900;
@@ -703,6 +768,7 @@ int main(void)
 			trial.change_elem_members = change_int_elem_members;
 			trial.allocate_elem_set_tlv =
 						allocate_int_elem_set_tlv;
+			trial.tlv_readable = false;
 			break;
 		case SND_CTL_ELEM_TYPE_ENUMERATED:
 			trial.element_count = 900;
@@ -715,6 +781,7 @@ int main(void)
 			trial.check_elem_props = check_enum_elem_props;
 			trial.change_elem_members = change_enum_elem_members;
 			trial.allocate_elem_set_tlv = NULL;
+			trial.tlv_readable = false;
 			break;
 		case SND_CTL_ELEM_TYPE_BYTES:
 			trial.element_count = 900;
@@ -728,6 +795,7 @@ int main(void)
 			trial.change_elem_members = change_bytes_elem_members;
 			trial.allocate_elem_set_tlv =
 						allocate_bytes_elem_set_tlv;
+			trial.tlv_readable = false;
 			break;
 		case SND_CTL_ELEM_TYPE_IEC958:
 			trial.element_count = 1;
@@ -740,6 +808,7 @@ int main(void)
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_iec958_elem_members;
 			trial.allocate_elem_set_tlv = NULL;
+			trial.tlv_readable = false;
 			break;
 		case SND_CTL_ELEM_TYPE_INTEGER64:
 		default:
@@ -754,6 +823,7 @@ int main(void)
 			trial.change_elem_members = change_int64_elem_members;
 			trial.allocate_elem_set_tlv =
 						allocate_int64_elem_set_tlv;
+			trial.tlv_readable = false;
 			break;
 		}
 
@@ -784,7 +854,7 @@ int main(void)
 		/* Check properties of each element in this element set. */
 		err = check_elem_set_props(&trial);
 		if (err < 0) {
-			printf("Fail to check propetries of each element with "
+			printf("Fail to check properties of each element with "
 			       "%s type.\n",
 			       snd_ctl_elem_type_name(trial.type));
 			break;
@@ -822,14 +892,6 @@ int main(void)
 				       snd_ctl_elem_type_name(trial.type));
 				break;
 			}
-			err = check_event(&trial, SND_CTL_EVENT_MASK_TLV, 1);
-			if (err < 0) {
-				printf("Fail to check an event to change TLV"
-				       "data of an an element set with %s "
-				       "type.\n",
-				       snd_ctl_elem_type_name(trial.type));
-				break;
-			}
 		}
 
 		/* Test an operation to remove elements in this element set. */
-- 
2.11.0
