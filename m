From: mengdong.lin@linux.intel.com
Subject: [PATCH 06/13] topology: Rename varaibles for add
	physical links by C API
Date: Sun,  6 Nov 2016 13:13:19 +0800
Message-ID: <716aa62b2f50876e16e17a49c680869b473de78d.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 47BEF2665B0
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:11:49 +0100 (CET)
In-Reply-To: <cover.1478407716.git.mengdong.lin@linux.intel.com>
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

Code refactoring. When adding a physical link element from C API:
- Rename "link" to "link_tpl" for physical link config template for
  C API users.
- Rename "lk" to "link" for physical link elements created by topology
  internally.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index d8dd96a..fe8af45 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -740,10 +740,11 @@ int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	return 0;
 }
 
+/* Add a physical DAI link element from C API */
 int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 {
-	struct snd_tplg_link_template *link = t->link;
-	struct snd_soc_tplg_link_config *lk;
+	struct snd_tplg_link_template *link_tpl = t->link;
+	struct snd_soc_tplg_link_config *link, *_link;
 	struct tplg_elem *elem;
 	int i;
 
@@ -751,22 +752,25 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 		return -EINVAL;
 
 	/* here type can be either BE or CC. */
-	elem = tplg_elem_new_common(tplg, NULL, link->name, t->type);
+	elem = tplg_elem_new_common(tplg, NULL, link_tpl->name, t->type);
 	if (!elem)
 		return -ENOMEM;
 
 	if (t->type == SND_TPLG_TYPE_BE)
-		tplg_dbg("BE Link: %s", link->name);
+		tplg_dbg("BE Link: %s", link_tpl->name);
 	else
-		tplg_dbg("CC Link: %s", link->name);
+		tplg_dbg("CC Link: %s", link_tpl->name);
 
-	lk = elem->link;
-	lk->size = elem->size;
-	lk->id = link->id;
-	lk->num_streams = link->num_streams;
+	link = elem->link;
+	link->size = elem->size;
 
+	link->id = link_tpl->id;
+	/* stream configs */
+	if (link_tpl->num_streams > SND_SOC_TPLG_STREAM_CONFIG_MAX)
+		return -EINVAL;
+	link->num_streams = link_tpl->num_streams;
 	for (i = 0; i < link->num_streams; i++)
-		tplg_add_stream_object(&lk->stream[i], &link->stream[i]);
+		tplg_add_stream_object(&link->stream[i], &link_tpl->stream[i]);
 
 	return 0;
 }
-- 
2.7.4
