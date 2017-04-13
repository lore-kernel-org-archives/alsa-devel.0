From: fuweix.tang@intel.com
Subject: [PATCH 4/4] topology: Group elements with the same
	index value into a block
Date: Thu, 13 Apr 2017 14:52:47 +0800
Message-ID: <1a5aaddf0d9c7937d3ebdecedc23c3eb65ff81ef.1492065639.git.fuweix.tang@intel.com>
References: <cover.1492065639.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 94CA0266AD7
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 08:53:03 +0200 (CEST)
In-Reply-To: <cover.1492065639.git.fuweix.tang@intel.com>
In-Reply-To: <cover.1492065639.git.fuweix.tang@intel.com>
References: <cover.1492065639.git.fuweix.tang@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Fuwei Tang <fuweix.tang@intel.com>

Topology objects(widgets,controls) with different index value should be grouped
into different blocks and the block headers contain the index value.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
Reviewed-by: Mengdong Lin <mengdong.lin@linux.intel.com>
---
 src/topology/builder.c | 94 +++++++++++++++++++++++++++-----------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/src/topology/builder.c b/src/topology/builder.c
index dcd9e2a..ca5cbe1 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -86,58 +86,66 @@ static int write_block_header(snd_tplg_t *tplg, unsigned int type,
 static int write_elem_block(snd_tplg_t *tplg,
 	struct list_head *base, int size, int tplg_type, const char *obj_name)
 {
-	struct list_head *pos;
-	struct tplg_elem *elem;
-	int ret, wsize = 0, count = 0, vendor_type;
+	struct list_head *pos, *sub_pos, *sub_base;
+	struct tplg_elem *elem, *elem_next;
+	int ret, wsize = 0, total_size = 0, count = 0, block_size = 0;
 
-	/* count number of elements */
-	list_for_each(pos, base)
-		count++;
-	if (!count)
-		return 0;
-
-	/* write the header for this block */
-	elem = list_entry(base->next, struct tplg_elem, list);
-	vendor_type = elem->vendor_type;
-
-	ret = write_block_header(tplg, tplg_type, vendor_type,
-		tplg->version, 0, size, count);
-	if (ret < 0) {
-		SNDERR("error: failed to write %s block %d\n",
-			obj_name, ret);
-		return ret;
-	}
-
-	/* write each elem to block */
+	sub_base = base;
 	list_for_each(pos, base) {
-
+		/* find elems with the same index to make a block */
 		elem = list_entry(pos, struct tplg_elem, list);
+		elem_next = list_entry(pos->next, struct tplg_elem, list);
+		block_size += elem->size;
+		count++;
 
-		/* compound elems have already been copied to other elems */
-		if (elem->compound_elem)
-			continue;
-
-		if (elem->type != SND_TPLG_TYPE_DAPM_GRAPH)
-			verbose(tplg, " %s '%s': write %d bytes\n",
-				obj_name, elem->id, elem->size);
-		else
-			verbose(tplg, " %s '%s': write %d bytes\n",
-				obj_name, elem->route->source, elem->size);
-
-		count = write(tplg->out_fd, elem->obj, elem->size);
-		if (count < 0) {
-			SNDERR("error: failed to write %s %d\n",
-				obj_name, ret);
-			return ret;
+		if ((pos->next == base) || (elem_next->index != elem->index)) {
+			/* write header for the block */
+			ret = write_block_header(tplg, tplg_type, elem->vendor_type,
+				tplg->version, elem->index, block_size, count);
+			if (ret < 0) {
+				SNDERR("error: failed to write %s block %d\n",
+					obj_name, ret);
+				return ret;
+			}
+
+			/* write elems for the block */
+			list_for_each(sub_pos, sub_base) {
+				elem = list_entry(sub_pos, struct tplg_elem, list);
+				/* compound elems have already been copied to other elems */
+				if (elem->compound_elem)
+					continue;
+
+				if (elem->type != SND_TPLG_TYPE_DAPM_GRAPH)
+					verbose(tplg, " %s '%s': write %d bytes\n",
+						obj_name, elem->id, elem->size);
+				else
+					verbose(tplg, " %s '%s': write %d bytes\n",
+						obj_name, elem->route->source, elem->size);
+
+				wsize = write(tplg->out_fd, elem->obj, elem->size);
+				if (wsize < 0) {
+					SNDERR("error: failed to write %s %d\n",
+						obj_name, ret);
+					return ret;
+				}
+
+				total_size += wsize;
+				/* get to the end of sub list */
+				if (sub_pos == pos)
+					break;
+			}
+			/* the last elem of the current sub list as the head of 
+			next sub list*/
+			sub_base = pos;
+			count = 0;
+			block_size = 0;
 		}
-
-		wsize += count;
 	}
 
 	/* make sure we have written the correct size */
-	if (wsize != size) {
+	if (total_size != size) {
 		SNDERR("error: size mismatch. Expected %d wrote %d\n",
-			size, wsize);
+			size, total_size);
 		return -EIO;
 	}
 
-- 
2.7.4
