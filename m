From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 1/6] topology: Set manifest size for ABI
Date: Fri, 29 Apr 2016 11:02:57 +0800
Message-ID: <2181ca1b572ebfe66f3ed5be006989245f0fe05b.1461898635.git.mengdong.lin@linux.intel.com>
References: <cover.1461898635.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 448B42651A5
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 05:00:00 +0200 (CEST)
In-Reply-To: <cover.1461898635.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

The topology kernel driver will check the size of manifest struct, and
will stop loading topology info if size mismatch is detected.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/parser.c b/src/topology/parser.c
index 30d91f9..84117c3 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -414,6 +414,8 @@ snd_tplg_t *snd_tplg_new(void)
 	if (!tplg)
 		return NULL;
 
+	tplg->manifest.size = sizeof(struct snd_soc_tplg_manifest);
+
 	INIT_LIST_HEAD(&tplg->tlv_list);
 	INIT_LIST_HEAD(&tplg->widget_list);
 	INIT_LIST_HEAD(&tplg->pcm_list);
-- 
2.5.0
