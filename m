From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 2/2] topology: Fix the missing referenced
	elem ptr when merging private data
Date: Fri, 22 Jul 2016 13:12:54 +0800
Message-ID: <49ac654e701ef70abfc525af3cf48fd87d067596.1469163116.git.mengdong.lin@linux.intel.com>
References: <cover.1469163116.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F907265713
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 07:07:46 +0200 (CEST)
In-Reply-To: <cover.1469163116.git.mengdong.lin@linux.intel.com>
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

tplg_copy_data() should set the valid referenced data element pointer
on success. The caller will double check this pointer for all kinds of
references, including controls and data.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/data.c b/src/topology/data.c
index 768fc27..4798086 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -1053,8 +1053,10 @@ int tplg_copy_data(snd_tplg_t *tplg, struct tplg_elem *elem,
 
 	tplg_dbg("Data '%s' used by '%s'\n", ref->id, elem->id);
 	/* overlook empty private data */
-	if (!ref_elem->data || !ref_elem->data->size)
+	if (!ref_elem->data || !ref_elem->data->size) {
+		ref->elem = ref_elem;
 		return 0;
+	}
 
 	old_priv = get_priv_data(elem);
 	if (!old_priv)
@@ -1078,6 +1080,8 @@ int tplg_copy_data(snd_tplg_t *tplg, struct tplg_elem *elem,
 	ref_elem->compound_elem = 1;
 	memcpy(priv->data + old_priv_data_size,
 	       ref_elem->data->data, priv_data_size);
+
+	ref->elem = ref_elem;
 	return 0;
 }
 
-- 
2.5.0
