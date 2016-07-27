From: mengdong.lin@linux.intel.com
Subject: [PATCH v4] topology: Return -EINVAL at once on failure
	to find a reference
Date: Wed, 27 Jul 2016 16:48:53 +0800
Message-ID: <1469609333-13961-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3241426524F
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 10:43:54 +0200 (CEST)
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
Cc: tiwai@suse.de, mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

In building phase, return error -EINVAL at once if an element's references
(e.g. TLV, text, control or private data) cannot be found.

Move this error check right after looking up a reference, to make the
code more clear. And checking the return value of tplg_copy_data() is
enough, no need to check ref->elem for data references.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index 54f8e44..d910230 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -135,24 +135,23 @@ static int tplg_build_mixer_control(snd_tplg_t *tplg,
 		if (ref->type == SND_TPLG_TYPE_TLV) {
 			ref->elem = tplg_elem_lookup(&tplg->tlv_list,
 						ref->id, SND_TPLG_TYPE_TLV);
-			if (ref->elem)
-				 err = copy_tlv(elem, ref->elem);
+			if (!ref->elem)
+				goto ref_missing;
 
+			copy_tlv(elem, ref->elem);
 		} else if (ref->type == SND_TPLG_TYPE_DATA) {
 			err = tplg_copy_data(tplg, elem, ref);
 			if (err < 0)
 				return err;
 		}
-
-		if (!ref->elem) {
-			SNDERR("error: cannot find '%s' referenced by"
-				" control '%s'\n", ref->id, elem->id);
-			return -EINVAL;
-		} else if (err < 0)
-			return err;
 	}
 
 	return 0;
+
+ref_missing:
+	SNDERR("error: cannot find '%s' referenced by control '%s'\n",
+		ref->id, elem->id);
+	return -EINVAL;
 }
 
 static void copy_enum_texts(struct tplg_elem *enum_elem,
@@ -183,23 +182,23 @@ static int tplg_build_enum_control(snd_tplg_t *tplg,
 		if (ref->type == SND_TPLG_TYPE_TEXT) {
 			ref->elem = tplg_elem_lookup(&tplg->text_list,
 						ref->id, SND_TPLG_TYPE_TEXT);
-			if (ref->elem)
-				copy_enum_texts(elem, ref->elem);
+			if (!ref->elem)
+				goto ref_missing;
 
+			copy_enum_texts(elem, ref->elem);
 		} else if (ref->type == SND_TPLG_TYPE_DATA) {
 			err = tplg_copy_data(tplg, elem, ref);
 			if (err < 0)
 				return err;
 		}
-		if (!ref->elem) {
-			SNDERR("error: cannot find '%s' referenced by"
-				" control '%s'\n", ref->id, elem->id);
-			return -EINVAL;
-		} else if (err < 0)
-			return err;
 	}
 
 	return 0;
+
+ref_missing:
+	SNDERR("error: cannot find '%s' referenced by control '%s'\n",
+		ref->id, elem->id);
+	return -EINVAL;
 }
 
 /* check referenced private data for a byte control */
diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 4d343b2..988a5fc 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -160,7 +160,10 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 
 	base = &elem->ref_list;
 
-	/* for each ref in this control elem */
+	/* Look up and merge each reference in this widget elem.
+	 * For widgets added by C API, its control elements are already set
+	 * and so no need to look up.
+	 */
 	list_for_each(pos, base) {
 
 		ref = list_entry(pos, struct tplg_ref, list);
@@ -170,48 +173,50 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 			if (!ref->elem)
 				ref->elem = tplg_elem_lookup(&tplg->mixer_list,
 						ref->id, SND_TPLG_TYPE_MIXER);
-			if (ref->elem)
-				err = copy_dapm_control(elem, ref->elem);
+			if (!ref->elem)
+				goto ref_missing;
+
+			err = copy_dapm_control(elem, ref->elem);
 			break;
 
 		case SND_TPLG_TYPE_ENUM:
 			if (!ref->elem)
 				ref->elem = tplg_elem_lookup(&tplg->enum_list,
 						ref->id, SND_TPLG_TYPE_ENUM);
-			if (ref->elem)
-				err = copy_dapm_control(elem, ref->elem);
+			if (!ref->elem)
+				goto ref_missing;
+
+			err = copy_dapm_control(elem, ref->elem);
 			break;
 
 		case SND_TPLG_TYPE_BYTES:
 			if (!ref->elem)
 				ref->elem = tplg_elem_lookup(&tplg->bytes_ext_list,
 						ref->id, SND_TPLG_TYPE_BYTES);
-			if (ref->elem)
-				err = copy_dapm_control(elem, ref->elem);
+			if (!ref->elem)
+				goto ref_missing;
+
+			err = copy_dapm_control(elem, ref->elem);
 			break;
 
 		case SND_TPLG_TYPE_DATA:
 			err = tplg_copy_data(tplg, elem, ref);
-			if (err < 0)
-				return err;
 			break;
 
 		default:
 			break;
 		}
 
-		if (!ref->elem) {
-			SNDERR("error: cannot find control '%s'"
-				" referenced by widget '%s'\n",
-				ref->id, elem->id);
-			return -EINVAL;
-		}
-
 		if (err < 0)
 			return err;
 	}
 
 	return 0;
+
+ref_missing:
+	SNDERR("error: cannot find '%s' referenced by widget '%s'\n",
+		ref->id, elem->id);
+	return -EINVAL;
 }
 
 int tplg_build_widgets(snd_tplg_t *tplg)
-- 
2.5.0
