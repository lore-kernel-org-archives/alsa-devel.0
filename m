From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 2/2] topology: Fix the missing referenced
	elem ptr when merging private data
Date: Fri, 22 Jul 2016 09:47:01 +0800
Message-ID: <7d8df59aab4a6935f4d3c7ca1c6955a2ff0e8d20.1469151453.git.mengdong.lin@linux.intel.com>
References: <cover.1469151453.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F9A7265A1B
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 03:41:53 +0200 (CEST)
In-Reply-To: <cover.1469151453.git.mengdong.lin@linux.intel.com>
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
index 768fc27..e7793b2 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -1078,6 +1078,8 @@ int tplg_copy_data(snd_tplg_t *tplg, struct tplg_elem *elem,
 	ref_elem->compound_elem = 1;
 	memcpy(priv->data + old_priv_data_size,
 	       ref_elem->data->data, priv_data_size);
+
+	ref->elem = ref_elem;
 	return 0;
 }
 
-- 
2.5.0
