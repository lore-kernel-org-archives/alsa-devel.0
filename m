From: mengdong.lin@linux.intel.com
Subject: [PATCH] topology: Fix inaccurate comments when
	building a widget element
Date: Thu, 28 Jul 2016 09:39:01 +0800
Message-ID: <1469669941-19665-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 33D9626533F
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2016 03:33:45 +0200 (CEST)
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
Cc: tiwai@suse.de, mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

The original comments use 'control' by mistake when building a widget.
Also describe the difference between the referenced controls defined by
C API and text conf file.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index e3c90d8..0141653 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -150,7 +150,7 @@ static int copy_dapm_control(struct tplg_elem *elem, struct tplg_elem *ref)
 	return 0;
 }
 
-/* check referenced controls for a widget */
+/* Merge referenced controls and private data for a widget */
 static int tplg_build_widget(snd_tplg_t *tplg,
 	struct tplg_elem *elem)
 {
@@ -160,7 +160,12 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 
 	base = &elem->ref_list;
 
-	/* for each ref in this control elem */
+	/* Look up and merge each control or data reference of this
+	 * widget element. For a widget defined by C API, its control
+	 * references are already bound and can be directly merged
+	 * without lookup. Only control references defined by text
+	 * conf file need lookup before being merged.
+	 */
 	list_for_each(pos, base) {
 
 		ref = list_entry(pos, struct tplg_ref, list);
-- 
2.5.0
