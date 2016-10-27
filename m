From: mengdong.lin@linux.intel.com
Subject: [PATCH 07/22] topology: Merge an element's be & cc
	pointer to one link pointer
Date: Thu, 27 Oct 2016 15:12:14 +0800
Message-ID: <a01309fc239892c936202c100d5188b7497a721a.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A337226688A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:11:01 +0200 (CEST)
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

Code refactoring. Previously an element has two pointers, 'be' and 'cc',
for BE (Back End) and CC (Codec-Codec) link respectively. But actually
the topology tool processes BE and CC links in the same way, so these
two pointers can be merged into one 'link' pointer, which can be used
configure any physical links.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 33940c6..64c8fd9 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -175,11 +175,7 @@ int tplg_build_link_cfg(snd_tplg_t *tplg, unsigned int type)
 			return -EINVAL;
 		}
 
-		if (type == SND_TPLG_TYPE_BE)
-			link = elem->be;
-		else
-			link = elem->cc;
-
+		link = elem->link;
 		err = tplg_build_stream_cfg(tplg, link->stream,
 			link->num_streams);
 		if (err < 0)
@@ -546,7 +542,7 @@ int tplg_parse_be(snd_tplg_t *tplg,
 	if (!elem)
 		return -ENOMEM;
 
-	link = elem->be;
+	link = elem->link;
 	link->size = elem->size;
 
 	tplg_dbg(" BE: %s\n", elem->id);
@@ -606,7 +602,7 @@ int tplg_parse_cc(snd_tplg_t *tplg,
 	if (!elem)
 		return -ENOMEM;
 
-	link = elem->cc;
+	link = elem->link;
 	link->size = elem->size;
 
 	tplg_dbg(" CC: %s\n", elem->id);
@@ -760,14 +756,12 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	if (!elem)
 		return -ENOMEM;
 
-	if (t->type == SND_TPLG_TYPE_BE) {
+	if (t->type == SND_TPLG_TYPE_BE)
 		tplg_dbg("BE Link: %s", link->name);
-		lk = elem->be;
-	} else {
+	else
 		tplg_dbg("CC Link: %s", link->name);
-		lk = elem->cc;
-	}
 
+	lk = elem->link;
 	lk->size = elem->size;
 	lk->id = link->id;
 	lk->num_streams = link->num_streams;
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 7b30b84..3aa51ee 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -144,8 +144,7 @@ struct tplg_elem {
 		struct snd_soc_tplg_bytes_control *bytes_ext;
 		struct snd_soc_tplg_dapm_widget *widget;
 		struct snd_soc_tplg_pcm *pcm;
-		struct snd_soc_tplg_link_config *be;
-		struct snd_soc_tplg_link_config *cc;
+		struct snd_soc_tplg_link_config *link;/* physical link */
 		struct snd_soc_tplg_dapm_graph_elem *route;
 		struct snd_soc_tplg_stream *stream_cfg;
 		struct snd_soc_tplg_stream_caps *stream_caps;
-- 
2.5.0
