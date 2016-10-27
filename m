From: mengdong.lin@linux.intel.com
Subject: [PATCH 16/22] topology: Parse and build private data
	of physical links
Date: Thu, 27 Oct 2016 15:14:14 +0800
Message-ID: <55d8c0b57916319b6d39d4ba578121b36aa46220.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 16C0D2672C7
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:12:59 +0200 (CEST)
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

Users can define private data for physical links by C API or text conf
file.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index daeb32e..c4857ba 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -162,7 +162,7 @@ static int build_link(snd_tplg_t *tplg, struct tplg_elem *elem)
 	if (err < 0)
 		return err;
 
-	/* hw configs */
+	/* hw configs & private data */
 	base = &elem->ref_list;
 	list_for_each(pos, base) {
 
@@ -185,6 +185,12 @@ static int build_link(snd_tplg_t *tplg, struct tplg_elem *elem)
 			num_hw_configs++;
 			break;
 
+		case SND_TPLG_TYPE_DATA: /* merge private data */
+			err = tplg_copy_data(tplg, elem, ref);
+			if (err < 0)
+				return err;
+			break;
+
 		default:
 			break;
 		}
@@ -1079,5 +1085,24 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	/* flags */
 	link->flag_mask = link_tpl->flag_mask;
 	link->flags = link_tpl->flags;
+
+	/* private data */
+	if (link_tpl->priv != NULL && link_tpl->priv->size) {
+		_link = realloc(link,
+			elem->size + link_tpl->priv->size);
+		if (!_link) {
+			tplg_elem_free(elem);
+			return -ENOMEM;
+		}
+
+		link = _link;
+		elem->link = link;
+		elem->size += link_tpl->priv->size;
+
+		memcpy(link->priv.data, link_tpl->priv->data,
+			link_tpl->priv->size);
+		link->priv.size = link_tpl->priv->size;
+	}
+
 	return 0;
 }
-- 
2.5.0
