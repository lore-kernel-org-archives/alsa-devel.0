From: mengdong.lin@linux.intel.com
Subject: [PATCH 2/2] topology: Store number of strings of a
	text section
Date: Thu, 24 Nov 2016 09:34:00 +0800
Message-ID: <1479951240-23257-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BB462666A8
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 02:32:06 +0100 (CET)
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Enum controls may use text elements and need the number of strings.

This patch adds a text child object for a generic element. When parsing
a text section from the configuation file, store the text strings and
number of strings (num_items) in the text child object of the element.

Reported-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 54f8e44..907a97f 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -159,9 +159,11 @@ static void copy_enum_texts(struct tplg_elem *enum_elem,
 	struct tplg_elem *ref_elem)
 {
 	struct snd_soc_tplg_enum_control *ec = enum_elem->enum_ctrl;
+	struct tplg_texts *texts = ref_elem->texts;
 
-	memcpy(ec->texts, ref_elem->texts,
+	memcpy(ec->texts, texts->items,
 		SND_SOC_TPLG_NUM_TEXTS * SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	ec->items += texts->num_items;
 }
 
 /* check referenced text for a enum control */
diff --git a/src/topology/elem.c b/src/topology/elem.c
index 1a5ac84..db26483 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -159,6 +159,7 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		break;
 	case SND_TPLG_TYPE_TEXT:
 		list_add_tail(&elem->list, &tplg->text_list);
+		obj_size = sizeof(struct tplg_texts);
 		break;
 	case SND_TPLG_TYPE_TLV:
 		list_add_tail(&elem->list, &tplg->tlv_list);
diff --git a/src/topology/text.c b/src/topology/text.c
index 0c6594a..303fbeb 100644
--- a/src/topology/text.c
+++ b/src/topology/text.c
@@ -25,6 +25,7 @@
 
 static int parse_text_values(snd_config_t *cfg, struct tplg_elem *elem)
 {
+	struct tplg_texts *texts = elem->texts;
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
 	const char *value = NULL;
@@ -44,13 +45,14 @@ static int parse_text_values(snd_config_t *cfg, struct tplg_elem *elem)
 		if (snd_config_get_string(n, &value) < 0)
 			continue;
 
-		elem_copy_text(&elem->texts[j][0], value,
+		elem_copy_text(&texts->items[j][0], value,
 			SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
-		tplg_dbg("\t%s\n", &elem->texts[j][0]);
+		tplg_dbg("\t%s\n", &texts->items[j][0]);
 
 		j++;
 	}
 
+	texts->num_items = j;
 	return 0;
 }
 
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index f913563..eb2f7bd 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -91,6 +91,11 @@ struct tplg_ref {
 	struct list_head list;
 };
 
+struct tplg_texts {
+	unsigned int num_items;
+	char items[SND_SOC_TPLG_NUM_TEXTS][SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+};
+
 /* element for vendor tokens */
 struct tplg_token {
 	char id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
@@ -128,9 +133,6 @@ struct tplg_elem {
 
 	char id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 
-	/* storage for texts and data if this is text or data elem*/
-	char texts[SND_SOC_TPLG_NUM_TEXTS][SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-
 	int index;
 	enum snd_tplg_type type;
 
@@ -155,6 +157,7 @@ struct tplg_elem {
 
 		/* these do not map to UAPI structs but are internal only */
 		struct snd_soc_tplg_ctl_tlv *tlv;
+		struct tplg_texts *texts;
 		struct snd_soc_tplg_private *data;
 		struct tplg_vendor_tokens *tokens;
 		struct tplg_vendor_tuples *tuples;
-- 
2.5.0
