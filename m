From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 1/7] topology: Use the generic pointer to
	free an element's object
Date: Wed, 30 Mar 2016 15:10:37 +0800
Message-ID: <c8d960fe4b38966d873f0f3951aff9879208d112.1459321387.git.mengdong.lin@linux.intel.com>
References: <cover.1459321387.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 826CC2658B3
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 09:08:27 +0200 (CEST)
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

The element is a wrapper for different types of objects.So use the
generic pointer 'obj' instead of the type-specific pointer to free
the object.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/elem.c b/src/topology/elem.c
index 12d6a72..00f9eea 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -83,8 +83,8 @@ void tplg_elem_free(struct tplg_elem *elem)
 	/* free struct snd_tplg_ object,
 	 * the union pointers share the same address
 	 */
-	if (elem->mixer_ctrl)
-		free(elem->mixer_ctrl);
+	if (elem->obj)
+		free(elem->obj);
 
 	free(elem);
 }
-- 
2.5.0
