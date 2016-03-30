From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 2/7] topology: Define a free handler for the
	element
Date: Wed, 30 Mar 2016 15:10:45 +0800
Message-ID: <c84880ade867ba29181f49c8a06a93f2c3136993.1459321387.git.mengdong.lin@linux.intel.com>
References: <cover.1459321387.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B16D26170F
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 09:09:02 +0200 (CEST)
In-Reply-To: <cover.1459321387.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This handler is defined for type-specific destruction of an element.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/elem.c b/src/topology/elem.c
index 00f9eea..f2afaaf 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -83,8 +83,12 @@ void tplg_elem_free(struct tplg_elem *elem)
 	/* free struct snd_tplg_ object,
 	 * the union pointers share the same address
 	 */
-	if (elem->obj)
+	if (elem->obj) {
+		if (elem->free)
+			elem->free(elem->obj);
+
 		free(elem->obj);
+	}
 
 	free(elem);
 }
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 4915b1a..7368a86 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -127,6 +127,8 @@ struct tplg_elem {
 	 */
 	struct list_head ref_list;
 	struct list_head list; /* list of all elements with same type */
+
+	void (*free)(void *obj);
 };
 
 struct map_elem {
-- 
2.5.0
