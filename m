From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/2] topology: Merge private data before
	embedded controls of a widget
Date: Thu, 24 Nov 2016 09:33:52 +0800
Message-ID: <1479951232-23213-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CF1C02666A8
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2016 02:31:53 +0100 (CET)
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

For a widget ABI object, its private data sits before the embedded
controls, so we should merge the private data blocks at first, and
then the embedded controls.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 9fa0aac..e830751 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -160,7 +160,21 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 
 	base = &elem->ref_list;
 
-	/* for each ref in this control elem */
+	/* A widget's private data sits before the embedded controls.
+	 * So merge the private data blocks at first
+	 */
+	 list_for_each(pos, base) {
+		ref = list_entry(pos, struct tplg_ref, list);
+
+		if (ref->type != SND_TPLG_TYPE_DATA)
+			continue;
+
+		err = tplg_copy_data(tplg, elem, ref);
+		if (err < 0)
+			return err;
+	}
+
+	/* Merge the embedded controls */
 	list_for_each(pos, base) {
 
 		ref = list_entry(pos, struct tplg_ref, list);
@@ -190,12 +204,6 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 				err = copy_dapm_control(elem, ref->elem);
 			break;
 
-		case SND_TPLG_TYPE_DATA:
-			err = tplg_copy_data(tplg, elem, ref);
-			if (err < 0)
-				return err;
-			break;
-
 		default:
 			break;
 		}
-- 
2.5.0
