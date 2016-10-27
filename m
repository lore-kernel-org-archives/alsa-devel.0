From: mengdong.lin@linux.intel.com
Subject: [PATCH 06/22] topology: tplg_elem_lookup() checks
	parameter before searching
Date: Thu, 27 Oct 2016 15:12:06 +0800
Message-ID: <71fe37d22156ec663c2841e994c4881b9678ed78.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id D180D2672CA
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:10:51 +0200 (CEST)
In-Reply-To: <cover.1477549962.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Check the parameters at first in case of misuse.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/elem.c b/src/topology/elem.c
index 029c9ab..724bf26 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -111,6 +111,9 @@ struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
 	struct list_head *pos;
 	struct tplg_elem *elem;
 
+	if (!base || !id)
+		return NULL;
+
 	list_for_each(pos, base) {
 
 		elem = list_entry(pos, struct tplg_elem, list);
-- 
2.5.0
