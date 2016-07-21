From: mengdong.lin@linux.intel.com
Subject: [PATCH] topology: Fix the missing referenced elem ptr
	when merging private data
Date: Thu, 21 Jul 2016 15:00:47 +0800
Message-ID: <1469084447-30740-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C198B2614E3
 for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2016 08:55:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

tplg_copy_data() should set the valid referenced data element pointer.
The caller will double check this pointer for all kinds of references,
including TLV, controls, text and data.

Also fix an inaccurate dmesg.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 4d343b2..e3c90d8 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -201,7 +201,7 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 		}
 
 		if (!ref->elem) {
-			SNDERR("error: cannot find control '%s'"
+			SNDERR("error: cannot find '%s'"
 				" referenced by widget '%s'\n",
 				ref->id, elem->id);
 			return -EINVAL;
diff --git a/src/topology/data.c b/src/topology/data.c
index 768fc27..397f6a5 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -1050,6 +1050,7 @@ int tplg_copy_data(snd_tplg_t *tplg, struct tplg_elem *elem,
 		" element '%s'\n", ref->id, elem->id);
 		return -EINVAL;
 	}
+	ref->elem = ref_elem;
 
 	tplg_dbg("Data '%s' used by '%s'\n", ref->id, elem->id);
 	/* overlook empty private data */
-- 
2.5.0
